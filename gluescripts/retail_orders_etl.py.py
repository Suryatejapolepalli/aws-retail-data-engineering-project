from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.types import *
import datetime

spark = SparkSession.builder.appName("RetailOrdersETL").getOrCreate()

# -----------------------------
# Read Raw Orders CSV
# -----------------------------

input_path = "s3://retail-raw-surya/orders/"

df = spark.read.option("header", "true").csv(input_path)

# -----------------------------
# Data Cleaning
# -----------------------------

df_clean = df.dropDuplicates(["order_id"])

df_clean = df_clean.filter(col("order_id").isNotNull())

df_clean = df_clean.filter(col("customer_id").isNotNull())

# -----------------------------
# Type Casting
# -----------------------------

df_clean = df_clean.withColumn(
    "quantity",
    col("quantity").cast(IntegerType())
)

df_clean = df_clean.withColumn(
    "price",
    col("price").cast(DoubleType())
)

# -----------------------------
# Validation
# -----------------------------

# -----------------------------
# Reject Records Identification
# -----------------------------

reject_df = df_clean.filter(
    (col("quantity") <= 0) |
    (col("price") <= 0) |
    (col("customer_id").isNull())
)

# Write rejected records

reject_df.write \
    .mode("append") \
    .json("s3://retail-curated-surya/rejects/")

# Keep only valid records

df_clean = df_clean.filter(
    (col("quantity") > 0) &
    (col("price") > 0) &
    (col("customer_id").isNotNull())
)
# -----------------------------
# Derived Columns
# -----------------------------

df_clean = df_clean.withColumn(
    "total_amount",
    col("quantity") * col("price")
)

df_clean = df_clean.withColumn(
    "order_date",
    to_date(col("order_date"))
)

df_clean = df_clean.withColumn(
    "year",
    year(col("order_date"))
)

df_clean = df_clean.withColumn(
    "month",
    month(col("order_date"))
)

df_clean = df_clean.withColumn(
    "processed_timestamp",
    current_timestamp()
)

# -----------------------------
# Write Curated Parquet
# -----------------------------

output_path = "s3://retail-curated-surya/orders/"

df_clean.write \
    .mode("overwrite") \
    .partitionBy("year", "month") \
    .parquet(output_path)
# -----------------------------
# Audit Logging
# -----------------------------

audit_data = [{
    "job_name": "retail-orders-etl-job",
    "load_timestamp": str(datetime.datetime.now()),
    "records_processed": df_clean.count(),
    "job_status": "SUCCESS"
}]

audit_df = spark.createDataFrame(audit_data)

audit_df.write \
    .mode("append") \
    .json("s3://retail-curated-surya/audit/")
print("Enterprise ETL Job Completed Successfully")
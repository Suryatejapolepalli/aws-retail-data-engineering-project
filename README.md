# aws-retail-data-engineering-project
# Enterprise Retail Data Lake and Analytics Platform on AWS

## Project Overview

Designed and implemented an enterprise-grade retail data lake and analytics platform on AWS using Amazon S3, AWS Glue PySpark, Glue Data Catalog, Athena, and Power BI.

The project demonstrates scalable raw-to-curated ETL pipelines, data validation frameworks, audit logging, reject handling, partitioned Parquet optimization, and serverless analytics for enterprise reporting workloads.

---

## Architecture

<img width="1672" height="941" alt="AWS architecture" src="https://github.com/user-attachments/assets/02318481-e49e-47e8-ac67-7493bff635f9" />

---

## AWS Services Used

- Amazon S3
- AWS Glue
- AWS Glue Data Catalog
- Amazon Athena
- Amazon CloudWatch
- IAM
- Power BI

---

## Key Features

- Enterprise Data Lake Architecture
- Raw → Curated ETL Pipelines
- PySpark Transformations
- Data Validation Framework
- Reject Records Handling
- Audit Logging Framework
- Partitioned Parquet Optimization
- Athena SQL Analytics
- Enterprise Reporting

---

## Dataset

- Orders
- Customers
- Products

---

## ETL Flow

1. Source CSV files uploaded into S3 Raw Layer
2. Glue Crawlers create metadata tables
3. Glue PySpark ETL job validates and transforms data
4. Invalid records redirected into Reject Zone
5. Audit logs generated for operational tracking
6. Curated Parquet datasets stored in S3
7. Athena performs SQL analytics
8. Power BI visualizes business KPIs

---

## Business KPIs

- Total Revenue
- Revenue by City
- Revenue by Product Category
- Monthly Revenue Trend
- Top Customers
- Payment Method Analytics

---

## Project Structure

```text
datasets/
glue-scripts/
athena-queries/
architecture/
screenshots/
documentation/

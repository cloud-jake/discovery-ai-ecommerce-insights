# discovery-ai-ecommerce-insights
Do more with retail data for Discovery AI with Looker and Vertex AI

Based on Google Documentation [Do More with Retail Data](https://cloud.google.com/retail/docs/do-more-with-retail-data)

<!-----

Yay, no errors, warnings, or alerts!

Conversion time: 0.321 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β34
* Sat Aug 19 2023 06:10:51 GMT-0700 (PDT)
* Source doc: [markdown export]Do more with Retail Data - Quickstart
----->



# Do more with Retail Data - Quickstart

Quickstart to automate parts of the process to export and prepare Retail data from Discovery AI into BigQuery.  A sample foundational Looker dashboard is available as a starting point.


## Request Allowlist for Data Export

Google Partner Engineer must submit request 


## Data Export Quickstart Scripts

[https://github.com/cloud-jake/discovery-ai-ecommerce-insights](https://github.com/cloud-jake/discovery-ai-ecommerce-insights)

Update variables.inc with the PROJECT_ID of your retail API instance and change any of the remaining variables to meet your needs.  Retail data Bigquery exports need to live in the same project as Retail API.

Run the 2 scripts in order to create the BQ dataset for the retail API export, export the data from the retail API to Big Query, and create the appropriate tables and (materialized) views.


## Looker Instructions

[Get dashboards that show key performance indicators | Retail | Google Cloud](https://cloud.google.com/retail/docs/get-dashboards-that-show-kpis#install-the-looker-block)



# Data Quality Querying

Sample scripts to verify data quality

## Catalog Data Quality

```
WITH CATALOG_DATA AS (
SELECT 
  -- Splits the string and gets the 6th element (index 5)
  SPLIT(name, '/')[SAFE_OFFSET(5)] AS catalog_name,

  -- Splits the string and gets the 8th element (index 7)
  SPLIT(name, '/')[SAFE_OFFSET(7)] AS branch_id,
  *
FROM `retail_data.export_retail_products` 
),
UPDATE_MAX AS (
  SELECT name, MAX(update_time) AS max_update_time
  FROM `retail_data.export_retail_products` 
  GROUP BY 1
  ORDER BY 2 DESC
),
GET_MAX_CATALOG AS (
  SELECT CD.* FROM CATALOG_DATA CD
  LEFT JOIN UPDATE_MAX UM
  ON cd.name = um.name
  AND cd.update_time = um.max_update_time
  WHERE max_update_time IS NOT NULL 
  AND delete_time = TIMESTAMP("1970-01-01 00:00:00 UTC") 
)

SELECT *
FROM GET_MAX_CATALOG
WHERE type IN ("PRIMARY","VARIANT")
-- AND branch_id = "0"
```

## User Event Data Quality

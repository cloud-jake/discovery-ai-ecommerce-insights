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


#!/bin/bash

#TODO: 
# - update the export commands to use a Service Account
# - format the export commands to use scheduler


source variables.inc


# Generate Project Number
# gcloud command to get the Project_Number from a know PROJECT_ID
PROJECT_NUM=`gcloud projects describe $PROJECT_ID --format="value(projectNumber)"`

# Create BQ Dataset
# bq command to create a dataset ${EXPORT_DATASET} in Project $PROJECT_ID
bq mk --project_id ${PROJECT_ID} --dataset ${EXPORT_DATASET} 


# Create request.json for Product and User Event Data

echo '{
  "outputConfig":
  {
    "bigqueryDestination":
    {
      "datasetId": "'${EXPORT_DATASET}'",
        "tableIdPrefix": "'${EXPORT_PREFIX}'",
        "tableType": "view"
    }
  }
}' > request.json


curl -X POST \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    -H "Content-Type: application/json; charset=utf-8" \
    -H "x-goog-user-project: ${PROJECT_ID}" \
    -d @request.json \
    "https://retail.googleapis.com/v2alpha/projects/${PROJECT_ID}/locations/global/catalogs/default_catalog/userEvents:export"

curl -X POST \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    -H "Content-Type: application/json; charset=utf-8" \
    -H "x-goog-user-project: ${PROJECT_ID}" \
    -d @request.json \
    "https://retail.googleapis.com/v2alpha/projects/${PROJECT_ID}/locations/global/catalogs/default_catalog/branches/0/products:export"


# Create request-analytics.json for Analytics Metrics Data

echo '{
  "catalog": "projects/'${PROJECT_ID}'/locations/global/catalogs/default_catalog",  
  "outputConfig":
  {
    "bigqueryDestination":
    {
      "datasetId": "'${EXPORT_DATASET}'",
        "tableIdPrefix": "'${EXPORT_PREFIX}'",
        "tableType": "view"
    }
  }
}' > request-analytics.json

curl -X POST \
     -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json; charset=utf-8" \
     -H "x-goog-user-project: ${PROJECT_ID}" \
     -d @request-analytics.json \
     "https://retail.googleapis.com/v2/projects/${PROJECT_ID}/locations/global/catalogs/default_catalog:exportAnalyticsMetrics"
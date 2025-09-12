-- macros/create_azure_integration.sql
{% macro create_azure_integration() %}
{% set sql %}
CREATE OR REPLACE STORAGE INTEGRATION AZURE_INTEGRATION
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'AZURE'
  ENABLED = TRUE
  AZURE_TENANT_ID = 'e48ef36b-d204-4a33-80c8-f1e3b74fa725'
  STORAGE_ALLOWED_LOCATIONS = ('azure://stgaccdeviesandbox.blob.core.windows.net/devie');
{% endset %}
{{ run_query(sql) }}
{% do log("Storage Integration 'azure_integration' created (or replaced) successfully using Managed Identity", info=True) %}
{% endmacro %}

-- macros/create_azure_stage.sql
{% macro create_azure_stage() %}

{% set sql %}
create or replace stage bronze.azure_stage
  url = 'azure://stgdeviesandbox.blob.core.windows.net/devie'
  storage_integration = my_azure_integration
  file_format = (type = csv field_optionally_enclosed_by='"' skip_header=1);
{% endset %}

{{ run_query(sql) }}

{% do log("Stage 'bronze.azure_stage' created successfully", info=True) %}

{% endmacro %}

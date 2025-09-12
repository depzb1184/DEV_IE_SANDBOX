-- macros/create_stage.sql
{% macro create_azure_stage() %}
    create or replace bronze.bronze_azure_stage
    url='azure://stgdeviesandbox.blob.core.windows.net/devie'
    storage_integration = my_azure_integration
    file_format = (type = csv field_optionally_enclosed_by='' skip_header=1);
{% endmacro %}

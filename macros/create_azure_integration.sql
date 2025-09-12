-- macros/create_azure_integration.sql
{% macro create_azure_integration() %}

{% set sql %}
create or replace storage integration my_azure_integration
  type = external_stage
  storage_provider = azure
  enabled = true
  azure_tenant_id = '8d620fbc-eff3-4946-8633-21f9f7dd6338'
  storage_allowed_locations = ('azure://stgdeviesandbox.blob.core.windows.net/devie');
{% endset %}

{{ run_query(sql) }}

{% do log("Storage Integration 'my_azure_integration' created (or replaced) successfully", info=True) %}

{% endmacro %}

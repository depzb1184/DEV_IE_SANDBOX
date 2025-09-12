{% macro create_file_formats() %}
    {% set sql %}
        create or replace file format BRONZE.CSV
          type = csv
          field_optionally_enclosed_by = '"'
          skip_header = 1;
    {% endset %}

    {{ run_query(sql) }}
    {{ log("File format BRONZE.CSV created successfully", info=True) }}
{% endmacro %}

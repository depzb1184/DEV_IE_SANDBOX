{% macro get_nextval(seq_name) %}
    {{ target.database }}.{{ target.schema }}.{{ seq_name }}.NEXTVAL
{% endmacro %}

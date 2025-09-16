{% macro generate_dynamic_fields(column_name, max_count=10) %}
  {% for i in range(1, max_count + 1) %}
    case
      when split_part({{ column_name }}, '~', {{ i }}) in ('A','B','I','O','P','W')
      then 'RACE_' || split_part({{ column_name }}, '~', {{ i }})::string
      when split_part({{ column_name }}, '~', {{ i }}) = 'H'
      then 'ETHN_' || split_part({{ column_name }}, '~', {{ i }})::string
    end as datum{{ i }}_type_code,
    case
      when coalesce(split_part({{ column_name }}, '~', {{ i }}), '') <> '' then 'Y'::string
    end as datum{{ i }}_value,
    case
      when coalesce(split_part({{ column_name }}, '~', {{ i }}), '') <> '' then 'U'::string
    end as datum{{ i }}_record_status{% if not loop.last %},{% endif %}
  {% endfor %}
{% endmacro %}
{% macro generate_hospital_field(hosp_num) %}
    hosp_affil_bcbsnc_prov_{{ hosp_num }}_id as pra1_insp1_hosp_affil{{ hosp_num }}_facil_identifier,
    (
        case when hosp_affil_bcbsnc_prov_{{ hosp_num }}_id is not null 
        then (
            case 
                when misc_txt_15 in ('A','C') then 'U'::string
                when misc_txt_15 = 'D' then 'D'::string 
            end
        ) 
        end
    ) as pra1_insp1_hosp_affil{{ hosp_num }}_record_status
{% endmacro %}
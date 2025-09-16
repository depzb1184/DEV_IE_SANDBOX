{% macro generate_specialty_field(spe_num, f_index) %}
(
    case when impt.addtl_specl{{ f_index }}_cd != 'DME-IP' 
    then fs{{ f_index }}.field_specialty_id end
) as pra1_insp1_spe{{ spe_num }}_field_specialty_id,

(
    case when impt.addtl_specl{{ f_index }}_cd != 'DME-IP' 
         and fs{{ f_index }}.field_specialty_id is not null
    then (
        case 
            when misc_txt_15 in ('A','C') then 'U'::string 
            when misc_txt_15 = 'D' then 'D'::string 
        end
    ) end
) as pra1_insp1_spe{{ spe_num }}_record_status,

(
    case when impt.addtl_specl{{ f_index }}_cd != 'DME-IP' 
         and fs{{ f_index }}.field_specialty_id is not null
    then impt.prov_type_cd end
) as pra1_insp1_spe{{ spe_num }}_type_code,

'N'::string as pra1_insp1_spe{{ spe_num }}_is_principal
{% endmacro %}
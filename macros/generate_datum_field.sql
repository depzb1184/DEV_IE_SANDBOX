{% macro generate_datum_field(datum_num) %}
    {% set datum_config = {
        1: {
            "type_code": "'NETWR'::string",
            "value": "fut_ntwk_stat_cd",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
            "desc": "fut_ntwk_display_cd as pra1_insp1_datum1_desc",
        },
        2: {
            "type_code": "(case when addtl_specl1_cd='DME-IP' then 'IP' else null end)",
            "value": "(case when addtl_specl1_cd='DME-IP' then 'Y' else null end)",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        3: {
            "type_code": "(case when acpt_new_pat_cd IS NOT NULL then 'ANP' end)",
            "value": "(case when acpt_new_pat_cd IS NOT NULL then acpt_new_pat_cd end)",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        4: {
            "type_code": "(case when ded_ind IS NOT NULL then 'DED' end)",
            "value": "(case when ded_ind IS NOT NULL then ded_ind end)",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        5: {
            "type_code": "(case when coin_ind IS NOT NULL then 'COIN' end)",
            "value": "(case when coin_ind IS NOT NULL then coin_ind end)",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        6: {
            "type_code": "(case when partcp_type_cd IS NOT NULL then 'PARTCP' end)",
            "value": "(case when partcp_type_cd IS NOT NULL then partcp_type_cd end)",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        7: {
            "type_code": "(case when obc_ind IS NOT NULL then 'OBC' end)",
            "value": "(case when obc_ind IS NOT NULL then obc_ind end)",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        8: {
            "type_code": "(case when lower(ntwk_qlty1_desc)='state health plan-ppo' and ntwk_qlty1_cur_yr_rank IS NOT NULL then 'SPPOQC' when lower(ntwk_qlty1_desc)='tier cost and quality' and ntwk_qlty1_cur_yr_rank IS NOT NULL then 'TIERQC' end)",
            "value": "(case when lower(ntwk_qlty1_desc)='tier cost and quality' and cast(ntwk_qlty1_cur_yr_rank as string)='UR' then '3'::string else cast(ntwk_qlty1_cur_yr_rank as string) end)",
            "record_status": "(case when ntwk_qlty1_cur_yr_rank IS NOT NULL then (case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end) end)",
        },
        9: {
            "type_code": "(case when lower(ntwk_qlty1_desc)='state health plan-ppo' and ntwk_qlty1_fut_yr_rank IS NOT NULL then 'SPPOQF' when lower(ntwk_qlty1_desc)='tier cost and quality' and ntwk_qlty1_fut_yr_rank IS NOT NULL then 'TIERQF' end)",
            "value": "ntwk_qlty1_fut_yr_rank",
            "record_status": "(case when ntwk_qlty1_fut_yr_rank IS NOT NULL then (case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end) end)",
        },
        10: {
            "type_code": "(case when lower(ntwk_qlty2_desc)='blue cost and quality-ppo' and ntwk_qlty2_cur_yr_rank IS NOT NULL then 'BCQPC' end)",
            "value": "ntwk_qlty2_cur_yr_rank",
            "record_status": "(case when ntwk_qlty2_cur_yr_rank IS NOT NULL then (case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end) end)",
        },
        11: {
            "type_code": "(case when lower(ntwk_qlty2_desc)='blue cost and quality-ppo' and ntwk_qlty2_fut_yr_rank IS NOT NULL then 'BCQPF' end)",
            "value": "ntwk_qlty2_fut_yr_rank",
            "record_status": "(case when ntwk_qlty2_fut_yr_rank IS NOT NULL then (case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end) end)",
        },
        12: {
            "type_code": "'NSD'::string",
            "value": "ntwk_effect_dt::date",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        13: {
            "type_code": "'NED'::string",
            "value": "ntwk_term_dt::date",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
14: {
    "type_code": "(case 
                      when lower(ntwk_qlty1_desc)='state health plan-ppo' 
                           and ntwk_qlty1_cur_yr_rank in (1,2,3) then 'TIERSH' 
                      when lower(ntwk_qlty1_desc)='tier cost and quality' 
                           and ntwk_qlty1_cur_yr_rank = 9 then 'COSTTC' 
                      else NULL
                   end)::string",
    "value": "(case 
                 when lower(ntwk_qlty1_desc)='state health plan-ppo' 
                      and ntwk_qlty1_cur_yr_rank = 1 then '1'::string
                 when lower(ntwk_qlty1_desc)='state health plan-ppo' 
                      and ntwk_qlty1_cur_yr_rank = 2 then '2'::string
                 when lower(ntwk_qlty1_desc)='state health plan-ppo' 
                      and ntwk_qlty1_cur_yr_rank = 3 then '3'::string
                 when lower(ntwk_qlty1_desc)='tier cost and quality' 
                      and ntwk_qlty1_cur_yr_rank = 9 then 'UR'::string
                 else NULL
              end)",
    "record_status": "(case 
                         when ntwk_qlty1_cur_yr_rank IS NOT NULL then 
                             (case 
                                 when misc_txt_15 in ('A','C') then 'U'::string 
                                 when misc_txt_15='D' then 'D'::string 
                                 else NULL 
                              end)
                         else NULL
                      end)"
        },
        15: {
            "type_code": "(case when lower(ntwk_qlty2_desc)='blue cost and quality-ppo' and ntwk_qlty2_cur_yr_rank in ('HQLC','CA','HQO') then 'TIERBC' end)",
            "value": "(case when lower(ntwk_qlty2_desc)='blue cost and quality-ppo' and ntwk_qlty2_cur_yr_rank='HQLC' then '1'::string when lower(ntwk_qlty2_desc)='blue cost and quality-ppo' and ntwk_qlty2_cur_yr_rank ='CA' then '3'::string when lower(ntwk_qlty2_desc)='blue cost and quality-ppo' and ntwk_qlty2_cur_yr_rank ='HQO' then '2'::string end)",
            "record_status": "(case when ntwk_qlty2_cur_yr_rank IS NOT NULL then (case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end) end)",
        },
        16: {
            "type_code": "misc_txt_2",
            "value": "misc_txt_2",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        17: {
            "type_code": "case when misc_txt_3='Y' then 'FED'::string end",
            "value": "case when misc_txt_3='Y' then ntwk_effect_dt end",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        18: {
            "type_code": "case when misc_txt_4='Y' then 'FTD'::string end",
            "value": "case when misc_txt_4='Y' then ntwk_term_dt end",
            "record_status": "(case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end)",
        },
        19: {
            "type_code": "case when practn_low_age_lmt_nbr is not null then 'FRA'::string end",
            "value": "case when practn_low_age_lmt_nbr is not null then practn_low_age_lmt_nbr end",
            "record_status": "case when practn_low_age_lmt_nbr is not null then (case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end) end",
        },
        20: {
            "type_code": "case when practn_up_age_lmt_nbr is not null then 'TOA'::string end",
            "value": "case when practn_up_age_lmt_nbr is not null then practn_up_age_lmt_nbr end",
            "record_status": "case when practn_up_age_lmt_nbr is not null then (case when misc_txt_15 in ('A','C') then 'U'::string when misc_txt_15='D' then 'D'::string end) end",
        },
        21: {
            "type_code": "case when lower(ntwk_qlty1_desc)='cpp' and coalesce(ntwk_qlty1_cur_yr_rank::VARCHAR, '') <> '' then 'CPPQC' end",
            "value": "case when lower(ntwk_qlty1_desc)='cpp' and coalesce(ntwk_qlty1_cur_yr_rank::VARCHAR, '') <> '' then ntwk_qlty1_cur_yr_rank::VARCHAR end",
            "record_status": "case when lower(ntwk_qlty1_desc)='cpp' and coalesce(ntwk_qlty1_cur_yr_rank::VARCHAR, '') <> '' then 'U'::string end",
        },
        22: {
            "type_code": "case when lower(ntwk_qlty1_desc)='cpp' and coalesce(ntwk_qlty1_fut_yr_rank, '') <> '' then 'CPPQF' end",
            "value": "case when lower(ntwk_qlty1_desc)='cpp' and coalesce(ntwk_qlty1_fut_yr_rank, '') <> '' then ntwk_qlty1_fut_yr_rank end",
            "record_status": "case when lower(ntwk_qlty1_desc)='cpp' and coalesce(ntwk_qlty1_fut_yr_rank, '') <> '' then 'U'::string end",
        },
        23: {
            "type_code": "case when lower(ntwk_qlty1_desc)='mara-char' and coalesce(ntwk_qlty1_cur_yr_rank::VARCHAR, '') <> '' then 'MCHARCY' end",
            "value": "case when lower(ntwk_qlty1_desc)='mara-char' and coalesce(ntwk_qlty1_cur_yr_rank::VARCHAR, '') <> '' then ntwk_qlty1_cur_yr_rank::VARCHAR end",
            "record_status": "case when lower(ntwk_qlty1_desc)='mara-char' and coalesce(ntwk_qlty1_cur_yr_rank::VARCHAR, '') <> '' then 'U'::string end",
        },
        24: {
            "type_code": "case when coalesce(misc_txt_10,'')<>'' then 'CCC'::string end",
            "value": "case when coalesce(misc_txt_10,'')<>'' then 'Y'::string end",
            "record_status": "case when coalesce(misc_txt_10,'')<>'' then 'U'::string end",
        },
    } %}

    {% set config = datum_config.get(datum_num, {}) %}

    {{ config.get("type_code", "null::string") }}
    as pra1_insp1_datum{{ datum_num }}_type_code,
    {{ config.get("value", "null::string") }} as pra1_insp1_datum{{ datum_num }}_value,
    {{ config.get("record_status", "null::string") }}
    as pra1_insp1_datum{{ datum_num }}_record_status
    {% if config.get("desc") %}, {{ config.desc }} {% endif %}
{% endmacro %}

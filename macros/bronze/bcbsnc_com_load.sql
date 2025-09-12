{% macro load_from_stage(stage_name, schema_name, table_name) %}
  {# 
    Define column metadata: 
    - key = column name
    - value = snowflake datatype 
  #}

  {% set columns = [
    ("FILE_NAME", "VARCHAR"),
    ("LOAD_TYPE", "VARCHAR"),
    ("LOAD_TIME", "TIMESTAMP_LTZ"),
    ("BCBSNC_PROV_ID", "VARCHAR"),
    ("SRC_SYS_PROV_ID", "VARCHAR"),
    ("LOC_SEQ_ID", "NUMBER"),
    ("BCBSNC_ADDR_ID", "NUMBER"),
    ("NTWK_ID", "VARCHAR"),
    ("NTWK_EFFECT_DT", "DATE"),
    ("NTWK_TERM_DT", "DATE"),
    ("FUT_NTWK_STAT_CD", "VARCHAR"),
    ("FUT_NTWK_DISPLAY_CD", "VARCHAR"),
    ("PROV_TYPE_CD", "VARCHAR"),
    ("BCBSNC_PRACT_ID", "VARCHAR"),
    ("SRC_SYS_PRACT_ID", "VARCHAR"),
    ("NPI", "NUMBER"),
    ("DEA_ID", "VARCHAR"),
    ("PRIM_SPECL_CD", "VARCHAR"),
    ("ADDTL_SPECL1_CD", "VARCHAR"),
    ("ADDTL_SPECL2_CD", "VARCHAR"),
    ("BOARD_CERT_1_CD", "VARCHAR"),
    ("BOARD_CERT_2_CD", "VARCHAR"),
    ("BOARD_CERT_3_CD", "VARCHAR"),
    ("BOARD_CERT_4_CD", "VARCHAR"),
    ("BOARD_CERT_5_CD", "VARCHAR"),
    ("PROV_FULL_NM", "VARCHAR"),
    ("PROV_LAST_NM", "VARCHAR"),
    ("PROV_FRST_NM", "VARCHAR"),
    ("PROV_MID_NM", "VARCHAR"),
    ("TITL_NM", "VARCHAR"),
    ("GEND_CD", "VARCHAR"),
    ("PRACTICE_NM", "VARCHAR"),
    ("SEC_LNG_1_CD", "VARCHAR"),
    ("SEC_LNG_2_CD", "VARCHAR"),
    ("SEC_LNG_3_CD", "VARCHAR"),
    ("SEC_LNG_4_CD", "VARCHAR"),
    ("SEC_LNG_5_CD", "VARCHAR"),
    ("URL_NM", "VARCHAR"),
    ("EMAIL_ADDR", "VARCHAR"),
    ("ADDR_1_NM", "VARCHAR"),
    ("ADDR_2_NM", "VARCHAR"),
    ("ADDR_3_NM", "VARCHAR"),
    ("CITY_NM", "VARCHAR"),
    ("CNTY_NM", "VARCHAR"),
    ("ST_NM", "VARCHAR"),
    ("ZIP", "NUMBER"),
    ("ANCILLARY_ADDR_DISPLAY_IND", "BOOLEAN"),
    ("ADDR_SUPRES_IND", "BOOLEAN"),
    ("REGN_CD", "VARCHAR"),
    ("MKT_NM", "VARCHAR"),
    ("PHONE_NBR", "VARCHAR"),
    ("PHONE_EXT_NBR", "VARCHAR"),
    ("FAX_NBR", "VARCHAR"),
    ("FAX_EXT_NBR", "VARCHAR"),
    ("MED_SCHL_UNIV_1_NM", "VARCHAR"),
    ("MED_SCHL_UNIV_1_YEAR", "NUMBER"),
    ("RESD_SCHL_UNIV_2_NM", "VARCHAR"),
    ("RESD_SCHL_UNIV_2_YEAR", "NUMBER"),
    ("INRTN_SCHL_UNIV_3_NM", "VARCHAR"),
    ("INRTN_SCHL_UNIV_3_YEAR", "NUMBER"),
    ("ACPT_NEW_PAT_CD", "BOOLEAN"),
    ("HOSP_AFFIL_BCBSNC_PROV_1_ID", "VARCHAR"),
    ("HOSP_AFFIL_BCBSNC_PROV_2_ID", "VARCHAR"),
    ("HOSP_AFFIL_BCBSNC_PROV_3_ID", "VARCHAR"),
    ("HOSP_AFFIL_BCBSNC_PROV_4_ID", "VARCHAR"),
    ("HOSP_AFFIL_BCBSNC_PROV_5_ID", "VARCHAR"),
    ("ELCTR_MED_REC_IND", "VARCHAR"),
    ("ELCTR_PRESCR_IND", "VARCHAR"),
    ("MED_DECSN_SUPRT_IND", "VARCHAR"),
    ("PARK_CD_IND", "VARCHAR"),
    ("TDD_ACCS_IND", "VARCHAR"),
    ("DED_IND", "BOOLEAN"),
    ("COIN_IND", "BOOLEAN"),
    ("PARTCP_TYPE_CD", "VARCHAR"),
    ("OBC_IND", "BOOLEAN"),
    ("HANDCP_ACCS_IND", "BOOLEAN"),
    ("NTWK_QLTY1_DESC", "VARCHAR"),
    ("NTWK_QLTY1_CUR_YR_RANK", "NUMBER"),
    ("NTWK_QLTY1_CUR_YR", "NUMBER"),
    ("NTWK_QLTY1_FUT_YR_RANK", "VARCHAR"),
    ("NTWK_QLTY1_FUT_YR", "VARCHAR"),
    ("FUT_QLTY1_DISPLAY_IND", "BOOLEAN"),
    ("NTWK_QLTY2_DESC", "VARCHAR"),
    ("NTWK_QLTY2_CUR_YR_RANK", "VARCHAR"),
    ("NTWK_QLTY2_CUR_YR", "NUMBER"),
    ("NTWK_QLTY2_FUT_YR_RANK", "VARCHAR"),
    ("NTWK_QLTY2_FUT_YR", "NUMBER"),
    ("FUT_QLTY2_DISPLAY_IND", "BOOLEAN"),
    ("MISC_TXT_1", "VARCHAR"),
    ("MISC_TXT_2", "VARCHAR"),
    ("MISC_TXT_3", "BOOLEAN"),
    ("MISC_TXT_4", "BOOLEAN"),
    ("MISC_TXT_5", "VARCHAR"),
    ("MISC_TXT_6", "VARCHAR"),
    ("MISC_TXT_7", "BOOLEAN"),
    ("MISC_TXT_8", "VARCHAR"),
    ("MISC_TXT_9", "BOOLEAN"),
    ("MISC_TXT_10", "VARCHAR"),
    ("MISC_TXT_11", "VARCHAR"),
    ("MISC_TXT_12", "VARCHAR"),
    ("MISC_TXT_13", "VARCHAR"),
    ("MISC_TXT_14", "VARCHAR"),
    ("MISC_TXT_15", "VARCHAR"),
    ("PRACTN_LOW_AGE_LMT_NBR", "NUMBER"),
    ("PRACTN_UP_AGE_LMT_NBR", "NUMBER")
  ] %}

  {# Build select statement dynamically #}
  {% set select_parts = [] %}
  {% for col in columns %}
    {% set col_index = loop.index %}
    {% set col_name = col[0] %}
    {% set col_type = col[1] %}

    {% if col_type == "NUMBER" %}
      {% set expr = "TRY_TO_NUMBER($" ~ col_index ~ ") AS " ~ col_name %}
    {% elif col_type == "TIMESTAMP_LTZ" %}
      {% set expr = "TRY_TO_TIMESTAMP($" ~ col_index ~ ") AS " ~ col_name %}
    {% elif col_type == "DATE" %}
      {% set expr = "TRY_TO_DATE($" ~ col_index ~ ") AS " ~ col_name %}
    {% elif col_type == "BOOLEAN" %}
      {% set expr = "TRY_TO_BOOLEAN($" ~ col_index ~ ") AS " ~ col_name %}
    {% else %}
      {% set expr = "$" ~ col_index ~ " AS " ~ col_name %}
    {% endif %}

    {% do select_parts.append(expr) %}
  {% endfor %}

  {# Final SQL #}
  {{ return(
    "SELECT\n    " ~ select_parts | join(',\n    ') ~
    "\nFROM @" ~ schema_name ~ "." ~ stage_name ~ " (FILE_FORMAT => 'CSV')"
  ) }}
{% endmacro %}


{% set timeseries = [
  'lpd_cap_gain_dt_long_term_cap_gain',
  'lpd_cap_gain_dt_qualified_short_term_cap_gain', 
  'lpd_cap_gain_dt_non_qual_short_term_cap_gain', 
  'lpd_cap_gain_dt_short_term_cap_gain',
  'lpd_cap_gain_dt_medium_term_cap_gain',
  'lpd_cap_gain_dt_capital_gain',
  'lpd_cap_gain_dt_reit_section_1250',
  'lpd_cap_gain_dt_return_of_capital'
  ] 
%}

with mf_cap_gain as (
  {% for table_name in timeseries %}
    
    SELECT 
      id, 
      date, 
      value,
      'mf_cap_gain' as type,
      '{{ table_name }}' as detail
    FROM {{ source('tsm', table_name) }}
    
    {% if not loop.last %}
    UNION ALL
    {% endif %}

  {% endfor %}
)

SELECT * FROM mf_cap_gain
ORDER by id, date

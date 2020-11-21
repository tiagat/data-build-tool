
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


with timeseries_duplicates as (
  {% for table_name in timeseries %}
    
    select count(*)
    from {{ source('tsm', table_name) }}
    group by id, date
    having count(*) > 1
    
    {% if not loop.last %}
    UNION ALL
    {% endif %}

  {% endfor %}
)

select * from timeseries_duplicates

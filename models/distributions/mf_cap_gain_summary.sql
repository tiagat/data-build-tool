
select 
  id, 
  date, 
  sum(value) as value
from {{ ref('mf_cap_gain') }}
group by id, date
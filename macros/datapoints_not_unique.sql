{% macro test_datapoints_not_unique(model) %}

with validation_errors as (
  select count(*)
  from {{ model }}
  group by id, date
  having count(*) > 1
)

select count(*)
from validation_errors

{% endmacro %}

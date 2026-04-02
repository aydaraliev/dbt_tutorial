Замените `from taxi_rides_raw` на `from {{ ref('taxi_rides_raw') }}`, затем `dbt run -f`.

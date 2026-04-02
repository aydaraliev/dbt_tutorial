# Создание и запуск первой модели

Сначала удалите примеры моделей, которые dbt сгенерировал автоматически:

```
rm -rf /root/nyc_yellow_taxi/models/example
```{{exec}}

Создайте модель, которая считает количество поездок и среднюю стоимость по зонам посадки из набора данных NYC Yellow Taxi:

```
cat > /root/nyc_yellow_taxi/models/taxi_zone_summary.sql << 'EOF'
SELECT
    PULocationID AS pickup_zone_id,
    COUNT(*) AS total_trips,
    ROUND(AVG(total_amount), 2) AS avg_total_amount,
    ROUND(AVG(trip_distance), 2) AS avg_distance
FROM read_parquet('/root/data/yellow_tripdata_2023-01.parquet')
GROUP BY PULocationID
ORDER BY total_trips DESC
EOF
```{{exec}}

Теперь запустите dbt:

```
cd /root/nyc_yellow_taxi && dbt run
```{{exec}}

В выводе должно быть сообщение об успешном создании модели `taxi_zone_summary`.

dbt создал **представление (view)** в DuckDB из вашей SQL-модели.

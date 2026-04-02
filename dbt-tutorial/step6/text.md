# Создание модели dbt

В dbt модели — это SQL-файлы в директории `models/`. При выполнении `dbt run` каждый SQL-файл компилируется и выполняется в базе данных. По умолчанию dbt создаёт **представление (view)**, а не таблицу.

## Задание

Заполните пропуск в файле `models/taxi_rides/taxi_rides_raw.sql` и материализуйте модель.

<details>
<summary>Решение</summary>

Замените `____` на `yellow_tripdata_2023-01-partial.parquet`, затем `cd ~/nyc_yellow_taxi && dbt run`.

</details>

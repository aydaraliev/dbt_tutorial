# Создание модели dbt

В dbt модели — это SQL-файлы в директории `models/`. При выполнении `dbt run` каждый SQL-файл компилируется и выполняется в базе данных. По умолчанию dbt создаёт **представление (view)**, а не таблицу.

## Задание

- В файле `nyc_yellow_taxi/models/taxi_rides/taxi_rides_raw.sql` замените `____` на имя parquet-файла `yellow_tripdata_2023-01-partial.parquet`.

- В терминале перейдите в директорию `nyc_yellow_taxi` командой `cd`.

- Выполните соответствующую подкоманду `dbt` из директории `nyc_yellow_taxi/` для материализации модели.

<details>
<summary>Подсказка</summary>

Замените `____` на `yellow_tripdata_2023-01-partial.parquet`, затем `cd ~/nyc_yellow_taxi && dbt run`.

</details>

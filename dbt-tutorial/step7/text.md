# Запуск проекта

В предыдущем шаге вы использовали короткий синтаксис DuckDB для чтения parquet-файла. В dbt-моделях можно свободно использовать любой SQL-синтаксис, включая CTE (Common Table Expressions) и функции DuckDB, такие как `read_parquet()`.

В файле `taxi_rides_raw.sql` уже есть шаблон запроса с CTE и пропуском. Для проверки результата используйте скрипт `./datacheck` — это Python-скрипт для валидации данных, он не является частью dbt.

## Задание

- Выполните `dbt run` и обратите внимание на ошибку.

- Исправьте запрос в файле `taxi_rides_raw.sql`. Замените `_____` на:

  `select * from read_parquet('yellow_tripdata_2023-01-partial.parquet')`

- Запустите проект снова и убедитесь, что ошибка исправлена.

- Выполните `./datacheck`, чтобы убедиться, что в представлении 500000 записей.

<details>
<summary>Подсказка</summary>

Замените `_____` на `select * from read_parquet('yellow_tripdata_2023-01-partial.parquet')`, затем `dbt run` и `./datacheck`.

</details>

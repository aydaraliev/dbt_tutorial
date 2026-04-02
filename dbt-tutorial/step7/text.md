# Запуск проекта

В предыдущем шаге вы использовали короткий синтаксис DuckDB для чтения parquet-файла. В dbt-моделях можно свободно использовать любой SQL-синтаксис, включая CTE (Common Table Expressions) и функции DuckDB, такие как `read_parquet()`.

В файле `taxi_rides_raw.sql` уже есть шаблон запроса с CTE и пропуском. Для проверки результата используйте скрипт `./datacheck` — это Python-скрипт для валидации данных, он не является частью dbt.

Запустите `dbt run` — вы увидите ошибку. Исправьте запрос в `taxi_rides_raw.sql`, запустите снова и проверьте результат скриптом `./datacheck`.

<details>
<summary>Подсказка</summary>

Замените `_____` на `select * from read_parquet('yellow_tripdata_2023-01-partial.parquet')`, затем `dbt run` и `./datacheck` (ожидается 500000 записей).

</details>

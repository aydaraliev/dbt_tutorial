# Запуск проекта

В предыдущем шаге вы использовали короткий синтаксис DuckDB для чтения parquet-файла. В dbt-моделях можно свободно использовать любой SQL-синтаксис, включая CTE (Common Table Expressions) и функции DuckDB, такие как `read_parquet()`.

В файле `taxi_rides_raw.sql` уже есть шаблон запроса с CTE и пропуском. Для проверки результата используйте скрипт `./datacheck` — это Python-скрипт для валидации данных, он не является частью dbt.

## Задание

Запустите проект, исправьте ошибку в запросе и проверьте результат скриптом `./datacheck`.

<details>
<summary>Решение</summary>

Замените <code>_____</code> на <code>select * from read_parquet('yellow_tripdata_2023-01-partial.parquet')</code>, затем <code>dbt run</code> и <code>./datacheck</code> (ожидается 500000 записей).

</details>

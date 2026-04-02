# Обработка Jinja-шаблона

dbt использует Jinja — язык шаблонов, который позволяет генерировать SQL-код динамически. В файле `models/taxi_rides/total_amounts.sql` используется цикл `{% for %}` для перебора колонок. Вам не нужно понимать сам SQL — просто сравните шаблон с результатом компиляции.

## Задание

Скомпилируйте проект и сравните исходный шаблон с результатом.

<details>
<summary>Решение</summary>

`dbt compile`, затем откройте `target/compiled/nyc_yellow_taxi/models/taxi_rides/total_amounts.sql`.

</details>

# Обработка Jinja-шаблона

dbt использует Jinja — язык шаблонов, который позволяет генерировать SQL-код динамически. В файле `models/taxi_rides/total_amounts.sql` используется цикл `{% for %}` для перебора колонок. Вам не нужно понимать сам SQL — просто сравните шаблон с результатом компиляции.

Скомпилируйте проект и сравните исходный шаблон `models/taxi_rides/total_amounts.sql` с результатом компиляции.

<details>
<summary>Подсказка</summary>

`dbt compile`, затем откройте `target/compiled/nyc_yellow_taxi/models/taxi_rides/total_amounts.sql`.

</details>

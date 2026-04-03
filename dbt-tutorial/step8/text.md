# Создание новой модели

Необходимо посчитать всех пользователей **кредитных карт** по дням на основе текущих моделей dbt. Новая модель называется `total_creditcard_riders_by_day` и содержит колонки `day` и `total_cc_riders`.

Модель `taxi_rides_raw` уже доступна как представление, к которому можно обращаться напрямую.

Описание всех колонок и коды типов оплаты находятся в файле `data_dictionary.txt` в корне проекта.

## Задание

Изучите словарь данных, заполните пропуски в `total_creditcard_riders_by_day.sql`, материализуйте модель и проверьте результат.

<details>
<summary>Решение</summary>

Замените первый <code>____</code> на <code>count(*)</code>, второй на <code>1</code> (credit card payment type). Затем <code>dbt run</code> и <code>./datacheck</code>.

</details>

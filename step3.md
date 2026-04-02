# Создание и запуск первой модели

Сначала удалите примеры моделей, которые dbt сгенерировал автоматически:

```
rm -rf /root/my_dbt_project/models/example
```{{exec}}

Создайте модель, которая объединяет клиентов с агрегированными данными по заказам:

```
cat > /root/my_dbt_project/models/customer_orders.sql << 'EOF'
WITH customer_orders AS (
    SELECT
        c.id AS customer_id,
        c.name,
        c.email,
        COUNT(o.id) AS total_orders,
        SUM(o.amount) AS total_amount
    FROM raw.customers c
    LEFT JOIN raw.orders o ON c.id = o.customer_id
    GROUP BY c.id, c.name, c.email
)

SELECT
    customer_id,
    name,
    email,
    total_orders,
    total_amount
FROM customer_orders
EOF
```{{exec}}

Теперь запустите dbt:

```
cd /root/my_dbt_project && dbt run
```{{exec}}

В выводе должно быть сообщение об успешном создании модели `customer_orders`.

Проверьте результат, выполнив запрос к новому представлению:

```
sudo -u postgres psql -d dbt_db -c "SELECT * FROM public.customer_orders;"
```{{exec}}

dbt создал **представление (view)** в схеме `public` из вашей SQL-модели.

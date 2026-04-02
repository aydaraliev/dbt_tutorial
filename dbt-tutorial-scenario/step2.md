# Инициализация проекта dbt

Создайте новый проект dbt:

```
cd /root && dbt init my_dbt_project
```{{exec}}

Когда появится запрос:
- Выберите **postgres** в качестве базы данных (введите `1`)

Теперь настроим профиль подключения. Заменим стандартный профиль нашими настройками:

```
mkdir -p /root/.dbt && cat > /root/.dbt/profiles.yml << 'EOF'
my_dbt_project:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      port: 5432
      user: dbt_user
      password: dbt_pass
      dbname: dbt_db
      schema: public
      threads: 1
EOF
```{{exec}}

Перейдите в директорию проекта и проверьте подключение:

```
cd /root/my_dbt_project && dbt debug
```{{exec}}

Внизу вывода должно быть **All checks passed!** — это подтверждает, что dbt может подключиться к PostgreSQL.

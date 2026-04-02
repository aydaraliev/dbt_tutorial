# Initialize a dbt project

Create a new dbt project:

```
cd /root && dbt init my_dbt_project
```{{exec}}

When prompted:
- Choose **postgres** as the database (enter `1`)

Now configure the connection profile. Replace the default profile with our settings:

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

Navigate into the project and test the connection:

```
cd /root/my_dbt_project && dbt debug
```{{exec}}

You should see **All checks passed!** at the bottom. This confirms dbt can connect to PostgreSQL.

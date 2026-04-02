#!/bin/bash



apt-get update -qq && apt-get install -y -qq python3-pip python3-venv > /dev/null 2>&1

python3 -m venv /opt/dbt-env
/opt/dbt-env/bin/pip install --quiet dbt-duckdb

# dbt wrapper: logs every invocation then calls the real binary
cat > /usr/local/bin/dbt << 'WRAPPER'
#!/bin/bash
echo "$(date -Iseconds) dbt $*" >> /tmp/dbt_history
exec /opt/dbt-env/bin/dbt "$@"
WRAPPER
chmod +x /usr/local/bin/dbt

touch /tmp/setup-done

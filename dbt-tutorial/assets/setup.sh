#!/bin/bash

# Hide dotfiles and system dirs from the IDE file explorer
mkdir -p /root/.theia
cat > /root/.theia/settings.json << 'SETTINGS'
{
  "files.exclude": {
    "**/.cache": true,
    "**/.ssh": true,
    "**/.theia": true,
    "**/.bash_history": true,
    "**/.bashrc": true,
    "**/.profile": true,
    "**/.vimrc": true,
    "**/.wget-hsts": true,
    "**/filesystem": true
  }
}
SETTINGS

# Copy parquet data to a clean path
mkdir -p /root/data
cp /root/assets/yellow_tripdata_2023-01.parquet /root/data/ 2>/dev/null || true

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

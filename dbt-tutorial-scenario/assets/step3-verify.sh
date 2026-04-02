#!/bin/bash
# Verify the customer_orders model exists
test -f /root/my_dbt_project/models/customer_orders.sql && \
sudo -u postgres psql -d dbt_db -tAc "SELECT COUNT(*) FROM public.customer_orders;" 2>/dev/null | grep -q "^3$"

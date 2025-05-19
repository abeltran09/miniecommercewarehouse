from db import run_sql_script, create_stage_table

# create tables
tables = ["stage_table", "ddl_dim_tables", "ddl_fact_tables"]
for script in tables:
    run_sql_script(f"sql/{script}.sql")

create_stage_table()

# transformations
run_sql_script("sql/transformations.sql")

# Create sales_fact
run_sql_script("sql/sql_sales_fact.sql")


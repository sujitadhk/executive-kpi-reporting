# Executive KPI Reporting from a Consolidated Warehouse

Turns the centralized warehouse built in
[`crm-excel-data-consolidation-pipeline`](../crm-excel-data-consolidation-pipeline) into
**C-level-ready reporting**: a formatted Excel workbook with native charts, a plain-English executive
summary, and CSV exports ready to load into **Power BI**.

## What it produces (`output/`)

| File | Purpose |
|---|---|
| `executive_kpi_report.xlsx` | Summary KPIs + monthly trend, region, category, segment/country and top-customer sheets, with charts |
| `executive_summary.md` | Auto-written headline findings for managers |
| `*.csv` | Clean tables to import into Power BI for dashboards |

## KPIs covered
Total revenue, orders, active customers, average order value, average discount, monthly revenue trend,
revenue by region / category / segment / country, top 10 customers.

All KPI logic lives in plain, readable SQL: [`sql/kpi_queries.sql`](sql/kpi_queries.sql).

## Run it

```bash
# 1. Build the warehouse (project 1)
cd ../crm-excel-data-consolidation-pipeline && pip install -r requirements.txt && python main.py
# 2. Build the report
cd ../executive-kpi-reporting && pip install -r requirements.txt && python build_report.py
# or point at any warehouse with the same schema:
python build_report.py --db path/to/warehouse.db
```

## Power BI
Open Power BI Desktop → Get Data → Text/CSV → select the files in `output/` → build visuals
(line chart for `monthly_revenue`, bar charts for region/category, table for `top_customers`).

## Tech stack
Python · SQL · Pandas · openpyxl · Excel · Power BI

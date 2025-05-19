INSERT INTO dim_date (date, timestamp, month, day, year, day_nm)
SELECT
    DISTINCT(InvoiceDate::date) as date,
    InvoiceDate,
    EXTRACT(MONTH FROM InvoiceDate),
    EXTRACT(DAY FROM InvoiceDate),
    EXTRACT(YEAR FROM InvoiceDate),
    TO_CHAR(InvoiceDate, 'DAY')
FROM staging_sales;

INSERT INTO dim_customer (customer_id, country)
SELECT
    DISTINCT CustomerID, Country
FROM staging_sales
WHERE CustomerID IS NOT NULL;

INSERT INTO dim_product (product_id, description)
SELECT
    DISTINCT StockCode, Description
FROM staging_sales
WHERE StockCode IS NOT NULL;


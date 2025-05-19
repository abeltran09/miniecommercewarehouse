INSERT INTO sales_fact (
    invoice_num,
    customer_sk,
    product_sk,
    date,
    quantity,
    unit_price,
    total_price,
    transaction_type
)
SELECT
    s.invoiceNo,
    dc.customer_sk,
    dp.product_sk,
    s.InvoiceDate::Date AS date,
    s.Quantity,
    s.UnitPrice,
    s.Quantity * s.UnitPrice as total_price,
    CASE
        WHEN s.Quantity < 0 THEN 'return'
        ELSE 'sale'
    END AS transaction_type
FROM staging_sales s
INNER JOIN dim_customer dc
    ON s.CustomerID = dc.customer_id
INNER JOIN dim_product dp
    ON s.StockCode = dp.product_id
INNER JOIN dim_date dd
    ON InvoiceDate::date = dd.date
WHERE s.CustomerID IS NOT NULL
    AND s.StockCode IS NOT NULL
GROUP BY
    s.invoiceNo,
    dc.customer_sk,
    product_sk,
    InvoiceDate::date,
    s.Quantity,
    s.UnitPrice;


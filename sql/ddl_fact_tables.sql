DROP TABLE IF EXISTS sales_fact;
CREATE TABLE sales_fact (
    invoice_num VARCHAR(250),
    customer_sk INT,
    product_sk INT,
    date date,
    quantity INT,
    unit_price float,
    total_price float,
    transaction_type VARCHAR(10)
);
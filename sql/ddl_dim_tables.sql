DROP TABLE IF EXISTS dim_customer;
CREATE TABLE dim_customer (
    customer_sk INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT,
    country VARCHAR(250)
);

DROP TABLE IF EXISTS dim_date;
CREATE TABLE dim_date (
    date_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date date,
    timestamp timestamp,
    month SMALLINT,
    day SMALLINT,
    year SMALLINT,
    day_nm VARCHAR(20)
);

DROP TABLE IF EXISTS dim_product;
CREATE TABLE dim_product (
    product_sk INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id VARCHAR(250),
    description TEXT
);
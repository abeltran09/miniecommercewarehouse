DROP TABLE IF EXISTS staging_sales;
CREATE TABLE staging_sales (
    invoiceNo VARCHAR(250),
    StockCode VARCHAR(250),
    Description Text,
    Quantity INT,
    InvoiceDate timestamp,
    UnitPrice float,
    CustomerID INT,
    Country VARCHAR(250)
);
-- ANSWER 1
WITH SplitProducts AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(value) AS Product
    FROM ProductDetail
    CROSS APPLY STRING_SPLIT(Products, ',')
)
SELECT 
    OrderID,
    CustomerName,
    Product
FROM SplitProducts
ORDER BY OrderID, Product;


-- answer 2

-- Create Orders table (removes the partial dependency)
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create OrderItems table (contains only full dependencies)
CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Set primary keys
ALTER TABLE Orders ADD PRIMARY KEY (OrderID);
ALTER TABLE OrderItems ADD PRIMARY KEY (OrderID, Product);

-- Add foreign key constraint
ALTER TABLE OrderItems ADD CONSTRAINT fk_order
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
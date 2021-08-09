CREATE TABLE customers (
  `Customer` INTEGER,
  `ID_Type` VARCHAR(8),
  `Phone_Number` VARCHAR(12)
);

INSERT INTO customers
  (`Customer`, `ID_Type`, `Phone_Number`)
VALUES
  ('1001', 'Cellular', '555-897-5421'),
  ('1001', 'Work', '555-897-6542'),
  ('1001', 'Home', '555-698-9874'),
  ('2002', 'Cellular', '555-963-6544'),
  ('2002', 'Work', '555-812-9856'),
  ('3003', 'Cellular', '555-987-6541');

-- Pivot the ID Type to its own columns
-- MySQL supports pivot function but at this moment I found it to be a bit too confusing
-- So, I went with multiple join statements with CTE

With
Cellular as
(SELECT Customer, Phone_Number as Cellular
FROM customers
WHERE ID_Type="Cellular"),

Work as
(SELECT Customer, Phone_Number as Work
FROM customers
WHERE ID_Type="Work"),

Home as
(SELECT Customer, Phone_Number as Home
FROM customers
WHERE ID_Type="Home"),

Cellular_Work as
(SELECT Cellular.Customer, Cellular.Cellular, Work.Work
FROM Cellular
LEFT JOIN Work
ON Cellular.customer = Work.customer)

SELECT Cellular_Work.Customer, Cellular_Work.Cellular, Cellular_Work.Work, Home.Home
FROM Cellular_Work
LEFT JOIN Home
ON Cellular_Work.customer = Home.customer
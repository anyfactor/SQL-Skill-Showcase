-- Finding IDs that had delivery to two states

WITH 
CA_order as (
  SELECT * FROM customers
  WHERE `Delivery State` = 'CA'
),

TX_order as (
  SELECT * FROM customers
  WHERE `Delivery State` = 'TX'
)

SELECT TX_order.`Customer ID`, TX_order.`Order ID`,
	TX_order.`Delivery State`, TX_order.`Amount` FROM TX_order
JOIN CA_order
WHERE CA_order.`Customer ID` = TX_order.`Customer ID`
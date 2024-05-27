/* Q3. วันที่ซื้อขายมีความสัมพันธ์กับประเทศหรือผลิตภัณฑ์หรือไม่?
*/ 

WITH B AS(
SELECT
	DISTINCT cus.Country, 
	cat.CategoryName,
    YEAR(o.OrderDate) AS Year,
	ROUND(SUM(o.TotalSales) OVER( PARTITION BY cus.Country,cat.CategoryName, YEAR(o.OrderDate) ),2) AS Total_Sale,
    ROUND(SUM(o.Profit) OVER( PARTITION BY cus.Country,cat.CategoryName, YEAR(o.OrderDate) ),2) AS Total_Profit
FROM order_detail o
LEFT JOIN products p ON o.ProductID = p.ProductID
LEFT JOIN customers cus ON o.CustomerID = cus.CustomerID
LEFT JOIN categories cat ON p.CategoryID = cat.CategoryID
)
SELECT 
	B.*,
    ROUND(B.Total_Profit *100 / B.Total_Sale,2) AS Margin
FROM B


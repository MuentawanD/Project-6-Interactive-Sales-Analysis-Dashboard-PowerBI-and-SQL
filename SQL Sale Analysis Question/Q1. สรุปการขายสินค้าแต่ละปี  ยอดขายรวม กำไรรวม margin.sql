/* Q1. สรุปการขายสินค้าแต่ละปี  ยอดขายรวม กำไรรวม margin */

WITH A AS ( 
SELECT 
	distinct YEAR(OrderDate) AS Year,
    CONCAT("Q", QUARTER(OrderDate)) AS Quarter, 
    QUARTER(OrderDate) AS Quarter_Num,
    MONTHNAME(OrderDate) AS Month,
    MONTH(OrderDate) As Month_Num,
	ROUND(SUM(Quantity) OVER (PARTITION BY YEAR(OrderDate) ORDER BY QUARTER(OrderDate), MONTH(OrderDate)),2)  AS Total_Quantity,
	ROUND(SUM(TotalCosts) OVER (PARTITION BY YEAR(OrderDate) ORDER BY QUARTER(OrderDate), MONTH(OrderDate)),2) AS Total_Cost,
	ROUND(SUM(TotalSales) OVER (PARTITION BY YEAR(OrderDate) ORDER BY QUARTER(OrderDate), MONTH(OrderDate)),2) AS Total_Sale,
    ROUND(SUM(Profit) OVER (PARTITION BY YEAR(OrderDate) ORDER BY QUARTER(OrderDate), MONTH(OrderDate)),2) AS Total_profit
FROM order_detail
)
SELECT 
	A.*,
    ROUND(A.Total_profit *100/ A.Total_Sale ,2) AS Margin
FROM A ;
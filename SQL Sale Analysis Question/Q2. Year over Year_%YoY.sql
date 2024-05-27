/* Q2. Year over Year
YOY BY CategoryName
LAG(sales, 1) OVER (ORDER BY year) จะเลื่อนยอดขายย้อนหลังไป 1 ปี โดยเรียงตามปี 
จากนั้นคำนวณอัตราการเติบโต YoY จากสูตร (current_value - previous_value) / previous_value
*/

SELECT
	cat.CategoryName AS CategoryName,
    YEAR(o.OrderDate) AS Year,
    ROUND(SUM(o.Quantity),2 ) AS Total_Quantity,
    ROUND(SUM(o.TotalSales),2 ) AS Total_Sale,
	ROUND(SUM(o.Profit),2 ) AS Total_Profit,
	ROUND(SUM(o.Profit) *100 / SUM(o.TotalSales) ,2 ) AS Margin,
    ROUND(SUM(o.TotalSales),2 ) AS Current_Year_Sales,
    ROUND(LAG(SUM(o.TotalSales), 1) OVER (PARTITION BY cat.CategoryName ORDER BY YEAR(o.OrderDate)),2) AS previous_year_sales,
    ROUND((SUM(o.TotalSales) - LAG(SUM(o.TotalSales), 1) OVER (PARTITION BY cat.CategoryName ORDER BY YEAR(o.OrderDate)))*100 / LAG(SUM(o.TotalSales), 1) OVER (PARTITION BY cat.CategoryName ORDER BY YEAR(o.OrderDate)),2) AS YoY_Sale_Growth_by_Cat
FROM order_detail o
LEFT JOIN products p ON o.ProductID = p.ProductID
LEFT JOIN categories cat ON p.CategoryID = cat.CategoryID
GROUP BY Year, CategoryName;


/*
Q5.มีปัจจัยใดที่ส่งผลต่อ Margin เช่น ต้นทุนการผลิต ราคาขาย ฯลฯ
*/
SELECT
	cat.CategoryName,
    ROUND(SUM(o.Quantity),2 ) AS Quantity,
    ROUND(SUM(o.TotalSales),2 ) AS Total_Sale,
    ROUND(SUM(o.TotalCosts),2 ) AS Total_Cost,
    ROUND(SUM(o.Profit),2 ) AS Total_profit,
    ROUND(AVG(o.TotalCosts/ o.Quantity),2) AS Unit_Cost ,
    ROUND(AVG(o.TotalSales/ o.Quantity),2) AS Unit_Price,
    ROUND(SUM(o.Profit)*100/ SUM(o.TotalSales),2) AS Margin
FROM order_detail o
LEFT JOIN products p ON o.ProductID = p.ProductID
LEFT JOIN categories cat ON p.CategoryID = cat.CategoryID
GROUP BY cat.CategoryName
ORDER BY Total_Sale DESC;
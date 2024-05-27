/*
Q4. ผลิตภัณฑ์ใดมี Margin สูงสุด? อาจบ่งชี้ผลิตภัณฑ์ที่มีกำไรสูง
*/
SELECT
	cat.CategoryName,
    ROUND(SUM(o.TotalSales),2 ) AS Total_Sale,
    ROUND(SUM(o.Profit),2 ) AS Total_profit,
    ROUND(SUM(o.Profit)*100/ SUM(o.TotalSales),2) AS Margin
FROM order_detail o
LEFT JOIN products p ON o.ProductID = p.ProductID
LEFT JOIN categories cat ON p.CategoryID = cat.CategoryID
GROUP BY cat.CategoryName
ORDER BY Total_Sale DESC;

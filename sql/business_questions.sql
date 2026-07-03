USE Retail_Sales_DB;
GO

SELECT COUNT(*) FROM dbo.cleaned_data WHERE Order_ID IS NULL;


-- Q1: Monthly sales & profit trend
SELECT Order_Month, SUM(Sales) AS Total_Sales, 
SUM(Profit) AS Total_Profit
FROM dbo.cleaned_data
GROUP BY Order_Month
ORDER BY Order_Month;

-- Q2: Category-wise sales and profit
SELECT Category, SUM(Sales) AS Total_Sales, 
SUM(Profit) AS Total_Profit
FROM dbo.cleaned_data
GROUP BY Category ORDER	BY Total_Sales DESC;

-- Q3: Top 10 sub-categories by profit
SELECT TOP 10 Sub_Category, SUM(Profit)	AS Total_Profit
FROM dbo.cleaned_data 
GROUP BY Sub_Category 
ORDER BY Total_Profit DESC;

--	Q4:	Region/state contribution to revenue
SELECT Region, State, SUM(Sales) AS Total_Sales
FROM dbo.cleaned_data
GROUP BY Region, State
ORDER BY Total_Sales DESC;

--	Q5: Preferred payment method
SELECT Payment_Method, COUNT(Order_ID) AS Total_Orders, 
SUM(Sales) AS Total_Sales
FROM dbo.cleaned_data
GROUP BY Payment_Method 
ORDER	BY Total_Orders DESC;

--	Q6:	Most profitable customer segment
SELECT Segment, SUM(Sales) AS Total_Sales, 
SUM(Profit) AS Total_Profit
FROM dbo.cleaned_data
GROUP BY Segment 
ORDER BY Total_Profit DESC;

--	Q7: Return rate by category
SELECT	Category,
		COUNT(CASE	
			  WHEN Return_Status='Returned' THEN 1 END)*100.0/COUNT(*) AS Return_Rate_Pct
FROM dbo.cleaned_data
GROUP BY Category 
ORDER BY Return_Rate_Pct DESC;

--	Q8:	Average	delivery days by ship mode
SELECT Ship_Mode, AVG(Delivery_Days) AS Avg_Delivery_Days
FROM dbo.cleaned_data
GROUP	BY Ship_Mode
ORDER BY Avg_Delivery_Days;

--	Q9:	Top	5 cities by average rating
SELECT TOP 5 City, AVG(Customer_Rating) AS Avg_Rating
FROM dbo.cleaned_data
GROUP BY City 
HAVING COUNT(Order_ID) > 50	
ORDER BY Avg_Rating	DESC;

--	Q10: Discount band impact on profit margin
SELECT CASE 
	   WHEN Discount_Percent=0 THEN 'No	Discount'
	   WHEN	Discount_Percent<=15 THEN 'Low'
	   WHEN	Discount_Percent<=25 THEN 'Medium'
	   ELSE	'High' END AS Discount_Band,
	   AVG(Profit_Margin_Percent) AS Avg_Margin
FROM dbo.cleaned_data
GROUP BY CASE WHEN Discount_Percent=0 THEN 'No	Discount'
			  WHEN	Discount_Percent<=15 THEN 'Low'
			  WHEN	Discount_Percent<=25 THEN 'Medium'
			  ELSE 'High' END
ORDER BY  Avg_Margin DESC;


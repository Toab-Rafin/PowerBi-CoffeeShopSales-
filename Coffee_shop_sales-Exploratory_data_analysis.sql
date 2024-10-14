Select *
From coffee_shop_sales
;

Select Concat(Round(Sum(Transaction_Qty*Unit_Price),0)/1000,'K') Total_Sales
From coffee_shop_sales
Where Month(Transation_Date) = 5   -- Month Sale
;

Select month(Transation_Date) As `Month`, Round(Sum(Transaction_Qty*Unit_Price)) Total_Sales,
Round((Sum(Transaction_Qty*Unit_Price)-Lag(Sum(Transaction_Qty*Unit_Price),1) Over()),2) As Sales_Difference,
Concat(Round((((Sum(Transaction_Qty*Unit_Price)/Lag(Sum(Transaction_Qty*Unit_Price),1) Over())-1)*100),2),'%') As Increase_in_Sales
From coffee_shop_sales
Where month(Transation_Date) In (1,2,3,4,5,6)
Group By month(Transation_Date)
Order By Month(Transation_Date);  -- Sales Difference & %-Differnce

Select 
Lag(Transation_Date) Over()
From coffee_shop_sales
Limit 2 -- Lag() Over()
;

Select (Concat(Round(Sum((Transaction_Qty)/1000),2),'k')) As Total_Order
From coffee_shop_sales; -- Total Order Quantity

Select Month(Transation_Date) As `Month`, Sum(Transaction_Qty) `Order`
From coffee_shop_sales
Where Month(Transation_Date) = 2
Group By Month(Transation_Date);  -- Monthly Quantity Sold

Select Month(Transation_Date) `Month`,
Sum(Transaction_Qty)-Lag(Sum(Transaction_Qty),1) Over() Sales_Difference,
Concat(Round(((Sum(Transaction_Qty)/Lag(Sum(Transaction_Qty),1) Over()-1)*100),2),'%') Increase_In_Order
From coffee_shop_sales
Where Month(Transation_Date) In(3,4,5,6)
group by Month(Transation_Date); -- Quantity Difference & %-Differnce

Select Month(Transation_Date) `Month`,
Count(Transaction_Qty),
Count(Transaction_Qty)-Lag(Count(Transaction_Qty),1) Over() Sales_Difference,
Concat(Round(((Count(Transaction_Qty)/Lag(Count(Transaction_Qty),1) Over()-1)*100),2),'%') Increase_In_Order
From coffee_shop_sales
Where Month(Transation_Date) In(3,4,5,6)
group by Month(Transation_Date); -- No of Order

Select 
	Concat(Round(Count(Transaction_Qty)/1000,2),'K') No_Of_Order,
    Concat(Round(Sum(Transaction_Qty)/1000,2),'K')Total_Quantity_Sales,
	Concat(Round(Sum(Transaction_Qty*Unit_Price)/1000,2),'K') Total_Sales
From coffee_shop_sales
Where Transation_Date = '2023-05-13'; -- Order Details Of Specific Day

Select 
(Case
	When Dayofweek(Transation_Date) In (6, 7) Then'Weekend'
    Else 'Weekday'
End) As Day_Type,
Concat(Round(Sum(Unit_Price*Transaction_Qty)/1000,2),'K') As Total_Sale
From coffee_shop_sales
Where month(Transation_Date) = 3
Group BY (Case
	When Dayofweek(Transation_Date) In (6, 7) Then 'Weekend'
    Else 'Weekday'
End); -- Weekend & Weekday Sales

Select Store_Location, Concat(Round(Sum(Unit_Price*Transaction_Qty)/1000,2),'K') As Total_Sale
From coffee_shop_sales
Group By Store_Location; -- Total Sales By Location

Select Store_Location, Concat(Round(Sum(Unit_Price*Transaction_Qty)/1000,2),'K') As Total_Sale
From coffee_shop_sales
Where Month(Transation_Date) = 2
Group By Store_Location;

Select Avg(total_sale) As Avg_Sale
From
( Select Concat(Round(Sum(Unit_Price*Transaction_Qty)/1000,2),'K') As total_sale
	From coffee_shop_sales
    Where Month(Transation_Date) = 5
    Group By Transation_Date
    ) av  -- Average Sale By Month
;

Select Sum(total_sale) As Sale
From
( Select Transation_Date, Round(Sum(Unit_Price*Transaction_Qty),2) As total_sale
	From coffee_shop_sales
    Where Month(Transation_Date) = 5
    Group By Transation_Date
    ) av
Where Day(Transation_Date) = 1 -- Total Sale By Specific Day
;

Select Transation_Date, Round(Sum(Unit_Price*Transaction_Qty),2) As total_sale
	From coffee_shop_sales
    Where Month(Transation_Date) = 5
    And Day(Transation_Date)
    Group By Transation_Date
    Order By Transation_Date
; -- Everyday Sale of a Month

With cte_dailysales As (
	Select Transation_Date, Sum(Transaction_Qty*Unit_Price) As total_sales
	From coffee_shop_sales
	Where Month(Transation_Date) = 4
	Group By Transation_Date
), cte_avgsale As (
	Select Avg(total_sales) avg_sales
	From cte_dailysales
)
	Select Month(Transation_Date), Round(avg_sales,2) As 'Average Sale',
	Case
		When total_sales > avg_sales Then 'Above Average'
		When total_sales < avg_sales Then 'Below Average'
        Else 'Satisfactory'
	End As Catagory
	From cte_dailysales, cte_avgsale -- Average Line
;

Select Product_Category, Concat(Round(Sum(Transaction_Qty*Unit_Price)/1000,2),'K') As Total_Sales
From coffee_shop_sales
Where Month(Transation_Date) = 1
Group By Product_Category -- Sales By Product Category
;

Select Product_Details, Round(Sum(Transaction_Qty*Unit_Price),2) As Total_Sales
From coffee_shop_sales
Group By Product_Details
Order By Total_Sales Desc
Limit 10 -- Top 10 Product
;

Select Hour(Transaction_Time) 'Time of The Day',
Count(Transaction_Qty) 'Total Order',
Sum(Transaction_Qty) as 'Order Quantity', 
Round(Sum(Transaction_Qty*Unit_Price),2) 'Total Sales'
From coffee_shop_sales
Where Month(Transation_Date) = 3 -- March
And Dayofweek(Transation_Date) = 6 -- Friday of That Month
And Hour(Transaction_time) In (12) -- Hour
Group By Hour(Transaction_time)
; -- Order Details In Specific Hour

Select
Case
	When Dayofweek(Transation_Date) = 1 Then 'Sunday'
	When Dayofweek(Transation_Date) = 2 Then 'Monday'
	When Dayofweek(Transation_Date) = 3 Then 'Tuesday'
	When Dayofweek(Transation_Date) = 4 Then 'Wednesday'
	When Dayofweek(Transation_Date) = 5 Then 'Thursday'
	When Dayofweek(Transation_Date) = 6 Then 'Friday'
	When Dayofweek(Transation_Date) = 7 Then 'Saturday'
End As `Day Name`,
Round(Sum(Transaction_Qty*Unit_Price),2) 'Total Sales'
From coffee_shop_sales
Where Month(Transation_Date) = 3
Group By DAYOFWEEK(Transation_Date), 
Case
	When Dayofweek(Transation_Date) = 1 Then 'Sunday'
	When Dayofweek(Transation_Date) = 2 Then 'Monday'
	When Dayofweek(Transation_Date) = 3 Then 'Tuesday'
	When Dayofweek(Transation_Date) = 4 Then 'Wednesday'
	When Dayofweek(Transation_Date) = 5 Then 'Thursday'
	When Dayofweek(Transation_Date) = 6 Then 'Friday'
	When Dayofweek(Transation_Date) = 7 Then 'Saturday'
End
ORDER BY DAYOFWEEK(Transation_Date)
; -- Summed Up Months Order in a Week












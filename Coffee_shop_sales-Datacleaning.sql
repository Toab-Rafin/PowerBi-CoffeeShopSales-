Create Database Sales_Coffeshop;

Rename Table `coffee shop sales` To Coffee_shop_sales;

SELECT * FROM sales_coffeshop.coffee_shop_sales;

-- Changing Format & Standarizing The Data

Alter Table coffee_shop_sales
Change ï»¿transaction_id Transation_ID int;

Alter Table coffee_shop_sales
Change transaction_date Transation_Date text;

Select Transation_Date, Str_To_Date(Transation_Date, '%m/%d/%Y')
From coffee_shop_sales;

Update coffee_shop_sales
Set Transation_Date = Str_To_Date(Transation_Date, '%m/%d/%Y');

Alter Table coffee_shop_sales
Modify Column Transation_Date Date; 

Select transaction_time, Str_To_Date(Transaction_time, '%H:%i:%s')
From coffee_shop_sales;

Update coffee_shop_sales
Set Transaction_time = Str_To_Date(Transaction_time, '%H:%i:%s');

Alter Table coffee_shop_sales
Modify Column Transaction_time Time;

Alter Table coffee_shop_sales
Change product_detail Product_Details text;

Describe coffee_shop_sales;

-- Finding Duplicates & Null Values

Select *
From coffee_shop_sales;

Select Distinct Product_Category
From coffee_shop_sales;

Select Transation_Id, count(*) AS dupli
From coffee_shop_sales
Group By Transation_Id
Having dupli > 1;

With cte_dupli As
	(Select *,
	row_number() Over
				(
				Partition By Transation_ID, Transation_Date, Transaction_Time, Transaction_Qty, Store_ID, Store_Location,Product_ID,Unit_Price,Product_Category,Product_Type,Product_Details
				) dup
	From coffee_shop_sales)
Select Transation_ID, dup
From cte_dupli
Where dup > 1
;

-- Null or Blanck Value

Select Transation_Id From coffee_shop_sales
Where Transation_Id Is Null 
Or Transation_Id = ''
;

Select Product_Category From coffee_shop_sales
Where Product_Category Is Null 
Or Product_Category = ''
;








































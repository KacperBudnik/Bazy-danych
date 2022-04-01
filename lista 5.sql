Select Sum(Discount) FROM `Order Details`; 

-- Zad 1
Select OrderID, SUM(UnitPrice*Quantity) AS `Kwota zamóienia` , SUM(Quantity) AS `Ilosc`  From `Order Details`
GROUP BY OrderID
ORDER BY SUM(UnitPrice*Quantity*(1-Discount)) DESC
Limit 1;

-- Zad 2
SELECT Customerid, count(Customerid) From Orders
Group BY Customerid Having Count(Customerid)>19;

SELECT Customerid From Orders
GROUP BY CustomerID Having Count(CustomerID)>19;


Select Count(*) AS `czlowiekow`
 From (
    SELECT Customerid as id From Orders
    GROUP BY CustomerID Having Count(CustomerID)>19) as xyz;


-- ZAD 3
SELECT CONCAT(ROUND(SUM(Discontinued)/Count(Discontinued)*100),"%") AS `% wycofanych` From Products;

-- Zad 4
Select Country From Customers
Where SUBSTRING_INDEX(ContactName,' ',1) Like "%a"
GROUP BY Country
Order By Count(Country) Desc, Country 
Limit 5;

Select Country, Count(country) From Customers
Where SUBSTRING_INDEX(ContactName,' ',1) Like "%a"
GROUP BY Country
Order By Count(Country) Desc, Country 
Limit 5;
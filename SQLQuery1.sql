USE [Procedury]
GO

-- The stored procedure displays complete information about all products
CREATE PROCEDURE GetAllProductsInfo
AS
BEGIN
    SELECT *
    FROM Products;
END
GO

-- Calling a stored procedure
EXEC GetAllProductsInfo;
GO

-- The stored procedure shows complete information about the product of a specific type
CREATE PROCEDURE GetProductsByType
    @productType NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Products
    WHERE Type = @productType;
END
GO

-- Calling a stored procedure
EXEC GetProductsByType 'information about the product';
GO

-- The stored procedure shows the top 3 oldest customers
CREATE PROCEDURE GetTop3OldestCustomers
AS
BEGIN
    SELECT TOP 3 *
    FROM Customers
    ORDER BY OrderDate ASC;
END
GO

-- Calling a stored procedure
EXEC GetTop3OldestCustomers;
GO

-- The stored procedure shows information about the most successful seller
CREATE PROCEDURE GetMostSuccessfulSalesperson
AS
BEGIN
    SELECT TOP 1 e.FullName AS SalespersonName, SUM(s.SalePrice) AS TotalSales
    FROM Sales s
    INNER JOIN Employees e ON s.EmployeeID = e.EmployeeID
    GROUP BY e.FullName
    ORDER BY TotalSales DESC;
END
GO

-- Calling a stored procedure
EXEC GetMostSuccessfulSalesperson;
GO

-- The stored procedure checks whether at least one product of the given manufacturer is available
CREATE PROCEDURE CheckManufacturerProductAvailability
    @manufacturer NVARCHAR(100),
    @availability BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Products WHERE Manufacturer = @manufacturer)
        SET @availability = 1;
    ELSE
        SET @availability = 0;
END
GO

-- Calling a stored procedure
DECLARE @avail BIT;
EXEC CheckManufacturerProductAvailability 'Nike', @avail OUTPUT;
PRINT 'Availability: ' + CASE WHEN @avail = 1 THEN 'Yes' ELSE 'No' END;
GO

-- The stored procedure displays information about the most popular manufacturer among buyers
CREATE PROCEDURE GetMostPopularManufacturer
AS
BEGIN
    SELECT TOP 1 p.Manufacturer, SUM(s.SalePrice) AS TotalSales
    FROM Sales s
    INNER JOIN Products p ON s.ProductID = p.ProductID
    GROUP BY p.Manufacturer
    ORDER BY TotalSales DESC;
END
GO

-- Calling a stored procedure
EXEC GetMostPopularManufacturer;
GO

-- The stored procedure deletes all customers registered after the specified date
CREATE PROCEDURE DeleteCustomersRegisteredAfterDate
    @registrationDate DATE,
    @deletedCount INT OUTPUT
AS
BEGIN
    DELETE FROM Customers
    WHERE RegistrationDate > @registrationDate;

    SET @deletedCount = @@ROWCOUNT;
END
GO

-- Calling a stored procedure
DECLARE @deletedCount INT;
EXEC DeleteCustomersRegisteredAfterDate '2024-01-01', @deletedCount OUTPUT;
PRINT 'Number of deleted customers: ' + CAST(@deletedCount AS VARCHAR(10));
GO
CREATE DATABASE [Procedury]
GO

USE [Procedury]
GO

-- The stored procedure outputs «Hello, world!»
CREATE PROCEDURE PrintHello
AS
BEGIN
    PRINT 'Hello, world!'
END
GO

-- The stored procedure returns information about the current time
CREATE PROCEDURE GetCurrentTime
AS
BEGIN
    SELECT GETDATE() AS CurrentTime
END
GO

-- The stored procedure returns information about the current date
CREATE PROCEDURE GetCurrentDate
AS
BEGIN
    SELECT CONVERT(date, GETDATE()) AS CurrentDate
END
GO

-- The stored procedure takes three numbers and returns their sum
CREATE PROCEDURE GetSum
    @num1 INT,
    @num2 INT,
    @num3 INT
AS
BEGIN
    SELECT @num1 + @num2 + @num3 AS Sum
END
GO

-- The stored procedure takes three numbers and returns the arithmetic mean of the three numbers
CREATE PROCEDURE GetAverage
    @num1 INT,
    @num2 INT,
    @num3 INT
AS
BEGIN
    SELECT AVG(CAST(Value AS FLOAT)) AS Average
    FROM (VALUES (@num1), (@num2), (@num3)) AS Numbers(Value)
END
GO

-- The stored procedure takes three numbers and returns the maximum value
CREATE PROCEDURE GetMaxValue
    @num1 INT,
    @num2 INT,
    @num3 INT
AS
BEGIN
    SELECT MAX(Value) AS MaxValue
    FROM (VALUES (@num1), (@num2), (@num3)) AS Numbers(Value)
END
GO

-- The stored procedure takes three numbers and returns the minimum value
CREATE PROCEDURE GetMinValue
    @num1 INT,
    @num2 INT,
    @num3 INT
AS
BEGIN
    SELECT MIN(Value) AS MinValue
    FROM (VALUES (@num1), (@num2), (@num3)) AS Numbers(Value)
END
GO

-- The stored procedure takes a number and a character and displays a line
CREATE PROCEDURE DrawLine
    @length INT,
    @symbol CHAR(1)
AS
BEGIN
    DECLARE @line VARCHAR(MAX) = REPLICATE(@symbol, @length)
    PRINT @line
END
GO

-- The stored procedure takes a number as a parameter and returns its factorial
CREATE PROCEDURE GetFactorial
    @number INT
AS
BEGIN
    DECLARE @factorial BIGINT = 1
    DECLARE @i INT = 1
    WHILE @i <= @number
    BEGIN
        SET @factorial = @factorial * @i
        SET @i = @i + 1
    END
    SELECT @factorial AS Factorial
END
GO

-- The stored procedure takes two numeric parameters and returns a number raised to the power
CREATE PROCEDURE Power
    @base FLOAT,
    @exponent INT
AS
BEGIN
    SELECT POWER(@base, @exponent) AS Result
END
GO
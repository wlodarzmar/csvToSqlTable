CREATE TABLE #TempTable
(
    Region NVARCHAR(MAX) NULL,
	Country NVARCHAR(MAX) NULL,
	ItemType NVARCHAR(MAX) NULL,
	SalesChannel NVARCHAR(MAX) NULL,
	OrderPriority NVARCHAR(MAX) NULL,
	OrderDate DATETIME NULL,
	OrderId INT NULL,
	ShipDate DATETIME NULL,
	UnitSold BIGINT NULL,
	UnitPrice MONEY NULL,
	UnitCost MONEY NULL,
	TotalRevenue MONEY NULL,
	TotalCost MONEY NULL,
	TotalProfit MONEY NULL
)
 
BULK INSERT #TempTable
FROM 'C:\100 Sales Records.csv'
WITH
(
  CODEPAGE = 'ACP',
  FIRSTROW = 2,
  DATAFILETYPE='widechar', 
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK,
  KEEPNULLS
)

INSERT INTO dbo.Sales (Region, Country, ItemType, Channel, OrderPriority, OrderData, OrderId, ShipDate, UnitSold, UnitPrice, UnitCost, TotalRevenue, TotalCost, TotalProfit)
SELECT
	csv.Region,
	csv.Country,
	csv.ItemType,
	csv.SalesChannel,
	csv.OrderPriority,
	csv.OrderDate,
	csv.OrderId,
	csv.ShipDate,
	csv.UnitSold,
	csv.UnitPrice,
	csv.UnitCost,
	csv.TotalRevenue,
	csv.TotalCost,
	csv.TotalProfit
FROM #TempTable csv

DROP TABLE #TempTable
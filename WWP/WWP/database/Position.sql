CREATE TABLE [dbo].[Position]
(
	[Position_Id] INT NOT NULL PRIMARY KEY, 
    [Position_Name] NCHAR(52) NULL, 
    [Position_Discription] NCHAR(52) NULL, 
    [Pay_Period] DATETIME NULL, 
    [PayRate] FLOAT NULL
)

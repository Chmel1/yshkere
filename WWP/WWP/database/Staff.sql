CREATE TABLE [dbo].[Staff]
(
	[Staff_id] INT NOT NULL PRIMARY KEY, 
    [First_Name] NCHAR(52) NULL, 
    [Last_Name] NCHAR(52) NULL, 
    [Date_Of_Birth] NCHAR(52) NULL, 
    [Gender] NCHAR(52) NULL, 
    [Position_Id] INT NOT NULL Foreign key references [Position]([Position_id]),
    [Email] NCHAR(52) NULL, 
    [Comments] NCHAR(52) NULL
)

CREATE TABLE [dbo].[Volunteer]
(
	[Voloteer_Id] INT NOT NULL PRIMARY KEY, 
    [First_Name] NCHAR(52) NULL, 
    [Last_Name] NCHAR(52) NULL, 
    [Country_Code] NCHAR(52) NULL, 
    [Gender_id] INT NOT NULL Foreign key references [Gender]([Gender_id]),
)

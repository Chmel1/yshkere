CREATE TABLE [dbo].[Charity]
(
    [Charity_id] INT NOT NULL, 
    [Charity_Name] NCHAR(52) NULL, 
    [Charity_Description] NCHAR(52) NULL, 
    [Charity_Logo] NCHAR(52) NULL, 
    CONSTRAINT [PK_Charity] PRIMARY KEY ([Charity_id])
)

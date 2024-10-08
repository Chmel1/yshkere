CREATE TABLE [dbo].[Runner]
(
    [Runner_id] INT NOT NULL, 
    [Email] NCHAR(10) NULL, 
    [Gender] NCHAR(10) NULL, 
    [DateOfBirth] DATE NULL, 
    [Country_Code] NCHAR(10) NULL, 
    CONSTRAINT [PK_Runner] PRIMARY KEY ([Runner_id])
)

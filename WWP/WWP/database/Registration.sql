CREATE TABLE [dbo].[Registration]
(
    [Registration_id] INT NOT NULL PRIMARY KEY,
    [Runner_Id] INT NOT NULL Foreign key references [Runner]([Runner_Id]), 
    [Registration_Date_Time] DATETIME NULL, 
    [Race_Kit_Option_Id] INT NOT NULL  Foreign key references [RaceKitOption] ([Race_Kit_Option_Id]),
    [Registration_Status_Id] INT NOT NULL Foreign key references[RegistrationStatus]([Registration_Status_Id]),
    [Cost] FLOAT NULL, 
    [Charity_id] INT NOT NULL Foreign key references [Charity]([Charity_id]), 
    [Sponsorship_Target] NCHAR(10) NULL, 
)

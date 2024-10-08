CREATE TABLE [dbo].[Timesheet]
(
	[Timesheet_id] INT NOT NULL PRIMARY KEY, 
    [Staff_id] INT NOT NULL Foreign key references [Staff]([Staff_id]),
    [Start_Date_Time] DATETIME NULL, 
    [End_Date_Time] DATETIME NULL, 
    [Pay_Amount] FLOAT NULL 
)

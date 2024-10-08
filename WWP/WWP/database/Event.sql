CREATE TABLE [dbo].[Event]
(
	[Event_id] INT NOT NULL PRIMARY KEY, 
    [Event_Name] NCHAR(52) NULL, 
    [Event_Type_Id] INT NOT NULL Foreign key references[EventType]([Event_Type_Id]), 
    [Marathon_Id] INT NOT NULL Foreign key references [Marathon]([Marathon_Id]), 
    [Start_Date_Time] DATETIME NULL, 
    [Cost] FLOAT NULL, 
    [Max_Participants] FLOAT NULL
    
)

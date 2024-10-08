CREATE TABLE [dbo].[Registration_Event]
(
    [RegistrationEvent_id] INT NOT NULL PRIMARY KEY, 
    [Event_Id] INT NOT NULL Foreign key references [Event]([Event_Id]), 
    [Registration_id] INT NOT NULl Foreign key references [Registration]([Registration_id]),
    [Bib_Number] NCHAR(52) NULL, 
    [Race_Time] TIME NULL, 
    
   
)

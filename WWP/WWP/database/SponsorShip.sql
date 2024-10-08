CREATE TABLE [dbo].[SponsorShip]
(
    [Sponsorship_id] INT NOT NULL, 
    [Sponsor_Name] NCHAR(52) NULL, 
    [Registration_id] INT NOT NULL Foreign key references [Registration]([Registration_id]), 
    [Amount] FLOAT NULL, 
    CONSTRAINT [PK_SponsorShip] PRIMARY KEY ([Sponsorship_id])
)

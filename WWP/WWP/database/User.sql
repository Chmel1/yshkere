CREATE TABLE [dbo].[User] (
    [User_id]    INT        IDENTITY (1, 1) NOT NULL,
    [Email]      NVARCHAR (52) NOT NULL,
    [Password]   NVARCHAR (52) NOT NULL,
    [First_Name] NVARCHAR (52) NOT NULL,
    [Last_Name]  NVARCHAR (52) NOT NULL,
    [Role_Id]    INT        NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([User_id] ASC),
    FOREIGN KEY ([Role_Id]) REFERENCES [dbo].[Role] ([Role_id])
);


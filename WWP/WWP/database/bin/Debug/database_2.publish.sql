/*
Скрипт развертывания для database

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "database"
:setvar DefaultFilePrefix "database"
:setvar DefaultDataPath "C:\Users\NetribovskijVA\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\NetribovskijVA\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Проверьте режим SQLCMD и отключите выполнение скрипта, если режим SQLCMD не поддерживается.
Чтобы повторно включить скрипт после включения режима SQLCMD выполните следующую инструкцию:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Для успешного выполнения этого скрипта должен быть включен режим SQLCMD.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Идет создание базы данных $(DatabaseName)…'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Идет создание Таблица [dbo].[Charity]…';


GO
CREATE TABLE [dbo].[Charity] (
    [Charity_id]          INT        NOT NULL,
    [Charity_Name]        NCHAR (52) NULL,
    [Charity_Description] NCHAR (52) NULL,
    [Charity_Logo]        NCHAR (52) NULL,
    CONSTRAINT [PK_Charity] PRIMARY KEY CLUSTERED ([Charity_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Country]…';


GO
CREATE TABLE [dbo].[Country] (
    [Country_Code] INT        NOT NULL,
    [Country_Name] NCHAR (52) NULL,
    [Country_Flag] NCHAR (52) NULL,
    PRIMARY KEY CLUSTERED ([Country_Code] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Event]…';


GO
CREATE TABLE [dbo].[Event] (
    [Event_id]         INT        NOT NULL,
    [Event_Name]       NCHAR (52) NULL,
    [Event_Type_Id]    INT        NOT NULL,
    [Marathon_Id]      INT        NOT NULL,
    [Start_Date_Time]  DATETIME   NULL,
    [Cost]             FLOAT (53) NULL,
    [Max_Participants] FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Event_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[EventType]…';


GO
CREATE TABLE [dbo].[EventType] (
    [Event_Type_Id]   INT        NOT NULL,
    [Event_Type_Name] NCHAR (52) NULL,
    PRIMARY KEY CLUSTERED ([Event_Type_Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Gender]…';


GO
CREATE TABLE [dbo].[Gender] (
    [Gender_id]   INT        NOT NULL,
    [Gender_Name] NCHAR (52) NULL,
    PRIMARY KEY CLUSTERED ([Gender_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Marathon]…';


GO
CREATE TABLE [dbo].[Marathon] (
    [Marathon_id]   INT        NOT NULL,
    [Marathon_Name] NCHAR (52) NULL,
    [City_Name]     NCHAR (52) NULL,
    [CountryCode]   NCHAR (10) NULL,
    [Year_Held]     NCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([Marathon_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Position]…';


GO
CREATE TABLE [dbo].[Position] (
    [Position_Id]          INT        NOT NULL,
    [Position_Name]        NCHAR (52) NULL,
    [Position_Discription] NCHAR (52) NULL,
    [Pay_Period]           DATETIME   NULL,
    [PayRate]              FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Position_Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[RaceKitOption]…';


GO
CREATE TABLE [dbo].[RaceKitOption] (
    [Race_Kit_Option_Id] INT        NOT NULL,
    [RaceKitOption]      NCHAR (10) NULL,
    [Cost]               FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Race_Kit_Option_Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Registration]…';


GO
CREATE TABLE [dbo].[Registration] (
    [Registration_id]        INT        NOT NULL,
    [Runner_Id]              INT        NOT NULL,
    [Registration_Date_Time] DATETIME   NULL,
    [Race_Kit_Option_Id]     INT        NOT NULL,
    [Registration_Status_Id] INT        NOT NULL,
    [Cost]                   FLOAT (53) NULL,
    [Charity_id]             INT        NOT NULL,
    [Sponsorship_Target]     NCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([Registration_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Registration_Event]…';


GO
CREATE TABLE [dbo].[Registration_Event] (
    [RegistrationEvent_id] INT        NOT NULL,
    [Event_Id]             INT        NOT NULL,
    [Registration_id]      INT        NOT NULL,
    [Bib_Number]           NCHAR (52) NULL,
    [Race_Time]            TIME (7)   NULL,
    PRIMARY KEY CLUSTERED ([RegistrationEvent_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[RegistrationStatus]…';


GO
CREATE TABLE [dbo].[RegistrationStatus] (
    [Registration_Status_Id] INT        NOT NULL,
    [Registration_Status]    NCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([Registration_Status_Id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Role]…';


GO
CREATE TABLE [dbo].[Role] (
    [Role_id]   INT        NOT NULL,
    [Role_Name] NCHAR (52) NULL,
    PRIMARY KEY CLUSTERED ([Role_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Runner]…';


GO
CREATE TABLE [dbo].[Runner] (
    [Runner_id]    INT        NOT NULL,
    [Email]        NCHAR (10) NULL,
    [Gender]       NCHAR (10) NULL,
    [DateOfBirth]  DATE       NULL,
    [Country_Code] NCHAR (10) NULL,
    CONSTRAINT [PK_Runner] PRIMARY KEY CLUSTERED ([Runner_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[SponsorShip]…';


GO
CREATE TABLE [dbo].[SponsorShip] (
    [Sponsorship_id]  INT        NOT NULL,
    [Sponsor_Name]    NCHAR (52) NULL,
    [Registration_id] INT        NOT NULL,
    [Amount]          FLOAT (53) NULL,
    CONSTRAINT [PK_SponsorShip] PRIMARY KEY CLUSTERED ([Sponsorship_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Staff]…';


GO
CREATE TABLE [dbo].[Staff] (
    [Staff_id]      INT        NOT NULL,
    [First_Name]    NCHAR (52) NULL,
    [Last_Name]     NCHAR (52) NULL,
    [Date_Of_Birth] NCHAR (52) NULL,
    [Gender]        NCHAR (52) NULL,
    [Position_Id]   INT        NOT NULL,
    [Email]         NCHAR (52) NULL,
    [Comments]      NCHAR (52) NULL,
    PRIMARY KEY CLUSTERED ([Staff_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Timesheet]…';


GO
CREATE TABLE [dbo].[Timesheet] (
    [Timesheet_id]    INT        NOT NULL,
    [Staff_id]        INT        NOT NULL,
    [Start_Date_Time] DATETIME   NULL,
    [End_Date_Time]   DATETIME   NULL,
    [Pay_Amount]      FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Timesheet_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[User]…';


GO
CREATE TABLE [dbo].[User] (
    [User_id]    INT           IDENTITY (1, 1) NOT NULL,
    [Email]      NVARCHAR (52) NOT NULL,
    [Password]   NVARCHAR (52) NOT NULL,
    [First_Name] NVARCHAR (52) NOT NULL,
    [Last_Name]  NVARCHAR (52) NOT NULL,
    [Role_Id]    INT           NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([User_id] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Volunteer]…';


GO
CREATE TABLE [dbo].[Volunteer] (
    [Voloteer_Id]  INT        NOT NULL,
    [First_Name]   NCHAR (52) NULL,
    [Last_Name]    NCHAR (52) NULL,
    [Country_Code] NCHAR (52) NULL,
    [Gender_id]    INT        NOT NULL,
    PRIMARY KEY CLUSTERED ([Voloteer_Id] ASC)
);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Event]…';


GO
ALTER TABLE [dbo].[Event]
    ADD FOREIGN KEY ([Event_Type_Id]) REFERENCES [dbo].[EventType] ([Event_Type_Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Event]…';


GO
ALTER TABLE [dbo].[Event]
    ADD FOREIGN KEY ([Marathon_Id]) REFERENCES [dbo].[Marathon] ([Marathon_id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration]…';


GO
ALTER TABLE [dbo].[Registration]
    ADD FOREIGN KEY ([Runner_Id]) REFERENCES [dbo].[Runner] ([Runner_id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration]…';


GO
ALTER TABLE [dbo].[Registration]
    ADD FOREIGN KEY ([Race_Kit_Option_Id]) REFERENCES [dbo].[RaceKitOption] ([Race_Kit_Option_Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration]…';


GO
ALTER TABLE [dbo].[Registration]
    ADD FOREIGN KEY ([Registration_Status_Id]) REFERENCES [dbo].[RegistrationStatus] ([Registration_Status_Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration]…';


GO
ALTER TABLE [dbo].[Registration]
    ADD FOREIGN KEY ([Charity_id]) REFERENCES [dbo].[Charity] ([Charity_id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration_Event]…';


GO
ALTER TABLE [dbo].[Registration_Event]
    ADD FOREIGN KEY ([Event_Id]) REFERENCES [dbo].[Event] ([Event_id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Registration_Event]…';


GO
ALTER TABLE [dbo].[Registration_Event]
    ADD FOREIGN KEY ([Registration_id]) REFERENCES [dbo].[Registration] ([Registration_id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[SponsorShip]…';


GO
ALTER TABLE [dbo].[SponsorShip]
    ADD FOREIGN KEY ([Registration_id]) REFERENCES [dbo].[Registration] ([Registration_id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Staff]…';


GO
ALTER TABLE [dbo].[Staff]
    ADD FOREIGN KEY ([Position_Id]) REFERENCES [dbo].[Position] ([Position_Id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Timesheet]…';


GO
ALTER TABLE [dbo].[Timesheet]
    ADD FOREIGN KEY ([Staff_id]) REFERENCES [dbo].[Staff] ([Staff_id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[User]…';


GO
ALTER TABLE [dbo].[User]
    ADD FOREIGN KEY ([Role_Id]) REFERENCES [dbo].[Role] ([Role_id]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Volunteer]…';


GO
ALTER TABLE [dbo].[Volunteer]
    ADD FOREIGN KEY ([Gender_id]) REFERENCES [dbo].[Gender] ([Gender_id]);


GO
-- Выполняется этап рефакторинга для обновления развернутых журналов транзакций на целевом сервере

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f940b4a4-58e9-40ea-abd5-8fd1e07a4247')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f940b4a4-58e9-40ea-abd5-8fd1e07a4247')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '15eef6bb-084b-44ec-b533-18c5ec77fd87')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('15eef6bb-084b-44ec-b533-18c5ec77fd87')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '165e7fa8-9e82-4e86-8422-7aef820b0599')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('165e7fa8-9e82-4e86-8422-7aef820b0599')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '509ff710-1417-4557-9418-94ce5b306162')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('509ff710-1417-4557-9418-94ce5b306162')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9ddb8578-6aa0-45e8-9701-9f7b2b988e49')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9ddb8578-6aa0-45e8-9701-9f7b2b988e49')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '95a961fa-e8fe-405f-b5d1-a69aad60b94d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('95a961fa-e8fe-405f-b5d1-a69aad60b94d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0c51add8-2aad-4dc0-b9e5-3aa22b06a21f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0c51add8-2aad-4dc0-b9e5-3aa22b06a21f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2689e75f-95c4-4715-9cbf-a965f53cbf5d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2689e75f-95c4-4715-9cbf-a965f53cbf5d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '50e75b47-7ad6-4e26-ae41-80351bb35cf3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('50e75b47-7ad6-4e26-ae41-80351bb35cf3')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '202adfba-5683-4192-8f17-c8bad2fdbca3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('202adfba-5683-4192-8f17-c8bad2fdbca3')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '559bcd10-a05f-42d8-bf52-de3567e8615b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('559bcd10-a05f-42d8-bf52-de3567e8615b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0a227db3-11f2-4290-ae09-d640e5dd260d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0a227db3-11f2-4290-ae09-d640e5dd260d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c38cf998-f254-4395-b4f5-918177e17776')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c38cf998-f254-4395-b4f5-918177e17776')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b434f60e-a58b-42d2-beee-f2ccc5b65489')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b434f60e-a58b-42d2-beee-f2ccc5b65489')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1d590709-1b7e-4f14-a582-086ee501e986')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1d590709-1b7e-4f14-a582-086ee501e986')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2ce649b0-ca0b-4397-a1bf-ac7bd05f09dd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2ce649b0-ca0b-4397-a1bf-ac7bd05f09dd')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Обновление завершено.';


GO

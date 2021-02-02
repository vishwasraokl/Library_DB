﻿/*
Deployment script for vish-practice-library

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "vish-practice-library"
:setvar DefaultFilePrefix "vish-practice-library"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
    END


GO
PRINT N'Creating [dbo].[tblBarrower]...';


GO
CREATE TABLE [dbo].[tblBarrower] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [Title]        VARCHAR (3)  NOT NULL,
    [FirstName]    VARCHAR (30) NOT NULL,
    [LastName]     VARCHAR (30) NOT NULL,
    [AddressLine1] VARCHAR (30) NOT NULL,
    [AddressLine2] VARCHAR (30) NULL,
    [City]         VARCHAR (30) NOT NULL,
    [StateName]    VARCHAR (30) NOT NULL,
    [Country]      VARCHAR (30) NOT NULL,
    [PostCode]     VARCHAR (10) NOT NULL,
    [CountryCode]  VARCHAR (5)  NOT NULL,
    [MobileNumber] VARCHAR (10) NOT NULL,
    [EmailId]      VARCHAR (20) NOT NULL,
    [BarrowerType] VARCHAR (20) NOT NULL,
    [LastUpdated]  DATE         NULL,
    CONSTRAINT [Id_PK] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[tblBook]...';


GO
CREATE TABLE [dbo].[tblBook] (
    [ID]                 INT             IDENTITY (1, 1) NOT NULL,
    [Title]              VARCHAR (30)    NOT NULL,
    [Author]             VARCHAR (30)    NOT NULL,
    [Price]              DECIMAL (10, 2) NOT NULL,
    [PublishedDate]      DATE            NOT NULL,
    [DateAddedToLibrary] DATE            NOT NULL,
    [LastUpdated]        DATE            NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[tblTransaction]...';


GO
CREATE TABLE [dbo].[tblTransaction] (
    [TransactionId]    INT      NOT NULL,
    [BarrowerId]       INT      NOT NULL,
    [BookId]           INT      NOT NULL,
    [BarrowedDateTime] DATETIME NOT NULL,
    [ReturnDate]       DATETIME NULL,
    [LastUpdated]      DATETIME NULL,
    CONSTRAINT [pK_tblTransaction] PRIMARY KEY CLUSTERED ([BookId] ASC)
);


GO
PRINT N'Creating [dbo].[FK_tblBarrower_tblTransaction]...';


GO
ALTER TABLE [dbo].[tblTransaction] WITH NOCHECK
    ADD CONSTRAINT [FK_tblBarrower_tblTransaction] FOREIGN KEY ([BarrowerId]) REFERENCES [dbo].[tblBarrower] ([Id]);


GO
PRINT N'Creating [dbo].[FK_tblBook_tblTransaction]...';


GO
ALTER TABLE [dbo].[tblTransaction] WITH NOCHECK
    ADD CONSTRAINT [FK_tblBook_tblTransaction] FOREIGN KEY ([TransactionId]) REFERENCES [dbo].[tblBarrower] ([Id]);


GO

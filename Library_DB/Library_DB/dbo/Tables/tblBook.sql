CREATE TABLE [dbo].[tblBook] (
	[ID] INT IDENTITY(1, 1) NOT NULL
	,[Title] VARCHAR(30) NOT NULL
	,[Author] VARCHAR(30) NOT NULL
	,[Price] DECIMAL(10, 2) NOT NULL
	,[PublishedDate] DATE NOT NULL
	,[DateAddedToLibrary] DATE NOT NULL
	,[LastUpdated] DATE NULL
	,PRIMARY KEY CLUSTERED ([ID] ASC)
	);

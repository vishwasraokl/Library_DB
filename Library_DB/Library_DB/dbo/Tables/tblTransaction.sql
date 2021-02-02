CREATE TABLE [dbo].[tblTransaction] (
	[TransactionId] INT NOT NULL
	,[BarrowerId] INT NOT NULL
	,[BookId] INT NOT NULL
	,[BarrowedDateTime] DATETIME NOT NULL
	,[ReturnDate] DATETIME NULL
	,[LastUpdated] DATETIME NULL
	,CONSTRAINT [pK_tblTransaction] PRIMARY KEY CLUSTERED ([BookId] ASC)
	,CONSTRAINT [FK_tblBarrower_tblTransaction] FOREIGN KEY ([BarrowerId]) REFERENCES [dbo].[tblBarrower]([Id])
	,CONSTRAINT [FK_tblBook_tblTransaction] FOREIGN KEY ([TransactionId]) REFERENCES [dbo].[tblBarrower]([Id])
	);

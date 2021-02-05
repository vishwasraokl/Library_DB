CREATE TABLE [dbo].[tblTransaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[BarrowerId] [int] NOT NULL,
	[BookId] [int] NOT NULL,
	[BarrowedDateTime] [datetime] NOT NULL,
	[ReturnDate] [datetime] NULL,
	[LastUpdated] [datetime] NULL,
 CONSTRAINT [pK_tblTransaction] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tblBarrower_tblTransaction] FOREIGN KEY([BarrowerId])
REFERENCES [dbo].[tblBarrower] ([Id])
GO

ALTER TABLE [dbo].[tblTransaction] CHECK CONSTRAINT [FK_tblBarrower_tblTransaction]
GO

ALTER TABLE [dbo].[tblTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tblBook_tblTransaction] FOREIGN KEY([BookId])
REFERENCES [dbo].[tblBook] ([ID])
GO

ALTER TABLE [dbo].[tblTransaction] CHECK CONSTRAINT [FK_tblBook_tblTransaction]
GO
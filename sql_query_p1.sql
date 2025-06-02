USE [sql_project_p2]
GO

/****** Object:  Table [dbo].[retail_sales]    Script Date: 5/29/2025 5:06:33 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[retail_sales]') AND type in (N'U'))
DROP TABLE [dbo].[retail_sales]
GO

/****** Object:  Table [dbo].[retail_sales]    Script Date: 5/29/2025 5:06:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[retail_sales](
	[transactions_id] [int] NOT NULL,
	[sale_date] [date] NULL,
	[sale_time] [time](7) NULL,
	[customer_id] [int] NULL,
	[gender] [varchar](15) NULL,
	[age] [int] NULL,
	[category] [varchar](15) NULL,
	[quantiy] [int] NULL,
	[price_per_unit] [float] NULL,
	[cogs] [float] NULL,
	[total_sale] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[transactions_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


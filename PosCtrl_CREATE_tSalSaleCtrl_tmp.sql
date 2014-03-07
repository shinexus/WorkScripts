USE [posctrl2010]
GO

/****** Object:  Table [dbo].[tSalSaleCtrl_tmp]    Script Date: 03/31/2012 13:12:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tSalSaleCtrl_tmp](
	[OrgCode] [varchar](10) NOT NULL,
	[SaleNo] [varchar](20) NOT NULL,
	[PosNo] [varchar](4) NOT NULL,
	[XsDate] [datetime] NOT NULL,
	[JzDate] [varchar](10) NULL,
	[CshID] [numeric](19, 0) NULL,
	[CshCode] [varchar](6) NULL,
	[YsTotal] [numeric](19, 2) NOT NULL,
	[SsTotal] [numeric](19, 2) NOT NULL,
	[ZfTotal] [numeric](19, 2) NOT NULL,
	[ZlTotal] [numeric](19, 2) NOT NULL,
	[TranType] [varchar](1) NOT NULL,
	[ConsType] [varchar](1) NOT NULL,
	[VipCardNo] [varchar](40) NULL,
	[LeftTotal] [numeric](19, 2) NULL,
	[CustCode] [varchar](10) NULL,
	[Remark] [varchar](100) NULL,
	[Tag] [numeric](5, 0) NULL,
	[WorkNo] [numeric](5, 0) NULL,
	[SourceSaleNo] [varchar](400) NULL,
	[IsDecCvsKc] [varchar](100) NULL,
	[UDP1] [varchar](400) NULL,
	[UDP2] [varchar](400) NULL,
	[UDP3] [varchar](400) NULL,
	[UDP4] [varchar](400) NULL,
	[UDP5] [varchar](400) NULL,
 CONSTRAINT [PK_tSalSaleCtrl_tmp] PRIMARY KEY CLUSTERED 
(
	[OrgCode] ASC,
	[SaleNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



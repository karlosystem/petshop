USE [dbOnlineStore]
GO
/****** Object:  Table [dbo].[tblMascota]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMascota](
	[idMasc] [int] IDENTITY(1,1) NOT NULL,
	[nomMasc] [varchar](30) NULL,
	[createDate] [datetime] NULL,
	[idUser] [int] NULL,
	[idRaza] [int] NULL,
	[estado] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idMasc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[RoleType] [int] NULL,
	[apellidos] [varchar](50) NULL,
	[direccion] [varchar](50) NULL,
	[telefono] [varchar](50) NULL,
	[estado] [int] NULL,
	[fecharegistro] [date] NULL,
	[id_veterinario] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRaza]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRaza](
	[idRaza] [int] IDENTITY(1,1) NOT NULL,
	[nomRaza] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idRaza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_listaMascotas]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vw_listaMascotas]
as
Select tblMascota.idMasc, tblMascota.nomMasc, tblMascota.createDate, tblMascota.estado, tblRaza.nomRaza, tblUser.Name as cliente
	from tblMascota 
	inner join tblRaza on tblMascota.idRaza = tblRaza.idRaza
	inner join tblUser on tblMascota.idUser = tblUser.UserId
GO
/****** Object:  Table [dbo].[tblTipoPago]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTipoPago](
	[idTipoPago] [int] IDENTITY(1,1) NOT NULL,
	[nomTipoPago] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFactura]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFactura](
	[idFactura] [int] IDENTITY(1,1) NOT NULL,
	[numero] [varchar](30) NULL,
	[createDate] [datetime] NULL,
	[idUser] [int] NULL,
	[idTipoPago] [int] NULL,
	[estado] [int] NULL,
	[FinalTotal] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ListaFacturas]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vw_ListaFacturas]
as
	Select top 100
	tblFactura.idFactura,
	tblFactura.numero,
	tblUser.Name + ' ' + tblUser.apellidos as 'Cliente',
	tblFactura.createDate,
	tblTipoPago.nomTipoPago,
	tblFactura.estado,
	tblFactura.FinalTotal 
	from tblFactura 
	inner join tblTipoPago on tblFactura.idTipoPago = tblTipoPago.idTipoPago
	inner join tblUser on tblFactura.idUser = tblUser.UserId
	order by tblFactura.createDate DESC
GO
/****** Object:  Table [dbo].[tblFacturaDetalles]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFacturaDetalles](
	[idDetaFactura] [int] IDENTITY(1,1) NOT NULL,
	[idFactura] [int] NULL,
	[ItemId] [int] NULL,
	[UnitPrice] [decimal](10, 2) NULL,
	[Quantity] [decimal](10, 2) NULL,
	[Discount] [decimal](10, 2) NULL,
	[Total] [decimal](10, 2) NULL,
	[estado] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idDetaFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProducts]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProducts](
	[ProID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Unit] [int] NULL,
	[Image] [nvarchar](max) NULL,
	[CatID] [int] NULL,
	[Stock] [int] NULL,
	[Serie] [varchar](30) NULL,
	[Marca] [varchar](30) NULL,
	[DescriptionHTML] [text] NULL,
	[Image02] [varchar](30) NULL,
	[Image03] [varchar](30) NULL,
	[estado] [int] NULL,
	[FechaRegistro] [date] NULL,
	[idProv] [int] NULL,
	[idUser] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_FacturasDetalles]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vw_FacturasDetalles]
as
Select  
	[idDetaFactura],
	[idFactura],
	[ItemId],
	tblProducts.Name as Producto,
	[UnitPrice],
	[Quantity],
	[Discount],
	[Total],
	[tblFacturaDetalles].[estado]

	from [tblFacturaDetalles] inner join tblProducts on tblFacturaDetalles.ItemId = tblProducts.ProID

GO
/****** Object:  Table [dbo].[tblInvoice]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInvoice](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[UserId] [int] NULL,
	[Bill] [int] NULL,
	[Payment] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[InvoiceDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[user_invoices]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[user_invoices] as
select tblInvoice.InvoiceId,  tblUser.Name as 'Customer', 
 tblInvoice.Bill,tblInvoice.Payment, tblInvoice.InvoiceDate
 from tblInvoice
inner join tblUser on tblUser.UserId = tblInvoice.UserId
where tblInvoice.UserId = ''

GO
/****** Object:  Table [dbo].[tblCategories]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategories](
	[CatId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_getallproducts]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* get all product for admin  */
CREATE VIEW [dbo].[vw_getallproducts]
AS
SELECT        dbo.tblProducts.ProID, dbo.tblProducts.Name, dbo.tblCategories.Name AS Category, dbo.tblProducts.Description, dbo.tblProducts.Unit, dbo.tblProducts.Image, dbo.tblProducts.Stock, dbo.tblProducts.Serie, dbo.tblProducts.Marca, 
                         dbo.tblProducts.estado, dbo.tblProducts.FechaRegistro, dbo.tblProducts.idUser
FROM            dbo.tblProducts INNER JOIN
                         dbo.tblCategories ON dbo.tblCategories.CatId = dbo.tblProducts.CatID
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrder](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[ProID] [int] NULL,
	[Contact] [varchar](50) NULL,
	[Address] [varchar](100) NULL,
	[Unit] [int] NULL,
	[Qty] [int] NULL,
	[Total] [int] NULL,
	[OrderDate] [date] NULL,
	[PayMethod] [varchar](50) NULL,
	[UserId] [int] NULL,
	[InvoiceId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_productosPedido]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  Create View [dbo].[vw_productosPedido]
  as
  Select tblOrder.OrderId, tblOrder.InvoiceId, tblProducts.Name as 'Producto', tblOrder.Unit, tblOrder.Qty, tblOrder.Total 
		from tblOrder inner join tblProducts on tblOrder.ProID = tblProducts.ProID
GO
/****** Object:  View [dbo].[getallorders]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[getallorders]
as
SELECT        TOP (100) dbo.tblInvoice.InvoiceId, dbo.tblUser.UserId, dbo.tblUser.Name AS [user], dbo.tblInvoice.Bill, dbo.tblInvoice.Payment, dbo.tblInvoice.InvoiceDate, dbo.tblInvoice.Status
FROM            dbo.tblInvoice INNER JOIN
                         dbo.tblUser ON dbo.tblUser.UserId = dbo.tblInvoice.UserId
ORDER BY dbo.tblInvoice.InvoiceId DESC
GO
/****** Object:  View [dbo].[getallorderusers]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[getallorderusers]
as
SELECT        TOP (100) dbo.tblInvoice.InvoiceId, dbo.tblUser.UserId, dbo.tblUser.Name AS [user], dbo.tblInvoice.Bill, dbo.tblInvoice.Payment, dbo.tblInvoice.InvoiceDate, dbo.tblInvoice.Status
FROM            dbo.tblInvoice INNER JOIN
                         dbo.tblUser ON dbo.tblUser.UserId = dbo.tblInvoice.UserId
ORDER BY dbo.tblInvoice.InvoiceId DESC
GO
/****** Object:  Table [dbo].[tblEstados]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEstados](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[activo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTracking]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTracking](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[observacion] [varchar](100) NULL,
	[InvoiceId] [int] NULL,
	[IdEstado] [int] NULL,
	[Modified_On] [smalldatetime] NULL,
	[Created_On] [datetime] NULL,
	[Sys_Change_Date] [datetime2](7) NULL,
	[activo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_TrackingUsuarios]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vw_TrackingUsuarios]
as
SELECT        top 100 dbo.tblTracking.id, dbo.tblTracking.nombre, dbo.tblTracking.InvoiceId, dbo.tblTracking.Created_On, dbo.tblEstados.nombre AS estado, dbo.tblTracking.observacion
FROM            dbo.tblTracking INNER JOIN
                         dbo.tblEstados ON dbo.tblTracking.IdEstado = dbo.tblEstados.id
ORDER BY dbo.tblTracking.Created_On DESC
GO
/****** Object:  View [dbo].[vw_TrackingEstados]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_TrackingEstados]
as
SELECT        top 100 dbo.tblTracking.id, dbo.tblTracking.nombre, dbo.tblTracking.InvoiceId, dbo.tblTracking.Created_On, dbo.tblEstados.nombre AS estado, dbo.tblTracking.observacion
FROM            dbo.tblTracking INNER JOIN
                         dbo.tblEstados ON dbo.tblTracking.IdEstado = dbo.tblEstados.id
ORDER BY dbo.tblTracking.Created_On DESC
GO
/****** Object:  View [dbo].[vw_comboPedidos]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vw_comboPedidos]
as
  Select top 100 tblInvoice.InvoiceId, 'Pedido: ' + CAST(tblInvoice.InvoiceId as varchar(10)) + ' | ' + CAST(tblUser.Name as varchar(10)) + ' | ' + CAST(tblInvoice.InvoiceDate as varchar(10)) as pedido
  from tblInvoice inner join tblUser on tblInvoice.UserId = tblUser.UserId
  order by tblInvoice.InvoiceId desc

GO
/****** Object:  Table [dbo].[tblProveedor]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProveedor](
	[idProv] [int] IDENTITY(1,1) NOT NULL,
	[nomProv] [varchar](30) NOT NULL,
	[RUC] [varchar](11) NOT NULL,
	[estado] [int] NOT NULL,
	[FechaRegistro] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[idProv] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblServicio]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblServicio](
	[idServ] [int] IDENTITY(1,1) NOT NULL,
	[nomServ] [varchar](30) NULL,
	[precServ] [money] NULL,
	[desServ] [varchar](30) NULL,
	[horarioServ] [varchar](50) NULL,
	[fecServ] [varchar](50) NULL,
	[enabled] [int] NULL,
	[createDate] [datetime] NULL,
	[idUser] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idServ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTipo]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTipo](
	[idTipo] [int] IDENTITY(1,1) NOT NULL,
	[nomTipo] [varchar](30) NOT NULL,
	[createDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTransaccion]    Script Date: 26/06/2021 15:57:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTransaccion](
	[idTransaccion] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [decimal](10, 2) NULL,
	[ItemId] [int] NULL,
	[createDate] [datetime] NULL,
	[Type] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idTransaccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblEstados] ADD  DEFAULT ((0)) FOR [activo]
GO
ALTER TABLE [dbo].[tblFactura] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[tblFactura] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[tblFacturaDetalles] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[tblMascota] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[tblMascota] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[tblProducts] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[tblProducts] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[tblProducts] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[tblProveedor] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[tblProveedor] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[tblServicio] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[tblServicio] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[tblTracking] ADD  DEFAULT (getdate()) FOR [Modified_On]
GO
ALTER TABLE [dbo].[tblTracking] ADD  DEFAULT (getdate()) FOR [Created_On]
GO
ALTER TABLE [dbo].[tblTracking] ADD  DEFAULT (sysdatetime()) FOR [Sys_Change_Date]
GO
ALTER TABLE [dbo].[tblTracking] ADD  DEFAULT ((0)) FOR [activo]
GO
ALTER TABLE [dbo].[tblTransaccion] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT (getdate()) FOR [fecharegistro]
GO
ALTER TABLE [dbo].[tblFacturaDetalles]  WITH CHECK ADD FOREIGN KEY([idFactura])
REFERENCES [dbo].[tblFactura] ([idFactura])
GO
ALTER TABLE [dbo].[tblInvoice]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[tblOrder] ([OrderId])
GO
ALTER TABLE [dbo].[tblInvoice]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD FOREIGN KEY([ProID])
REFERENCES [dbo].[tblProducts] ([ProID])
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblProducts]  WITH CHECK ADD FOREIGN KEY([CatID])
REFERENCES [dbo].[tblCategories] ([CatId])
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblProducts"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblCategories"
            Begin Extent = 
               Top = 6
               Left = 257
               Bottom = 102
               Right = 427
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getallproducts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getallproducts'
GO

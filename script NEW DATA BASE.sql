USE [TPI2023TM03]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[idEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[tipoUsuario] [varchar](20) NOT NULL,
	[nombreUsuario] [varchar](50) NOT NULL,
	[password] [varchar](100) NOT NULL,
 CONSTRAINT [PK__Empleado__5295297C43BAC60B] PRIMARY KEY CLUSTERED 
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Habitacion]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Habitacion](
	[idHabitacion] [int] IDENTITY(1,1) NOT NULL,
	[estado] [bit] NOT NULL,
	[numeroHabitacion] [int] NOT NULL,
	[pisoHabitacion] [int] NOT NULL,
	[idTipoHabitacion] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idHabitacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Habitacion] UNIQUE NONCLUSTERED 
(
	[pisoHabitacion] ASC,
	[numeroHabitacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Huesped]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Huesped](
	[idHuesped] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[apellido] [varchar](100) NOT NULL,
	[numeroDocumento] [varchar](20) NOT NULL,
	[tipoDocumento] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idHuesped] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Huesped] UNIQUE NONCLUSTERED 
(
	[numeroDocumento] ASC,
	[tipoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrecioServicio]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrecioServicio](
	[idPrecioServicio] [int] IDENTITY(1,1) NOT NULL,
	[fechaPrecio] [datetime] NOT NULL,
	[precioServicio] [float] NOT NULL,
	[idServicio] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idPrecioServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrecioTipoHabitacion]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrecioTipoHabitacion](
	[idPrecioTipoHabitacion] [int] IDENTITY(1,1) NOT NULL,
	[fechaPrecio] [datetime] NOT NULL,
	[precioHabitacion] [float] NOT NULL,
	[idTipoHabitacion] [int] NOT NULL,
 CONSTRAINT [PK__PrecioTi__6BCE3FC9630C3AC5] PRIMARY KEY CLUSTERED 
(
	[idPrecioTipoHabitacion] ASC,
	[idTipoHabitacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reserva]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reserva](
	[idReserva] [int] IDENTITY(1,1) NOT NULL,
	[fechaInscripcion] [date] NOT NULL,
	[fechaInicioReserva] [date] NOT NULL,
	[fechaFinReserva] [date] NOT NULL,
	[estadoReserva] [varchar](100) NOT NULL,
	[cantidadPersonas] [int] NOT NULL,
	[idHabitacion] [int] NOT NULL,
	[idHuesped] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idReserva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reserva_Servicio]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reserva_Servicio](
	[idReservaServicio] [int] IDENTITY(1,1) NOT NULL,
	[idReserva] [int] NOT NULL,
	[idServicio] [int] NOT NULL,
 CONSTRAINT [PK_Reserva_Servicio] PRIMARY KEY CLUSTERED 
(
	[idReservaServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Reserva_Servicio] UNIQUE NONCLUSTERED 
(
	[idReserva] ASC,
	[idServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicio](
	[idServicio] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idServicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Servicio] UNIQUE NONCLUSTERED 
(
	[descripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoHabitacion]    Script Date: 02/11/2023 20:03:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoHabitacion](
	[idTipoHabitacion] [int] IDENTITY(1,1) NOT NULL,
	[numeroCamas] [int] NOT NULL,
	[descripcion] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoHabitacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_TipoHabitacion] UNIQUE NONCLUSTERED 
(
	[descripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Habitacion]  WITH CHECK ADD  CONSTRAINT [FK__Habitacio__idTip__2C3393D0] FOREIGN KEY([idTipoHabitacion])
REFERENCES [dbo].[TipoHabitacion] ([idTipoHabitacion])
GO
ALTER TABLE [dbo].[Habitacion] CHECK CONSTRAINT [FK__Habitacio__idTip__2C3393D0]
GO
ALTER TABLE [dbo].[PrecioServicio]  WITH CHECK ADD  CONSTRAINT [FK__PrecioSer__idSer__02FC7413] FOREIGN KEY([idServicio])
REFERENCES [dbo].[Servicio] ([idServicio])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PrecioServicio] CHECK CONSTRAINT [FK__PrecioSer__idSer__02FC7413]
GO
ALTER TABLE [dbo].[PrecioTipoHabitacion]  WITH CHECK ADD  CONSTRAINT [FK__PrecioTip__idTip__31EC6D26] FOREIGN KEY([idTipoHabitacion])
REFERENCES [dbo].[TipoHabitacion] ([idTipoHabitacion])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PrecioTipoHabitacion] CHECK CONSTRAINT [FK__PrecioTip__idTip__31EC6D26]
GO
ALTER TABLE [dbo].[Reserva]  WITH CHECK ADD  CONSTRAINT [FK__Reserva__idHabit__35BCFE0A] FOREIGN KEY([idHabitacion])
REFERENCES [dbo].[Habitacion] ([idHabitacion])
GO
ALTER TABLE [dbo].[Reserva] CHECK CONSTRAINT [FK__Reserva__idHabit__35BCFE0A]
GO
ALTER TABLE [dbo].[Reserva]  WITH CHECK ADD  CONSTRAINT [FK__Reserva__idHuesp__151B244E] FOREIGN KEY([idHuesped])
REFERENCES [dbo].[Huesped] ([idHuesped])
GO
ALTER TABLE [dbo].[Reserva] CHECK CONSTRAINT [FK__Reserva__idHuesp__151B244E]
GO
ALTER TABLE [dbo].[Reserva_Servicio]  WITH CHECK ADD  CONSTRAINT [FK_Reserva_Servicio_Reserva] FOREIGN KEY([idReserva])
REFERENCES [dbo].[Reserva] ([idReserva])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reserva_Servicio] CHECK CONSTRAINT [FK_Reserva_Servicio_Reserva]
GO
ALTER TABLE [dbo].[Reserva_Servicio]  WITH CHECK ADD  CONSTRAINT [FK_Reserva_Servicio_Servicio] FOREIGN KEY([idServicio])
REFERENCES [dbo].[Servicio] ([idServicio])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reserva_Servicio] CHECK CONSTRAINT [FK_Reserva_Servicio_Servicio]
GO

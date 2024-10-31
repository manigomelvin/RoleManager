USE [master]
GO
/****** Object:  Database [RoleManager]    Script Date: 27/10/2024 2:43:46 am ******/
CREATE DATABASE [RoleManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RoleManager', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\RoleManager.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RoleManager_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\RoleManager_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [RoleManager] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RoleManager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RoleManager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RoleManager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RoleManager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RoleManager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RoleManager] SET ARITHABORT OFF 
GO
ALTER DATABASE [RoleManager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RoleManager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RoleManager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RoleManager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RoleManager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RoleManager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RoleManager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RoleManager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RoleManager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RoleManager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RoleManager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RoleManager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RoleManager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RoleManager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RoleManager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RoleManager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RoleManager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RoleManager] SET RECOVERY FULL 
GO
ALTER DATABASE [RoleManager] SET  MULTI_USER 
GO
ALTER DATABASE [RoleManager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RoleManager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RoleManager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RoleManager] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RoleManager] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RoleManager] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RoleManager', N'ON'
GO
ALTER DATABASE [RoleManager] SET QUERY_STORE = ON
GO
ALTER DATABASE [RoleManager] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [RoleManager]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 27/10/2024 2:43:46 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 27/10/2024 2:43:46 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
	[CompanyId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Companies] ON 

INSERT [dbo].[Companies] ([Id], [Name]) VALUES (1, N'Razor ERP')
INSERT [dbo].[Companies] ([Id], [Name]) VALUES (2, N'Purple Group')
SET IDENTITY_INSERT [dbo].[Companies] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [PasswordHash], [Role], [CompanyId]) VALUES (1, N'admin_user', N'$2a$12$CzhBxZiBQWS/hIMYIcbzZOq5tgnc48.s08JVh1visYwG5eB32vvA2', N'Admin', 1)
INSERT [dbo].[Users] ([Id], [Username], [PasswordHash], [Role], [CompanyId]) VALUES (2, N'normal_user', N'$2a$12$6Mx.ZM2gRJZJYv7S2I5FGuHjKRwipZLlh76AaoPw7RFaU2xDWs9Ha', N'User', 1)
INSERT [dbo].[Users] ([Id], [Username], [PasswordHash], [Role], [CompanyId]) VALUES (3, N'normal_user2', N'$2a$12$oNNp0r7iTTRUTkosM6dIMOFrVWxtzAW5bgGiMvnQS1gu9yE7kUyY.', N'User', 2)
INSERT [dbo].[Users] ([Id], [Username], [PasswordHash], [Role], [CompanyId]) VALUES (5, N'lLim', N'$2a$11$AVezmxp31OyL8f4f59jI5O0SdPNNT8rUXqTSvgHHIQCI/giwing2G', N'Admin', 1)
INSERT [dbo].[Users] ([Id], [Username], [PasswordHash], [Role], [CompanyId]) VALUES (6, N'bmanalili', N'$2a$11$a18awi7SEPuRk0qfyc9gVOau1CHjuUOjlqqXKcVGGTEE5VEytKQVO', N'Admin', 2)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E48FE10FB7]    Script Date: 27/10/2024 2:43:46 am ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([Role]='User' OR [Role]='Admin'))
GO
USE [master]
GO
ALTER DATABASE [RoleManager] SET  READ_WRITE 
GO

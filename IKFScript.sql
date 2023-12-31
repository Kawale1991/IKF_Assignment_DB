USE [IKFCrud]
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 10-07-2023 12:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designation](
	[DesignationID] [bigint] NULL,
	[DesignationName] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IKFEmployee]    Script Date: 10-07-2023 12:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IKFEmployee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[DOB] [date] NOT NULL,
	[SKILLS] [varchar](100) NOT NULL,
	[DESIGNATION] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Skills]    Script Date: 10-07-2023 12:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skills](
	[SkillID] [int] IDENTITY(1,1) NOT NULL,
	[SkillName] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Designation] ([DesignationID], [DesignationName]) VALUES (1, N'Junior Software Developer')
INSERT [dbo].[Designation] ([DesignationID], [DesignationName]) VALUES (2, N'Senior Software Developer')
INSERT [dbo].[Designation] ([DesignationID], [DesignationName]) VALUES (3, N'Techinical Lead')
INSERT [dbo].[Designation] ([DesignationID], [DesignationName]) VALUES (4, N'Manager')
INSERT [dbo].[Designation] ([DesignationID], [DesignationName]) VALUES (5, N'All')
GO
SET IDENTITY_INSERT [dbo].[IKFEmployee] ON 

INSERT [dbo].[IKFEmployee] ([ID], [Name], [DOB], [SKILLS], [DESIGNATION]) VALUES (39, N'SHYAM MAHADEV KAWALE', CAST(N'2023-07-31' AS Date), N'JavaScript', N'Techinical Lead')
SET IDENTITY_INSERT [dbo].[IKFEmployee] OFF
GO
SET IDENTITY_INSERT [dbo].[Skills] ON 

INSERT [dbo].[Skills] ([SkillID], [SkillName]) VALUES (2, N'ASP.NET')
INSERT [dbo].[Skills] ([SkillID], [SkillName]) VALUES (3, N'HTML')
INSERT [dbo].[Skills] ([SkillID], [SkillName]) VALUES (4, N'CSS')
INSERT [dbo].[Skills] ([SkillID], [SkillName]) VALUES (5, N'JavaScript')
SET IDENTITY_INSERT [dbo].[Skills] OFF
GO
/****** Object:  StoredProcedure [dbo].[IKFCRUD]    Script Date: 10-07-2023 12:52:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IKFCRUD]
(
	@ID INT = NULL,
	@NAME NVARCHAR(100) = NULL,
	@DOB DATE = NULL,
	@SKILLS NVARCHAR(200)= NULL,
	@ACTION NVARCHAR(50)= NULL,
	@DESIGNATION NVARCHAR(100) = NULL
)
AS BEGIN
BEGIN TRY
	IF @ACTION = 'INSERT'
	BEGIN
			INSERT INTO IKFEmployee
			VALUES(@NAME,@DOB,@SKILLS,@DESIGNATION);
	END
	ELSE IF @ACTION ='UPDATE'
	BEGIN
			UPDATE IKFEmployee SET NAME=@NAME,DOB=@DOB,SKILLS=@SKILLS, DESIGNATION=@DESIGNATION WHERE ID= @ID;
	END
	ELSE IF @ACTION ='DELETE'
	BEGIN
		DELETE FROM IKFEmployee WHERE ID= @ID;
	END
	ELSE IF @ACTION ='GETDATA'
	BEGIN
		SELECT * FROM IKFEmployee;
	END
	ELSE IF @ACTION ='EDITDATA'
	BEGIN
		SELECT * FROM IKFEmployee WHERE ID= @ID;
	END
	ELSE IF @ACTION ='GETSKILLS'
	BEGIN
		SELECT SkillID, SkillName FROM Skills;
	END
	ELSE IF @ACTION ='LOADDESIGNATION'
	BEGIN
		SELECT * FROM DESIGNATION ORDER BY DesignationID DESC;
	END
	
END TRY
BEGIN CATCH
  print 'This is the CATCH block for our MAIN sql code block:'
  + ' Error Number #'+convert(varchar,ERROR_NUMBER())
  + ' Error Line #'+convert(varchar,ERROR_LINE())
  + ' of procedure '+isnull(ERROR_PROCEDURE(),'(Main)')
END CATCH
END
GO

USE [master]
GO
/****** Object:  Database [Quiz]    Script Date: 19/06/2017 6:26:14 CH ******/
CREATE DATABASE [Quiz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Quiz', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Quiz.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Quiz_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Quiz_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Quiz] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Quiz].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Quiz] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Quiz] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Quiz] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Quiz] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Quiz] SET ARITHABORT OFF 
GO
ALTER DATABASE [Quiz] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Quiz] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Quiz] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Quiz] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Quiz] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Quiz] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Quiz] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Quiz] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Quiz] SET RECURSIVE_TRIGGERS ON 
GO
ALTER DATABASE [Quiz] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Quiz] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Quiz] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Quiz] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Quiz] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Quiz] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Quiz] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Quiz] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Quiz] SET RECOVERY FULL 
GO
ALTER DATABASE [Quiz] SET  MULTI_USER 
GO
ALTER DATABASE [Quiz] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Quiz] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Quiz] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Quiz] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Quiz] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Quiz', N'ON'
GO
USE [Quiz]
GO
/****** Object:  UserDefinedFunction [dbo].[getCorrectAnswer]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getCorrectAnswer](@id_question int, @id_answer int)
returns NVARCHAR(MAX)
as
begin
declare @rs NVARCHAR(MAX)
set @rs = (select answer_content from dbo.correct_answer where id_question=@id_question and id_answer=@id_answer)
return @rs
end


GO
/****** Object:  Table [dbo].[account]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[account](
	[id_acc] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[birth] [date] NULL,
	[job] [nvarchar](50) NULL,
	[gender] [bit] NULL,
	[email] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[state] [bit] NOT NULL CONSTRAINT [DF_account_state]  DEFAULT ((0)),
	[address] [nvarchar](300) NULL,
	[avatar] [varchar](500) NULL,
 CONSTRAINT [PK_account] PRIMARY KEY CLUSTERED 
(
	[id_acc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cl_list2]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cl_list2](
	[pmcode] [nvarchar](10) NOT NULL,
	[cdgr] [nvarchar](10) NOT NULL,
	[val_name] [nvarchar](50) NOT NULL,
	[param_name] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_clList2] PRIMARY KEY CLUSTERED 
(
	[param_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[comment]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[id_post] [int] NOT NULL,
	[id_acc] [int] NOT NULL,
	[comment_content] [ntext] NOT NULL,
	[comment_time] [datetime] NOT NULL,
	[comment_state] [bit] NOT NULL,
	[id_comment] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_comment] PRIMARY KEY CLUSTERED 
(
	[id_comment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[correct_answer]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[correct_answer](
	[id_question] [int] NOT NULL,
	[id_answer] [int] NOT NULL,
	[answer_content] [text] NULL,
	[correct_answer] [bit] NULL,
 CONSTRAINT [PK_correct_answer_1] PRIMARY KEY CLUSTERED 
(
	[id_question] ASC,
	[id_answer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[chat]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[chat](
	[chat_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](max) NOT NULL,
	[room_id] [nvarchar](max) NOT NULL,
	[COUNT_MSG] [int] NULL CONSTRAINT [DF_chat_COUNT_MSG]  DEFAULT ((0)),
	[LAST_USER] [varchar](max) NULL,
 CONSTRAINT [PK_chat] PRIMARY KEY CLUSTERED 
(
	[chat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[chatdetails]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chatdetails](
	[details_chat_id] [int] IDENTITY(1,1) NOT NULL,
	[body] [ntext] NULL,
	[time_on] [datetime] NULL,
	[chat_id] [int] NULL,
	[url] [nvarchar](255) NULL,
	[client_id] [nvarchar](255) NULL,
 CONSTRAINT [PK_chatdetails] PRIMARY KEY CLUSTERED 
(
	[details_chat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[liked]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[liked](
	[id_post] [int] NOT NULL,
	[id_acc] [int] NOT NULL,
 CONSTRAINT [PK_like] PRIMARY KEY CLUSTERED 
(
	[id_post] ASC,
	[id_acc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[post]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[post](
	[id_post] [int] IDENTITY(1,1) NOT NULL,
	[post_content] [ntext] NOT NULL,
	[post_date] [datetime] NOT NULL,
	[id_connect] [int] NOT NULL,
	[id_post_type] [int] NOT NULL,
	[id_acc] [int] NOT NULL,
 CONSTRAINT [PK_post] PRIMARY KEY CLUSTERED 
(
	[id_post] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[post_manage]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[post_manage](
	[id_post] [int] NOT NULL,
	[id_room] [int] NOT NULL,
 CONSTRAINT [PK_post_manage_1] PRIMARY KEY CLUSTERED 
(
	[id_post] ASC,
	[id_room] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[question]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question](
	[id_question] [int] IDENTITY(1,1) NOT NULL,
	[question_content] [text] NULL,
	[question_type] [int] NULL,
	[id_topic] [int] NULL,
 CONSTRAINT [PK_question] PRIMARY KEY CLUSTERED 
(
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[room]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[room](
	[id_room] [int] IDENTITY(1,1) NOT NULL,
	[room_name] [nvarchar](50) NOT NULL,
	[room_descr] [nvarchar](100) NOT NULL,
	[id_acc] [int] NOT NULL,
	[id_test] [int] NULL,
 CONSTRAINT [PK_room] PRIMARY KEY CLUSTERED 
(
	[id_room] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[room_manage]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[room_manage](
	[id_room] [int] NOT NULL,
	[id_acc] [int] NOT NULL,
	[state] [bit] NOT NULL,
 CONSTRAINT [PK_room_manage] PRIMARY KEY CLUSTERED 
(
	[id_room] ASC,
	[id_acc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[task]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[task](
	[id_test] [int] NOT NULL,
	[id_acc] [int] NOT NULL,
	[id_question] [int] NOT NULL,
	[id_answer] [int] NULL,
	[note] [text] NULL,
 CONSTRAINT [PK_task] PRIMARY KEY CLUSTERED 
(
	[id_test] ASC,
	[id_acc] ASC,
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[test]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[id_test] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[date_start] [date] NULL,
	[date_end] [date] NULL,
 CONSTRAINT [PK_test] PRIMARY KEY CLUSTERED 
(
	[id_test] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[test_content]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test_content](
	[id_test] [int] NOT NULL,
	[id_question] [int] NOT NULL,
 CONSTRAINT [PK_test_content] PRIMARY KEY CLUSTERED 
(
	[id_test] ASC,
	[id_question] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[test_default_room]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test_default_room](
	[id_test] [int] NOT NULL,
	[id_room] [int] NOT NULL,
 CONSTRAINT [PK_test_default_room] PRIMARY KEY CLUSTERED 
(
	[id_test] ASC,
	[id_room] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[topic]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[topic](
	[id_topic] [int] IDENTITY(1,1) NOT NULL,
	[topic_name] [nvarchar](300) NULL,
	[id_acc] [int] NULL,
 CONSTRAINT [PK_topic] PRIMARY KEY CLUSTERED 
(
	[id_topic] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[f_getMemberInRoom]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

   create function [dbo].[f_getMemberInRoom](@id_room int)  returns table
   as
   return(
		select  account.id_acc, isnull(name,email) as name from room_manage  left join account on account.id_acc=room_manage.id_acc   where room_manage.id_room=@id_room and room_manage.state=1)




GO
/****** Object:  UserDefinedFunction [dbo].[getPostByGroup]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[getPostByGroup](@room_id int)
returns table
as
return (select  p.id_post,p.post_content,p.post_date, p.id_acc,case when p.id_connect =0 then 'POST' else 'QUIZ' end as type_post,case when p.id_connect =0 then '' ELSE isnull(dbo.getCorrectAnswer(id_connect,1),'') END as da1,case when p.id_connect =0 then ''ELSE isnull(dbo.getCorrectAnswer(id_connect,2),'') END as da2,case when p.id_connect =0 then '' ELSE isnull(dbo.getCorrectAnswer(id_connect,3),'') END as da3,case when p.id_connect =0 then '' ELSE isnull(dbo.getCorrectAnswer(id_connect,4),'') END as da4
from dbo.post_manage m inner join ( dbo.post p left join dbo.question q  on p.id_connect = q.id_question ) on m.id_post=p.id_post
where m.id_room=@room_id
)

GO
/****** Object:  UserDefinedFunction [dbo].[getPostQuizByGroup]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getPostQuizByGroup](@post_id int)
returns table
as
return (select  p.id_post,p.post_content,p.post_date, p.id_acc,case when p.id_connect =0 then 'POST' else 'QUIZ' end as type_post,case when p.id_connect =0 then '' ELSE isnull(dbo.getCorrectAnswer(id_connect,1),'') END as da1,case when p.id_connect =0 then ''ELSE isnull(dbo.getCorrectAnswer(id_connect,2),'') END as da2,case when p.id_connect =0 then '' ELSE isnull(dbo.getCorrectAnswer(id_connect,3),'') END as da3,case when p.id_connect =0 then '' ELSE isnull(dbo.getCorrectAnswer(id_connect,4),'') END as da4
from dbo.post p left join dbo.question q  on p.id_connect = q.id_question 
where p.id_connect > 0 and p.id_post=@post_id
)

GO
SET IDENTITY_INSERT [dbo].[account] ON 

INSERT [dbo].[account] ([id_acc], [name], [birth], [job], [gender], [email], [password], [state], [address], [avatar]) VALUES (1, N'Spring Team', CAST(N'2017-06-01' AS Date), N'Sinh Viên', 0, N'vanthang20437@gmail.com', N'12345', 1, N'Dh Nông lâm', N'https://docs.google.com/uc?id=0B8pIcz51dX7JTnM1MGNrZ1hhWkk')
INSERT [dbo].[account] ([id_acc], [name], [birth], [job], [gender], [email], [password], [state], [address], [avatar]) VALUES (2, N'Trương Tam Lang', CAST(N'2017-06-03' AS Date), N'Sinh Viên', 1, N'vanthang1996@yahoo.com', N'12345', 1, N'DH Nông lâm', N'https://docs.google.com/uc?id=0B8pIcz51dX7JOVUtemE0M0dXZnc')
INSERT [dbo].[account] ([id_acc], [name], [birth], [job], [gender], [email], [password], [state], [address], [avatar]) VALUES (3, NULL, NULL, NULL, NULL, N'14130118@st.hcmuaf.edu.vn', N'12345', 1, NULL, NULL)
INSERT [dbo].[account] ([id_acc], [name], [birth], [job], [gender], [email], [password], [state], [address], [avatar]) VALUES (4, N'Trương Tam Lang', CAST(N'2017-06-19' AS Date), N'Sinh Viên', 1, N'lang.tt16@gmail.com', N'12345', 1, N'Đại Học Nông Lâm', N'https://docs.google.com/uc?id=0B8pIcz51dX7JUG1NVkhBQVU0T0k')
SET IDENTITY_INSERT [dbo].[account] OFF
SET IDENTITY_INSERT [dbo].[cl_list2] ON 

INSERT [dbo].[cl_list2] ([pmcode], [cdgr], [val_name], [param_name]) VALUES (N'USER', N'POST', N'Trạng thái', 1)
INSERT [dbo].[cl_list2] ([pmcode], [cdgr], [val_name], [param_name]) VALUES (N'USER', N'POST', N'Trắc nghiệm', 3)
INSERT [dbo].[cl_list2] ([pmcode], [cdgr], [val_name], [param_name]) VALUES (N'USER', N'POST', N'Up file', 4)
INSERT [dbo].[cl_list2] ([pmcode], [cdgr], [val_name], [param_name]) VALUES (N'USER', N'POST', N'Trạng thái', 5)
SET IDENTITY_INSERT [dbo].[cl_list2] OFF
SET IDENTITY_INSERT [dbo].[comment] ON 

INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'xádasd', CAST(N'2017-05-06 10:01:08.893' AS DateTime), 1, 1004)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'xádasd', CAST(N'2017-05-06 10:01:10.243' AS DateTime), 1, 1005)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:36.410' AS DateTime), 1, 1006)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:36.870' AS DateTime), 1, 1007)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.137' AS DateTime), 1, 1008)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.320' AS DateTime), 1, 1009)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.490' AS DateTime), 1, 1010)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.657' AS DateTime), 1, 1011)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.833' AS DateTime), 1, 1012)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:38.007' AS DateTime), 1, 1013)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:38.187' AS DateTime), 1, 1014)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:38.357' AS DateTime), 1, 1015)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:39.130' AS DateTime), 1, 1016)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:39.300' AS DateTime), 1, 1017)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:39.483' AS DateTime), 1, 1018)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (2074, 2, N'dit', CAST(N'2017-06-05 03:17:10.540' AS DateTime), 1, 1019)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (37, 2, N'chó', CAST(N'2017-06-06 14:33:46.987' AS DateTime), 1, 1020)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (37, 2, N'abc', CAST(N'2017-06-17 15:12:20.020' AS DateTime), 1, 1021)
SET IDENTITY_INSERT [dbo].[comment] OFF
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1, 1, NULL, NULL)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2, 2, N'nodn4g', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2, 3, N'nodng343', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2, 4, N'nodng34', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1002, 1, N'nodnffg', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1002, 2, N'nodn4g', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1002, 3, N'nodng343', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1002, 4, N'nodng34', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1003, 1, N'asdasdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1003, 2, N'dasdasdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1003, 3, N'jvj', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1003, 4, NULL, 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1004, 1, N'asdasdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1004, 2, N'dasdasdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1004, 3, N'jvj', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1004, 4, NULL, 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1005, 1, N'1', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1005, 2, N'2', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1005, 3, N'4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1005, 4, NULL, 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1006, 1, N'1', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1006, 2, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1006, 3, N'4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1006, 4, N'5', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1007, 1, N'1', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1007, 2, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1007, 3, N'4', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1007, 4, N'5', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1008, 1, N'nodnffg', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1008, 2, N'nodn4g', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1008, 3, N'nodng343', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1008, 4, N'nodng34', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1009, 1, N'?áp án 1', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1009, 2, N'?áp án 2', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1009, 3, N'?áp án 3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1009, 4, N'?áp án 4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1010, 1, N'H? ti?u', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1010, 2, N'Bánh canh', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1010, 3, N'Cơm', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1010, 4, N'Cháo', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1011, 1, N'addf', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1011, 2, N'adsad', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1011, 3, N'ádad', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1011, 4, N'sadasd', 0)
SET IDENTITY_INSERT [dbo].[chat] ON 

INSERT [dbo].[chat] ([chat_id], [code], [room_id], [COUNT_MSG], [LAST_USER]) VALUES (1, N'POST_2', N'1', 0, N'1')
INSERT [dbo].[chat] ([chat_id], [code], [room_id], [COUNT_MSG], [LAST_USER]) VALUES (2, N'POST_1', N'2', 0, N'2')
SET IDENTITY_INSERT [dbo].[chat] OFF
SET IDENTITY_INSERT [dbo].[chatdetails] ON 

INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (1, N'Trương Tam Lang vừa đăng một bài viết mới trong nhóm A hi hi', CAST(N'2017-06-19 16:27:32.113' AS DateTime), 1, N'/classRoom/14#divcontent2079', N'1')
INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (2, N'Spring Team vừa đăng một bài viết mới trong nhóm A hi hi', CAST(N'2017-06-19 16:41:56.020' AS DateTime), 2, N'/classRoom/14#divcontent2080', N'2')
INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (3, N'Trương Tam Lang vừa đăng một bài viết mới trong nhóm A hi hi', CAST(N'2017-06-19 16:47:31.640' AS DateTime), 1, N'/classRoom/14#divcontent2081', N'1')
INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (4, N'Trương Tam Lang vừa đăng một bài viết mới trong nhóm A hi hi', CAST(N'2017-06-19 16:47:31.737' AS DateTime), 1, N'/classRoom/14#divcontent2082', N'1')
SET IDENTITY_INSERT [dbo].[chatdetails] OFF
SET IDENTITY_INSERT [dbo].[post] ON 

INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (14, N'dxfcgv
', CAST(N'2017-05-03 15:02:35.340' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (16, N'ádasd
', CAST(N'2017-05-06 10:00:58.817' AS DateTime), 0, 1, 3)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (35, N'ád', CAST(N'2017-05-08 03:10:32.557' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (37, N'ád', CAST(N'2017-05-08 03:10:37.690' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (38, N'â', CAST(N'2017-05-08 03:12:15.420' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (39, N'Noi dung test', CAST(N'2017-05-08 16:11:15.907' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (40, N'asdasdas', CAST(N'2017-05-08 16:30:01.833' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (64, N'nodng', CAST(N'2017-05-13 12:57:26.237' AS DateTime), 2, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1064, N'nodng', CAST(N'2017-05-13 13:15:05.010' AS DateTime), 1002, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1065, N'asdasdasd', CAST(N'2017-05-13 13:34:00.413' AS DateTime), 1003, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1066, N'asdasdasd', CAST(N'2017-05-13 13:39:34.597' AS DateTime), 1004, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1067, N'tesst 5', CAST(N'2017-05-13 13:40:24.340' AS DateTime), 1005, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1068, N'asdasd1111', CAST(N'2017-05-13 13:43:00.407' AS DateTime), 1006, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1069, N'Cau hoi 1', CAST(N'2017-05-13 13:45:23.037' AS DateTime), 1007, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1070, N'nodng', CAST(N'2017-05-13 14:21:35.510' AS DateTime), 1008, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (2072, N'12345', CAST(N'2017-05-22 00:30:26.117' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (2074, N'abc', CAST(N'2017-06-05 03:17:02.733' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (2075, N'Hôm nay ăn g?', CAST(N'2017-06-06 22:41:51.030' AS DateTime), 1010, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (2076, N'haha', CAST(N'2017-06-17 15:12:39.153' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (2077, N'abc', CAST(N'2017-06-17 16:09:15.553' AS DateTime), 1011, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (2078, N'sadsadasdas', CAST(N'2017-06-18 17:16:55.550' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (2081, N'ádasdasd', CAST(N'2017-06-19 16:47:30.780' AS DateTime), 0, 1, 2)
SET IDENTITY_INSERT [dbo].[post] OFF
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (14, 2)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (16, 3)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (2077, 2)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (2078, 2)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (2081, 14)
SET IDENTITY_INSERT [dbo].[question] ON 

INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1, N'Không tin du?c', 3, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2, N'nodng', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1002, N'nodng', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1003, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1004, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1005, N'tesst 5', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1006, N'asdasd1111', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1007, N'Cau hoi 1', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1008, N'nodng', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1009, N'test post with type Quiz', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1010, N'Hôm nay ăn g?', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (1011, N'abc', NULL, NULL)
SET IDENTITY_INSERT [dbo].[question] OFF
SET IDENTITY_INSERT [dbo].[room] ON 

INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (2, N'hsgdfjha', N'', 1, NULL)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (3, N'hscdvbkjlam', N'', 3, NULL)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (14, N'A hi hi', N'', 2, 7)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (15, N'HTTTQL', N'', 2, 8)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (16, N'adsasd', N'', 1, 9)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (17, N'sdasd', N'', 4, 10)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (18, N'lạááa', N'', 2, 11)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (19, N'sdsadsada', N'', 2, 12)
SET IDENTITY_INSERT [dbo].[room] OFF
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (2, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (3, 3, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (14, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (14, 2, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (15, 2, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (16, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (17, 4, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (18, 2, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (19, 2, 1)
SET IDENTITY_INSERT [dbo].[test] ON 

INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (4, N'11-POST-2', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (5, N'12-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (6, N'13-POST-2', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (7, N'14-POST-2', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (8, N'15-POST-2', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (9, N'16-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (10, N'17-POST-4', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (11, N'18-POST-2', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (12, N'19-POST-2', NULL, NULL)
SET IDENTITY_INSERT [dbo].[test] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_account]    Script Date: 19/06/2017 6:26:14 CH ******/
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [IX_account] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FK_comment_account] FOREIGN KEY([id_acc])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FK_comment_account]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FK_comment_post] FOREIGN KEY([id_post])
REFERENCES [dbo].[post] ([id_post])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FK_comment_post]
GO
ALTER TABLE [dbo].[correct_answer]  WITH CHECK ADD  CONSTRAINT [FK_correct_answer_question1] FOREIGN KEY([id_question])
REFERENCES [dbo].[question] ([id_question])
GO
ALTER TABLE [dbo].[correct_answer] CHECK CONSTRAINT [FK_correct_answer_question1]
GO
ALTER TABLE [dbo].[chatdetails]  WITH CHECK ADD  CONSTRAINT [FK_chatdetails_chat] FOREIGN KEY([chat_id])
REFERENCES [dbo].[chat] ([chat_id])
GO
ALTER TABLE [dbo].[chatdetails] CHECK CONSTRAINT [FK_chatdetails_chat]
GO
ALTER TABLE [dbo].[liked]  WITH CHECK ADD  CONSTRAINT [FK_like_account] FOREIGN KEY([id_acc])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[liked] CHECK CONSTRAINT [FK_like_account]
GO
ALTER TABLE [dbo].[liked]  WITH CHECK ADD  CONSTRAINT [FK_like_post] FOREIGN KEY([id_post])
REFERENCES [dbo].[post] ([id_post])
GO
ALTER TABLE [dbo].[liked] CHECK CONSTRAINT [FK_like_post]
GO
ALTER TABLE [dbo].[post]  WITH CHECK ADD  CONSTRAINT [FK_post_account] FOREIGN KEY([id_acc])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[post] CHECK CONSTRAINT [FK_post_account]
GO
ALTER TABLE [dbo].[post]  WITH CHECK ADD  CONSTRAINT [FK_post_clList2] FOREIGN KEY([id_post_type])
REFERENCES [dbo].[cl_list2] ([param_name])
GO
ALTER TABLE [dbo].[post] CHECK CONSTRAINT [FK_post_clList2]
GO
ALTER TABLE [dbo].[post_manage]  WITH CHECK ADD  CONSTRAINT [FK_post_manage_post] FOREIGN KEY([id_post])
REFERENCES [dbo].[post] ([id_post])
GO
ALTER TABLE [dbo].[post_manage] CHECK CONSTRAINT [FK_post_manage_post]
GO
ALTER TABLE [dbo].[post_manage]  WITH CHECK ADD  CONSTRAINT [FK_post_manage_room] FOREIGN KEY([id_room])
REFERENCES [dbo].[room] ([id_room])
GO
ALTER TABLE [dbo].[post_manage] CHECK CONSTRAINT [FK_post_manage_room]
GO
ALTER TABLE [dbo].[question]  WITH CHECK ADD  CONSTRAINT [FK_question_clList22] FOREIGN KEY([question_type])
REFERENCES [dbo].[cl_list2] ([param_name])
GO
ALTER TABLE [dbo].[question] CHECK CONSTRAINT [FK_question_clList22]
GO
ALTER TABLE [dbo].[question]  WITH CHECK ADD  CONSTRAINT [FK_question_topic] FOREIGN KEY([id_topic])
REFERENCES [dbo].[topic] ([id_topic])
GO
ALTER TABLE [dbo].[question] CHECK CONSTRAINT [FK_question_topic]
GO
ALTER TABLE [dbo].[room]  WITH CHECK ADD  CONSTRAINT [FK_room_account] FOREIGN KEY([id_acc])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[room] CHECK CONSTRAINT [FK_room_account]
GO
ALTER TABLE [dbo].[room_manage]  WITH CHECK ADD  CONSTRAINT [FK_room_manage_account] FOREIGN KEY([id_acc])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[room_manage] CHECK CONSTRAINT [FK_room_manage_account]
GO
ALTER TABLE [dbo].[room_manage]  WITH CHECK ADD  CONSTRAINT [FK_room_manage_room] FOREIGN KEY([id_room])
REFERENCES [dbo].[room] ([id_room])
GO
ALTER TABLE [dbo].[room_manage] CHECK CONSTRAINT [FK_room_manage_room]
GO
ALTER TABLE [dbo].[task]  WITH CHECK ADD  CONSTRAINT [FK_task_account] FOREIGN KEY([id_acc])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[task] CHECK CONSTRAINT [FK_task_account]
GO
ALTER TABLE [dbo].[task]  WITH CHECK ADD  CONSTRAINT [FK_task_question] FOREIGN KEY([id_question])
REFERENCES [dbo].[question] ([id_question])
GO
ALTER TABLE [dbo].[task] CHECK CONSTRAINT [FK_task_question]
GO
ALTER TABLE [dbo].[task]  WITH CHECK ADD  CONSTRAINT [FK_task_test] FOREIGN KEY([id_test])
REFERENCES [dbo].[test] ([id_test])
GO
ALTER TABLE [dbo].[task] CHECK CONSTRAINT [FK_task_test]
GO
ALTER TABLE [dbo].[test_content]  WITH CHECK ADD  CONSTRAINT [FK_test_content_question] FOREIGN KEY([id_question])
REFERENCES [dbo].[question] ([id_question])
GO
ALTER TABLE [dbo].[test_content] CHECK CONSTRAINT [FK_test_content_question]
GO
ALTER TABLE [dbo].[test_content]  WITH CHECK ADD  CONSTRAINT [FK_test_content_test] FOREIGN KEY([id_test])
REFERENCES [dbo].[test] ([id_test])
GO
ALTER TABLE [dbo].[test_content] CHECK CONSTRAINT [FK_test_content_test]
GO
ALTER TABLE [dbo].[test_default_room]  WITH CHECK ADD  CONSTRAINT [FK_test_default_room_room] FOREIGN KEY([id_room])
REFERENCES [dbo].[room] ([id_room])
GO
ALTER TABLE [dbo].[test_default_room] CHECK CONSTRAINT [FK_test_default_room_room]
GO
ALTER TABLE [dbo].[test_default_room]  WITH CHECK ADD  CONSTRAINT [FK_test_default_room_test] FOREIGN KEY([id_test])
REFERENCES [dbo].[test] ([id_test])
GO
ALTER TABLE [dbo].[test_default_room] CHECK CONSTRAINT [FK_test_default_room_test]
GO
ALTER TABLE [dbo].[topic]  WITH CHECK ADD  CONSTRAINT [FK_topic_account] FOREIGN KEY([id_acc])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[topic] CHECK CONSTRAINT [FK_topic_account]
GO
/****** Object:  StoredProcedure [dbo].[box_msg]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[box_msg] 
@code nvarchar(max) ,
@room_id   nvarchar(max) ,
@top int  =null 
AS
SET NOCOUNT ON;
IF @top is null 
 set @top = 5 
 IF EXISTS (SELECT *  FROM chat c WHERE c.LAST_USER LIKE  @code )
 BEGIN
   UPDATE chat set  COUNT_MSG = 0 WHERE ((code = @code  AND room_id = @room_id AND LAST_USER = @code )OR (code = @room_id AND room_id = @code AND LAST_USER = @code)) and code not like 'POST_%'
 END
SELECT  top (@top)  d.body , d.time_on  , d.url  , d.client_id FROM chat c  JOIN chatdetails d ON c.chat_id = d.chat_id  
    where( c.code = @code and c.room_id = @room_id OR c.code = @room_id AND c.room_id = @code) and c.code not like 'POST_%'  ORDER BY d.time_on DESC





GO
/****** Object:  StoredProcedure [dbo].[box_notify]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[box_notify] 
@code nvarchar(max) ,
@room_id   nvarchar(max) ,
@top int  =null 
AS
SET NOCOUNT ON;
IF @top is null 
 set @top = 5 
 IF EXISTS (SELECT *  FROM chat c WHERE c.LAST_USER=@room_id )
 BEGIN
   UPDATE chat set  COUNT_MSG = 0 WHERE (code like @code+'%'  AND room_id = @room_id  )and code like 'POST_%'
 END
SELECT  top (@top)  d.body , d.time_on  , d.url  , d.client_id , c.code FROM chat c  JOIN chatdetails d ON c.chat_id = d.chat_id  
    where ( c.room_id = @room_id and c.code like @code+'%') and c.code  like 'POST_%' ORDER BY d.time_on DESC



GO
/****** Object:  StoredProcedure [dbo].[kiemtratinnhan]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




	CREATE proc  [dbo].[kiemtratinnhan] 
	@code  nvarchar(max) 
	AS 
	SELECT  * from  chat c where c.COUNT_MSG > 0 AND c.LAST_USER  like @code   and c.code not like 'POST_%'  	






GO
/****** Object:  StoredProcedure [dbo].[kiemtrathongbao]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc  [dbo].[kiemtrathongbao] 
	@code  nvarchar(max) 
	AS 
	SELECT  * from  chat c where c.COUNT_MSG > 0 AND c.LAST_USER  like @code   and c.code  like 'POST_%'  	

GO
/****** Object:  StoredProcedure [dbo].[p_addAnswerIntoTestRoom]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE  procedure [dbo].[p_addAnswerIntoTestRoom] @id_room int ,@id_question int, @id_acc int, @id_answer int
 as
 begin
	declare @enable int
	set @enable = 1
	declare @id_test int
	set @id_test=(select isnull(id_test,-1)  from room where id_room=@id_room)
	if @id_test is not null or @id_test>-1
		begin
			if exists (select * from dbo.task where id_Acc=@id_acc and @id_question=id_question and id_test=@id_test) and @enable= 1
			
			update dbo.task
			set id_answer=@id_answer
			where id_Acc=@id_acc and @id_question=id_question and id_test=@id_test
			
			else
			INSERT INTO TASK  VALUES (@id_test,@id_acc,@id_question,@id_answer,N'')
			
		end 
	
 end

GO
/****** Object:  StoredProcedure [dbo].[p_addCommentIntoPost_comment]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[p_addCommentIntoPost_comment] @comment_content nvarchar(100),
 @id_post  int, @id_acc int
 AS
 BEGIN
 if exists(select id_acc from room_manage where id_room =(select id_room from post_manage where id_post=@id_post)  and id_acc=@id_acc)
 or exists(select id_acc from room where id_room =(select id_room from post_manage where id_post=@id_post)  and id_acc=@id_acc)
	begin
		DECLARE @comment_time  datetime 
	 set @comment_time = getdate();
		INSERT INTO COMMENT VALUES(@id_post,@id_acc,@comment_content,@comment_time,1);
	end
	else raiserror(N'Tài khoản không thuộc nhóm của bài đăng không thể đăng bình luận!',16,1);
 END


GO
/****** Object:  StoredProcedure [dbo].[p_addPostAfterIntoRoom_postAndRoom]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[p_addPostAfterIntoRoom_postAndRoom] @post_content	nvarchar(100),
@id_post_type	int,
@id_acc	int,
@id_room int
 AS
 BEGIN
	set nocount on;
		IF EXISTS(select *  from room_manage  where id_acc=@id_acc and id_room=@id_room and room_manage.state=1) or exists (select *  from room where id_acc=@id_acc)
			BEGIN
			declare @post_date  datetime;
			set @post_date = GETDATE();
				INSERT INTO POST		VALUES(@post_content,@post_date, 0, @id_post_type, @id_acc);
				declare @id_post_tmp int
				set @id_post_tmp = (SELECT id_post AS LastID FROM post WHERE id_post = @@Identity)
				INSERT INTO post_manage VALUES(@id_post_tmp, @id_room);
				select @id_post_tmp  ;
			END
		ELSE
			RAISERROR(N'Không phải thành viên trong nhóm không thể đăng bài!',16,1);
 END


GO
/****** Object:  StoredProcedure [dbo].[p_addQuizPostIntoGroup]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE procedure [dbo].[p_addQuizPostIntoGroup] @id_room int,@id_acc int,@question_content text, @answer_content1 text,@answer_content2 text,@answer_content3 text,@answer_content4 text,@correct_question int
 as
 begin
 Set NOCOUNT on
 --Insert question to get id_connect by id_question
 Declare @id_connect int
 Declare @id_post int
 Insert into dbo.question values (@question_content,null,null)
 set @id_connect = (select id_question from dbo.question where id_question = @@identity )
 -- Insert post, which is quiz post, with id_Connect 
 Insert into dbo.post values (@question_content,getdate(),@id_connect,1,@id_Acc)
 Set @id_post = ( select id_post from dbo.post where id_post =@@identity)
 Insert into dbo.post_manage values(@id_post ,@id_room)
 -- Insert quiz answer with id_connect, which is id_question
 insert into dbo.correct_answer values(@id_connect,1,@answer_content1,0)
 insert into dbo.correct_answer values(@id_connect,2,@answer_content2,0)
 insert into dbo.correct_answer values(@id_connect,3,@answer_content3,0)
 insert into dbo.correct_answer values(@id_connect,4,@answer_content4,0)
 -- Set question correct for question post
 Update dbo.correct_answer
 Set correct_answer=1
 Where id_question=@id_connect and id_answer=@correct_question

  select id_post as LastID from Post where id_post=@@IDENTITY
 end

GO
/****** Object:  StoredProcedure [dbo].[p_addRoom_room]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[p_addRoom_room] @room_name NVARCHAR(50), @room_descr NVARCHAR(100)=N'', @id_acc int
 AS
 SET NOCOUNT ON
 BEGIN
		INSERT INTO room (room_name,room_descr,id_acc) VALUES(@room_name,@room_descr,@id_acc)
		SELECT id_room AS LastID FROM room WHERE id_room = IDENT_CURRENT('room');
 END


GO
/****** Object:  StoredProcedure [dbo].[p_checkLogIn_account]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_checkLogIn_account](@email varchar(50),@password varchar(50))
AS
BEGIN
DECLARE @mes nvarchar(100)
IF EXISTS (SELECT * FROM account WHERE account.email=@email)
	BEGIN 
		IF EXISTS(SELECT * FROM account WHERE account.email=@email AND account.state=1)
			BEGIN
				IF EXISTS(SELECT * FROM account WHERE account.email=@email AND account.password=@password)
					BEGIN
						SET @mes=(SELECT account.id_acc FROM account WHERE account.email=@email AND account.password=@password)
					END
				ELSE
				SET @mes=N'Mật khẩu không đúng';
			END
			ELSE
			SET @mes=N'Tài khoản chưa kích hoạt';
	END
	ELSE
		SET @mes=N'Tài khoản không tồn tại'
		SELECT @mes
END






GO
/****** Object:  StoredProcedure [dbo].[p_delete_room]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_delete_room] @id_room int
AS
BEGIN
DECLARE @message NVARCHAR(100)
SET NOCOUNT ON

BEGIN
TRY
DELETE room_manage where id_room =@id_room
DELETE post_manage WHERE id_room=@id_room
DELETE room where id_room = @id_room
  
IF(@@ROWCOUNT>0)
BEGIN
SET @message = N'Thành công'
END

	ELSE
	
	BEGIN 
	SET @message = N'Thất bại'
	END 

SELECT @message AS result
END TRY

BEGIN CATCH
RAISERROR(N'Xóa phòng thất bại',16,1)
END CATCH	

END


GO
/****** Object:  StoredProcedure [dbo].[p_deleteComment_Comment]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- xóa comment trong bài viết qua quyền của account id
create procedure [dbo].[p_deleteComment_Comment] @id_comment int, @id_acc int
as
begin
	if exists( select * from comment  where id_acc=@id_acc and id_comment=@id_comment)
	or exists(select *  from room where id_acc=@id_acc and id_room=(select id_room  from post_manage where id_post=(select  id_post  from comment where id_comment=@id_comment)))
	begin
		delete from comment where id_comment=@id_comment
	end
	else
		raiserror(N'Bạn không phải người bình luận hoặc quản trị viên!',16,1);

end

execute p_deleteComment_Comment @id_comment=207,@id_acc=5




GO
/****** Object:  StoredProcedure [dbo].[p_deletePost_post]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create procedure [dbo].[p_deletePost_post] @id_post int, @id_acc int
 as
  begin
  if exists(select *  from room where id_acc=@id_acc and id_room =(select id_room from post_manage where id_post=@id_post)) or
  exists(select * from post where id_acc=@id_acc  and id_post=@id_post)
  begin
	delete from comment where id_post=@id_post;
	delete from post_manage where id_post=@id_post  and id_room=(select id_room  from post_manage where id_post=@id_post);
	delete from post where id_post=@id_post;
	delete from liked select id_post,id_acc from liked where id_post=@id_post;
  end
	else 
	raiserror (N'Bạn không có quyền xóa bài đăng này!',16,1);  
end

GO
/****** Object:  StoredProcedure [dbo].[p_likeOrUnlikePost]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create procedure [dbo].[p_likeOrUnlikePost] (@id_post int, @id_acc int)
 as
 begin
	if exists ( select *from room_manage where id_acc=@id_acc and id_room=(select id_room from post_manage where							id_post=@id_post) and state=1)/* kiểm tra thành viên nhóm*/
		begin
			if exists (  select * from liked  where id_acc=@id_acc and id_post=@id_post)
				begin
					delete from liked where id_acc=@id_acc and id_post=@id_post
				end
			else
				begin
					insert into liked values(@id_post,@id_acc);
				end
		end
	else
		raiserror(N'Bạn không phải thành viên nhóm!',16,1);
	
 end

GO
/****** Object:  StoredProcedure [dbo].[p_participationRoom_room_manage]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[p_participationRoom_room_manage] @id_room int, @id_acc int
 AS
 BEGIN
		INSERT INTO room_manage		VALUES(@id_room,@id_acc,0)
 END


GO
/****** Object:  StoredProcedure [dbo].[p_signUp_account]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_signUp_account] (@email varchar(50),@password varchar(50))
AS
BEGIN
SET NOCOUNT ON
DECLARE @idAccount int
INSERT INTO account(account.email,account.password) values (@email, @password)
SET @idAccount=(SELECT account.id_acc FROM account WHERE account.email=@email)
SELECT @idAccount
END






GO
/****** Object:  StoredProcedure [dbo].[themnoidung]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[themnoidung]
 @code nvarchar(max) ,
 @room_id  nvarchar(max) ,
 @body ntext , 
 @url  nvarchar(255) 
 AS
 DECLARE @chat_id int  , @client nvarchar(255) , @date datetime = getdate() 
 IF NOT EXISTS (SELECT * FROM  chat c where c.code = @code  AND c.room_id = @room_id OR c.code = @room_id AND c.room_id = @code )
   BEGIN 
   begin tran 
     INSERT INTO chat(code , room_id , COUNT_MSG , LAST_USER) values (@code , @room_id , 1 ,@room_id ) 
	   set @chat_id  =  SCOPE_IDENTITY()  
	    commit tran
		end
    ELSE  
	BEGIN 
	DECLARE @count  int = (select c.COUNT_MSG from chat c where  c.code = @code  AND c.room_id = @room_id OR c.code = @room_id AND c.room_id = @code)
	UPDATE chat set COUNT_MSG = @count + 1  ,  LAST_USER = @room_id where  code = @code  AND room_id = @room_id OR code = @room_id AND room_id = @code
	set @chat_id  = ( SELECT c.chat_id FROM  chat c where c.code = @code  AND c.room_id = @room_id OR c.code = @room_id AND c.room_id = @code) 
	END 
	BEGIN 
	INSERT chatdetails values (@body , @date , @chat_id  ,  @url , @room_id)   
	end






GO
/****** Object:  Trigger [dbo].[t_insertAdminIntoRoomManage]    Script Date: 19/06/2017 6:26:14 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE TRIGGER  [dbo].[t_insertAdminIntoRoomManage] ON [dbo].[room] AFTER INSERT
 AS
 BEGIN
  declare @id_room  int, @id_acc int,@id_test int
set @id_room = (select id_room  from inserted)
set @id_acc = (select id_acc  from inserted)
 /*insert admin into lisst member*/
	 INSERT INTO room_manage(id_room, id_acc, state)   values (@id_room,@id_acc,1)
	 /*insert test default for room*/
	 INSERT INTO TEST(title,date_start,date_end) VALUES(concat(concat(@id_room,'-POST-'),@id_acc), null, null);
		set @id_test=( SELECT id_test AS LastID FROM TEST WHERE id_test = @@Identity);
	update room set id_test=@id_test where id_room = @id_room;
 END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'mã phòng học' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'room', @level2type=N'COLUMN',@level2name=N'id_room'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tên phòng học' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'room', @level2type=N'COLUMN',@level2name=N'room_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'mô tả' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'room', @level2type=N'COLUMN',@level2name=N'room_descr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quản lý phòng học' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'room_manage'
GO
USE [master]
GO
ALTER DATABASE [Quiz] SET  READ_WRITE 
GO

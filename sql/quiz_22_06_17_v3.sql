USE [master]
GO
/****** Object:  Database [Quiz]    Script Date: 22/06/2017 5:43:23 CH ******/
CREATE DATABASE [Quiz]
 CONTAINMENT = NONE

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
/****** Object:  UserDefinedFunction [dbo].[getCorrectAnswer]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[account]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[cl_list2]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[comment]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[correct_answer]    Script Date: 22/06/2017 5:43:23 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[correct_answer](
	[id_question] [int] NOT NULL,
	[id_answer] [int] NOT NULL,
	[answer_content] [ntext] NULL,
	[correct_answer] [bit] NULL,
 CONSTRAINT [PK_correct_answer_1] PRIMARY KEY CLUSTERED 
(
	[id_question] ASC,
	[id_answer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[chat]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[chatdetails]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[liked]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[post]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[post_manage]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[question]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[relationship]    Script Date: 22/06/2017 5:43:23 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[relationship](
	[id_acc_add] [int] NOT NULL,
	[id_acc_friend] [int] NOT NULL,
	[waiting] [bit] NULL,
 CONSTRAINT [PK_relationship] PRIMARY KEY CLUSTERED 
(
	[id_acc_add] ASC,
	[id_acc_friend] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[room]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[room_manage]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[task]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[test]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[test_content]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[test_default_room]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  Table [dbo].[topic]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[f_getMemberInRoom]    Script Date: 22/06/2017 5:43:23 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

   create function [dbo].[f_getMemberInRoom](@id_room int)  returns table
   as
   return(
		select  account.id_acc, isnull(name,email) as name from room_manage  left join account on account.id_acc=room_manage.id_acc   where room_manage.id_room=@id_room and room_manage.state=1)





GO
/****** Object:  UserDefinedFunction [dbo].[getPostByGroup]    Script Date: 22/06/2017 5:43:23 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[getPostQuizByGroup]    Script Date: 22/06/2017 5:43:23 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getPostQuizByGroup] (@post_id int)
RETURNS TABLE
AS
  RETURN (SELECT
    p.id_post,
    p.post_content,
    p.post_date,
    p.id_acc,
    CASE
      WHEN p.id_connect = 0 THEN 'POST'
      ELSE 'QUIZ'
    END AS type_post,
    CASE
      WHEN p.id_connect = 0 THEN ''
      ELSE ISNULL(dbo.getCorrectAnswer(id_connect, 1), '')
    END AS da1,
    CASE
      WHEN p.id_connect = 0 THEN ''
      ELSE ISNULL(dbo.getCorrectAnswer(id_connect, 2), '')
    END AS da2,
    CASE
      WHEN p.id_connect = 0 THEN ''
      ELSE ISNULL(dbo.getCorrectAnswer(id_connect, 3), '')
    END AS da3,
    CASE
      WHEN p.id_connect = 0 THEN ''
      ELSE ISNULL(dbo.getCorrectAnswer(id_connect, 4), '')
    END AS da4
  FROM dbo.post p
  LEFT JOIN dbo.question q
    ON p.id_connect = q.id_question
  WHERE p.id_connect > 0
  AND p.id_post = @post_id
  )


GO
SET IDENTITY_INSERT [dbo].[account] ON 

INSERT [dbo].[account] ([id_acc], [name], [birth], [job], [gender], [email], [password], [state], [address], [avatar]) VALUES (1, N'Trần Văn Thắng', CAST(N'2017-06-17' AS Date), N'Sinh Viên', 1, N'vanthang20437@gmail.com', N'12345', 1, N'Dh Nông lâm', N'https://docs.google.com/uc?id=0B8pIcz51dX7JaHpFVzlaUlg1X2c')
INSERT [dbo].[account] ([id_acc], [name], [birth], [job], [gender], [email], [password], [state], [address], [avatar]) VALUES (2, N'tam lagn', CAST(N'2017-06-17' AS Date), N'Sinh Viên', 0, N'vanthang1996@yahoo.com', N'12345', 1, N'DH Nông lâm', N'https://docs.google.com/uc?id=0B8pIcz51dX7JRHBHaUZBMEZGZWs')
INSERT [dbo].[account] ([id_acc], [name], [birth], [job], [gender], [email], [password], [state], [address], [avatar]) VALUES (3, N'Trần Văn Thắng', CAST(N'2017-01-01' AS Date), N'Sinh Vien', 1, N'14130118@st.hcmuaf.edu.vn', N'12345', 1, N'Dh Nông lâm', N'https://docs.google.com/uc?id=0B8pIcz51dX7JVGJHZ2lzSkktVGs')
INSERT [dbo].[account] ([id_acc], [name], [birth], [job], [gender], [email], [password], [state], [address], [avatar]) VALUES (7, N'Truong tam lang', CAST(N'2017-06-02' AS Date), N'sinh vien', 1, N'lang.tt16@gmail.com', N'12345', 1, N'', N'https://docs.google.com/uc?id=0B8pIcz51dX7JakhzQWpTcjAzUms')
SET IDENTITY_INSERT [dbo].[account] OFF
SET IDENTITY_INSERT [dbo].[cl_list2] ON 

INSERT [dbo].[cl_list2] ([pmcode], [cdgr], [val_name], [param_name]) VALUES (N'USER', N'POST', N'Trạng thái', 1)
INSERT [dbo].[cl_list2] ([pmcode], [cdgr], [val_name], [param_name]) VALUES (N'USER', N'POST', N'Trắc nghiệm', 3)
INSERT [dbo].[cl_list2] ([pmcode], [cdgr], [val_name], [param_name]) VALUES (N'USER', N'POST', N'Up file', 4)
INSERT [dbo].[cl_list2] ([pmcode], [cdgr], [val_name], [param_name]) VALUES (N'USER', N'POST', N'Trạng thái', 5)
SET IDENTITY_INSERT [dbo].[cl_list2] OFF
SET IDENTITY_INSERT [dbo].[comment] ON 

INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:36.870' AS DateTime), 1, 1007)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.137' AS DateTime), 1, 1008)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.320' AS DateTime), 1, 1009)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.657' AS DateTime), 1, 1011)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:37.833' AS DateTime), 1, 1012)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:38.007' AS DateTime), 1, 1013)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:38.187' AS DateTime), 1, 1014)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:38.357' AS DateTime), 1, 1015)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:39.130' AS DateTime), 1, 1016)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:39.300' AS DateTime), 1, 1017)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (16, 3, N'ádasd', CAST(N'2017-05-06 10:03:39.483' AS DateTime), 1, 1018)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3072, 1, N'jhjh', CAST(N'2017-06-17 15:47:09.217' AS DateTime), 1, 2091)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3187, 1, N'cc', CAST(N'2017-06-20 23:50:16.223' AS DateTime), 1, 2096)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3188, 2, N'cl', CAST(N'2017-06-20 23:50:23.633' AS DateTime), 1, 2097)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3184, 1, N'adasdasd', CAST(N'2017-06-20 23:54:07.943' AS DateTime), 1, 2098)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3184, 1, N'ásdfsdf', CAST(N'2017-06-20 23:54:13.487' AS DateTime), 1, 2099)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3188, 1, N'asdasd', CAST(N'2017-06-20 23:56:19.457' AS DateTime), 1, 2100)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3189, 1, N'asdasdas', CAST(N'2017-06-20 23:57:50.963' AS DateTime), 1, 2101)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3189, 1, N'asdasdas', CAST(N'2017-06-20 23:57:51.790' AS DateTime), 1, 2102)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3190, 1, N'sdasdasd', CAST(N'2017-06-21 00:00:08.337' AS DateTime), 1, 2103)
INSERT [dbo].[comment] ([id_post], [id_acc], [comment_content], [comment_time], [comment_state], [id_comment]) VALUES (3190, 1, N'sdasdasd', CAST(N'2017-06-21 00:00:09.500' AS DateTime), 1, 2104)
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
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1009, 1, N'Ðáp án 1', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1009, 2, N'Ðáp án 2', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1009, 3, N'Ðáp án 3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (1009, 4, N'Ðáp án 4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2009, 1, N'dap an 1 ', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2009, 2, N'dap an 2', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2009, 3, N'dap an 3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2009, 4, N' dap an4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2010, 1, N'dgdf', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2010, 2, N'dgfdf', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2010, 3, N'dfgdfg', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2010, 4, N'dfg', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2011, 1, N'adas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2011, 2, N'asasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2011, 3, N'sdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2011, 4, N'dáp án dúng', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2012, 1, N'jadhgjasdhg', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2012, 2, N'sjfgjsdhgf', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2012, 3, N'jshgfjsdhgf', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2012, 4, N'jsfgjsdgf', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2013, 1, N'asdasdasdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2013, 2, N'asdasdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2013, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2013, 4, N'asdasdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2014, 1, N'asdasdasdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2014, 2, N'asdasdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2014, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2014, 4, N'asdasdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2015, 1, N'1', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2015, 2, N'2', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2015, 3, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2015, 4, N'4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2016, 1, N'1', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2016, 2, N'2', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2016, 3, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2016, 4, N'4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2017, 1, N'ádasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2017, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2017, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2017, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2018, 1, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2018, 2, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2018, 3, N'asdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2018, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2019, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2019, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2019, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2019, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2020, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2020, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2020, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2020, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2021, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2021, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2021, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2021, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2022, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2022, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2022, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2022, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2023, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2023, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2023, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2023, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2024, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2024, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2024, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2024, 4, N'asdasd', 0)
GO
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2025, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2025, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2025, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2025, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2026, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2026, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2026, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2026, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2027, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2027, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2027, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2027, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2028, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2028, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2028, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2028, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2029, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2029, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2029, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2029, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2030, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2030, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2030, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2030, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2031, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2031, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2031, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2031, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2032, 1, N'qweqwe', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2032, 2, N'qweqweqw', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2032, 3, N'qweqw', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2032, 4, N'qweqwe', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2033, 1, N'qweqwe', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2033, 2, N'qweqweqw', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2033, 3, N'qweqw', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2033, 4, N'qweqwe', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2034, 1, N'qweqwe', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2034, 2, N'qweqweqw', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2034, 3, N'qweqw', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2034, 4, N'qweqwe', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2035, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2035, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2035, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2035, 4, N'asdasdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2036, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2036, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2036, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2036, 4, N'asdasdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2037, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2037, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2037, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2037, 4, N'asdasdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2038, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2038, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2038, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2038, 4, N'asdasdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2039, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2039, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2039, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2039, 4, N'asdasdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2040, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2040, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2040, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2040, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2041, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2041, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2041, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2041, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2042, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2042, 2, N'asdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2042, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2042, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2043, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2043, 2, N'asdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2043, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2043, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2044, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2044, 2, N'asdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2044, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2044, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2045, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2045, 2, N'asdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2045, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2045, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2046, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2046, 2, N'asdas', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2046, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2046, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2047, 1, N'fghfgh', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2047, 2, N'fghfg', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2047, 3, N'hfgh', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2047, 4, N'fghfgh', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2048, 1, N'dfgdfg', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2048, 2, N'dfgdfg', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2048, 3, N'dfgdfg', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2048, 4, N'dfgdfg', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2049, 1, N'234234', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2049, 2, N'234234', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2049, 3, N'234234', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2049, 4, N'234234', 0)
GO
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2050, 1, N'234234', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2050, 2, N'234234', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2050, 3, N'234234', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2050, 4, N'234234', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2051, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2051, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2051, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2051, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2052, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2052, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2052, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2052, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2054, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2054, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2054, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2054, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2055, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2055, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2055, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2055, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2057, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2057, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2057, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2057, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2058, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2058, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2058, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2058, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2060, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2060, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2060, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2060, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2061, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2061, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2061, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2061, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2062, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2062, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2062, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2062, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2063, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2063, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2063, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2063, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2064, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2064, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2064, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2064, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2065, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2065, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2065, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2065, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2066, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2066, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2066, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2066, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2067, 1, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2067, 2, N'adasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2067, 3, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2067, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2068, 1, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2068, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2068, 3, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2068, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2069, 1, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2069, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2069, 3, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2069, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2070, 1, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2070, 2, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2070, 3, N'asdasd', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2070, 4, N'asdasd', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2071, 1, N'1', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2071, 2, N'2', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2071, 3, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2071, 4, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2072, 1, N'1', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2072, 2, N'2', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2072, 3, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2072, 4, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2073, 1, N'2', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2073, 2, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2073, 3, N'4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2073, 4, N'5', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2074, 1, N'2', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2074, 2, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2074, 3, N'4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2074, 4, N'5', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2075, 1, N'1', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2075, 2, N'2', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2075, 3, N'3', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2075, 4, N'4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2076, 1, N'thứ 2', 1)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2076, 2, N'thứ 3 ', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2076, 3, N'thứ 4', 0)
INSERT [dbo].[correct_answer] ([id_question], [id_answer], [answer_content], [correct_answer]) VALUES (2076, 4, N'thứ 5', 0)
SET IDENTITY_INSERT [dbo].[chat] ON 

INSERT [dbo].[chat] ([chat_id], [code], [room_id], [COUNT_MSG], [LAST_USER]) VALUES (21, N'POST_1', N'2', 3, N'2')
INSERT [dbo].[chat] ([chat_id], [code], [room_id], [COUNT_MSG], [LAST_USER]) VALUES (22, N'POST_1', N'3', 3, N'3')
SET IDENTITY_INSERT [dbo].[chat] OFF
SET IDENTITY_INSERT [dbo].[chatdetails] ON 

INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (209, N'Trần Văn Thắng vừa đăng một bài viết mới trong nhóm Công Nghệ Phần Mềm', CAST(N'2017-06-22 04:44:30.073' AS DateTime), 21, N'/classRoom/1012#divcontent3243', N'2')
INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (210, N'Trần Văn Thắng vừa đăng một bài viết mới trong nhóm Công Nghệ Phần Mềm', CAST(N'2017-06-22 04:44:30.093' AS DateTime), 22, N'/classRoom/1012#divcontent3243', N'3')
INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (211, N'Trần Văn Thắng vừa đăng một bài viết mới trong nhóm Công Nghệ Phần Mềm', CAST(N'2017-06-22 04:49:57.893' AS DateTime), 21, N'/classRoom/1012#divcontent3246', N'2')
INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (212, N'Trần Văn Thắng vừa đăng một bài viết mới trong nhóm Công Nghệ Phần Mềm', CAST(N'2017-06-22 04:49:57.907' AS DateTime), 22, N'/classRoom/1012#divcontent3246', N'3')
INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (213, N'Trần Văn Thắng vừa đăng một bài viết mới trong nhóm Công Nghệ Phần Mềm', CAST(N'2017-06-22 04:49:57.910' AS DateTime), 21, N'/classRoom/1012#divcontent3245', N'2')
INSERT [dbo].[chatdetails] ([details_chat_id], [body], [time_on], [chat_id], [url], [client_id]) VALUES (214, N'Trần Văn Thắng vừa đăng một bài viết mới trong nhóm Công Nghệ Phần Mềm', CAST(N'2017-06-22 04:49:57.913' AS DateTime), 22, N'/classRoom/1012#divcontent3245', N'3')
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
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (64, N'nodng', CAST(N'2017-05-13 12:57:26.237' AS DateTime), 2, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1064, N'nodng', CAST(N'2017-05-13 13:15:05.010' AS DateTime), 1002, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1065, N'asdasdasd', CAST(N'2017-05-13 13:34:00.413' AS DateTime), 1003, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1066, N'asdasdasd', CAST(N'2017-05-13 13:39:34.597' AS DateTime), 1004, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1067, N'tesst 5', CAST(N'2017-05-13 13:40:24.340' AS DateTime), 1005, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1068, N'asdasd1111', CAST(N'2017-05-13 13:43:00.407' AS DateTime), 1006, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1069, N'Cau hoi 1', CAST(N'2017-05-13 13:45:23.037' AS DateTime), 1007, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (1070, N'nodng', CAST(N'2017-05-13 14:21:35.510' AS DateTime), 1008, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (2072, N'12345', CAST(N'2017-05-22 00:30:26.117' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3072, N'ádasdas', CAST(N'2017-06-17 15:47:00.450' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3073, N'nvanvdjasda', CAST(N'2017-06-17 15:50:00.820' AS DateTime), 2009, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3074, N'sdsdf', CAST(N'2017-06-17 15:50:52.783' AS DateTime), 2010, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3075, N'adsasdasdasd', CAST(N'2017-06-17 15:51:43.577' AS DateTime), 2011, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3076, N'sfsfsdf', CAST(N'2017-06-17 16:52:05.260' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3085, N'ádasdasdasd', CAST(N'2017-06-18 16:22:41.370' AS DateTime), 0, 1, 3)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3086, N'Hôm nay vui!', CAST(N'2017-06-18 16:23:38.320' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3087, N'fdfsdf', CAST(N'2017-06-18 16:24:22.147' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3088, N'adasdasdasd', CAST(N'2017-06-18 16:24:45.980' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3089, N'adsasdasd', CAST(N'2017-06-18 16:25:05.600' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3090, N'ádasdasd', CAST(N'2017-06-18 16:27:26.320' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3091, N'adsasdasd', CAST(N'2017-06-18 16:32:20.473' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3092, N'asdasdasd', CAST(N'2017-06-18 16:32:48.970' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3093, N'asdasdasd', CAST(N'2017-06-18 16:33:12.223' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3114, N'adasdasd', CAST(N'2017-06-19 12:16:32.640' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3115, N'a', CAST(N'2017-06-19 12:16:34.160' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3116, N'asdasda', CAST(N'2017-06-19 12:16:35.443' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3117, N'asdasdasd', CAST(N'2017-06-19 12:16:37.810' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3118, N'asdasdasd', CAST(N'2017-06-19 12:16:40.130' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3119, N'asdasdasd', CAST(N'2017-06-19 12:16:42.030' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3120, N'sdasdasd', CAST(N'2017-06-19 12:16:44.207' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3121, N'Tran Văn Thắng', CAST(N'2017-06-19 12:16:53.733' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3122, N'ádasd', CAST(N'2017-06-19 12:18:56.760' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3123, N'ádasdas', CAST(N'2017-06-19 12:20:40.973' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3124, N'ádasdasd', CAST(N'2017-06-19 12:20:52.220' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3125, N'asdasdasd', CAST(N'2017-06-19 12:21:05.260' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3126, N'akhsdkashd', CAST(N'2017-06-19 12:21:20.530' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3127, N'ádasdasdasd', CAST(N'2017-06-19 12:26:29.097' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3128, N'ấdasdasd', CAST(N'2017-06-19 12:27:07.617' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3129, N'ádasdasd', CAST(N'2017-06-19 12:27:53.407' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3130, N'adasdasd', CAST(N'2017-06-19 12:28:09.470' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3131, N'adsasdasd', CAST(N'2017-06-19 12:28:49.790' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3132, N'sdasdasd', CAST(N'2017-06-19 12:30:05.720' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3133, N'asdasdasd', CAST(N'2017-06-19 12:31:20.080' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3134, N'adasdasd', CAST(N'2017-06-19 12:32:13.707' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3135, N'asdasdasd', CAST(N'2017-06-19 12:33:23.833' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3136, N'asdasd', CAST(N'2017-06-19 12:33:39.850' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3137, N'asdasdas', CAST(N'2017-06-19 12:34:43.937' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3138, N'asdasdasd', CAST(N'2017-06-19 12:34:51.543' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3139, N'adasd', CAST(N'2017-06-19 12:36:29.490' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3140, N'asdasdasd', CAST(N'2017-06-19 12:36:58.640' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3141, N'asdasdas', CAST(N'2017-06-19 12:38:01.143' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3171, N'asdasdas', CAST(N'2017-06-20 14:19:27.877' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3183, N'<p>Bóstrap<p><a class=''btn btn-info'' href=https://drive.google.com/file/d/0B8pIcz51dX7JanI2TXBvekE1NEU/view?usp=drivesdk target=''_blank''>Xem Trước </a><span>&nbsp;</span><a target=''_blank'' class=''btn btn-success'' href=https://drive.google.com/uc?id=0B8pIcz51dX7JanI2TXBvekE1NEU&export=download>Tải Xuống</a>', CAST(N'2017-06-20 23:04:22.540' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3184, N'<p>1 mớ hình nè</p><div class=''row''><div class=''col-md-4''><a target=''_blank'' href=''https://docs.google.com/uc?id=0B8pIcz51dX7JRzhJUjBwaXV0bTg''><img src=''https://docs.google.com/uc?id=0B8pIcz51dX7JRzhJUjBwaXV0bTg''width=''200'' height=''200'' style=''margin-bottom: 10px;''></a></div><div class=''col-md-4''><a target=''_blank'' href=''https://docs.google.com/uc?id=0B8pIcz51dX7Jd0NXanUwLXM0QkE''><img src=''https://docs.google.com/uc?id=0B8pIcz51dX7Jd0NXanUwLXM0QkE''width=''200'' height=''200'' style=''margin-bottom: 10px;''></a></div><div class=''col-md-4''><a target=''_blank'' href=''https://docs.google.com/uc?id=0B8pIcz51dX7JV18tMzZxc0drd28''><img src=''https://docs.google.com/uc?id=0B8pIcz51dX7JV18tMzZxc0drd28''width=''200'' height=''200'' style=''margin-bottom: 10px;''></a></div><div class=''col-md-4''><a target=''_blank'' href=''https://docs.google.com/uc?id=0B8pIcz51dX7JVDhRUXNCT2RmVTg''><img src=''https://docs.google.com/uc?id=0B8pIcz51dX7JVDhRUXNCT2RmVTg''width=''200'' height=''200'' style=''margin-bottom: 10px;''></a></div><div class=''col-md-4''><a target=''_blank'' href=''https://docs.google.com/uc?id=0B8pIcz51dX7JS3FvOFN4MzFWM1U''><img src=''https://docs.google.com/uc?id=0B8pIcz51dX7JS3FvOFN4MzFWM1U''width=''200'' height=''200'' style=''margin-bottom: 10px;''></a></div></div>', CAST(N'2017-06-20 23:05:27.487' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3185, N'AasASas', CAST(N'2017-06-20 23:12:26.793' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3187, N'<p>aa<p><a class=''btn btn-info'' href=https://drive.google.com/file/d/0B8pIcz51dX7JYmtpSElpN2ZsaTA/view?usp=drivesdk target=''_blank''>Xem Trước </a><span>&nbsp;</span><a target=''_blank'' class=''btn btn-success'' href=https://drive.google.com/uc?id=0B8pIcz51dX7JYmtpSElpN2ZsaTA&export=download>Tải Xuống</a>', CAST(N'2017-06-20 23:33:43.440' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3188, N'<p>Hình con chó<p><a class=''btn btn-info'' href=https://drive.google.com/file/d/0B8pIcz51dX7JRFgwejhuMXc4ek0/view?usp=drivesdk target=''_blank''>Xem Trước </a><span>&nbsp;</span><a target=''_blank'' class=''btn btn-success'' href=https://drive.google.com/uc?id=0B8pIcz51dX7JRFgwejhuMXc4ek0&export=download>Tải Xuống</a>', CAST(N'2017-06-20 23:47:27.540' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3189, N'asdasdasd', CAST(N'2017-06-20 23:57:38.043' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3190, N'ADSadasdasd', CAST(N'2017-06-20 23:59:59.690' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3191, N'adasdasd', CAST(N'2017-06-21 00:02:53.283' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3192, N'adasdasd', CAST(N'2017-06-21 00:02:57.863' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3193, N'646', CAST(N'2017-06-21 00:05:44.520' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3194, N'646', CAST(N'2017-06-21 00:05:47.740' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3195, N'646', CAST(N'2017-06-21 00:05:54.883' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3198, N'<p>chào các bạn</p><div class=''row''><div class=''col-md-4''><a target=''_blank'' href=''https://docs.google.com/uc?id=0B8pIcz51dX7JSmE4LUJJRl9OOVk''><img src=''https://docs.google.com/uc?id=0B8pIcz51dX7JSmE4LUJJRl9OOVk''width=''200'' height=''200'' style=''margin-bottom: 10px;''></a></div></div>', CAST(N'2017-06-21 01:44:15.467' AS DateTime), 0, 1, 2)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3201, N'sdasdasd', CAST(N'2017-06-22 03:38:58.647' AS DateTime), 2013, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3202, N'sdasdasd', CAST(N'2017-06-22 03:39:02.983' AS DateTime), 2014, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3203, N'ádasdasd', CAST(N'2017-06-22 03:39:27.737' AS DateTime), 2015, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3204, N'ádasdasd', CAST(N'2017-06-22 03:39:45.277' AS DateTime), 2016, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3205, N'asdasd', CAST(N'2017-06-22 03:46:23.790' AS DateTime), 2017, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3220, N'queqweq', CAST(N'2017-06-22 03:53:20.440' AS DateTime), 2032, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3221, N'queqweq', CAST(N'2017-06-22 03:53:21.103' AS DateTime), 2033, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3222, N'queqweq', CAST(N'2017-06-22 03:53:22.067' AS DateTime), 2034, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3223, N'ádasdasd', CAST(N'2017-06-22 03:53:38.440' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3224, N'ádasdasd', CAST(N'2017-06-22 03:53:38.460' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3225, N'asdasdasd', CAST(N'2017-06-22 03:53:47.420' AS DateTime), 2035, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3226, N'asdasdasd', CAST(N'2017-06-22 03:53:47.433' AS DateTime), 2036, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3228, N'asdasd', CAST(N'2017-06-22 03:55:07.477' AS DateTime), 2038, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3232, N'ádasdasd', CAST(N'2017-06-22 04:11:00.507' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3233, N'asdasdasd', CAST(N'2017-06-22 04:11:14.297' AS DateTime), 2042, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3234, N'asdasdasd', CAST(N'2017-06-22 04:11:14.297' AS DateTime), 2043, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3242, N'adasd', CAST(N'2017-06-22 04:41:29.840' AS DateTime), 2051, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3243, N'asdasd', CAST(N'2017-06-22 04:44:29.940' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3244, N'asdasdasd', CAST(N'2017-06-22 04:46:43.283' AS DateTime), 2052, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3245, N'asdasdasd', CAST(N'2017-06-22 04:49:57.760' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3246, N'asdasdasd', CAST(N'2017-06-22 04:49:57.790' AS DateTime), 0, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3248, N'asdasd', CAST(N'2017-06-22 04:50:05.710' AS DateTime), 2054, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3249, N'asdasd', CAST(N'2017-06-22 04:50:14.380' AS DateTime), 2055, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3250, N'âsdasdasd', CAST(N'2017-06-22 04:58:51.313' AS DateTime), 2057, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3251, N'âsdasdasd', CAST(N'2017-06-22 04:58:51.313' AS DateTime), 2057, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3252, N'âsdasdasd', CAST(N'2017-06-22 04:58:52.820' AS DateTime), 2058, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3253, N'âsdasdasd', CAST(N'2017-06-22 04:58:59.213' AS DateTime), 2060, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3254, N'âsdasdasd', CAST(N'2017-06-22 04:58:59.213' AS DateTime), 2060, 1, 1)
GO
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3255, N'âsdasdasd', CAST(N'2017-06-22 04:59:01.420' AS DateTime), 2061, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3256, N'âsdasdasd', CAST(N'2017-06-22 04:59:01.447' AS DateTime), 2062, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3257, N'âsdasdasd', CAST(N'2017-06-22 04:59:17.583' AS DateTime), 2063, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3258, N'âsdasdasd', CAST(N'2017-06-22 04:59:58.907' AS DateTime), 2064, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3259, N'âsdasdasd', CAST(N'2017-06-22 05:00:06.423' AS DateTime), 2065, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3260, N'âsdasdasd', CAST(N'2017-06-22 05:01:08.757' AS DateTime), 2066, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3261, N'âsdasdasd', CAST(N'2017-06-22 05:01:08.780' AS DateTime), 2067, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3262, N'asdasd', CAST(N'2017-06-22 05:03:21.667' AS DateTime), 2068, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3263, N'asdasd', CAST(N'2017-06-22 05:03:27.067' AS DateTime), 2069, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3264, N'asdasd', CAST(N'2017-06-22 05:03:50.087' AS DateTime), 2070, 1, 1)
INSERT [dbo].[post] ([id_post], [post_content], [post_date], [id_connect], [id_post_type], [id_acc]) VALUES (3270, N'Hôm nay là thứ mấy', CAST(N'2017-06-22 16:40:29.150' AS DateTime), 2076, 1, 1)
SET IDENTITY_INSERT [dbo].[post] OFF
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (16, 3)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3086, 1017)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3087, 1017)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3088, 1017)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3089, 1017)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3090, 1017)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3091, 1017)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3092, 1017)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3093, 1017)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3114, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3115, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3116, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3117, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3118, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3119, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3120, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3121, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3122, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3123, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3124, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3125, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3126, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3127, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3128, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3129, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3130, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3131, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3132, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3133, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3134, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3135, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3136, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3137, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3138, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3139, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3140, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3141, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3171, 11)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3198, 11)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3201, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3202, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3203, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3204, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3205, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3220, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3221, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3222, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3223, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3224, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3225, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3226, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3228, 1019)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3232, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3233, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3234, 1014)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3242, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3243, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3244, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3245, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3246, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3248, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3249, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3251, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3252, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3254, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3255, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3256, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3257, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3258, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3259, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3260, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3261, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3262, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3263, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3264, 1012)
INSERT [dbo].[post_manage] ([id_post], [id_room]) VALUES (3270, 1012)
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
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2009, N'nvanvdjasda', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2010, N'sdsdf', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2011, N'adsasdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2012, N'ahdgjasdgjasgd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2013, N'sdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2014, N'sdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2015, N'ádasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2016, N'ádasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2017, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2018, N'ádasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2019, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2020, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2021, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2022, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2023, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2024, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2025, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2026, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2027, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2028, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2029, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2030, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2031, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2032, N'queqweq', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2033, N'queqweq', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2034, N'queqweq', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2035, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2036, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2037, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2038, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2039, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2040, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2041, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2042, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2043, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2044, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2045, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2046, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2047, N'fghfgh', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2048, N'dfgdfgdfg', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2049, N'234234', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2050, N'234234', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2051, N'adasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2052, N'asdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2054, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2055, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2056, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2057, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2058, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2059, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2060, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2061, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2062, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2063, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2064, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2065, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2066, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2067, N'âsdasdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2068, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2069, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2070, N'asdasd', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2071, N'Tr?n Van Th?ng', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2072, N'Tr?n Van Th?ng', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2073, N'Hôm nay', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2074, N'Hôm nay', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2075, N'abc', NULL, NULL)
INSERT [dbo].[question] ([id_question], [question_content], [question_type], [id_topic]) VALUES (2076, N'Hôm nay là th? m?y', NULL, NULL)
SET IDENTITY_INSERT [dbo].[question] OFF
INSERT [dbo].[relationship] ([id_acc_add], [id_acc_friend], [waiting]) VALUES (1, 3, 1)
SET IDENTITY_INSERT [dbo].[room] ON 

INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (3, N'hscdvbkjlam', N'', 3, NULL)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (11, N'Phong hoc 1', N'', 2, 4)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1012, N'Công Nghệ Phần Mềm', N'', 1, 1005)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1013, N'Hệ Thống Thông Tin Quản Lý', N'', 1, 1006)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1014, N'Trí Tuệ Nhân Tạo', N'', 1, 1007)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1015, N'Lý Thuyết Đồ Thị', N'', 1, 1008)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1016, N'Lập Trình Nâng Cao', N'', 1, 1009)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1017, N'DEmo test', N'cgfvhbjnm', 1, 1010)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1018, N'DEmo test', N'cgfvhbjnm', 1, 1011)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1019, N'Lập Trình Cơ Bản', N'', 1, 1012)
INSERT [dbo].[room] ([id_room], [room_name], [room_descr], [id_acc], [id_test]) VALUES (1021, N'TRần Văn Thắng', N'', 7, 1014)
SET IDENTITY_INSERT [dbo].[room] OFF
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (3, 3, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (11, 1, 0)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (11, 2, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1012, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1012, 2, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1012, 3, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1012, 7, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1013, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1014, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1015, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1016, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1017, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1018, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1019, 1, 1)
INSERT [dbo].[room_manage] ([id_room], [id_acc], [state]) VALUES (1021, 7, 1)
INSERT [dbo].[task] ([id_test], [id_acc], [id_question], [id_answer], [note]) VALUES (1005, 1, 2072, 1, N'')
INSERT [dbo].[task] ([id_test], [id_acc], [id_question], [id_answer], [note]) VALUES (1005, 1, 2075, 4, N'')
INSERT [dbo].[task] ([id_test], [id_acc], [id_question], [id_answer], [note]) VALUES (1005, 1, 2076, 1, N'')
INSERT [dbo].[task] ([id_test], [id_acc], [id_question], [id_answer], [note]) VALUES (1005, 2, 2076, 2, N'')
INSERT [dbo].[task] ([id_test], [id_acc], [id_question], [id_answer], [note]) VALUES (1005, 3, 2076, 1, N'')
INSERT [dbo].[task] ([id_test], [id_acc], [id_question], [id_answer], [note]) VALUES (1005, 7, 2076, 3, N'')
INSERT [dbo].[task] ([id_test], [id_acc], [id_question], [id_answer], [note]) VALUES (1007, 1, 2046, 1, N'')
SET IDENTITY_INSERT [dbo].[test] ON 

INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (4, N'11-POST-2', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (5, N'12-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1005, N'1012-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1006, N'1013-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1007, N'1014-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1008, N'1015-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1009, N'1016-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1010, N'1017-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1011, N'1018-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1012, N'1019-POST-1', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1013, N'1020-POST-7', NULL, NULL)
INSERT [dbo].[test] ([id_test], [title], [date_start], [date_end]) VALUES (1014, N'1021-POST-7', NULL, NULL)
SET IDENTITY_INSERT [dbo].[test] OFF
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (4, 11)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1005, 1012)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1006, 1013)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1007, 1014)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1008, 1015)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1009, 1016)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1010, 1017)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1011, 1018)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1012, 1019)
INSERT [dbo].[test_default_room] ([id_test], [id_room]) VALUES (1014, 1021)
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_account]    Script Date: 22/06/2017 5:43:24 CH ******/
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
ALTER TABLE [dbo].[relationship]  WITH CHECK ADD  CONSTRAINT [FK_relationship_account] FOREIGN KEY([id_acc_add])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[relationship] CHECK CONSTRAINT [FK_relationship_account]
GO
ALTER TABLE [dbo].[relationship]  WITH CHECK ADD  CONSTRAINT [FK_relationship_account1] FOREIGN KEY([id_acc_friend])
REFERENCES [dbo].[account] ([id_acc])
GO
ALTER TABLE [dbo].[relationship] CHECK CONSTRAINT [FK_relationship_account1]
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
/****** Object:  StoredProcedure [dbo].[box_msg]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[box_notify]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[danhsachbanbe]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[danhsachbanbe] @id_acc int
 as begin
if @id_acc  is not null
select account.*  from dbo.relationship join account on account.id_acc=relationship.id_acc_friend where  dbo.relationship.id_acc_add=@id_acc and dbo.relationship.waiting=0
end



GO
/****** Object:  StoredProcedure [dbo].[kiemtratinnhan]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



	CREATE proc  [dbo].[kiemtratinnhan] 
	@code  nvarchar(max) 
	AS 
	SELECT  * from  chat c where c.COUNT_MSG > 0 AND c.LAST_USER  like @code   and c.code not like 'POST_%'  	







GO
/****** Object:  StoredProcedure [dbo].[kiemtrathongbao]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[kiemtrathongbao] 
	@room_id  nvarchar(max) 
	AS 
	SELECT  * from  chat c where c.COUNT_MSG > 0 AND c.LAST_USER = @room_id   and c.code  like 'POST_%'  	


GO
/****** Object:  StoredProcedure [dbo].[p_addAnswerIntoTestRoom]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[p_addCommentIntoPost_comment]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[p_addCommentIntoPost_comment] @comment_content ntext,
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
/****** Object:  StoredProcedure [dbo].[p_addPostAfterIntoRoom_postAndRoom]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[p_addPostAfterIntoRoom_postAndRoom] @post_content	ntext,
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
/****** Object:  StoredProcedure [dbo].[p_addQuizPostIntoGroup]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_addQuizPostIntoGroup] @id_room int, @id_acc int, @question_content ntext, @answer_content1 ntext, @answer_content2 ntext, @answer_content3 ntext, @answer_content4 ntext, @correct_question int
AS
BEGIN
  SET NOCOUNT ON
  --Insert question to get id_connect by id_question
  DECLARE @id_connect int
  DECLARE @id_post int
  INSERT INTO dbo.question
    VALUES (@question_content, NULL, NULL)
  SET @id_connect = (SELECT
    id_question
  FROM dbo.question
  WHERE id_question = IDENT_CURRENT('QUESTION'))
  -- Insert post, which is quiz post, with id_Connect 
  INSERT INTO dbo.post
    VALUES (@question_content, GETDATE(), @id_connect, 1, @id_Acc)
  SET @id_post = (SELECT
    id_post
  FROM dbo.post
  WHERE id_post = IDENT_CURRENT('POST'))
  INSERT INTO dbo.post_manage
    VALUES (@id_post, @id_room)
  -- Insert quiz answer with id_connect, which is id_question
  INSERT INTO dbo.correct_answer
    VALUES (@id_connect, 1, @answer_content1, 0)
  INSERT INTO dbo.correct_answer
    VALUES (@id_connect, 2, @answer_content2, 0)
  INSERT INTO dbo.correct_answer
    VALUES (@id_connect, 3, @answer_content3, 0)
  INSERT INTO dbo.correct_answer
    VALUES (@id_connect, 4, @answer_content4, 0)
  -- Set question correct for question post
  UPDATE dbo.correct_answer
  SET correct_answer = 1
  WHERE id_question = @id_connect
  AND id_answer = @correct_question

  SELECT
    id_post AS LastID
  FROM Post
  WHERE id_post = IDENT_CURRENT('POST')
END

GO
/****** Object:  StoredProcedure [dbo].[p_addRoom_room]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[p_checkLogIn_account]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[p_chooseAnswerInPost]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[p_chooseAnswerInPost] @id_room int, @id_post int, @id_acc int, @id_answer int
AS
BEGIN
set nocount  on
  DECLARE @res int = 0,
          @id_test int,
          @id_question int;
  SET @id_test = (SELECT
    id_test
  FROM room
  WHERE id_room = @id_room)
  SET @id_question = (SELECT
    id_connect
  FROM post
  WHERE id_post = @id_post)
  IF EXISTS ( SELECT  * FROM TASK WHERE id_test=@id_test AND id_acc=@id_acc  AND id_question=@id_question)
		 UPDATE task SET id_answer=@id_answer WHERE id_test=@id_test AND id_acc=@id_acc  AND id_question=@id_question;
  ELSE
	 INSERT INTO task (id_test, id_acc, id_question, id_answer, note)
    VALUES (@id_test, @id_acc, @id_question, @id_answer, '')
END

GO
/****** Object:  StoredProcedure [dbo].[p_delete_room]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[p_delete_room] @id_room int
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
/****** Object:  StoredProcedure [dbo].[p_deleteComment_Comment]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[p_deletePost_post]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[p_friend_except]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[p_friend_except] @id_acc_add int , @id_acc_friend int
as
begin
	 update dbo.relationship set waiting=0 where id_acc_add=@id_acc_add and id_acc_friend=@id_acc_friend
	 insert into relationship(id_acc_add,id_acc_friend,waiting)  values(@id_acc_friend,@id_acc_add,0);
 end



GO
/****** Object:  StoredProcedure [dbo].[p_leaveRoom_room_manage]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_leaveRoom_room_manage] @idRoom int,@idAcc int
AS

	DELETE room_manage WHERE id_room=@idRoom AND id_acc=@idAcc


GO
/****** Object:  StoredProcedure [dbo].[p_likeOrUnlikePost]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[P_nguoiChonTracNghiem]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[P_nguoiChonTracNghiem] @id_post int

  AS BEGIN DECLARE @id_room int, @id_test int, @id_question int
SET @id_room =
  (SELECT top 1 id_room
   FROM post_manage
   WHERE id_post=@id_post )
SET @id_test=
  (SELECT id_test
   FROM room
   WHERE id_room=@id_room);
SET @id_question =
  (SELECT id_connect
   FROM post
   WHERE id_post=@id_post);
select * from task where id_test=@id_test and id_question=@id_question
end

GO
/****** Object:  StoredProcedure [dbo].[p_participationRoom_room_manage]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[p_signUp_account]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  StoredProcedure [dbo].[p_thongke_tracnghiem]    Script Date: 22/06/2017 5:43:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[p_thongke_tracnghiem] @id_post int
 AS BEGIN DECLARE @id_room int, @id_test int, @id_question int
SET @id_room =
  (SELECT top 1 id_room
   FROM post_manage
   WHERE id_post=@id_post )
SET @id_test=
  (SELECT id_test
   FROM room
   WHERE id_room=@id_room);
SET @id_question =
  (SELECT id_connect
   FROM post
   WHERE id_post=@id_post);
SELECT id_test,
       id_question,
       id_answer,
       sum(CASE id_answer
               WHEN 1 THEN 1
               WHEN 2 THEN 1
               WHEN 3 THEN 1
               ELSE 1
           END)AS slchon
FROM task
WHERE id_test=@id_test
  AND id_question=@id_question
GROUP BY id_test,
         id_question,
         id_answer
ORDER BY id_answer END


GO
/****** Object:  StoredProcedure [dbo].[themnoidung]    Script Date: 22/06/2017 5:43:24 CH ******/
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
/****** Object:  Trigger [dbo].[t_insertAdminIntoRoomManage]    Script Date: 22/06/2017 5:43:24 CH ******/
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
		set @id_test=( SELECT id_test AS LastID FROM TEST WHERE id_test = IDENT_CURRENT('TEST'));
	 INSERT INTO test_default_room(id_test,id_room) VALUES (@id_test,@id_room);
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

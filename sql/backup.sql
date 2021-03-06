USE [master]
GO
/****** Object:  Database [Quiz]    Script Date: 17/06/2017 17:21:32 ******/
CREATE DATABASE [Quiz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Quiz', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Quiz.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Quiz_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Quiz_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
USE [Quiz]
GO
/****** Object:  UserDefinedFunction [dbo].[getCorrectAnswer]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[account]    Script Date: 17/06/2017 17:21:32 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_account] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cl_list2]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[comment]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[correct_answer]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[liked]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[post]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[post_manage]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[question]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[room]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[room_manage]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[task]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[test]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[test_content]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[test_default_room]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Table [dbo].[topic]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  UserDefinedFunction [dbo].[f_getMemberInRoom]    Script Date: 17/06/2017 17:21:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

   create function [dbo].[f_getMemberInRoom](@id_room int)  returns table
   as
   return(
		select  account.id_acc, isnull(name,email) as name from room_manage  left join account on account.id_acc=room_manage.id_acc   where room_manage.id_room=@id_room and room_manage.state=1)



GO
/****** Object:  UserDefinedFunction [dbo].[getPostByGroup]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getPostQuizByGroup]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_addAnswerIntoTestRoom]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_addCommentIntoPost_comment]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_addPostAfterIntoRoom_postAndRoom]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_addQuizPostIntoGroup]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_addRoom_room]    Script Date: 17/06/2017 17:21:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[p_addRoom_room] @room_name NVARCHAR(50), @room_descr NVARCHAR(100)=N'', @id_acc int
 AS
 SET NOCOUNT ON
 BEGIN
		INSERT INTO room (room_name,room_descr,id_acc) VALUES(@room_name,@room_descr,@id_acc)
		SELECT id_room AS LastID FROM room WHERE id_room = @@Identity;
 END

GO
/****** Object:  StoredProcedure [dbo].[p_checkLogIn_account]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_delete_room]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_deleteComment_Comment]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_deletePost_post]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_likeOrUnlikePost]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_participationRoom_room_manage]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  StoredProcedure [dbo].[p_signUp_account]    Script Date: 17/06/2017 17:21:32 ******/
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
/****** Object:  Trigger [dbo].[t_insertAdminIntoRoomManage]    Script Date: 17/06/2017 17:21:32 ******/
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

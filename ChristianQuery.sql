CREATE DATABASE [ChristianPortfolio];
GO

USE [ChristianPortfolio];
GO

CREATE SCHEMA [IT];
GO

CREATE TABLE [IT].[Titles](
	title_id INT IDENTITY(1,1) PRIMARY KEY,
	title NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE [IT].[Descriptions](
	description_id INT IDENTITY(1,1) PRIMARY KEY,
	description_content NVARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE [IT].[Projects](
	project_id INT IDENTITY(1,1) PRIMARY KEY,
	title_id INT NOT NULL
		CONSTRAINT fk_title FOREIGN KEY (title_id) REFERENCES [IT].[Titles],
	description_id INT NOT NULL
		CONSTRAINT fk_description FOREIGN KEY (description_id) REFERENCES [IT].[Descriptions]
);
GO






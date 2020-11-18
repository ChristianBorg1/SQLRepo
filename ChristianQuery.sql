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

INSERT INTO [IT].[Titles] (title)
VALUES 
	('Directions For Visually Impaired'), 
	('Obstacle Detection For Visually Impaired'),
	('Movie Ratings'),
	('Crossword Puzzle'),
	('Word Search Puzzle'),
	('Automated Passport Photo Taking');
GO

INSERT INTO [IT].[Descriptions] (description_content)
VALUES
	('A web application which gives directions to a specified location. This application is suitable for visually impaired users.'),
	('An application which helps visually impaired people detect and recognize obstacles while walking.'),
	('A web application which predicts the movie ratings by a particular occupation (e.g. teacher, doctor) for different genres (e.g. comedy, horror).'),
	('An interactive crossword puzzle.'),
	('An interactive word search puzzle.'),
	('An AI which captures passport photos automatically with computer vision.');
GO

INSERT INTO [IT].[Projects] (title_id, description_id)
VALUES 
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6);
GO

SELECT * FROM [IT].[Titles];
GO

SELECT * FROM [IT].[Descriptions];
GO

SELECT * FROM [IT].[Projects];
GO

SELECT * FROM [IT].[Titles]
WHERE title_id = 2 OR title_id = 5;
GO

SELECT description_content
FROM [IT].[Descriptions]
GO



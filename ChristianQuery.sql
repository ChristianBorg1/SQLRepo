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

CREATE TABLE [IT].[table1](
	title_id INT PRIMARY KEY,
	title NVARCHAR(200) 
);
GO

CREATE TABLE [IT].[table2](
	description_id INT PRIMARY KEY,
	description_content NVARCHAR(MAX)
);
GO

/* 1, 2, 3 */
INSERT INTO [IT].[table1] (title_id,title)
VALUES (
	(SELECT title_id FROM [IT].[Titles] WHERE title_id = 3), 
	(SELECT title FROM [IT].[Titles] WHERE title_id = 3)
);
GO

/* 1, 2, 4 */
INSERT INTO [IT].[table2] (description_id,description_content)
VALUES (
	(SELECT description_id FROM [IT].[Descriptions] WHERE description_id = 4), 
	(SELECT description_content FROM [IT].[Descriptions] WHERE description_id = 4)
);
GO

CREATE TABLE [IT].[table3](
	project_id INT PRIMARY KEY,
	title_id INT 
		CONSTRAINT fk_table1 FOREIGN KEY (title_id) REFERENCES [IT].[table1],
	description_id INT 
		CONSTRAINT fk_table2 FOREIGN KEY (description_id) REFERENCES [IT].[table2]
);
GO

INSERT INTO [IT].[table3]
VALUES
	(1,1,1),
	(2,2,2),
	(5,NULL,NULL)
GO

SELECT *
FROM [IT].[table3]
LEFT OUTER JOIN [IT].[table1] ON [IT].[table3].title_id = [IT].[table1].title_id;
GO
/* returns the first 2 rows which are common in both table1 and table3 */ 
/* AND the other row in table3 */


SELECT *
FROM [IT].[table3]
RIGHT OUTER JOIN [IT].[table1] ON [IT].[table3].title_id = [IT].[table1].title_id;
GO
/* returns the first 2 rows which are common in both table1 and table3 */ 
/* AND the other row in table1 */

SELECT *
FROM [IT].[table3]
INNER JOIN [IT].[table1] ON [IT].[table3].title_id = [IT].[table1].title_id;
GO
/* returns ONLY the first 2 rows which are common in both table1 and table3 */

SELECT *
FROM [IT].[table2]
LEFT OUTER JOIN [IT].[table3] ON [IT].[table2].description_id = [IT].[table3].description_id;
GO
/* returns the first 2 rows which are common in both table2 and table3 */ 
/* AND the other row in table2 */ 


SELECT *
FROM [IT].[table2]
RIGHT OUTER JOIN [IT].[table3] ON [IT].[table2].description_id = [IT].[table3].description_id;
GO
/* returns the first 2 rows which are common in both table2 and table3 */ 
/* AND the other row in table3 */ 


DROP TABLE [IT].[table3];
GO

DROP TABLE [IT].[table1];
GO

DROP TABLE [IT].[table2];
GO

SELECT project_id, title, description_content
FROM [IT].[Projects]
INNER JOIN [IT].[Titles] ON [IT].[Projects].title_id = [IT].[Titles].title_id
INNER JOIN [IT].[Descriptions] ON [IT].[Projects].description_id = [IT].[Descriptions].description_id;
GO

CREATE FUNCTION [IT].udf_SelectDescription(@title NVARCHAR(200))
RETURNS NVARCHAR(MAX)
AS
BEGIN

	RETURN (
		SELECT description_content FROM [IT].[Projects] 
			INNER JOIN [IT].[Titles] ON [IT].[Projects].title_id = [IT].[Titles].title_id
			INNER JOIN [IT].[Descriptions] ON [IT].[Projects].description_id = [IT].[Descriptions].description_id
		WHERE title = @title
	)
END;
GO

SELECT [IT].udf_SelectDescription('Crossword Puzzle');
GO

DROP FUNCTION [IT].udf_SelectDescription;
GO



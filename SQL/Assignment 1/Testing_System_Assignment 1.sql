CREATE DATABASE Testing_System;
USE Testing_System;

CREATE TABLE Department(
	DepartmentID 	INT AUTO_INCREMENT,
    DepartmentName	VARCHAR(30)
); 

CREATE TABLE `Position`(
	PositionID		INT AUTO_INCREMENT,
    PositionName	VARCHAR(30)
);

CREATE TABLE `Account`(
	AccountID		INT AUTO_INCREMENT,
    Email			VARCHAR(30),
    Username		VARCHAR(30),
    Fullname		VARCHAR(30),
    DepartmentID	INT,
    PositionID		INT,
    CreateDate		DATE
);

CREATE TABLE `Group`(
	GroupID			INT AUTO_INCREMENT,
    GroupName		VARCHAR(30),
    CreatorID		INT,
    CreatorDate		DATE
);

CREATE TABLE GroupAccount(
	GroupID			INT AUTO_INCREMENT,
	AccountID		INT,
    JoinDate		DATE
);

CREATE TABLE TypeQuestion(
	TypeID			INT AUTO_INCREMENT,
    TypeName		VARCHAR(30)
);

CREATE TABLE CategoryQuestion(
	CategoryID		INT AUTO_INCREMENT,
    CategoryName	VARCHAR(30)
);

CREATE TABLE Question(
	QuestionID		INT AUTO_INCREMENT,
    Content			VARCHAR(30),
    CategoryID		INT,
    TypeID			INT,
    CreatorID		INT,
    CreatDate		DATE
);

CREATE TABLE Answer(
	AnswerID		INT AUTO_INCREMENT,
    Content			VARCHAR(30),
    QuestionID		INT,
    IsCorrect		BOOLEAN
);

CREATE TABLE Exam(
	ExamID			INT AUTO_INCREMENT,
    `Code`			VARCHAR(30),
    Title			VARCHAR(30),
    CategoryID		INT,
    Duration		DATE,
    CreatorID		INT,
    CreateDate		DATE
);

CREATE TABLE ExamQuestion(
	ExemID	INT,
    QuestionID	INT
);
CREATE DATABASE Testing_System_2;
USE Testing_System_2;

CREATE TABLE Department(
	DepartmentID 	INT NOT NULL PRIMARY KEY,
    DepartmentName	VARCHAR(30)
); 

CREATE TABLE `Position`(
	PositionID		INT NOT NULL PRIMARY KEY,
    PositionName	VARCHAR(30)
);

CREATE TABLE `Account`(
	AccountID		INT NOT NULL PRIMARY KEY,
    Email			VARCHAR(30),
    Username		VARCHAR(30),
    Fullname		VARCHAR(30),
    DepartmentID	INT,
    PositionID		INT,
    CreateDate		DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
);


CREATE TABLE `Group`(
	GroupID			INT NOT NULL PRIMARY KEY,
    GroupName		VARCHAR(30),
    CreatorID		INT,
    CreatorDate		DATE
);

CREATE TABLE GroupAccount(
	GroupID			INT,
	AccountID		INT,
    JoinDate		DATE,
    FOREIGN KEY (AccountID) REFERENCES `Account` (AccountID),
    FOREIGN KEY (GroupID) REFERENCES `Group` (GroupID)
);

CREATE TABLE TypeQuestion(
	TypeID			INT NOT NULL PRIMARY KEY,
    TypeName		VARCHAR(30)
);

CREATE TABLE CategoryQuestion(
	CategoryID		INT NOT NULL PRIMARY KEY,
    CategoryName	VARCHAR(30)
);

CREATE TABLE Question(
	QuestionID		INT NOT NULL PRIMARY KEY,
    Content			VARCHAR(30),
    CategoryID		INT,
    TypeID			INT,
    CreatorID		INT,
    CreatDate		DATE,
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
);

CREATE TABLE Answer(
	AnswerID		INT NOT NULL PRIMARY KEY,
    Content			VARCHAR(30),
    QuestionID		INT,
    IsCorrect		BOOLEAN,
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);

CREATE TABLE Exam(
	ExamID			INT NOT NULL PRIMARY KEY,
    `Code`			VARCHAR(30),
    Title			VARCHAR(30),
    CategoryID		INT,
    Duration		DATE,
    CreatorID		INT,
    CreateDate		DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
);

CREATE TABLE ExamQuestion(
	ExemID	INT,
    QuestionID	INT,
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID),
    FOREIGN KEY (ExemID) REFERENCES Exam (ExemID)
);
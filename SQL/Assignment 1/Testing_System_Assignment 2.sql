-- create database testing_system
DROP DATABASE IF EXISTS testing_system_2;
CREATE DATABASE IF NOT EXISTS testing_system_2;
USE testing_system_2;

-- create table departments
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
	department_id 			INT(10) AUTO_INCREMENT,
    department_name 		VARCHAR(255) UNIQUE NOT NULL,
PRIMARY KEY (department_id)
);

-- create table positions
DROP TABLE IF EXISTS positions;
CREATE TABLE positions (
	position_id 			INT(10) AUTO_INCREMENT,
    position_name 			VARCHAR(255) UNIQUE NOT NULL, 
PRIMARY KEY (position_id)
);

-- create table accounts
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	account_id  			INT(10) AUTO_INCREMENT,
    email 					VARCHAR(100) UNIQUE NOT NULL,
    user_name   			VARCHAR(50) UNIQUE NOT NULL,
    full_name   			VARCHAR(255),
    gender					VARCHAR(10) DEFAULT 'M',	
    -- gender					ENUM('M', 'F', 'U') DEFAULT 'M',
    department_id 			INT(10),
    position_id 			INT(10),
    create_date 			TIMESTAMP,
PRIMARY KEY (account_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (position_id) REFERENCES positions(position_id)
);

-- create table groups
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
	group_id 				INT(10) AUTO_INCREMENT,
    group_name 				VARCHAR(255) UNIQUE NOT NULL,
    creator_id 				INT(10),
    create_date 			TIMESTAMP,
PRIMARY KEY (group_id),
FOREIGN KEY (creator_id) REFERENCES accounts(account_id)
);

-- create table group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account (
	group_id 				INT(10),
    account_id 				INT(10),
    join_date 				TIMESTAMP,
PRIMARY KEY (group_id, account_id),
FOREIGN KEY (group_id) REFERENCES `groups`(group_id),
FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- create table type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question (
	type_id 				INT(10) AUTO_INCREMENT,
    type_name 				VARCHAR(50) UNIQUE NOT NULL,
PRIMARY KEY (type_id)
);

-- create table category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question (
	category_id 			INT(10) AUTO_INCREMENT,
    category_name 			VARCHAR(50) UNIQUE NOT NULL,
PRIMARY KEY (category_id)
);

-- create table questions
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
	question_id 			INT(10) AUTO_INCREMENT,
    content 				TEXT,
    category_id 			INT(10),
    type_id 				INT(10),
    creator_id 				INT(10),
    create_date 			TIMESTAMP,
PRIMARY KEY (question_id),
FOREIGN KEY (category_id) REFERENCES category_question(category_id),
FOREIGN KEY (type_id) REFERENCES type_question(type_id),
FOREIGN KEY (creator_id) REFERENCES accounts(account_id)
);

-- create table answers
DROP TABLE IF EXISTS answers;
CREATE TABLE answers (
	answer_id 				INT(10) AUTO_INCREMENT,
    content 				TEXT,
    question_id 			INT(10),
    is_correct				BIT DEFAULT 0,
PRIMARY KEY (answer_id),
FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

-- create table exams
DROP TABLE IF EXISTS exams;
CREATE TABLE exams (
	exam_id 				INT(10) AUTO_INCREMENT,
    `code` 					VARCHAR(10) UNIQUE NOT NULL,
    title 					VARCHAR(50) NOT NULL,
    category_id 			INT(10),
    duration 				INT(10),
    creator_id 				INT(10),
    create_date 			TIMESTAMP,
PRIMARY KEY (exam_id),
FOREIGN KEY (category_id) REFERENCES category_question(category_id),
FOREIGN KEY (creator_id) REFERENCES accounts(account_id)
);

-- create table exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question (
	exam_id 				INT(10),
    question_id 			INT(10),
PRIMARY KEY (exam_id, question_id),
FOREIGN KEY (exam_id) REFERENCES exams(exam_id),
FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

-- Question 1: Them it nhat 10 ban ghi vao moi bang
-- Bang Department
INSERT INTO departments (department_name)
VALUES					('Production'),
						('Research and Development'),
                        ('Sale'),
                        ('Marketing'),
                        ('Human Resource Management'),
                        ('Accounting and Finance'),
                        ('Waiting Room');
                        
                        
-- Bang Position
INSERT INTO positions (position_name)
VALUES				  ('Developer'),
					  ('Tester'),
                      ('Comtor'),
                      ('Business Analysis'),
                      ('Quality Assurance'),
                      ('Project Manager'),
                      ('Solution Architect'),
                      ('Scrum Master');
                
-- Bang Account
INSERT INTO accounts 
(email, 							user_name, 			full_name, 					department_id, 		position_id) VALUES
('tfermer0@ucla.edu', 				'tfermer0', 		'Tully Fermer', 			1, 					1		   ),
('tgatchell1@bbb.org', 				'tgatchell1', 		'Tuck Gatchell', 			2, 					1		   ),
('bsoutherell2@tripadvisor.com', 	'bsoutherell2', 	'Beatrisa Fermer', 			3, 					2		   ),
('dtomley3@nymag.com', 				'dtomley3', 		'Denis Tomley', 			2, 					1		   ),
('asteaning4@paginegialle.it', 		'asteaning4', 		'Allis Steaning', 			5, 					5		   ),
('rwynrehame5@census.gov', 			'rwynrehame5', 		'Rodina Wynrehame', 		6, 					6		   ),
('atanti6@eventbrite.com', 			'atanti6', 			'Amabelle Tanti', 			5, 					7		   ),
('olewington7@seesaa.net', 			'olewington7', 		'Ophelia Lewington', 		1, 					5		   ),
('glinklater8@w3.org', 				'glinklater8', 		'Germain Linklater', 		5, 					1		   ),
('mmcorkil9@reference.com', 		'mmcorkil9', 		'Michaeline McOrkil', 		2, 					2		   ),
('cjonuzia@irs.gov', 				'cjonuzia', 		'Cheri Jonuzi', 			3, 					3		   ),
('tlamontb@ow.ly', 					'tlamontb', 		'Tessi Lamont', 			3, 					3		   ),
('dkelsallc@ftc.gov', 				'dkelsallc', 		'Dosi Kelsall', 			4, 					4		   ),
('cbleackleyd@myspace.com', 		'cbleackleyd', 		'Carley Bleackley', 		5, 					8		   ),
('agerrarde@altervista.org', 		'agerrarde', 		'Annnora Gerrard', 			3, 					4		   ),
('mkevisf@photobucket.com', 		'mkevisf', 			'Mae Kevis', 				4, 					3		   ),
('ewahlbergg@independent.co.uk', 	'ewahlbergg', 		'Etienne Wahlberg', 		6, 					7		   ),
('fcoyh@baidu.com', 				'fcoyh', 			'Fionna Coy', 				5, 					7		   ),
('lcuruclisi@eepurl.com', 			'lcuruclisi', 		'Lorettalorna Curuclis', 	2, 					8		   ),
('eribeiroj@unblog.fr', 			'eribeiroj', 		'Elsey Ribeiro', 			5, 					2		   );		

-- Bang Group
INSERT INTO `groups` (group_name, 				creator_id)
VALUES				 ('Annihilators',			1		  ),
					 ('Avengers',				3		  ),
                     ('Bad to The Bone',		5		  ),
                     ('Black Panthers',			7		  ),
                     ('Black Widows',			9		  ),
                     ('Blitzkrieg ',			11		  ),
                     ('Braindead Zombies',		13		  ),
                     ('Brewmaster Crew',		15		  ),
                     ('Brute Force',			17		  ),
                     ('Butchers ',				19	      );

-- Bang GroupAccount
INSERT INTO group_account (group_id, 	account_id, 	join_date)
VALUES					  (1,		 	1,				'2020-01-01'),
						  (1,			2,				'2020-01-01'),
                          (2,			1,				'2020-01-01'),
                          (2,			4,				'2020-01-01'),
                          (3,			5,				'2020-01-01'),
                          (3,			2,				'2020-01-01'),
                          (4,			7,				'2020-01-01'),
                          (4,			8,				'2019-10-25'),
                          (5,			9,				'2020-01-01'),
                          (5,			10,				'2020-01-01'),
                          (6,			11,				'2018-10-25'),
                          (6,			12,				'2020-01-01'),
                          (7,			13,				'2018-09-25'),
                          (7,			14,				'2020-01-01'),
                          (8,			15,				'2020-01-01'),
                          (8,			16,				'2020-01-01'),
                          (1,			17,				'2020-01-01'),
                          (1,			18,				'2020-01-01'),
                          (1,			19,				'2020-01-01');
                        
-- Bang TypeQuestion
INSERT INTO type_question (type_name)
VALUES					  ('Essay Question'),
						  ('Multiple Choice Question'),
                          ('Rank Order Scaling Question'),
                          ('Text Slider Question'),
                          ('Likert Scale Question'),
                          ('Semantic Differential Scale'),
                          ('Stapel Scale Question'),
                          ('Constant Sum Question'),
                          ('Comment Box Open Ended Question'),
                          ('Text Question');

-- Bang CategoryQuestion
INSERT INTO category_question (category_name)
VALUES						  ('Java'),
							  ('C'),
                              ('Python'),
                              ('C++'),
                              ('C#'),
                              ('Visual Basic .Net'),
                              ('JavaScript'),
                              ('PHP'),
                              ('Swift'),
                              ('SQL');
                        
-- Bang Question
INSERT INTO questions 
(content, category_id, type_id, creator_id) VALUES
('Please explain what you understand by computer programming.',
1, 1, 1),
('Can you enumerate and explain the various types of errors that can occur during the execution of a computer program?',
1, 2, 3),
('Please explain an algorithm. What are some of its important features?',
2, 2, 5),
('What do you understand by maintaining and updating a computer program?',
2, 4, 7),
('Please provide a brief explanation on variables.',
2, 4, 9),
('Every programming language has reserved words. What are they? Give some examples.',
3, 4, 11),
('What do you understand by loops? Briefly explain the various types of loops.',
3, 6, 13),
('Please explain program documentation. Why is it important?',
3, 8, 15),
('What are constants? Explain their types.',
3, 8, 17),
('Please explain the operators.',
5, 1, 19),
('Program documentation is the written description of the algorithm(s), coding method, design, testing, and proper use of a particular computer program. It is valuable for those who use the program on a day-to-day basis and also for the programmer(s) who are meant to correct, modify, and update the computer program. Program documentation is the written description of the algorithm(s), coding method, design, testing, and proper use of a particular computer program. It is valuable for those who use the program on a day-to-day basis and also for the programmer(s) who are meant to correct, modify, and update the computer program.',
2, 2, 1);

-- Bang Answer
INSERT INTO answers 
(content, question_id, is_correct) VALUES
('Also known as coding or programming, computer programming is the process of encoding an algorithm into a notation, typically a computer program, by means of some programming language so that it can be executed by a computer.',
1, 1),
('Three types of errors can occur during the execution of a computer program.',
1, 0),
('An algorithm can be defined as a set of finite steps that when followed helps in accomplishing a particular task. Important features of an algorithm are clarity, efficiency, and finiteness.',
1, 0),
('The maintenance and updating process of a computer program starts post its successful installation. While program maintenance is the continuous process of monitoring the computer program for bugs and errors, updating the computer program means making it better with minor and major changes over time.',
3, 1),
('Variables are used for storing the input of a program as well as the computational results during program execution. These are actually named memory locations. The value stored in a variable can change during the program execution.',
3, 0),
('Reserved words, also known as keywords, are the words that have predefined meanings in a particular programming language. These reserved words can’t be used or redefined for serving other purposes. Following are some examples of reserved words.',
4, 1),
('A loop is a structure in programming that can repeat a defined set of statements for a set number of times or until a particular condition is satisfied. There are three important types of loops.',
4, 1),
('Program documentation is the written description of the algorithm(s), coding method, design, testing, and proper use of a particular computer program. It is valuable for those who use the program on a day-to-day basis and also for the programmer(s) who are meant to correct, modify, and update the computer program.',
5, 0),
('A constant is a programming entity whose value can’t be changed or modified during program execution. Constants are of two main types.',
5, 1),
('Operators are used for performing certain operations on data in a computer program. These are represented by symbols. For example, / represent mathematical division while * represents multiplication.',
1, 0);

-- Bang Exam
INSERT INTO exams (`code`, 		title, 								category_id, 	duration, 	creator_id)
VALUES			  ('E001', 		'Exam for Java', 					1, 			 	60, 		1		  ),
				  ('E002', 		'Exam for C', 						2, 			 	120, 		3		  ),
                  ('E003', 		'Exam for Python', 					3, 				180, 		5		  ),
                  ('E004', 		'Exam for C++', 					4, 				20, 		7		  ),
                  ('E005', 		'Exam for C#', 						5, 				120, 		9		  ),
                  ('E006', 		'Exam for Visual Basic .Net', 		6, 				180, 		11		  ),
                  ('E007', 		'Exam for JavaScript', 				7, 				60, 		13		  ),
                  ('E008', 		'Exam for PHP', 					8, 				30, 		15		  ),
                  ('E009', 		'Exam for Swift', 					9, 				45, 		17		  ),
                  ('E010', 		'Exam for SQL', 					10, 			45, 		19		  );

-- Bang ExamQuestion
INSERT INTO exam_question (exam_id, question_id)
VALUES					  (1, 		1		   ),
						  (2, 		1		   ),
                          (3, 		1		   ),
                          (4, 		1		   ),
                          (5, 		2		   ),
                          (6, 		2		   ),
                          (7, 		2		   ),
                          (8, 		2		   ),
                          (3, 		10		   ),
                          (10, 		9		   );
						
                        
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
Select 	*
From	accounts, departments;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT	*	FROM	accounts
WHERE	create_date > '2010/12/20'
;

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT *
FROM	accounts A JOIN positions P 
ON		A.position_id = P.position_id
WHERE	position_name = 'developer'
;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT	*, count(A.account_id)
FROM	accounts A JOIN departments D 
ON		A.department_id = D.department_id
GROUP BY	A.department_id
HAVING	count(A.account_id) > 3
;

SELECT	*, count(A.department_id)
FROM	accounts A JOIN departments D
ON		A.department_id = D.department_id
GROUP BY	A.department_id
HAVING	count(A.department_id) > 3
;







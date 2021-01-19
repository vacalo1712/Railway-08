-- create database testing_system
DROP DATABASE IF EXISTS testing_system_4;
CREATE DATABASE IF NOT EXISTS testing_system_4;
USE testing_system_4;

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
    create_date 			TIMESTAMP DEFAULT NOW(),
PRIMARY KEY (account_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE,
FOREIGN KEY (position_id) REFERENCES positions(position_id) ON DELETE CASCADE
);

-- create table groups
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
	group_id 				INT(10) AUTO_INCREMENT,
    group_name 				VARCHAR(255) UNIQUE NOT NULL,
    creator_id 				INT(10),
    create_date 			TIMESTAMP DEFAULT NOW(),
PRIMARY KEY (group_id),
FOREIGN KEY (creator_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- create table group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account (
	group_id 				INT(10),
    account_id 				INT(10),
    join_date 				TIMESTAMP,
FOREIGN KEY (group_id) REFERENCES `groups`(group_id) ON DELETE CASCADE,
FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
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
    create_date 			TIMESTAMP DEFAULT NOW(),
PRIMARY KEY (question_id),
FOREIGN KEY (category_id) REFERENCES category_question(category_id) ON DELETE CASCADE,
FOREIGN KEY (type_id) REFERENCES type_question(type_id) ON DELETE CASCADE,
FOREIGN KEY (creator_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- create table answers
DROP TABLE IF EXISTS answers;
CREATE TABLE answers (
	answer_id 				INT(10) AUTO_INCREMENT,
    content 				TEXT,
    question_id 			INT(10),
    is_correct				BIT DEFAULT 0,
PRIMARY KEY (answer_id),
FOREIGN KEY (question_id) REFERENCES questions(question_id) ON DELETE CASCADE
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
    create_date 			TIMESTAMP DEFAULT NOW(),
PRIMARY KEY (exam_id),
FOREIGN KEY (category_id) REFERENCES category_question(category_id) ON DELETE CASCADE,
FOREIGN KEY (creator_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- create table exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question (
	exam_id 				INT(10),
    question_id 			INT(10),
PRIMARY KEY (exam_id, question_id),
FOREIGN KEY (exam_id) REFERENCES exams(exam_id) ON DELETE CASCADE,
FOREIGN KEY (question_id) REFERENCES questions(question_id) ON DELETE CASCADE
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
('tfermer0@uclaccountsedu', 				'tfermer0', 		'Tully Fermer', 			1, 					1		   ),
('tgatchell1@bbb.org', 				'tgatchell1', 		'Tuck Gatchell', 			2, 					1		   ),
('bsoutherell2@tripadvisor.com', 	'bsoutherell2', 	'Beatrisa Fermer', 			3, 					2		   ),
('dtomley3@nymag.com', 				'dtomley3', 		'Denis Tomleyo', 			2, 					1		   ),
('asteaning4@paginegialle.it', 		'asteaning4', 		'Allis Steaning', 			5, 					5		   ),
('rwynrehame5@census.gov', 			'rwynrehame5', 		'Rodina Wynrehame', 		6, 					6		   ),
('atanti6@eventbrite.com', 			'atanti6', 			'Amabelle Tanti', 			5, 					7		   ),
('olewington7@seesaaccountsnet', 			'olewington7', 		'Ophelia Lewington', 		1, 					5		   ),
('glinklater8@w3.org', 				'glinklater8', 		'Germain Linklater', 		5, 					1		   ),
('mmcorkil9@reference.com', 		'mmcorkil9', 		'Michaeline McOrkil', 		2, 					2		   ),
('cjonuzia@irs.gov', 				'cjonuzia', 		'Cheri Jonuzi', 			3, 					3		   ),
('tlamontb@ow.ly', 					'tlamontb', 		'Tessi Lamont', 			3, 					3		   ),
('dkelsallc@ftc.gov', 				'dkelsallc', 		'Dosi Kelsall', 			4, 					4		   ),
('cbleackleyd@myspace.com', 		'cbleackleyd', 		'Carley Bleackley', 		5, 					8		   ),
('agerrarde@altervistaccountsorg', 		'agerrarde', 		'Annnora Gerrard', 			3, 					4		   ),
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
                          (4,			8,				'2020-01-01'),
                          (5,			9,				'2020-01-01'),
                          (5,			10,				'2020-01-01'),
                          (6,			11,				'2020-01-01'),
                          (6,			12,				'2020-01-01'),
                          (7,			13,				'2020-01-01'),
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

-- Bang Category_Question
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
('A loop is a structure in programming that can repeat a defined set of statements for a set number of times or until a particular condition is satisfiedepartments. There are three important types of loops.',
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

SELECT 		accounts.account_id, accounts.email, accounts.user_name, accounts.full_name, accounts.gender, accounts.department_id, accounts.position_id, accounts.create_date, departments.department_id
FROM		`accounts`
JOIN		departments
ON			`accounts`.department_id = departments.department_id
;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010

SELECT		*
FROM		`accounts`
WHERE		create_date > 2010/12/20
;

-- Question 3: Viết lệnh để lấy ra tất cả các developer

SELECT		*
FROM		`accounts`
JOIN		positions
ON			accounts.account_id = positions.position_id
WHERE		position_name	=	'Developer'
;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT		departments.department_id, departments.department_name, count(accounts.department_ID) AS 'So Luong'
FROM		`accounts`
JOIN		departments
ON			departments.department_id = accounts.department_ID
GROUP BY	accounts.department_id
HAVING		count(accounts.department_id) >3
;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

SELECT question_id, content, question_idany from (SELECT questions.question_id, questions.content, count(*) as question_idany
		FROM questions
		JOIN exam_question ON exam_question.question_id = questions.question_id
        GROUP BY questions.question_id
       ) A;
       
SELECT question_id, content, MAX(maxquestion) FROM (SELECT Q.question_id, Q.content, COUNT(*) as maxquestion
FROM questions Q 
INNER JOIN 	answers A ON	Q.question_id = A.question_id      
GROUP BY Q.question_id) A;

Select * from exam_question;

-- Question 6: Thống kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT		CQ.Category_ID, CQ.Category_Name, COUNT(Q.Category_ID) AS 'SO LUONG'
FROM		Category_Question CQ
LEFT JOIN 	Questions Q ON CQ.Category_ID = Q.Category_ID
GROUP BY	CQ.Category_ID
ORDER BY	CQ.Category_ID ASC;

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT	question_id
FROM	answers
GROUP BY	question_id
HAVING		question_id >= 4
;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT	`code`
FROM	exams
WHERE	duration >= '60' AND create_date > '2019/12/20'
;

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT	*
FROM	`groups`
ORDER BY create_date DESC
LIMIT 5
;

-- Question 10: Đếm số nhân viên thuộc department có id = 2

SELECT	department_id, count(account_id) AS 'so nhan vien'
FROM	`accounts`
WHERE	department_id = 2;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT	*
FROM	accounts A
JOIN	positions P ON A.position_id = P.position_id
HAVING	position_name IN ('Developer', 'Tester', 'Scrum Master', 'Project Manager')
;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT	Q.content AS Cau_Hoi, Q.creator_id AS Nguoi_Tao, Q.category_id AS Loai_Cau_Hoi, A.question_id , A.content AS Cau_Tra_Loi
FROM	questions Q 
JOIN	answers A ON Q.question_id = A.question_id
;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT	T.Type_name AS 'Loại Câu Hỏi', count(Q.type_id) AS 'So Luong'
FROM	type_question T 
JOIN	questions Q ON T.type_id = Q.type_id
GROUP BY	Q.type_id
;

-- Question 14:Lấy ra group không có account nào
SELECT	G.group_name
FROM	`groups` G 
LEFT JOIN	group_account GA ON	GA.group_id = G.group_id
WHERE	GA.account_id IS NULL
;

-- Question 15: Lấy ra group không có account nào
SELECT	*
FROM	`GroupS`
WHERE	Group_ID NOT IN (SELECT 	Group_ID
							FROM	Group_Account)
;

-- Question 16: Lấy ra question không có answer nào
SELECT 	*
FROM	questions
WHERE	question_id NOT IN (	SELECT	question_id
								FROM	answers)
;






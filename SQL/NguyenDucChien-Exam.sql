-- Tạo Database
DROP DATABASE IF EXISTS Thuc_Tap;
CREATE DATABASE IF NOT EXISTS Thuc_Tap;
USE Thuc_Tap;

-- Tạo bảng Country
DROP TABLE IF EXISTS Country;
CREATE TABLE Country (
	country_id		INT (10) UNSIGNED AUTO_INCREMENT,
    country_name	VARCHAR (50) NOT NULL,
    PRIMARY	KEY (country_id)
);

-- Tạo bảng Location
DROP TABLE IF EXISTS Location;
CREATE TABLE Location (
	location_id			INT (10) UNSIGNED AUTO_INCREMENT,
	street_address		NVARCHAR (50) NOT NULL UNIQUE,
	postal_code			INT	(10) UNSIGNED NOT NULL,
	country_id			INT (10) UNSIGNED,
    PRIMARY KEY	(location_id),
    FOREIGN KEY	(country_id) REFERENCES Country (country_id) ON DELETE CASCADE
);

-- Tạo bảng Car Employee
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
	employee_id		INT (10) UNSIGNED AUTO_INCREMENT,
    full_name		NVARCHAR (50) NOT NULL,
	email			NVARCHAR (50) NOT NULL UNIQUE,
	location_id 	INT (10) UNSIGNED,
    PRIMARY KEY (employee_id),
    FOREIGN KEY	(location_id) REFERENCES Location (location_id) ON DELETE CASCADE
);

-- 1. Tạo table với các ràng buộc và kiểu dữ liệu Thêm ít nhất 3 bản ghi vào table

-- INSERT DATA BẢNG Country
INSERT INTO	Country (country_name)
	VALUES			('VietNam'),
					('ThaiLan'),
					('Laos'),
                    ('Campuchia'),
                    ('USA'),
                    ('Canada');
                    
-- INSERT DATA BẢNG Location
INSERT INTO Location 	(street_address, 	postal_code, 	country_id)
	VALUES				('Vong',			'663144',			1),
						('Giai Phong',		'221199',			3),
                        ('Tran Duy Hung',	'837692',			2),
                        ('Hang Muoi',		'526721',			5),
                        ('Hang Ga',			'724156',			1),
                        ('Hang Da',			'934611',			4)
                        ;

-- INSERT DATA BẢNG Employee
INSERT INTO Employee	(full_name,			email,					location_id)
	VALUES				('Joe Biden',		'Biden@gmail.com',		3),
						('Barack Obama',	'nn03@gmail.com',		2),
                        ('Donald Trump',	'Trump@gmail.com',		1),
                        ('Jackma',			'Jackma@gmail.com',		3),
						('Maria Ozawa',		'Ozawa@gmail.com',		5),
                        ('Tra Xanh',		'Xanh@gmail.com',		4)
                        ;
                        

-- 2. Viết lệnh để
-- a) Lấy tất cả các nhân viên thuộc Việt nam

SELECT	E.full_name, C.country_name
FROM	country C 
JOIN	location L ON C.country_id = L.country_id
JOIN	employee E ON L.location_id = E.location_id
WHERE	C.country_name = 'VietNam'
;

-- b) Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"

SELECT	C.country_name
FROM	country C 
JOIN	location L ON C.country_id = L.country_id
JOIN	employee E ON L.location_id = E.location_id
WHERE	E.email = 'nn03@gmail.com'
;

-- c) Thống kê mỗi country, mỗi location có bao nhiêu employee đang làm việc.

SELECT	C.country_name, L.location_id, count(E.employee_id) AS So_Employee
FROM	country C 
JOIN	location L ON C.country_id = L.country_id
JOIN	employee E ON L.location_id = E.location_id
GROUP BY	E.employee_id
;

-- 3. Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 10 employee

DROP TRIGGER IF EXISTS Q3;
DELIMITER $$
CREATE TRIGGER Q3
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
	DECLARE	NV INT;
    DECLARE	CN NVARCHAR (50);
		SELECT	C.country_name, Count(E.employee_id) AS So_NV INTO CN, NV
        FROM	country C 
		JOIN	location L ON C.country_id = L.country_id
		JOIN	employee E ON L.location_id = E.location_id
        GROUP BY	C.country_name
        HAVING	So_NV > '10';
	IF NV  > 10
    THEN
	SIGNAL SQLSTATE '45000'
    Set MESSAGE_TEXT = ' Mỗi quốc gia chỉ có tối đa 10 Employee';
	END IF;
END$$
DELIMITER ;

INSERT INTO Employee	(full_name,					email,						location_id)
VALUES					('Mark Zuckerberg',			'Zuckerberg@gmail.com',			1),
						('Mark Zuckerberg 1',		'Zuckerber1g@gmail.com',		1),
						('Mark Zuckerberg 2',		'Zuckerber2g@gmail.com',		1),
						('Mark Zuckerberg 3',		'Zuckerber3g@gmail.com',		1),
						('Mark Zuckerberg 4',		'Zuckerber4g@gmail.com',		1),
						('Mark Zuckerberg 5',		'Zuckerber5g@gmail.com',		1),
						('Mark Zuckerberg 6',		'Zuckerber6g@gmail.com',		1),
						('Mark Zuckerberg 7',		'Zuckerber7g@gmail.com',		1),
						('Mark Zuckerberg 8',		'Zuckerber8g@gmail.com',		1),
						('Mark Zuckerberg 9',		'Zuckerber9g@gmail.com',		1),
						('Mark Zuckerberg 10',		'Zuckerber10g@gmail.com',		1),
						('Mark Zuckerberg 11',		'Zuckerber11g@gmail.com',		1)
						;


-- 4. Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở
-- location đó sẽ có location_id = null


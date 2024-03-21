CREATE DATABASE NendoroidStore

USE NendoroidStore
--User
CREATE TABLE tbl_User(
	id nvarchar(10) PRIMARY KEY NOT NULL,
	username nvarchar(50) NOT NULL,
	password nvarchar(20) NOT NULL,
	role int NOT NULL
)

INSERT tbl_User VALUES (N'A001',N'raidenshogun',N'raidenei',0)
INSERT tbl_User VALUES (N'C001',N'ganyu',N'kanu',1)
INSERT tbl_User VALUES (N'C002',N'navia',N'spinadirosula',1)

SELECT * FROM tbl_User

--Bank
CREATE TABLE tbl_Bank(
	id nvarchar(10) PRIMARY KEY NOT NULL,
	bank_name nvarchar(100),
	balance float,
	username nvarchar(50),
	password nvarchar(50),
)

INSERT tbl_Bank VALUES (N'B001', N'TP Bank', 20000, N'navia', N'1608')
INSERT tbl_Bank VALUES (N'B002', N'Liyue Bank', 20000, N'ganyu', N'0212')

SELECT * FROM tbl_Bank WHERE id LIKE 'B002'

--Customer
CREATE TABLE tbl_Customer(
	id nvarchar(10) PRIMARY KEY NOT NULL,
	fullname nvarchar(50),
	avatar nvarchar(500),
	phone nvarchar(20),
	address nvarchar(200),
	userID nvarchar(10) FOREIGN KEY REFERENCES tbl_User(id),
	bankID nvarchar(10) FOREIGN KEY REFERENCES tbl_Bank(id)
)

INSERT tbl_Customer VALUES 
(N'N001',N'Ganyu',
N'https://static.wikia.nocookie.net/gensin-impact/images/5/5a/Icon_Emoji_Paimon%27s_Paintings_04_Ganyu_6.png',
N'0123456789', N'Liyue', N'C001', N'B002')

INSERT tbl_Customer VALUES 
(N'N002',N'Navia',
N'https://static.wikia.nocookie.net/gensin-impact/images/2/2c/Icon_Emoji_Paimon%27s_Paintings_29_Navia_2.png',
N'0123456789', N'Fontaine', N'C002', N'B001')

SELECT * FROM tbl_Customer

--Admin
CREATE TABLE tbl_Admin(
	id nvarchar(10) PRIMARY KEY NOT NULL,
	fullname nvarchar(50),
	avatar nvarchar(500),
	userID nvarchar(10) FOREIGN KEY REFERENCES tbl_User(id)
)

INSERT tbl_Admin VALUES 
(N'M001',N'Raiden Shogun', N'https://static.wikia.nocookie.net/gensin-impact/images/2/2e/Icon_Emoji_Paimon%27s_Paintings_09_Raiden_Shogun_4.png',N'A001')

SELECT * FROM tbl_Admin

--Product
CREATE TABLE tbl_Product(
	id int PRIMARY KEY NOT NULL,
	name nvarchar(100),
	image nvarchar(1000),
	type nvarchar(50),
	description nvarchar(1000),
	color nvarchar(20),
	quantity int,
	price float,
	open_day nvarchar(20),
	closed_day nvarchar(20),
	isSale int
)

INSERT tbl_Product VALUES 
(2204, 
N'Nendoroid Amane Kanata', 
N'https://images.goodsmile.info/cgm/images/product/20231024/15127/122584/large/30aeb337bf461f7b16aae3c54c1954c6.jpg', 
N'Pre-order', 
N'From the popular VTuber group "hololive production" comes a Nendoroid of hololive 4th Generation VTuber Amane Kanata!',
N'#77d9ff',
50,
6900,
N'2023-10-27',
N'2024-01-25',
1)

INSERT tbl_Product VALUES 
(2118, 
N'Mori Calliope', 
N'https://images.goodsmile.info/cgm/images/product/20230419/14285/114506/large/706f8a1d693e9de235538041d3aefc05.jpg', 
N'Pre-order', 
N'From the popular virtual YouTube group "hololive production" comes a Nendoroid of hololive English -Myth- VTuber Mori Calliope!',
N'#C90D40',
50,
6500,
N'2023-04-28',
N'2024-06-08',
1)

INSERT tbl_Product VALUES 
(2240, 
N'Yuzuki Choco', 
N'https://images.goodsmile.info/cgm/images/product/20230823/14851/119936/large/d03789f8e92a30339df3f6e7c66c306d.jpg', 
N'Pre-order', 
N'From the popular VTuber group "hololive production" comes a Nendoroid of hololive 2nd Generation VTuber Yuzuki Choco!',
N'#ff6e9b',
50,
7900,
N'2023-09-05',
N'2023-10-19',
1)

INSERT tbl_Product VALUES 
(2350, 
N'Ninomae Ina’nis', 
N'https://images.goodsmile.info/cgm/images/product/20231212/15353/124717/large/71dea18c83e8a8677323c672aba2d5ef.jpg', 
N'Pre-order', 
N'From the popular virtual YouTube group "hololive production" comes a Nendoroid of hololive English -Myth- VTuber Ninomae Ina’nis!',
N'#574967',
50,
6900,
N'2023-12-15',
N'2024-01-25',
1)

SELECT * FROM tbl_Product

CREATE TABLE tbl_Order(
	id int IDENTITY PRIMARY KEY NOT NULL,
	orderDate nvarchar(20),
	status nvarchar(20),
	phone nvarchar(20),
	address nvarchar(200),
	customerID nvarchar(10) FOREIGN KEY REFERENCES tbl_Customer(id)
)

SELECT * FROM tbl_Order

DELETE FROM tbl_Order

CREATE TABLE tbl_OrderDetails(
	id int IDENTITY PRIMARY KEY NOT NULL,
	orderID int,
	productID int,
	price float,
	quantity int,
	FOREIGN KEY (orderID) REFERENCES tbl_Order(id),
	FOREIGN KEY (productID) REFERENCES tbl_Product(id)
)

CREATE TABLE tbl_Cart(
	cartID int IDENTITY PRIMARY KEY NOT NULL,
	customerID nvarchar(10) FOREIGN KEY REFERENCES tbl_Customer(id),
	productID int FOREIGN KEY REFERENCES tbl_Product(id),
	quantity int
)

SELECT * FROM tbl_Cart


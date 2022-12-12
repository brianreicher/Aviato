/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE `Aviato`;
USE `Aviato`;

GRANT ALL PRIVILEGES ON Aviato.* TO 'webapp'@'%';

FLUSH PRIVILEGES;


DROP TABLE IF EXISTS `user`;

CREATE TABLE `user`(
    `userID` varchar(50) NOT NULL,
    `gender` varchar(50) NOT NULL,
    `birthdate` varchar(50) NOT NULL,
    `firstName` varchar(50) NOT NULL,
    `lastName` varchar(50) NOT NULL,
    `phone` varchar(50) NOT NULL,
    `email` varchar(50) NOT NULL,
    `permissions` varchar(50) NOT NULL,
    `buyerID` varchar(50) NOT NULL,
    `sellerID` varchar(50) NOT NULL,
    PRIMARY KEY (`userID`),
    CONSTRAINT `user_ibfk_1` FOREIGN KEY (`buyerID`) REFERENCES `buyer` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `user_ibfk_2` FOREIGN KEY (`sellerID`) REFERENCES `seller` (`sellerID`)ON UPDATE cascade ON DELETE restrict

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `buyer`(
    `buyerID` varchar(50) NOT NULL,
    PRIMARY KEY (`buyerID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `seller`(
    `sellerID` varchar(50) NOT NULL,
    PRIMARY KEY (`sellerID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `payment`(
    `paymentNum` varchar(50) NOT NULL,
    `bankaccount_ID` varchar(50) NOT NULL,
    `amount` varchar(50) NOT NULL,
    `types` VARCHAR(255) NOT NULL,
    `admin_message` VARCHAR(255) NOT NULL,
    `sellerID` varchar(50) NOT NULL,
    `buyerID` varchar(50) NOT NULL,
    `bidID` varchar(50) NOT NULL,
    PRIMARY KEY (`paymentNum`),
    KEY `bankaccount_ID` (`bankaccount_ID`),
    CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`bidID`) REFERENCES `bid` (`bidID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`buyerID`) REFERENCES `buyer` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`sellerID`) REFERENCES `seller` (`sellerID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `bank`(
    `bankID` varchar(50) NOT NULL,
    `location` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `paymentNum` varchar(50) NOT NULL,
    `bankaccount_ID` varchar(50),
    PRIMARY KEY (`bankID`),
    CONSTRAINT `bank_ibfk_1` FOREIGN KEY (`paymentNum`) REFERENCES `payment` (`paymentNum`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `bank_ibfk_2` FOREIGN KEY (`bankaccount_ID`) REFERENCES `payment` (`bankaccount_ID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `bid`(
    `bidID` varchar(50) NOT NULL,
    `submit` boolean NOT NULL,
    `expirationDate` DATETIME NOT NULL,
    `status` VARCHAR(255) NOT NULL,
    `buyerID` varchar(50) NOT NULL,
    `trade_ID` varchar(50) NOT NULL,
    PRIMARY KEY (`bidID`),
    CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`buyerID`) REFERENCES `buyerID` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`trade_ID`) REFERENCES `trade` (`trade_ID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `trade`(
    `trade_ID` varchar(50) NOT NULL,
    `date` DATETIME NOT NULL,
    `price` VARCHAR(255) NOT NULL,
    `buyerID` varchar(50) NOT NULL,
    `sellerID` varchar(50) NOT NULL,
    PRIMARY KEY (`trade_ID`),
    CONSTRAINT `trade_ibfk_1` FOREIGN KEY (`buyerID`) REFERENCES `buyer` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `trade_ibfk_2` FOREIGN KEY (`sellerID`) REFERENCES `seller` (`sellerID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `direct_buy`(
    `trade_ID` varchar(50) NOT NULL,
    `buyerID` varchar(50) NOT NULL,
    CONSTRAINT `direct_buy_ibfk_1` FOREIGN KEY (`trade_ID`) REFERENCES `trade` (`trade_ID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `direct_buy_ibfk_2` FOREIGN KEY (`buyerID`) REFERENCES `buyer` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    autobuy_price varchar(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `flights`(
    `tripID` varchar(50) NOT NULL,
    `for_sale` BOOLEAN NOT NULL,
    `datePosted` DATETIME NOT NULL,
    `airline_message` VARCHAR(255) NOT NULL,
    `special_requests` VARCHAR(255) NOT NULL,
    `bidID` varchar(50) NOT NULL,
    `trade_ID` varchar(50) NOT NULL,
    `buyerID` varchar(50) NOT NULL,
    `portfolioID` varchar(50) NOT NULL,
    `adminID` varchar(50) NOT NULL,
    `date_purchased` DATETIME NOT NULL,
    `airline` VARCHAR(255) NOT NULL,
    `is_layover` boolean,
    `depart_airport` VARCHAR(255) NOT NULL,
    `arrive_airport` VARCHAR(255) NOT NULL,
    `purchased_price` VARCHAR(255) NOT NULL,
    `current_price` VARCHAR(255) NOT NULL,
    `asking_price` VARCHAR(255) NOT NULL,
    `takeoff` VARCHAR(255) NOT NULL,
    `land` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`tripID`),
    CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`bidID`) REFERENCES `bid` (`bidID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`trade_ID`) REFERENCES `trade` (`trade_ID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`buyerID`) REFERENCES `buyer` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_4` FOREIGN KEY (`portfolioID`) REFERENCES `flights_portfolio` (`portfolioID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_5` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_6` FOREIGN KEY (`trade_ID`) REFERENCES `trade` (`trade_ID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `flight_portfolio` (
    `portfolioID` varchar(50) NOT NULL,
    `portfolio_name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`portfolioID`),
    `adminID` varchar(50) NOT NULL,
    `userID` varchar(50) NOT NULL,
    CONSTRAINT `flight_portfolio_ibfk_1` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flight_portfolio_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `user_login`(
    `loginID` varchar(50) NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `userID` varchar(50) NOT NULL,
    PRIMARY KEY (`loginID`),
    CONSTRAINT `user_login_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `admin_login`(
    `loginID` varchar(50) NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`loginID`),
    `adminID` varchar(50) NOT NULL,
    CONSTRAINT `admin_login_ibfk_1` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `admin`(
    `adminID` varchar(50) NOT NULL,
    `birthdate` VARCHAR(255) NOT NULL,
    `firstName` VARCHAR(255) NOT NULL,
    `lastName` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `permissions` VARCHAR(255) NOT NULL,
    `gender` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`adminID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `customer_support`(
    `complaintID` varchar(50) NOT NULL,
    `message` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`complaintID`),
    `userID` varchar(50) NOT NULL,
    `adminID` varchar(50) NOT NULL,
    CONSTRAINT `customer_support_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `customer_support_ibfk_2` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;






insert into buyer (buyerID) values (1);
insert into buyer (buyerID) values (2);
insert into buyer (buyerID) values (3);
insert into buyer (buyerID) values (4);
insert into buyer (buyerID) values (5);
insert into buyer (buyerID) values (6);
insert into buyer (buyerID) values (7);
insert into buyer (buyerID) values (8);
insert into buyer (buyerID) values (9);
insert into buyer (buyerID) values (10);
insert into buyer (buyerID) values (11);
insert into buyer (buyerID) values (12);
insert into buyer (buyerID) values (13);
insert into buyer (buyerID) values (14);
insert into buyer (buyerID) values (15);
insert into buyer (buyerID) values (16);
insert into buyer (buyerID) values (17);
insert into buyer (buyerID) values (18);
insert into buyer (buyerID) values (19);
insert into buyer (buyerID) values (20);
insert into buyer (buyerID) values (21);
insert into buyer (buyerID) values (22);
insert into buyer (buyerID) values (23);
insert into buyer (buyerID) values (24);
insert into buyer (buyerID) values (25);
insert into buyer (buyerID) values (26);
insert into buyer (buyerID) values (27);
insert into buyer (buyerID) values (28);
insert into buyer (buyerID) values (29);
insert into buyer (buyerID) values (30);
insert into buyer (buyerID) values (31);
insert into buyer (buyerID) values (32);
insert into buyer (buyerID) values (33);
insert into buyer (buyerID) values (34);
insert into buyer (buyerID) values (35);
insert into buyer (buyerID) values (36);
insert into buyer (buyerID) values (37);
insert into buyer (buyerID) values (38);
insert into buyer (buyerID) values (39);
insert into buyer (buyerID) values (40);
insert into buyer (buyerID) values (41);
insert into buyer (buyerID) values (42);
insert into buyer (buyerID) values (43);
insert into buyer (buyerID) values (44);
insert into buyer (buyerID) values (45);
insert into buyer (buyerID) values (46);
insert into buyer (buyerID) values (47);
insert into buyer (buyerID) values (48);
insert into buyer (buyerID) values (49);
insert into buyer (buyerID) values (50);
insert into buyer (buyerID) values (51);
insert into buyer (buyerID) values (52);
insert into buyer (buyerID) values (53);
insert into buyer (buyerID) values (54);
insert into buyer (buyerID) values (55);
insert into buyer (buyerID) values (56);
insert into buyer (buyerID) values (57);
insert into buyer (buyerID) values (58);
insert into buyer (buyerID) values (59);
insert into buyer (buyerID) values (60);
insert into buyer (buyerID) values (61);
insert into buyer (buyerID) values (62);
insert into buyer (buyerID) values (63);
insert into buyer (buyerID) values (64);
insert into buyer (buyerID) values (65);
insert into buyer (buyerID) values (66);
insert into buyer (buyerID) values (67);
insert into buyer (buyerID) values (68);
insert into buyer (buyerID) values (69);
insert into buyer (buyerID) values (70);
insert into buyer (buyerID) values (71);
insert into buyer (buyerID) values (72);
insert into buyer (buyerID) values (73);
insert into buyer (buyerID) values (74);
insert into buyer (buyerID) values (75);
insert into buyer (buyerID) values (76);
insert into buyer (buyerID) values (77);
insert into buyer (buyerID) values (78);
insert into buyer (buyerID) values (79);
insert into buyer (buyerID) values (80);
insert into buyer (buyerID) values (81);
insert into buyer (buyerID) values (82);
insert into buyer (buyerID) values (83);
insert into buyer (buyerID) values (84);
insert into buyer (buyerID) values (85);
insert into buyer (buyerID) values (86);
insert into buyer (buyerID) values (87);
insert into buyer (buyerID) values (88);
insert into buyer (buyerID) values (89);
insert into buyer (buyerID) values (90);
insert into buyer (buyerID) values (91);
insert into buyer (buyerID) values (92);
insert into buyer (buyerID) values (93);
insert into buyer (buyerID) values (94);
insert into buyer (buyerID) values (95);
insert into buyer (buyerID) values (96);
insert into buyer (buyerID) values (97);
insert into buyer (buyerID) values (98);
insert into buyer (buyerID) values (99);
insert into buyer (buyerID) values (100);

insert into seller (sellerID) values (1);
insert into seller (sellerID) values (2);
insert into seller (sellerID) values (3);
insert into seller (sellerID) values (4);
insert into seller (sellerID) values (5);
insert into seller (sellerID) values (6);
insert into seller (sellerID) values (7);
insert into seller (sellerID) values (8);
insert into seller (sellerID) values (9);
insert into seller (sellerID) values (10);
insert into seller (sellerID) values (11);
insert into seller (sellerID) values (12);
insert into seller (sellerID) values (13);
insert into seller (sellerID) values (14);
insert into seller (sellerID) values (15);
insert into seller (sellerID) values (16);
insert into seller (sellerID) values (17);
insert into seller (sellerID) values (18);
insert into seller (sellerID) values (19);
insert into seller (sellerID) values (20);
insert into seller (sellerID) values (21);
insert into seller (sellerID) values (22);
insert into seller (sellerID) values (23);
insert into seller (sellerID) values (24);
insert into seller (sellerID) values (25);
insert into seller (sellerID) values (26);
insert into seller (sellerID) values (27);
insert into seller (sellerID) values (28);
insert into seller (sellerID) values (29);
insert into seller (sellerID) values (30);
insert into seller (sellerID) values (31);
insert into seller (sellerID) values (32);
insert into seller (sellerID) values (33);
insert into seller (sellerID) values (34);
insert into seller (sellerID) values (35);
insert into seller (sellerID) values (36);
insert into seller (sellerID) values (37);
insert into seller (sellerID) values (38);
insert into seller (sellerID) values (39);
insert into seller (sellerID) values (40);
insert into seller (sellerID) values (41);
insert into seller (sellerID) values (42);
insert into seller (sellerID) values (43);
insert into seller (sellerID) values (44);
insert into seller (sellerID) values (45);
insert into seller (sellerID) values (46);
insert into seller (sellerID) values (47);
insert into seller (sellerID) values (48);
insert into seller (sellerID) values (49);
insert into seller (sellerID) values (50);
insert into seller (sellerID) values (51);
insert into seller (sellerID) values (52);
insert into seller (sellerID) values (53);
insert into seller (sellerID) values (54);
insert into seller (sellerID) values (55);
insert into seller (sellerID) values (56);
insert into seller (sellerID) values (57);
insert into seller (sellerID) values (58);
insert into seller (sellerID) values (59);
insert into seller (sellerID) values (60);
insert into seller (sellerID) values (61);
insert into seller (sellerID) values (62);
insert into seller (sellerID) values (63);
insert into seller (sellerID) values (64);
insert into seller (sellerID) values (65);
insert into seller (sellerID) values (66);
insert into seller (sellerID) values (67);
insert into seller (sellerID) values (68);
insert into seller (sellerID) values (69);
insert into seller (sellerID) values (70);
insert into seller (sellerID) values (71);
insert into seller (sellerID) values (72);
insert into seller (sellerID) values (73);
insert into seller (sellerID) values (74);
insert into seller (sellerID) values (75);
insert into seller (sellerID) values (76);
insert into seller (sellerID) values (77);
insert into seller (sellerID) values (78);
insert into seller (sellerID) values (79);
insert into seller (sellerID) values (80);
insert into seller (sellerID) values (81);
insert into seller (sellerID) values (82);
insert into seller (sellerID) values (83);
insert into seller (sellerID) values (84);
insert into seller (sellerID) values (85);
insert into seller (sellerID) values (86);
insert into seller (sellerID) values (87);
insert into seller (sellerID) values (88);
insert into seller (sellerID) values (89);
insert into seller (sellerID) values (90);
insert into seller (sellerID) values (91);
insert into seller (sellerID) values (92);
insert into seller (sellerID) values (93);
insert into seller (sellerID) values (94);
insert into seller (sellerID) values (95);
insert into seller (sellerID) values (96);
insert into seller (sellerID) values (97);
insert into seller (sellerID) values (98);
insert into seller (sellerID) values (99);
insert into seller (sellerID) values (100);


insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (1, 'Male', '2022-10-26 11:10:04', 'Ellery', 'Folks', '762-368-8740', 'efolks0@java.com', '79e83721fc33e603aeb9addcfe9df054827fc483da298469e574ebad9c3f2d64', '1', '1');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (2, 'Female', '2022-10-07 03:56:21', 'Joane', 'Huttley', '560-595-1858', 'jhuttley1@cbsnews.com', '1fa5c48e5772c291ebe4b771d9025d9319473a3bf1c2da37ca4f0131ad85d440', '2', '2');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (3, 'Genderfluid', '2022-07-18 07:27:38', 'Loralie', 'Redhills', '320-786-2287', 'lredhills2@artisteer.com', 'ba955164b25292774a28f863d86d0e4853256defac6f390f3cc6d75db3fe5769', '3', '3');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (4, 'Female', '2022-10-29 21:20:35', 'Kandace', 'Mapson', '449-626-9993', 'kmapson3@geocities.jp', 'dc05b7f413a82b0d15a9abe4e9f163ea5fb43523ad9dda5bc650b487b8d7dac1', '4', '4');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (5, 'Female', '2022-11-20 13:33:33', 'Kelley', 'Cowgill', '742-228-2676', 'kcowgill4@networksolutions.com', 'dc24340dc71b7a547ac3fc88b4a21505b62de162ee85a1c5137b38098c73ab1f', '5', '5');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (6, 'Female', '2022-05-08 07:26:58', 'Liz', 'Antonsen', '387-521-4481', 'lantonsen5@last.fm', '8af6b24689565df0b3636003c7fef567c8270830fe56b3a452322499f71a8fbe', '6', '6');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (7, 'Male', '2022-06-27 06:54:11', 'Hurleigh', 'Ludlam', '928-429-0996', 'hludlam6@arizona.edu', 'eec2363c73a096dce6dabbcc18894a90e90bc4403f875e7087a930b131ae5fe5', '7', '7');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (8, 'Male', '2022-09-24 01:22:37', 'Lawrence', 'Lelande', '995-564-5566', 'llelande7@reverbnation.com', '29e11bdcf564df95ee23000c4025cb56a47d66a98a451c072060ada8fd47404b', '8', '8');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (9, 'Agender', '2022-01-08 07:05:04', 'Winifred', 'Youson', '271-264-1887', 'wyouson8@icq.com', '8ee5476bcff4a1268fb7fc2482b220800bcd3179db936791322253cfb323a786', '9', '9');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (10, 'Male', '2021-12-07 08:37:09', 'Paulo', 'Morey', '475-993-9620', 'pmorey9@drupal.org', 'db3a2be1fc8841011c0f4bb13c296ef31d6a923174d81cc83072deb97d96878d', '10', '10');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (11, 'Female', '2022-03-16 16:21:36', 'Muire', 'Santori', '596-922-2238', 'msantoria@mac.com', '82588d979b212151fd4ae63191bfbd997cb4870964aa1af3eb872fe118ed39e6', '11', '11');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (12, 'Female', '2022-04-04 11:37:03', 'Alysia', 'Defty', '458-190-4548', 'adeftyb@state.tx.us', '610ee30fffa4288177e96f15cae1e477a6411991ec5d181e24ab652fa3130011', '12', '12');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (13, 'Male', '2022-06-18 15:20:27', 'Quinn', 'Dorward', '309-227-4838', 'qdorwardc@berkeley.edu', '21917d3d678428ff036849b5e2248e2360472f179710449460d91b1ab72e7a46', '13', '13');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (14, 'Female', '2022-07-29 02:47:37', 'Bertha', 'Fomichkin', '337-640-6722', 'bfomichkind@weebly.com', 'a8656b1296d6bbcd28e7a04684ddd35b1e49259fc0d417b18620bb157e12b8fe', '14', '14');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (15, 'Male', '2022-04-20 15:10:11', 'Guntar', 'Kingsnoad', '671-632-8507', 'gkingsnoade@123-reg.co.uk', '85d13796f43d68a589ad6dca67f4295e87008d692eae412fdd170307da1490fc', '15', '15');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (16, 'Male', '2022-07-20 02:53:24', 'Rickie', 'Hembery', '230-680-3423', 'rhemberyf@salon.com', '55110e603bdeb68fa0d559d98a20d06e6862bc2ebdb856b9ca3e2348c3454272', '16', '16');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (17, 'Female', '2022-04-10 06:35:14', 'Atlanta', 'Porcas', '756-923-2758', 'aporcasg@behance.net', 'b21d30e7b2fdbbc322bc97c25ba0d9662ff2281de81a04be8b58ab9bd08b7983', '17', '17');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (18, 'Male', '2022-07-14 09:23:58', 'Stavro', 'Railton', '547-745-8286', 'srailtonh@scribd.com', '859d698c1e33072f238c8ceb51fe28935be42c2be743f8620462fa6b50264c2e', '18', '18');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (19, 'Male', '2022-10-29 01:29:25', 'Miller', 'McShee', '555-374-4772', 'mmcsheei@nationalgeographic.com', '33e46f84236ce11bc781c27775f1eea37b76e96d3cdd8258003c8e7c22cf193f', '19', '19');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (20, 'Male', '2022-10-16 14:59:35', 'Robers', 'Dimsdale', '686-288-2515', 'rdimsdalej@whitehouse.gov', 'ed61ee39578690c2a97c846767f781b0607c3e78cd907f3fa85015ba14013ba9', '20', '20');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (21, 'Male', '2022-02-24 19:11:47', 'Ikey', 'Milley', '982-230-2324', 'imilleyk@google.com.hk', '67f0a3484629b6e3bcc251a141106b93afe631641a0eb91fcd485b74238fb929', '21', '21');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (22, 'Male', '2021-12-30 01:58:25', 'David', 'Lathy', '515-973-9831', 'dlathyl@pen.io', '373a7b36a867261f3eefd7228cb62769a11f4b093d66a3cd0c7bf9c6c6768c76', '22', '22');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (23, 'Female', '2022-11-08 08:29:06', 'L;urette', 'Mallender', '290-233-7879', 'lmallenderm@elegantthemes.com', 'e7dd22e04ade5923c3d5927739ff0f06c1a1258ba2d80bcc276042e2bff1c321', '23', '23');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (24, 'Female', '2022-07-31 11:58:23', 'Sybila', 'Matherson', '542-400-7920', 'smathersonn@acquirethisname.com', '1b55b39fd40d4515fcc3876c7b589ee715d41370aa98de07e4c8d33fdc84e184', '24', '24');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (25, 'Male', '2021-12-12 09:58:23', 'Pembroke', 'Huxham', '730-470-4592', 'phuxhamo@blogs.com', '97251b86df82f22304b1b84476ca80764cc469ffb2cc80317ea2b874f43bc8c7', '25', '25');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (26, 'Female', '2022-09-21 11:10:53', 'Darby', 'Fansy', '114-204-6362', 'dfansyp@cocolog-nifty.com', '859c413486c911453dfae6b4bcc199e11462fa09475217f958aada8cf1c7f7ac', '26', '26');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (27, 'Male', '2022-11-07 01:43:53', 'Hewe', 'Jeandot', '261-629-0361', 'hjeandotq@biglobe.ne.jp', 'd3d5d44927a0d91dae26f5de127fb3759085f99969f23b7e155eaabe618e2e14', '27', '27');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (28, 'Female', '2021-12-23 11:42:07', 'Noami', 'Caldwell', '723-634-5708', 'ncaldwellr@ebay.co.uk', '6ec21d55ceff8c691fd61dda408585ae0c87d3d83258d39e9aeb743e00eb8580', '28', '28');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (29, 'Male', '2022-04-08 03:31:50', 'Faulkner', 'Casiero', '963-879-7365', 'fcasieros@google.it', '328f23087a5dda7fe73f4dfa56a93baeddd2816e1e0e13efee2f0cf4bb975677', '29', '29');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (30, 'Female', '2022-03-25 01:18:58', 'Delphinia', 'McCarron', '393-149-7465', 'dmccarront@blogtalkradio.com', 'b07fc70f3f28010fd3f4ef0bf82aee5678413f52c34d39e3e66e0fd291d15f28', '30', '30');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (31, 'Genderqueer', '2022-09-25 03:23:47', 'Nicky', 'O''Hearn', '101-643-4212', 'nohearnu@stumbleupon.com', '4f8dd7cd58ad47e50da6403733fba97fdc6a0ee439b7ecc007a989f7deb0a2c1', '31', '31');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (32, 'Male', '2022-08-22 07:30:20', 'Saleem', 'Billson', '760-953-3425', 'sbillsonv@symantec.com', 'cb39fa5537260f749bb3a87dafed7679577f30b0cca36c5606a92b4c4e2582e7', '32', '32');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (33, 'Male', '2021-12-24 08:23:22', 'Nial', 'Jamson', '255-902-0486', 'njamsonw@icio.us', '07158707156ea8252fc3dab2e6b52b1b8f2e57d32a32ac23a2223b1c360ab0fd', '33', '33');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (34, 'Male', '2022-09-19 20:06:16', 'Delainey', 'Streetley', '474-947-2167', 'dstreetleyx@sogou.com', 'bdba4a2248e1a32d1a1ddf20aae19a3d87e2c655d5f3dd23a55f30fdc7a1d012', '34', '34');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (35, 'Female', '2022-11-25 17:33:33', 'Kipp', 'Osgordby', '930-145-7228', 'kosgordbyy@wikia.com', 'd22c8d83dcd56ebdbf3669b38f072025c77534fe99181118232368acee386e91', '35', '35');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (36, 'Female', '2021-12-07 21:01:25', 'Odilia', 'Pinhorn', '644-901-4515', 'opinhornz@com.com', 'cc225a790c4b521003b5b3fab7849087e14a77fe83c05d7fd38f9159181b4143', '36', '36');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (37, 'Male', '2022-05-01 16:18:46', 'Claire', 'Denniss', '788-628-3691', 'cdenniss10@ebay.com', '2ba3ea2aa70ae880923351ae102c1d168363ff8c9d8180b3bb44df0d5a6d1950', '37', '37');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (38, 'Polygender', '2022-11-08 20:43:04', 'Carlynne', 'Ancliffe', '871-354-8334', 'cancliffe11@alexa.com', '343012d3210aea9208ed9c3bd2ca00b735007ec84f4850770439066db7addca9', '38', '38');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (39, 'Male', '2022-11-09 14:12:45', 'Hadrian', 'Guitte', '780-719-0731', 'hguitte12@moonfruit.com', '31f3a7e3be235bad9a52d37cb297478200b33bc90a6c6a88e5f801a4b3f3e2e5', '39', '39');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (40, 'Female', '2021-12-25 01:44:29', 'Bee', 'Dibdin', '862-336-2520', 'bdibdin13@ft.com', 'a7662046fbc6c6b260a7e30964b3ac3de4221624adbbb6c13b3ce1c1af1d830a', '40', '40');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (41, 'Male', '2022-10-25 06:36:54', 'Ignace', 'Curzon', '367-284-2619', 'icurzon14@dedecms.com', 'b6f2242ca3cebe4d9b98b7a395fe3f26308112dd0590b22814541455f2755197', '41', '41');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (42, 'Non-binary', '2022-11-23 03:07:49', 'Garnet', 'McCobb', '110-360-7606', 'gmccobb15@sun.com', '652c82b73cca8c095159f3c8ddb7ff6bcea6e43a7dc327c708af7aa8cbc7244c', '42', '42');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (43, 'Female', '2022-08-03 03:37:23', 'Brook', 'Worthing', '913-338-5062', 'bworthing16@symantec.com', 'df067ae4490436b32ade1ba413092cace6b8baa5dba4ba8163998ca5e08b9f58', '43', '43');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (44, 'Male', '2022-07-25 16:26:24', 'Elsworth', 'Gilbard', '244-275-5865', 'egilbard17@indiatimes.com', 'fa5f903327709fb340e4cbd696f3ff7417f3d9101eaf1b02dd4fc348cfddd1ea', '44', '44');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (45, 'Female', '2022-09-25 09:19:31', 'Dacia', 'Rishbrook', '668-989-1638', 'drishbrook18@amazon.co.uk', '39149f9a740c6c741820eaea482af1927fe0caebf6efdb0d4091949bf5f605b8', '45', '45');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (46, 'Female', '2022-11-10 13:37:11', 'Korrie', 'Duncklee', '560-465-5110', 'kduncklee19@bloomberg.com', '90bdd47f2902fbedb099eee06eb7c14c393bc1090aa83b6ef54fb2021aed5c3b', '46', '46');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (47, 'Male', '2021-12-13 01:03:12', 'Renaud', 'Grim', '858-625-8991', 'rgrim1a@skyrock.com', '7c18348f45d8be5ddac050837aba8587f8240aaa5db86b72bb554cf28765c968', '47', '47');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (48, 'Female', '2022-08-21 21:17:08', 'Eleanore', 'Thecham', '144-705-6690', 'ethecham1b@ucoz.ru', '87aa3e7c40a71e0c96677e7d15b20a9e814166e18b323f488b6047ace2c98a1e', '48', '48');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (49, 'Male', '2022-07-10 04:37:25', 'Iorgos', 'Lethbrig', '990-516-3387', 'ilethbrig1c@fastcompany.com', '2c163a4d5786ba384cac3818cf1766a29158c0958c6e8da949decce7fa2dc62a', '49', '49');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (50, 'Female', '2022-10-29 04:59:10', 'Polly', 'Radoux', '590-778-7200', 'pradoux1d@mapy.cz', '6c3a3e539bd2dd7da93f1be95396bcec7466d7023e5a9ae7dd28957481c6e0a7', '50', '50');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (51, 'Male', '2022-08-31 05:41:36', 'Townsend', 'Tixier', '912-502-8871', 'ttixier1e@addtoany.com', '828648bcb82cf31032b25046f30f624abddf86f291b8e1fb2dbce05dfef670a2', '51', '51');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (52, 'Female', '2022-08-30 05:13:54', 'Jeni', 'Corwin', '240-336-6035', 'jcorwin1f@patch.com', '259a76f26742dc628b241bc8211431fcd431966eb4a01fbd57c4c2d8b54b6a82', '52', '52');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (53, 'Polygender', '2022-03-27 03:26:44', 'Symon', 'Armfirld', '280-394-0761', 'sarmfirld1g@bloglovin.com', 'b523da79c38d723c7d09b0b3205f4c53b30cf468404261758eaa4cc6962501a8', '53', '53');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (54, 'Female', '2022-06-25 04:18:08', 'Linnea', 'Lerven', '718-322-3824', 'llerven1h@google.de', 'c0015fd804bcb7ac08a1cf9d4db1359ec7b6ac5a2f4ab217627c886b5f5a4063', '54', '54');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (55, 'Male', '2022-09-11 01:04:35', 'Xever', 'Wigan', '189-928-7271', 'xwigan1i@upenn.edu', '7b185ab4c6fa8878476e487ef65219a1e0b9be92b5e8ade4b7c3cb1c1c5b12ed', '55', '55');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (56, 'Male', '2021-12-31 06:31:10', 'Christoforo', 'Pollicatt', '872-695-1873', 'cpollicatt1j@sakura.ne.jp', '9464b6bb0642a2b1bb54e6a86dfe1c665f637d98f407ec3021ac12d458329c21', '56', '56');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (57, 'Female', '2022-03-27 08:36:01', 'Sharity', 'McCutheon', '779-253-7555', 'smccutheon1k@tuttocitta.it', '0ab94ebe565a08378a762d9513871e175251396d163b97728ab493e3ab3a8f8d', '57', '57');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (58, 'Female', '2022-07-01 04:51:35', 'Zorah', 'Botha', '169-980-6621', 'zbotha1l@abc.net.au', '35bc8e0ff8d7be4587009f584edbbea0c0f73f2dcb18acd5121dc8e61cc2c8cf', '58', '58');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (59, 'Non-binary', '2022-02-22 20:56:07', 'Sigvard', 'McIlmurray', '628-484-6625', 'smcilmurray1m@rakuten.co.jp', '140d9f53aa3773a714a4f433748bb8511bfb25abfd4d82bb05f18fab3ba7a009', '59', '59');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (60, 'Male', '2022-03-18 00:34:04', 'Jud', 'Sussans', '952-514-0199', 'jsussans1n@sbwire.com', 'e026712c9c951d13895c8332c97557dac56dfb6b8675bef07701447f05f03414', '60', '60');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (61, 'Male', '2022-09-23 06:56:42', 'Bertie', 'Lippett', '389-944-9987', 'blippett1o@yellowbook.com', '0dd3dbae6823230aaba751a060728ac9d590e0aef163493c320d4d03653e2e4e', '61', '61');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (62, 'Male', '2022-01-02 03:01:29', 'Eugene', 'Asipenko', '245-819-6968', 'easipenko1p@blogs.com', '3bc61bb68bdcbe025ef1a93de283edc74866dafd00805e5425d19b20796c5ed6', '62', '62');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (63, 'Polygender', '2022-01-16 19:44:13', 'Janella', 'Carlin', '961-471-3531', 'jcarlin1q@google.cn', '551e7086128f9ab17bffb55d78efd86d7ce816542e77f3f01e7fc812f4adb377', '63', '63');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (64, 'Male', '2021-12-14 16:07:39', 'Finley', 'Abrahami', '376-985-6395', 'fabrahami1r@webeden.co.uk', '1026c36bbf9d53c991a0941753957370ce5a02a32e981aafaa562cc5a610dce8', '64', '64');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (65, 'Female', '2021-12-08 07:47:49', 'Ketti', 'Gazzard', '981-301-1605', 'kgazzard1s@tiny.cc', '03e75c9f5ecf8a8ac1db3905b030ae4d8f09ef873cca16dd43e50c408c750816', '65', '65');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (66, 'Female', '2022-02-06 15:29:23', 'Berget', 'Heaps', '615-704-2948', 'bheaps1t@oracle.com', 'f480e55d7110918c209aa2bb14134f08edd37a80756ecb8997c949234ab93f31', '66', '66');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (67, 'Female', '2022-04-08 02:49:33', 'Pepita', 'Copplestone', '496-230-3003', 'pcopplestone1u@businessweek.com', '518cccfc70744c01869b22f670c76be50ad27377d99893a800dcdeed1ec6ca2a', '67', '67');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (68, 'Male', '2022-02-03 00:33:31', 'Padget', 'Ikin', '732-463-2897', 'pikin1v@theglobeandmail.com', '2a46845f20cebb11e2b6543e2858bd7fd578c4f5f45f572db6e2b6ff305f308e', '68', '68');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (69, 'Female', '2022-09-03 08:24:28', 'Fanechka', 'Northall', '763-108-8945', 'fnorthall1w@google.nl', '862135d9fbece0f8ad50b3ac76bfcbeed9547f110c668a3f18d46ea06b196fe4', '69', '69');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (70, 'Genderqueer', '2021-12-18 06:44:45', 'Stepha', 'Bendon', '738-103-8066', 'sbendon1x@sbwire.com', 'b4e4f3e2491a0decf1b628dbfa5ea8b2939644cb196688331b9e1437ae569905', '70', '70');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (71, 'Male', '2022-03-27 20:23:13', 'Lesley', 'Frayne', '649-220-9987', 'lfrayne1y@friendfeed.com', 'c5d1f4ac9e7eb781fe92e267f9adb5c6e0e786accd3cb9725dce56a22d162f9f', '71', '71');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (72, 'Male', '2022-05-08 08:07:00', 'Prinz', 'Cuppitt', '442-922-2413', 'pcuppitt1z@chronoengine.com', 'd63c7493a3f10f0d202507185a64f459eef044545f57b825af170f66a2f7dabc', '72', '72');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (73, 'Male', '2022-04-14 14:05:32', 'Terry', 'McConigal', '653-751-0596', 'tmcconigal20@wisc.edu', 'd5da87c9ae9c09358fd8420c44864f01ef1834652f9ff062c96627242d39c0c0', '73', '73');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (74, 'Male', '2022-07-31 10:28:04', 'Warren', 'Kordova', '541-811-2921', 'wkordova21@globo.com', 'c398ac9b2d4ffc51a2134951d3adc7ddb6163a04b8ddc58e254f48d00ac06d3b', '74', '74');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (75, 'Female', '2022-05-28 23:52:58', 'Vickie', 'O''Kennavain', '573-918-7782', 'vokennavain22@sogou.com', 'f1867231e395616c5385421161271af6d768b465c14fdafc6568cfef34b4d749', '75', '75');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (76, 'Female', '2021-12-16 21:51:45', 'Orella', 'Snowdon', '769-476-2010', 'osnowdon23@google.fr', '2fe0c6df4dc460da26fc2cb55e78a93c5082b879ed8958406ee020a1737656bc', '76', '76');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (77, 'Male', '2022-03-05 23:56:16', 'Temple', 'Chivrall', '496-972-2967', 'tchivrall24@tuttocitta.it', '2585fa3f6087cd546def09b04edb8a9742c302ac269c6345776dd9e72587c6bd', '77', '77');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (78, 'Female', '2022-03-28 00:17:33', 'Angelika', 'McFeate', '568-908-3423', 'amcfeate25@netscape.com', 'd861714bae4e2dadfa0b6e9298707cd6496add46ab24537e5ad107a05407e900', '78', '78');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (79, 'Male', '2022-06-07 09:25:30', 'Elias', 'Tythacott', '524-644-2352', 'etythacott26@abc.net.au', 'e33d72d961fdbab750a6f4c07dff6cae3c968c77722f351d1a6f15b8b7299115', '79', '79');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (80, 'Non-binary', '2022-02-17 21:12:10', 'Derrik', 'Skeen', '157-132-6385', 'dskeen27@cdbaby.com', 'c500f5f5d29fdd4bf07fe0dcdf352bf117b00b8eb752bec488b8b53e59099948', '80', '80');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (81, 'Female', '2022-02-10 10:18:50', 'Ebba', 'Ockwell', '175-672-8408', 'eockwell28@ucoz.com', '42882ab4ee68c38046830dee276982be6e4aa16cf52896c83c427cfb78cd91e6', '81', '81');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (82, 'Female', '2022-10-06 14:43:32', 'Letitia', 'Molfino', '747-548-2247', 'lmolfino29@etsy.com', '256753b2a828cff13683f32c341822fc5e2625241ef41dc8285fb1dcab84c9e8', '82', '82');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (83, 'Male', '2021-12-14 23:20:18', 'Mikel', 'Baxill', '693-522-2122', 'mbaxill2a@ycombinator.com', 'd77ec7ffbd241d6acd5b50997c050b6e4b7f7942761bf90636823c2abc6b840c', '83', '83');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (84, 'Female', '2022-07-14 14:17:58', 'Tami', 'Pigeon', '168-898-1512', 'tpigeon2b@gizmodo.com', '90452d898775b600028d8fdf3e14a4ade9d3e54e3d0a979d17c380af87b15802', '84', '84');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (85, 'Male', '2022-08-23 05:10:16', 'Daryl', 'Salaman', '655-980-9764', 'dsalaman2c@dedecms.com', '1c6fe240d76119c118b3dd822b36c4a80f95bc2a5644bd4d7d8afaf7523a70cc', '85', '85');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (86, 'Female', '2022-03-13 22:54:46', 'Carmita', 'Clausen', '295-589-7502', 'cclausen2d@businessweek.com', 'a1377ebc6450672a0d6ef3c39dfaa3a08b09c928b805deaebeafa2174d423ae4', '86', '86');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (87, 'Genderfluid', '2021-12-24 11:13:08', 'Darya', 'Macklin', '232-160-4878', 'dmacklin2e@usatoday.com', 'ecbbc11b78ba1e6b3da2d969295df741773fd917fd0018a1e1eefe8b980e0af8', '87', '87');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (88, 'Female', '2021-12-24 11:31:34', 'Joeann', 'Phonix', '337-962-9961', 'jphonix2f@facebook.com', 'fb93c113bcd8e1011e66bb71a62019c1ab97f240e885860243b6418c2d3b8995', '88', '88');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (89, 'Male', '2022-08-18 23:50:55', 'Miller', 'Verlander', '602-674-3516', 'mverlander2g@example.com', 'e7c96fc7ae20a7d38339553fd98da5191ae7c496dfc209214d7072512bcb111b', '89', '89');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (90, 'Male', '2021-12-11 22:24:12', 'Felicio', 'Manion', '521-520-3785', 'fmanion2h@wikia.com', '70525423f35542f85611e005a54405e525d42529c3801fde7240825ae03ed69a', '90', '90');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (91, 'Male', '2022-08-01 06:25:46', 'Robb', 'Munday', '982-471-5732', 'rmunday2i@usa.gov', '27c03fecbbcc5e60ceeef8758e028e36fde85866445354e79c96122667aecacb', '91', '91');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (92, 'Female', '2022-11-20 18:34:11', 'Sheelagh', 'Whitewood', '679-830-7509', 'swhitewood2j@blinklist.com', '9f51f410a8369af418b0cd3de8c0dd96c011c0ace816bde0cac67bb866f21117', '92', '92');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (93, 'Female', '2022-01-07 22:43:37', 'Aeriel', 'Goad', '864-474-6373', 'agoad2k@altervista.org', '8daa9fbf83209bf9d570c378f1b7ae9a8a2715406d8f023875850cff34e2b285', '93', '93');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (94, 'Male', '2022-10-28 01:11:16', 'Roth', 'Pleasaunce', '465-636-3021', 'rpleasaunce2l@acquirethisname.com', 'ffb64af992ae46bad7f39fd229c08d251fb7387f2733a2fb6290535b18136f68', '94', '94');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (95, 'Male', '2022-03-11 17:42:46', 'Jayme', 'Ogborne', '236-137-7661', 'jogborne2m@addthis.com', '4ad20e828cddfd53e8448eb69299e5e35a9d9ffc8f1de01948bc2743dbf2afd3', '95', '95');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (96, 'Female', '2022-09-19 21:59:04', 'Alexandra', 'McReidy', '788-503-9864', 'amcreidy2n@arstechnica.com', '95aa4b85061add7bf6b45228a551f02dc2ce1037aebf7563f0f13150b156fc30', '96', '96');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (97, 'Male', '2022-04-14 05:08:12', 'Llywellyn', 'Craker', '810-931-4473', 'lcraker2o@omniture.com', 'c50333c9980f405f4386cd58da40c27379e964d7cca210cd3679d5ac7fd8ef27', '97', '97');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (98, 'Male', '2022-10-17 08:53:23', 'Lucian', 'Bottby', '711-873-3361', 'lbottby2p@reuters.com', '63869da93768cbea20fb523b616d3abd6bc0cc4cce8e589fc169a4ee5418acfa', '98', '98');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (99, 'Male', '2022-11-28 10:18:52', 'Jessee', 'Doudny', '498-536-2785', 'jdoudny2q@engadget.com', '457669343666109dd42ac404ad12ee905651fbdbbab5fecf686d4c1ccc528d0c', '99', '99');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (100, 'Female', '2022-11-26 04:26:59', 'Ninnette', 'Bicheno', '108-557-5073', 'nbicheno2r@dot.gov', '2bb9d7e0c1ab7ce0cbfff0cfd89d20531ff7b9c131bc0754eacce5d8fd4a4ec4', '100', '100');

insert into trade (trade_ID, date, price, buyerID, sellerID) values (1, '2022-01-10 10:03:28', '$647.74', '1', 100);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (2, '2022-02-28 02:49:57', '$426.34', '2', 75);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (3, '2022-08-23 22:14:20', '$314.00', '3', 80);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (4, '2022-02-10 22:17:25', '$407.18', '4', 14);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (5, '2022-05-06 00:00:51', '$658.83', '5', 69);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (6, '2022-02-15 04:44:20', '$327.69', '6', 10);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (7, '2022-04-28 16:41:40', '$736.49', '7', 20);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (8, '2022-11-03 13:11:58', '$630.73', '8', 16);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (9, '2022-05-30 01:14:19', '$972.94', '9', 53);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (10, '2022-10-02 17:07:37', '$371.12', '10', 73);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (11, '2022-10-11 19:02:53', '$168.52', '11', 27);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (12, '2022-02-09 21:29:19', '$152.24', '12', 50);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (13, '2022-06-18 04:14:01', '$998.78', '13', 71);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (14, '2022-11-24 05:35:01', '$417.11', '14', 9);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (15, '2022-05-22 15:14:51', '$961.22', '15', 77);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (16, '2022-10-10 12:49:51', '$540.91', '16', 49);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (17, '2022-10-03 15:28:16', '$97.22', '17', 43);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (18, '2022-03-10 15:57:42', '$369.88', '18', 31);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (19, '2022-05-11 16:05:30', '$118.81', '19', 81);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (20, '2022-04-08 00:47:34', '$987.15', '20', 54);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (21, '2021-12-11 15:09:30', '$933.33', '21', 2);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (22, '2022-10-09 19:00:55', '$923.56', '22', 27);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (23, '2022-04-17 04:45:42', '$827.91', '23', 57);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (24, '2022-11-01 13:33:40', '$225.21', '24', 81);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (25, '2022-01-20 19:36:36', '$107.36', '25', 75);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (26, '2022-09-14 16:08:28', '$117.48', '26', 90);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (27, '2022-08-03 23:35:26', '$871.82', '27', 9);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (28, '2022-08-19 01:12:28', '$321.48', '28', 48);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (29, '2022-05-28 19:14:23', '$156.78', '29', 8);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (30, '2022-04-22 09:08:46', '$538.06', '30', 2);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (31, '2022-06-23 22:34:48', '$320.57', '31', 59);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (32, '2021-12-23 14:25:33', '$292.56', '32', 69);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (33, '2022-09-27 02:08:27', '$871.66', '33', 31);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (34, '2022-09-28 13:27:24', '$586.41', '34', 73);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (35, '2021-12-29 07:48:49', '$308.75', '35', 98);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (36, '2022-04-30 21:18:36', '$839.20', '36', 35);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (37, '2022-07-10 23:32:19', '$253.53', '37', 4);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (38, '2021-12-26 14:52:39', '$221.80', '38', 67);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (39, '2022-11-29 22:00:40', '$317.40', '39', 70);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (40, '2022-11-09 10:30:25', '$441.50', '40', 59);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (41, '2022-10-20 05:23:31', '$754.68', '41', 24);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (42, '2022-02-25 16:19:19', '$533.95', '42', 82);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (43, '2022-07-09 18:40:37', '$139.74', '43', 9);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (44, '2022-04-25 01:25:51', '$201.33', '44', 11);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (45, '2022-05-12 22:45:47', '$433.18', '45', 19);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (46, '2022-05-28 01:47:15', '$107.69', '46', 52);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (47, '2022-06-05 04:00:48', '$545.61', '47', 84);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (48, '2022-06-18 12:52:32', '$456.46', '48', 79);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (49, '2022-11-26 17:00:35', '$420.11', '49', 50);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (50, '2022-07-26 15:23:16', '$842.88', '50', 39);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (51, '2022-11-07 09:33:40', '$434.95', '51', 51);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (52, '2022-02-05 12:33:03', '$340.44', '52', 97);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (53, '2022-09-15 19:19:17', '$384.41', '53', 9);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (54, '2022-10-26 20:43:39', '$607.35', '54', 85);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (55, '2022-02-25 01:04:56', '$879.53', '55', 75);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (56, '2022-11-18 14:15:07', '$419.84', '56', 75);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (57, '2022-12-05 19:13:44', '$237.42', '57', 40);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (58, '2022-09-30 07:48:42', '$891.91', '58', 82);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (59, '2022-11-19 23:27:03', '$622.38', '59', 93);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (60, '2022-04-30 18:56:46', '$641.02', '60', 16);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (61, '2022-06-15 04:56:30', '$255.53', '61', 44);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (62, '2022-10-18 09:36:44', '$780.52', '62', 61);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (63, '2022-03-01 13:51:14', '$266.26', '63', 29);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (64, '2022-11-20 17:02:05', '$800.24', '64', 7);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (65, '2022-06-22 17:54:10', '$784.98', '65', 61);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (66, '2022-05-15 10:48:38', '$130.53', '66', 58);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (67, '2022-01-12 08:14:16', '$668.49', '67', 17);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (68, '2022-05-19 11:53:47', '$177.10', '68', 62);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (69, '2021-12-07 00:02:50', '$588.66', '69', 20);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (70, '2022-08-28 14:54:01', '$54.65', '70', 50);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (71, '2022-09-15 03:51:23', '$112.41', '71', 11);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (72, '2022-10-18 03:56:40', '$847.90', '72', 4);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (73, '2022-11-18 17:13:39', '$534.94', '73', 43);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (74, '2022-09-09 13:28:02', '$431.54', '74', 68);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (75, '2022-10-14 13:15:59', '$509.58', '75', 56);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (76, '2022-07-02 22:36:09', '$136.39', '76', 96);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (77, '2022-07-06 22:37:16', '$171.07', '77', 32);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (78, '2022-07-05 23:51:43', '$375.10', '78', 98);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (79, '2022-02-21 08:40:35', '$124.27', '79', 45);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (80, '2022-01-24 08:26:37', '$495.22', '80', 29);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (81, '2022-07-31 21:27:50', '$153.20', '81', 96);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (82, '2022-01-28 16:18:48', '$354.06', '82', 18);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (83, '2022-04-03 07:13:45', '$223.58', '83', 45);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (84, '2022-06-14 22:15:55', '$648.10', '84', 59);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (85, '2022-02-17 14:57:44', '$171.36', '85', 25);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (86, '2022-11-23 19:27:04', '$837.02', '86', 22);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (87, '2022-08-29 07:43:22', '$251.31', '87', 57);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (88, '2021-12-10 05:20:04', '$474.18', '88', 50);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (89, '2022-11-18 11:33:42', '$968.06', '89', 66);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (90, '2022-07-07 14:39:36', '$604.85', '90', 35);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (91, '2022-02-05 13:26:45', '$321.02', '91', 44);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (92, '2022-08-12 08:15:56', '$926.49', '92', 54);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (93, '2022-11-06 08:35:07', '$616.01', '93', 34);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (94, '2022-04-29 23:48:14', '$458.01', '94', 46);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (95, '2022-03-03 00:59:14', '$692.95', '95', 33);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (96, '2022-07-23 22:54:45', '$949.08', '96', 30);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (97, '2022-10-05 05:40:58', '$620.73', '97', 95);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (98, '2022-08-13 12:25:53', '$158.04', '98', 88);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (99, '2022-09-09 09:02:56', '$258.17', '99', 27);
insert into trade (trade_ID, date, price, buyerID, sellerID) values (100, '2022-05-23 05:08:50', '$878.02', '100', 33);


insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (1, false, '2022-05-08 08:01:45', 'Aliquam non mauris.', 81, 44);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (2, true, '2022-11-23 00:37:49', 'Duis aliquam convallis nunc.', 49, 95);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (3, false, '2022-05-06 17:45:27', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 69, 81);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (4, false, '2022-06-19 06:33:16', 'Sed sagittis.', 73, 91);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (5, false, '2022-11-14 04:03:02', 'Aliquam sit amet diam in magna bibendum imperdiet.', 64, 65);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (6, true, '2022-02-19 07:03:59', 'Integer a nibh.', 97, 72);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (7, false, '2022-12-04 11:32:08', 'In hac habitasse platea dictumst.', 46, 9);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (8, false, '2022-03-29 12:31:09', 'Donec semper sapien a libero.', 15, 48);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (9, true, '2022-11-10 19:41:08', 'Donec semper sapien a libero.', 35, 15);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (10, true, '2022-01-17 05:43:22', 'Aliquam erat volutpat.', 49, 31);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (11, false, '2022-10-25 08:03:11', 'Fusce consequat.', 58, 8);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (12, true, '2022-11-30 01:34:33', 'Nulla ut erat id mauris vulputate elementum.', 7, 53);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (13, false, '2022-08-24 03:21:34', 'Phasellus id sapien in sapien iaculis congue.', 76, 73);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (14, false, '2021-12-24 08:55:10', 'Donec vitae nisi.', 81, 13);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (15, false, '2022-09-29 23:54:08', 'Praesent id massa id nisl venenatis lacinia.', 47, 81);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (16, false, '2022-02-24 21:46:50', 'Sed ante.', 41, 60);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (17, true, '2021-12-18 20:55:55', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 13, 7);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (18, true, '2022-04-15 01:20:30', 'Maecenas rhoncus aliquam lacus.', 56, 23);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (19, true, '2022-06-22 22:53:24', 'Aenean fermentum.', 57, 27);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (20, false, '2022-06-15 19:20:59', 'Donec vitae nisi.', 90, 57);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (21, false, '2022-10-18 12:24:14', 'Duis ac nibh.', 25, 9);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (22, true, '2022-05-02 14:02:45', 'In quis justo.', 26, 57);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (23, true, '2022-12-01 21:52:33', 'Sed sagittis.', 84, 50);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (24, false, '2022-03-25 02:30:36', 'Morbi a ipsum.', 84, 59);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (25, false, '2022-08-24 15:28:21', 'Phasellus sit amet erat.', 9, 83);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (26, false, '2022-08-29 09:47:57', 'Aliquam quis turpis eget elit sodales scelerisque.', 26, 14);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (27, true, '2022-04-12 09:07:06', 'Nulla tempus.', 61, 93);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (28, false, '2022-07-13 18:03:13', 'Etiam vel augue.', 99, 19);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (29, true, '2022-05-18 07:58:46', 'Pellentesque viverra pede ac diam.', 81, 99);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (30, false, '2022-09-30 03:04:31', 'Ut tellus.', 22, 41);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (31, false, '2022-08-12 01:44:41', 'Nam tristique tortor eu pede.', 68, 12);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (32, true, '2022-01-07 04:53:52', 'Morbi vel lectus in quam fringilla rhoncus.', 47, 95);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (33, true, '2022-03-29 19:48:17', 'Nulla justo.', 74, 45);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (34, false, '2022-04-24 12:01:20', 'Ut at dolor quis odio consequat varius.', 48, 12);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (35, false, '2021-12-16 14:56:09', 'Suspendisse potenti.', 67, 48);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (36, true, '2022-06-14 06:09:51', 'Proin eu mi.', 84, 78);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (37, true, '2022-10-31 20:13:01', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 75, 57);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (38, true, '2022-05-19 04:28:39', 'Duis at velit eu est congue elementum.', 34, 11);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (39, true, '2022-02-14 19:00:18', 'Vivamus vel nulla eget eros elementum pellentesque.', 39, 42);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (40, false, '2022-07-24 07:40:37', 'Duis ac nibh.', 21, 13);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (41, false, '2022-03-15 09:37:29', 'Nullam sit amet turpis elementum ligula vehicula consequat.', 18, 93);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (42, true, '2021-12-24 08:21:41', 'In hac habitasse platea dictumst.', 62, 80);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (43, false, '2022-05-16 10:03:31', 'In est risus, auctor sed, tristique in, tempus sit amet, sem.', 73, 65);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (44, false, '2021-12-14 23:06:29', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 65, 38);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (45, false, '2022-10-11 07:52:17', 'In quis justo.', 52, 34);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (46, true, '2022-11-24 18:54:40', 'Etiam justo.', 70, 29);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (47, false, '2022-03-22 23:27:25', 'Maecenas pulvinar lobortis est.', 83, 25);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (48, true, '2022-11-07 23:41:36', 'Vivamus vestibulum sagittis sapien.', 62, 60);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (49, true, '2022-11-09 10:10:44', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', 81, 73);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (50, false, '2022-01-05 06:44:09', 'Praesent id massa id nisl venenatis lacinia.', 10, 26);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (51, true, '2022-11-27 10:39:13', 'Vivamus vestibulum sagittis sapien.', 29, 26);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (52, true, '2022-10-31 15:31:29', 'Sed vel enim sit amet nunc viverra dapibus.', 46, 4);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (53, false, '2022-11-08 12:15:24', 'Nulla tellus.', 21, 72);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (54, false, '2022-10-26 12:12:54', 'Nam tristique tortor eu pede.', 83, 27);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (55, true, '2022-10-07 07:50:36', 'Maecenas rhoncus aliquam lacus.', 65, 60);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (56, true, '2022-09-18 09:33:50', 'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 46, 56);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (57, false, '2022-07-17 09:00:40', 'Etiam vel augue.', 99, 13);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (58, false, '2022-11-06 18:25:17', 'Fusce consequat.', 91, 68);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (59, true, '2022-06-30 11:08:03', 'Ut at dolor quis odio consequat varius.', 24, 19);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (60, false, '2022-04-23 22:12:39', 'Nullam porttitor lacus at turpis.', 42, 3);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (61, false, '2022-07-04 05:21:21', 'Cras non velit nec nisi vulputate nonummy.', 50, 48);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (62, true, '2022-05-01 00:23:15', 'Pellentesque at nulla.', 17, 95);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (63, true, '2022-08-02 00:58:00', 'Nulla tellus.', 58, 64);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (64, true, '2022-10-10 11:11:18', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 76, 50);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (65, true, '2022-10-18 18:30:38', 'Nulla suscipit ligula in lacus.', 16, 80);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (66, false, '2022-05-13 10:03:23', 'Nullam porttitor lacus at turpis.', 92, 2);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (67, false, '2022-03-09 00:47:59', 'Curabitur convallis.', 68, 19);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (68, true, '2022-03-03 00:30:37', 'Pellentesque ultrices mattis odio.', 58, 26);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (69, false, '2022-06-17 17:04:42', 'Nulla suscipit ligula in lacus.', 66, 78);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (70, true, '2022-01-03 05:24:41', 'Fusce consequat.', 10, 57);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (71, false, '2022-09-17 08:54:24', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 19, 61);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (72, false, '2022-01-22 16:24:46', 'Duis aliquam convallis nunc.', 78, 57);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (73, true, '2022-10-26 05:34:23', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 5, 99);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (74, true, '2022-08-17 21:52:08', 'Phasellus sit amet erat.', 98, 49);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (75, true, '2022-05-04 02:31:44', 'Aliquam quis turpis eget elit sodales scelerisque.', 24, 12);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (76, false, '2022-04-01 02:33:22', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 54, 40);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (77, true, '2022-10-04 01:16:06', 'Pellentesque viverra pede ac diam.', 74, 15);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (78, false, '2022-07-13 13:27:03', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 31, 33);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (79, true, '2022-01-07 21:35:12', 'Suspendisse potenti.', 39, 35);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (80, false, '2022-04-25 01:13:59', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 3, 25);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (81, false, '2022-08-27 01:36:40', 'Nulla nisl.', 32, 3);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (82, false, '2021-12-31 16:00:49', 'Aenean auctor gravida sem.', 76, 46);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (83, true, '2022-08-14 12:53:44', 'Aliquam non mauris.', 94, 63);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (84, false, '2022-03-10 21:04:52', 'In congue.', 16, 82);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (85, false, '2022-07-21 00:12:42', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 41, 72);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (86, false, '2022-01-09 14:58:43', 'In hac habitasse platea dictumst.', 30, 100);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (87, true, '2022-02-09 07:01:19', 'Nullam sit amet turpis elementum ligula vehicula consequat.', 98, 92);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (88, true, '2022-07-01 16:56:53', 'In eleifend quam a odio.', 36, 65);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (89, false, '2021-12-28 04:57:10', 'Integer tincidunt ante vel ipsum.', 70, 34);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (90, true, '2022-05-18 13:08:30', 'Nam nulla.', 72, 64);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (91, false, '2022-10-07 07:47:08', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 83, 49);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (92, false, '2022-10-01 00:53:17', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 43, 70);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (93, false, '2022-01-07 03:45:34', 'Duis consequat dui nec nisi volutpat eleifend.', 82, 6);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (94, true, '2022-05-28 04:12:33', 'Morbi quis tortor id nulla ultrices aliquet.', 36, 84);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (95, false, '2022-11-13 06:16:07', 'Maecenas pulvinar lobortis est.', 19, 99);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (96, true, '2022-04-08 13:17:43', 'Morbi porttitor lorem id ligula.', 57, 18);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (97, false, '2021-12-14 17:12:30', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 26, 56);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (98, false, '2022-03-26 21:01:48', 'Duis mattis egestas metus.', 30, 55);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (99, false, '2022-01-17 20:16:47', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 41, 80);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (100, true, '2022-07-24 04:57:50', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 68, 10);


insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (1, 1, '$897.02', 'visa', 'Vivamus in felis eu sapien cursus vestibulum.', 87, 24, 74);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (2, 2, '$630.26', 'mastercard', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 43, 97, 29);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (3, 3, '$561.33', 'jcb', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 31, 32, 83);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (4, 4, '$525.38', 'visa-electron', 'Integer non velit.', 81, 7, 10);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (5, 5, '$617.41', 'jcb', 'Aenean lectus.', 47, 54, 3);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (6, 6, '$189.98', 'americanexpress', 'Proin at turpis a pede posuere nonummy. Integer non velit.', 57, 9, 63);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (7, 7, '$658.02', 'diners-club-enroute', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 34, 81, 92);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (8, 8, '$706.18', 'diners-club-enroute', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', 88, 70, 22);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (9, 9, '$429.18', 'jcb', 'Suspendisse accumsan tortor quis turpis.', 68, 4, 79);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (10, 10, '$309.33', 'maestro', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 82, 24, 13);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (11, 11, '$610.96', 'jcb', 'Mauris ullamcorper purus sit amet nulla.', 60, 96, 71);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (12, 12, '$844.47', 'jcb', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.', 89, 77, 99);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (13, 13, '$655.05', 'jcb', 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', 52, 34, 89);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (14, 14, '$360.15', 'visa-electron', 'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.', 66, 100, 5);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (15, 15, '$896.45', 'mastercard', 'Donec dapibus.', 11, 19, 82);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (16, 16, '$908.76', 'visa-electron', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', 2, 28, 70);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (17, 17, '$437.33', 'visa-electron', 'Ut at dolor quis odio consequat varius. Integer ac leo.', 53, 20, 2);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (18, 18, '$82.11', 'mastercard', 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', 66, 51, 54);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (19, 19, '$136.70', 'visa-electron', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', 3, 86, 58);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (20, 20, '$426.68', 'jcb', 'Aliquam non mauris. Morbi non lectus.', 88, 39, 94);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (21, 21, '$780.18', 'diners-club-carte-blanche', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 91, 78, 64);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (22, 22, '$818.26', 'china-unionpay', 'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 83, 86, 18);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (23, 23, '$948.60', 'visa-electron', 'Cras non velit nec nisi vulputate nonummy.', 5, 79, 66);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (24, 24, '$920.54', 'visa-electron', 'Ut at dolor quis odio consequat varius.', 44, 4, 47);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (25, 25, '$719.20', 'americanexpress', 'Nulla tellus.', 82, 71, 12);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (26, 26, '$838.54', 'diners-club-us-ca', 'Ut at dolor quis odio consequat varius. Integer ac leo.', 23, 22, 82);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (27, 27, '$439.60', 'bankcard', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 92, 49, 46);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (28, 28, '$740.06', 'laser', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 27, 44, 70);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (29, 29, '$385.66', 'china-unionpay', 'Vivamus in felis eu sapien cursus vestibulum.', 43, 21, 30);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (30, 30, '$723.95', 'switch', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', 6, 72, 62);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (31, 31, '$497.92', 'americanexpress', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', 52, 17, 9);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (32, 32, '$736.17', 'americanexpress', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', 40, 65, 22);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (33, 33, '$561.82', 'laser', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 24, 79, 57);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (34, 34, '$516.60', 'diners-club-enroute', 'Nunc nisl.', 25, 25, 59);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (35, 35, '$226.83', 'mastercard', 'Maecenas tincidunt lacus at velit.', 82, 73, 74);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (36, 36, '$469.61', 'jcb', 'Fusce posuere felis sed lacus.', 84, 43, 92);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (37, 37, '$152.73', 'mastercard', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 29, 77, 16);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (38, 38, '$604.14', 'jcb', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.', 94, 8, 94);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (39, 39, '$494.77', 'jcb', 'Nunc rhoncus dui vel sem.', 59, 95, 37);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (40, 40, '$928.07', 'americanexpress', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', 41, 19, 46);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (41, 41, '$44.93', 'jcb', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 39, 41, 1);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (42, 42, '$520.71', 'jcb', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', 59, 51, 35);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (43, 43, '$234.17', 'jcb', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 61, 67, 37);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (44, 44, '$302.07', 'instapayment', 'Etiam vel augue. Vestibulum rutrum rutrum neque.', 36, 58, 91);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (45, 45, '$485.72', 'maestro', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', 31, 66, 87);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (46, 46, '$906.33', 'switch', 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 4, 55, 71);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (47, 47, '$294.02', 'jcb', 'Nunc rhoncus dui vel sem. Sed sagittis.', 60, 88, 26);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (48, 48, '$301.19', 'instapayment', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 10, 100, 16);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (49, 49, '$245.77', 'visa', 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', 66, 35, 47);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (50, 50, '$886.05', 'jcb', 'In hac habitasse platea dictumst.', 63, 33, 34);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (51, 51, '$754.33', 'jcb', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 88, 44, 6);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (52, 52, '$388.45', 'jcb', 'Nulla tellus. In sagittis dui vel nisl.', 79, 36, 63);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (53, 53, '$279.17', 'bankcard', 'Aliquam erat volutpat.', 64, 69, 30);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (54, 54, '$334.20', 'jcb', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 10, 3, 39);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (55, 55, '$574.19', 'jcb', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 59, 81, 68);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (56, 56, '$555.52', 'diners-club-enroute', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 15, 61, 51);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (57, 57, '$985.38', 'americanexpress', 'In hac habitasse platea dictumst.', 63, 96, 29);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (58, 58, '$654.62', 'mastercard', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 86, 42, 39);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (59, 59, '$69.55', 'jcb', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', 94, 23, 20);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (60, 60, '$461.08', 'china-unionpay', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', 65, 45, 12);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (61, 61, '$217.49', 'jcb', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 60, 43, 68);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (62, 62, '$126.82', 'maestro', 'Nulla tellus. In sagittis dui vel nisl.', 32, 43, 27);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (63, 63, '$318.93', 'jcb', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque.', 4, 86, 59);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (64, 64, '$603.65', 'jcb', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 34, 80, 1);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (65, 65, '$157.45', 'diners-club-carte-blanche', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 44, 72, 16);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (66, 66, '$835.62', 'visa-electron', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 68, 89, 12);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (67, 67, '$363.81', 'laser', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 76, 80, 34);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (68, 68, '$501.02', 'jcb', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 29, 66, 47);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (69, 69, '$672.37', 'jcb', 'Maecenas ut massa quis augue luctus tincidunt.', 72, 24, 87);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (70, 70, '$537.36', 'jcb', 'Vestibulum ac est lacinia nisi venenatis tristique.', 69, 78, 19);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (71, 71, '$329.64', 'diners-club-carte-blanche', 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 1, 5, 73);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (72, 72, '$340.91', 'jcb', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 93, 3, 37);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (73, 73, '$177.18', 'bankcard', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.', 80, 92, 62);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (74, 74, '$164.55', 'mastercard', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 35, 52, 5);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (75, 75, '$530.26', 'solo', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', 6, 96, 6);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (76, 76, '$387.15', 'jcb', 'Donec dapibus.', 23, 76, 32);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (77, 77, '$362.70', 'visa-electron', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 25, 79, 10);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (78, 78, '$77.58', 'switch', 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.', 86, 77, 57);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (79, 79, '$597.99', 'visa-electron', 'Nulla nisl.', 29, 23, 98);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (80, 80, '$167.94', 'jcb', 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 75, 46, 52);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (81, 81, '$399.03', 'jcb', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 3, 93, 12);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (82, 82, '$512.07', 'visa', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', 98, 60, 42);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (83, 83, '$752.01', 'bankcard', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 40, 47, 7);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (84, 84, '$261.49', 'maestro', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', 53, 84, 16);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (85, 85, '$284.95', 'jcb', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', 61, 53, 35);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (86, 86, '$705.82', 'jcb', 'Ut at dolor quis odio consequat varius.', 87, 18, 18);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (87, 87, '$646.59', 'maestro', 'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.', 4, 45, 37);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (88, 88, '$113.47', 'jcb', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 100, 16, 1);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (89, 89, '$535.12', 'jcb', 'Praesent blandit lacinia erat.', 41, 20, 45);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (90, 90, '$762.31', 'jcb', 'Cras pellentesque volutpat dui.', 45, 49, 5);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (91, 91, '$492.50', 'jcb', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', 55, 100, 11);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (92, 92, '$570.83', 'china-unionpay', 'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.', 89, 100, 83);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (93, 93, '$935.57', 'visa', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 54, 82, 63);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (94, 94, '$540.23', 'americanexpress', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 25, 74, 86);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (95, 95, '$679.52', 'diners-club-us-ca', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 84, 49, 37);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (96, 96, '$106.06', 'mastercard', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', 9, 42, 91);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (97, 97, '$770.95', 'jcb', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 58, 99, 9);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (98, 98, '$910.72', 'jcb', 'Nulla tellus.', 85, 11, 95);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (99, 99, '$445.22', 'maestro', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 37, 51, 59);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (100, 100, '$609.34', 'visa-electron', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 34, 62, 29);

insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (1, 'Polo', 'Von and Sons', 12, 87);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (2, 'Karangsari', 'Flatley, Bauch and Moore', 80, 82);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (3, 'Jinping', 'Halvorson, Weber and Klein', 66, 65);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (4, 'Luxi', 'Reinger-Kris', 19, 82);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (5, 'Dalsjöfors', 'Bayer-Fritsch', 45, 45);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (6, 'Duque de Caxias', 'Dicki-Gottlieb', 28, 11);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (7, 'Kendal', 'Windler and Sons', 94, 95);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (8, 'Wąwolnica', 'Cronin, Waters and Weimann', 96, 67);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (9, 'Changping', 'Runolfsson-Spinka', 100, 8);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (10, 'Lafiagi', 'Koss, Koepp and Spencer', 73, 9);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (11, 'Dartang', 'Klein-Schaefer', 74, 10);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (12, 'Birmingham', 'Beahan, Olson and Hessel', 80, 23);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (13, 'Estreito', 'Ledner, Dickens and Cormier', 16, 62);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (14, 'Thala', 'Legros, Corkery and Stamm', 23, 62);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (15, 'Peña Blanca', 'Glover Inc', 26, 59);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (16, 'Ansermanuevo', 'Cassin-Padberg', 90, 20);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (17, 'Báguanos', 'Graham LLC', 74, 4);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (18, 'Margherita', 'Crooks and Sons', 90, 86);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (19, 'Kuala Lumpur', 'Paucek-Dicki', 13, 59);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (20, 'Shah Alam', 'Lebsack-Bosco', 4, 70);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (21, 'La Cañada', 'Kovacek LLC', 65, 53);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (22, 'Topolovgrad', 'Grimes Inc', 87, 32);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (23, 'Kasongo', 'Yundt, Aufderhar and Durgan', 91, 61);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (24, 'Reserva', 'Nolan, Reichert and Auer', 4, 22);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (25, 'Zambujeira do Mar', 'Witting, Spinka and Sanford', 94, 80);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (26, 'Xinglong', 'Bergnaum-Cole', 8, 90);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (27, 'Arras', 'Cremin, Turcotte and Mitchell', 43, 5);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (28, 'Fovissste', 'Kulas-Rodriguez', 4, 57);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (29, 'Longqiao', 'Wuckert, Feeney and Brown', 14, 32);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (30, 'Fushë-Bulqizë', 'Gleichner-Schmidt', 53, 100);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (31, 'Bonneuil-sur-Marne', 'Spinka Group', 61, 56);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (32, 'Clonskeagh', 'Schinner and Sons', 98, 63);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (33, 'Jepat Kidul', 'Ziemann and Sons', 26, 5);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (34, 'Smečno', 'Blanda-Hilll', 77, 92);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (35, 'Dordrecht', 'Towne and Sons', 31, 10);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (36, 'Singkup', 'Hudson-Rutherford', 84, 2);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (37, 'Pryyutivka', 'Schimmel-Hickle', 35, 55);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (38, 'Sosnovoborsk', 'Zemlak LLC', 95, 27);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (39, 'Tianxin', 'Kuvalis Group', 41, 39);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (40, 'Alfonso', 'Schiller LLC', 97, 76);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (41, 'Dziemiany', 'Stoltenberg-Kuvalis', 27, 47);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (42, 'Guzhu', 'Blick-Jacobs', 30, 30);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (43, 'Pulangbato', 'Smitham and Sons', 9, 95);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (44, 'Gongjiang', 'Kunde, Cremin and Jaskolski', 43, 67);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (45, 'Kembang', 'Veum Group', 16, 14);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (46, 'Embalse', 'Nitzsche, Botsford and West', 84, 12);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (47, 'Dededo Village', 'Runte Inc', 60, 10);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (48, 'Hampang', 'Larkin Group', 82, 36);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (49, 'As Sab‘ Biyār', 'Barrows-Block', 78, 91);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (50, 'Kardítsa', 'Mann-Mills', 87, 31);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (51, 'Port-à-Piment', 'Medhurst-Howell', 70, 75);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (52, 'Vaughan', 'Upton-Balistreri', 2, 11);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (53, 'Swedru', 'Halvorson Group', 59, 36);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (54, 'Orahovac', 'Williamson Group', 98, 71);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (55, 'Yangchengzhuang', 'Carter Group', 55, 45);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (56, 'Petřvald', 'Haag-Hoeger', 1, 25);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (57, 'Ujung', 'Considine and Sons', 46, 83);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (58, 'Rancagua', 'Parker, Rowe and Morar', 89, 71);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (59, 'Bochov', 'Botsford LLC', 61, 98);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (60, 'Ma‘bar', 'Zulauf, Franecki and Mertz', 62, 79);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (61, 'Xihanling', 'Green Inc', 24, 31);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (62, 'Pulo', 'Kirlin-Beer', 10, 99);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (63, 'Wang Sai Phun', 'Murphy-Buckridge', 17, 19);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (64, 'Huolongping', 'Ratke, MacGyver and White', 99, 63);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (65, 'Lipník nad Bečvou', 'Gusikowski-Funk', 7, 37);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (66, 'Guanbuqiao', 'Frami Inc', 40, 39);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (67, 'Trogan Barat', 'Prosacco and Sons', 12, 44);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (68, 'Lianzhu', 'Feil-Harber', 25, 6);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (69, 'Podedwórze', 'Hoeger-Mills', 97, 76);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (70, 'Krzyżanowice', 'Toy-Wilkinson', 8, 69);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (71, 'Coelho Neto', 'Price-Hammes', 86, 11);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (72, 'Columbus', 'Donnelly-Spencer', 89, 54);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (73, 'Gulonggang', 'Reilly, Wunsch and Robel', 99, 29);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (74, 'Pelasgía', 'Corkery, Cruickshank and Lind', 79, 43);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (75, 'Herrljunga', 'Greenholt, Shields and Fadel', 65, 79);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (76, 'Maringá', 'Tromp, Kemmer and Cartwright', 53, 6);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (77, 'Doibang', 'Nienow LLC', 56, 13);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (78, 'Huanglong', 'Lesch Group', 91, 34);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (79, 'Aix-en-Provence', 'Wolf Group', 83, 24);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (80, 'Ehu', 'Kirlin, Legros and Corwin', 77, 46);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (81, 'Laojieji', 'Ratke LLC', 27, 82);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (82, 'Draguignan', 'Rohan, Haag and Cummerata', 1, 57);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (83, 'Xiangshan', 'Cronin, Runolfsdottir and Lockman', 9, 89);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (84, 'Stockholm', 'Zieme, Kovacek and Bruen', 21, 41);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (85, 'Shilovo', 'Schiller Inc', 57, 39);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (86, 'Kuala Terengganu', 'Gusikowski, Beer and Koepp', 57, 51);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (87, 'Shchigry', 'Bernhard Group', 78, 37);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (88, 'Mardakyany', 'Homenick Inc', 53, 46);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (89, 'Telgawah', 'Goodwin, Wintheiser and Jast', 17, 56);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (90, 'Pasarbaru', 'Jakubowski-Mayer', 69, 64);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (91, 'Benito Juarez', 'Wisoky Inc', 84, 21);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (92, 'Tarusa', 'Huel, Dietrich and Hayes', 47, 73);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (93, 'Mtwara', 'Macejkovic-Marquardt', 24, 93);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (94, 'Zgłobień', 'Ryan, Thompson and O''Kon', 15, 34);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (95, 'Pallasovka', 'Walter and Sons', 10, 94);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (96, 'Sanghan', 'Sipes, Hammes and Prohaska', 72, 75);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (97, 'San Vicente', 'Schiller, Brown and Koch', 48, 14);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (98, 'Shimiaozi', 'Koepp Group', 7, 80);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (99, 'Jiasi', 'Cremin, Hegmann and Heaney', 1, 34);
insert into bank (bankID, location, name, paymentNum, bankaccount_ID) values (100, 'Adil Makmur', 'Huels-Connelly', 33, 6);

insert into direct_buy (trade_ID, buyerID, autobuy_price) values (94, 31, '$380.72');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (33, 19, '$465.46');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (49, 14, '$780.59');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (14, 76, '$59.80');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (6, 2, '$149.73');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (77, 87, '$610.03');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (30, 66, '$749.94');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (48, 22, '$249.01');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (77, 82, '$862.89');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (75, 47, '$586.60');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (58, 23, '$563.68');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (47, 32, '$962.66');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (73, 82, '$239.90');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (42, 35, '$118.48');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (64, 86, '$211.20');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (27, 55, '$310.23');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (19, 93, '$631.24');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (99, 69, '$708.36');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (3, 84, '$794.82');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (3, 81, '$683.11');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (83, 22, '$173.38');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (9, 86, '$552.35');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (46, 86, '$472.13');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (90, 68, '$329.66');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (74, 27, '$121.67');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (12, 98, '$452.98');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (99, 32, '$197.76');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (96, 76, '$912.71');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (44, 7, '$106.88');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (95, 10, '$520.32');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (52, 75, '$992.06');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (49, 57, '$843.91');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (46, 99, '$335.74');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (17, 4, '$554.45');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (89, 92, '$780.20');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (37, 95, '$470.88');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (73, 25, '$672.95');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (32, 93, '$129.40');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (14, 1, '$521.61');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (79, 90, '$796.35');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (58, 44, '$441.73');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (12, 63, '$676.49');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (84, 51, '$118.95');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (100, 68, '$336.23');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (61, 83, '$686.85');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (32, 6, '$274.03');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (45, 10, '$143.97');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (5, 71, '$137.47');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (44, 48, '$91.95');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (48, 70, '$243.78');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (64, 88, '$494.29');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (95, 95, '$173.34');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (9, 29, '$483.61');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (87, 51, '$888.89');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (58, 60, '$305.55');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (29, 19, '$668.65');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (83, 91, '$154.77');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (56, 64, '$481.21');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (58, 90, '$759.83');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (67, 24, '$796.65');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (38, 36, '$465.89');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (98, 25, '$666.54');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (33, 1, '$232.13');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (64, 75, '$963.47');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (42, 90, '$724.13');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (53, 60, '$371.81');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (95, 90, '$353.11');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (9, 58, '$102.30');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (54, 20, '$301.48');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (14, 30, '$784.64');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (79, 43, '$305.87');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (91, 50, '$423.56');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (95, 63, '$700.55');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (11, 60, '$712.17');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (52, 50, '$871.55');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (92, 27, '$800.94');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (67, 67, '$194.88');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (14, 56, '$645.29');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (26, 42, '$494.25');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (76, 96, '$692.88');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (46, 81, '$654.04');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (56, 85, '$765.68');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (84, 91, '$847.70');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (97, 41, '$358.05');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (44, 88, '$995.98');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (26, 58, '$424.76');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (84, 72, '$489.49');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (53, 97, '$303.25');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (5, 30, '$161.67');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (66, 73, '$793.96');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (66, 72, '$55.17');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (90, 87, '$363.42');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (78, 20, '$493.17');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (51, 99, '$600.95');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (34, 13, '$417.08');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (2, 96, '$589.57');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (20, 53, '$683.19');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (69, 3, '$834.34');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (85, 44, '$110.64');
insert into direct_buy (trade_ID, buyerID, autobuy_price) values (67, 93, '$123.17');

insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (1, '2022-05-28 19:41:25', 'Vinnie', 'Crumly', '396-188-8367', 'vcrumly0@statcounter.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (2, '2022-10-09 04:32:41', 'Catrina', 'Fines', '339-696-8384', 'cfines1@cbc.ca', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (3, '2022-01-20 23:49:49', 'Alleyn', 'Peron', '197-795-3084', 'aperon2@ustream.tv', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (4, '2022-10-03 21:38:26', 'Jo ann', 'Spires', '875-208-0928', 'jspires3@examiner.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (5, '2022-07-09 08:03:27', 'Oby', 'Minci', '536-454-2957', 'ominci4@constantcontact.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (6, '2022-04-13 20:20:19', 'Addison', 'Kolakovic', '541-840-5774', 'akolakovic5@example.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (7, '2022-06-28 15:02:10', 'Bryant', 'Glitherow', '794-365-0103', 'bglitherow6@bbc.co.uk', false, 'Genderfluid');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (8, '2022-06-24 01:36:21', 'Alyce', 'Ball', '879-836-9437', 'aball7@home.pl', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (9, '2022-07-13 22:25:37', 'Gustave', 'Aizikovitz', '582-885-0369', 'gaizikovitz8@addthis.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (10, '2022-04-02 05:28:14', 'Wileen', 'Leyes', '777-827-5265', 'wleyes9@woothemes.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (11, '2022-11-03 03:19:21', 'Evelina', 'Broadis', '482-648-2513', 'ebroadisa@hud.gov', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (12, '2022-02-21 09:42:41', 'Lusa', 'Burdell', '677-561-7560', 'lburdellb@mysql.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (13, '2022-05-25 08:08:52', 'Odilia', 'Ouver', '382-772-7519', 'oouverc@bloglines.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (14, '2022-04-23 07:33:13', 'Teodor', 'Wingeat', '226-836-1401', 'twingeatd@businessweek.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (15, '2022-04-21 02:23:13', 'Joela', 'Peres', '202-781-8300', 'jperese@example.com', true, 'Genderfluid');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (16, '2022-04-27 13:57:19', 'Trace', 'Marwood', '435-221-6621', 'tmarwoodf@patch.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (17, '2022-10-05 07:04:18', 'Sapphira', 'Newlove', '820-303-4629', 'snewloveg@guardian.co.uk', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (18, '2022-05-16 06:54:56', 'Tirrell', 'McKeurton', '534-279-4125', 'tmckeurtonh@craigslist.org', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (19, '2021-12-27 06:56:45', 'Binni', 'Seint', '994-398-6867', 'bseinti@blogspot.com', false, 'Bigender');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (20, '2022-11-18 04:30:17', 'Sibbie', 'Ainley', '757-813-0214', 'sainleyj@mac.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (21, '2022-08-06 02:32:05', 'Sanson', 'Baverstock', '459-705-3312', 'sbaverstockk@huffingtonpost.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (22, '2022-02-03 17:26:45', 'Hewe', 'Cloney', '280-691-0295', 'hcloneyl@twitter.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (23, '2022-03-22 13:07:08', 'Raddy', 'Hovenden', '703-477-4786', 'rhovendenm@fastcompany.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (24, '2022-04-16 11:58:54', 'Ringo', 'Moxsom', '746-607-4189', 'rmoxsomn@cloudflare.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (25, '2022-08-20 08:52:17', 'Irena', 'Benedidick', '125-978-7733', 'ibenedidicko@fda.gov', true, 'Agender');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (26, '2022-07-28 08:51:10', 'Raphaela', 'Cockayme', '186-550-4904', 'rcockaymep@gizmodo.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (27, '2022-01-21 04:33:11', 'Galven', 'Morrall', '825-419-9579', 'gmorrallq@webs.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (28, '2022-09-03 06:08:01', 'Trisha', 'Cherry', '215-507-0530', 'tcherryr@harvard.edu', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (29, '2022-08-19 22:29:24', 'Bernita', 'Smorfit', '947-924-0277', 'bsmorfits@ebay.com', true, 'Genderqueer');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (30, '2022-08-29 17:03:02', 'Pier', 'Autie', '147-683-3176', 'pautiet@over-blog.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (31, '2022-02-22 06:48:42', 'Ardra', 'Howford', '694-779-4450', 'ahowfordu@rambler.ru', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (32, '2022-08-26 16:02:16', 'Holmes', 'Avann', '770-346-1144', 'havannv@imageshack.us', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (33, '2022-01-23 11:44:53', 'Minda', 'Cusworth', '252-566-6999', 'mcusworthw@smugmug.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (34, '2022-09-20 15:26:43', 'Haslett', 'Larmet', '431-502-1848', 'hlarmetx@patch.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (35, '2022-09-20 02:46:42', 'Bartolemo', 'Gurko', '720-992-4004', 'bgurkoy@edublogs.org', false, 'Agender');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (36, '2022-11-22 22:30:05', 'Alaric', 'Hodgin', '222-838-6879', 'ahodginz@pagesperso-orange.fr', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (37, '2022-11-03 16:22:46', 'Tyler', 'Bunch', '900-722-1193', 'tbunch10@home.pl', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (38, '2022-07-04 05:49:16', 'Ulberto', 'Denny', '340-335-0732', 'udenny11@google.com.hk', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (39, '2022-05-06 17:55:29', 'Sada', 'Hamley', '233-280-8678', 'shamley12@amazon.de', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (40, '2022-04-26 03:11:20', 'Athene', 'Iacovini', '852-185-3143', 'aiacovini13@unicef.org', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (41, '2022-05-20 10:40:26', 'Friedrich', 'Olyfat', '783-910-5029', 'folyfat14@hud.gov', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (42, '2022-05-23 19:15:49', 'Burnard', 'Marques', '500-325-0725', 'bmarques15@sun.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (43, '2022-10-10 07:24:25', 'Loella', 'Maggill''Andreis', '679-440-0147', 'lmaggillandreis16@discovery.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (44, '2022-05-14 05:53:35', 'Daisey', 'Bickerstaff', '773-953-1417', 'dbickerstaff17@netscape.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (45, '2022-09-03 16:26:59', 'Quint', 'Oswal', '928-412-3626', 'qoswal18@godaddy.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (46, '2022-01-03 04:39:41', 'Ivy', 'Filyushkin', '795-438-5474', 'ifilyushkin19@state.gov', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (47, '2022-08-17 11:28:59', 'Torey', 'Forlong', '221-330-8141', 'tforlong1a@cnbc.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (48, '2022-04-18 13:59:30', 'Shelby', 'Prozillo', '112-999-1362', 'sprozillo1b@unblog.fr', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (49, '2022-06-30 06:41:36', 'Suzanna', 'Verey', '624-392-4195', 'sverey1c@tripod.com', false, 'Genderfluid');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (50, '2022-03-08 07:32:27', 'Oona', 'Reckus', '539-934-8522', 'oreckus1d@freewebs.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (51, '2022-11-24 14:58:57', 'Cristi', 'Harbor', '903-819-9154', 'charbor1e@mit.edu', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (52, '2022-05-12 16:22:06', 'Gunner', 'Mournian', '425-907-1614', 'gmournian1f@sina.com.cn', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (53, '2022-03-10 17:07:00', 'William', 'McChruiter', '913-531-7621', 'wmcchruiter1g@smugmug.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (54, '2021-12-07 01:45:53', 'Kaitlynn', 'Toth', '571-912-4011', 'ktoth1h@dagondesign.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (55, '2022-09-13 14:09:30', 'Gratia', 'Tother', '498-402-4563', 'gtother1i@umn.edu', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (56, '2022-05-25 21:50:19', 'Daniele', 'Mapston', '544-784-1506', 'dmapston1j@bloglovin.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (57, '2022-04-12 20:51:54', 'Antoine', 'Mansford', '269-500-1233', 'amansford1k@nsw.gov.au', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (58, '2022-01-05 04:28:58', 'Vevay', 'Ciciari', '786-621-2008', 'vciciari1l@wordpress.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (59, '2022-03-31 11:36:37', 'Harriott', 'Harrald', '104-926-6372', 'hharrald1m@issuu.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (60, '2021-12-24 16:55:16', 'Liv', 'Friberg', '720-565-2068', 'lfriberg1n@webeden.co.uk', true, 'Genderfluid');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (61, '2022-10-06 18:47:57', 'Joaquin', 'Nicklen', '939-742-5527', 'jnicklen1o@rediff.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (62, '2022-02-09 19:58:03', 'Margeaux', 'Aitken', '917-267-6873', 'maitken1p@tumblr.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (63, '2022-02-10 14:18:19', 'Eadith', 'Nisard', '919-907-1920', 'enisard1q@jalbum.net', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (64, '2022-02-03 08:26:52', 'Baudoin', 'Creddon', '492-371-0870', 'bcreddon1r@disqus.com', true, 'Bigender');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (65, '2022-09-29 08:33:49', 'Calida', 'Gostridge', '563-457-8913', 'cgostridge1s@nytimes.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (66, '2022-08-18 22:10:27', 'Carley', 'Harroway', '356-110-1727', 'charroway1t@virginia.edu', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (67, '2022-06-03 06:01:29', 'Wynne', 'Scholling', '380-888-2258', 'wscholling1u@nymag.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (68, '2022-02-10 00:53:16', 'Dionis', 'Kensitt', '410-747-0246', 'dkensitt1v@mac.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (69, '2022-05-05 07:46:42', 'Allan', 'Tichelaar', '574-680-1482', 'atichelaar1w@walmart.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (70, '2022-07-25 20:15:32', 'Richie', 'Gaunt', '885-730-9089', 'rgaunt1x@hugedomains.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (71, '2022-06-22 14:01:45', 'Dosi', 'Gerbi', '719-586-7448', 'dgerbi1y@theguardian.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (72, '2022-10-17 10:41:32', 'Karolina', 'Yarrow', '951-523-8579', 'kyarrow1z@icq.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (73, '2022-04-09 11:06:25', 'Sheree', 'Benedite', '542-252-0213', 'sbenedite20@noaa.gov', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (74, '2022-03-25 06:42:25', 'Haven', 'Hovard', '339-897-1102', 'hhovard21@hc360.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (75, '2022-08-25 21:49:17', 'Grayce', 'Quinnette', '267-197-9769', 'gquinnette22@msu.edu', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (76, '2022-07-09 05:02:24', 'Rafferty', 'Ryall', '810-559-3215', 'rryall23@europa.eu', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (77, '2022-03-06 06:12:13', 'Vaughan', 'Almey', '182-957-0920', 'valmey24@vimeo.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (78, '2022-05-06 04:00:29', 'Eveline', 'Roseaman', '318-459-0487', 'eroseaman25@last.fm', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (79, '2022-04-02 15:28:15', 'Luther', 'Farryan', '813-961-1044', 'lfarryan26@studiopress.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (80, '2022-10-22 21:20:11', 'Cherri', 'Troker', '685-976-1483', 'ctroker27@google.pl', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (81, '2022-11-17 04:43:10', 'Chris', 'Liston', '216-156-9881', 'cliston28@123-reg.co.uk', true, 'Genderfluid');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (82, '2022-04-09 13:49:43', 'Malvina', 'Guise', '518-872-4618', 'mguise29@oracle.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (83, '2021-12-27 13:29:33', 'Yevette', 'Billborough', '436-109-4018', 'ybillborough2a@elegantthemes.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (84, '2021-12-25 22:19:39', 'Lexis', 'Hryskiewicz', '715-288-3883', 'lhryskiewicz2b@wordpress.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (85, '2021-12-24 04:06:57', 'Adam', 'Terren', '431-170-5571', 'aterren2c@spotify.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (86, '2022-10-11 04:53:57', 'Lilas', 'Kesley', '365-442-7487', 'lkesley2d@wp.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (87, '2022-10-13 03:07:52', 'Cedric', 'Risson', '989-726-5739', 'crisson2e@huffingtonpost.com', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (88, '2022-04-30 14:46:28', 'Dulcia', 'Huegett', '533-779-7008', 'dhuegett2f@exblog.jp', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (89, '2022-08-10 13:31:54', 'Cortney', 'Bricham', '487-486-9361', 'cbricham2g@timesonline.co.uk', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (90, '2022-03-10 07:49:22', 'Stirling', 'Corday', '368-402-1603', 'scorday2h@va.gov', false, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (91, '2022-02-22 00:30:28', 'Willetta', 'Degli Antoni', '222-171-3033', 'wdegliantoni2i@theatlantic.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (92, '2022-06-15 22:07:37', 'Bar', 'Storey', '298-890-9375', 'bstorey2j@moonfruit.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (93, '2022-03-27 21:07:47', 'August', 'Dummer', '186-881-6347', 'adummer2k@ucoz.com', true, 'Male');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (94, '2022-08-18 22:04:44', 'Daisie', 'Valler', '661-578-5613', 'dvaller2l@soup.io', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (95, '2022-11-14 16:09:45', 'Lynette', 'Povele', '908-849-1353', 'lpovele2m@sbwire.com', true, 'Polygender');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (96, '2022-01-12 06:04:13', 'Orren', 'Gerrets', '893-420-3723', 'ogerrets2n@ihg.com', true, 'Agender');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (97, '2022-12-04 07:40:08', 'Nichol', 'Pedley', '655-323-5300', 'npedley2o@cisco.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (98, '2022-01-15 10:19:10', 'Stefa', 'Barcroft', '639-476-4520', 'sbarcroft2p@delicious.com', false, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (99, '2022-04-22 17:06:13', 'Adriane', 'Spritt', '574-458-6169', 'aspritt2q@list-manage.com', true, 'Female');
insert into admin (adminID, birthdate, firstName, lastName, phone, email, permissions, gender) values (100, '2022-06-25 19:34:51', 'Ringo', 'Krammer', '677-864-9921', 'rkrammer2r@ycombinator.com', false, 'Male');

insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (1, 'Keylex', 79, 11);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (2, 'Tempsoft', 75, 62);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (3, 'Redhold', 27, 68);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (4, 'Toughjoyfax', 45, 46);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (5, 'Cookley', 59, 71);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (6, 'Tin', 76, 95);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (7, 'Solarbreeze', 68, 8);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (8, 'Redhold', 36, 74);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (9, 'Treeflex', 35, 1);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (10, 'Zathin', 8, 37);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (11, 'Voyatouch', 89, 15);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (12, 'Ronstring', 42, 41);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (13, 'Zamit', 2, 58);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (14, 'Bitchip', 54, 48);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (15, 'Konklux', 53, 25);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (16, 'Voyatouch', 50, 44);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (17, 'Transcof', 25, 31);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (18, 'Ronstring', 44, 98);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (19, 'Fixflex', 44, 71);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (20, 'Zoolab', 28, 6);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (21, 'Flexidy', 39, 10);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (22, 'Hatity', 38, 24);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (23, 'Zaam-Dox', 15, 22);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (24, 'Tresom', 52, 55);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (25, 'Subin', 76, 73);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (26, 'Quo Lux', 53, 32);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (27, 'Voyatouch', 60, 56);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (28, 'Andalax', 77, 44);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (29, 'Flexidy', 28, 83);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (30, 'Bitchip', 51, 18);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (31, 'It', 66, 44);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (32, 'Redhold', 34, 53);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (33, 'Domainer', 32, 80);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (34, 'Sonair', 4, 92);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (35, 'Zaam-Dox', 80, 32);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (36, 'Cardify', 72, 69);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (37, 'Ronstring', 69, 60);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (38, 'Opela', 61, 41);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (39, 'Alpha', 70, 68);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (40, 'Wrapsafe', 36, 67);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (41, 'Trippledex', 56, 28);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (42, 'Flexidy', 85, 66);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (43, 'Viva', 94, 46);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (44, 'Gembucket', 98, 46);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (45, 'Flexidy', 53, 3);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (46, 'Tin', 74, 68);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (47, 'Wrapsafe', 93, 64);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (48, 'Holdlamis', 5, 99);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (49, 'Cardguard', 96, 60);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (50, 'Alphazap', 22, 100);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (51, 'Bitwolf', 61, 41);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (52, 'Fixflex', 6, 70);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (53, 'Konklux', 65, 15);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (54, 'Trippledex', 12, 11);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (55, 'Bitchip', 77, 75);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (56, 'Viva', 31, 27);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (57, 'Cardify', 87, 57);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (58, 'Vagram', 62, 43);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (59, 'Lotlux', 14, 98);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (60, 'Ronstring', 43, 35);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (61, 'Redhold', 39, 59);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (62, 'Flexidy', 3, 33);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (63, 'Tin', 58, 41);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (64, 'Redhold', 43, 90);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (65, 'Vagram', 28, 19);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (66, 'Redhold', 43, 29);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (67, 'Bamity', 91, 16);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (68, 'Alphazap', 75, 6);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (69, 'Zoolab', 98, 11);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (70, 'Latlux', 46, 94);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (71, 'Bitwolf', 96, 60);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (72, 'Stringtough', 36, 70);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (73, 'Hatity', 44, 63);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (74, 'Bigtax', 67, 9);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (75, 'Flexidy', 100, 100);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (76, 'Stim', 51, 62);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (77, 'Treeflex', 54, 98);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (78, 'Tempsoft', 66, 93);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (79, 'Rank', 11, 51);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (80, 'Latlux', 41, 97);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (81, 'Prodder', 80, 55);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (82, 'Holdlamis', 53, 98);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (83, 'Regrant', 9, 19);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (84, 'Stringtough', 75, 8);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (85, 'Asoka', 77, 28);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (86, 'Job', 63, 100);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (87, 'Alpha', 50, 86);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (88, 'Ronstring', 99, 15);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (89, 'Cardify', 33, 10);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (90, 'Solarbreeze', 91, 63);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (91, 'Bitchip', 85, 71);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (92, 'Kanlam', 75, 57);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (93, 'Otcom', 80, 74);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (94, 'Holdlamis', 84, 96);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (95, 'Redhold', 20, 46);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (96, 'Bigtax', 67, 49);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (97, 'Kanlam', 43, 79);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (98, 'Lotlux', 70, 88);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (99, 'Stringtough', 70, 23);
insert into flight_portfolio (portfolioID, portfolio_name, adminID, userID) values (100, 'Tempsoft', 49, 51);



insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (1, false, '2022-07-20 21:47:02', 'Vivamus in felis eu sapien cursus vestibulum.', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 47, 5, 11, 49, 41, '2021-12-29 23:07:56', 'United', false, 'BXK', 'BOU', '$560.81', '$98.42', '$609.53', '5:26 PM', '3:59 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (2, true, '2022-05-26 17:36:27', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', 5, 81, 45, 66, 75, '2022-02-01 20:13:31', 'Delta', false, 'CPF', 'BIO', '$843.77', '$249.45', '$604.54', '7:02 PM', '4:26 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (3, false, '2022-01-30 11:09:12', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 45, 44, 56, 59, 72, '2022-05-31 01:43:38', 'Delta', true, 'MVR', 'YBW', '$329.82', '$501.74', '$625.80', '9:57 PM', '10:12 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (4, false, '2022-05-02 16:59:58', 'Integer ac neque. Duis bibendum.', 'Duis ac nibh.', 24, 39, 75, 53, 6, '2022-04-04 11:37:25', 'JetBlue', true, 'GEM', 'WLG', '$651.60', '$323.59', '$75.49', '8:46 PM', '12:32 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (5, true, '2022-06-13 19:11:28', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 'Vivamus in felis eu sapien cursus vestibulum.', 43, 8, 97, 81, 58, '2022-11-06 03:19:47', 'United', false, 'VDP', 'MDM', '$584.07', '$333.95', '$943.80', '6:26 PM', '3:20 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (6, true, '2022-08-08 04:24:07', 'Aliquam erat volutpat. In congue.', 'Morbi non lectus.', 65, 63, 1, 25, 36, '2022-06-01 14:16:13', 'Delta', true, 'TNW', 'LYN', '$160.89', '$182.04', '$208.07', '9:29 AM', '7:44 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (7, true, '2022-02-06 00:57:14', 'In sagittis dui vel nisl. Duis ac nibh.', 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 92, 37, 93, 70, 52, '2022-05-08 17:15:24', 'Delta', true, 'KET', 'IPT', '$650.79', '$739.39', '$166.20', '11:54 AM', '5:12 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (8, true, '2022-03-04 04:03:30', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 74, 69, 72, 90, 82, '2022-07-05 04:21:54', 'United', false, 'MCQ', 'TRU', '$496.19', '$923.47', '$419.20', '2:38 AM', '9:52 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (9, false, '2022-06-19 09:19:19', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Etiam pretium iaculis justo. In hac habitasse platea dictumst.', 13, 43, 84, 94, 52, '2021-12-24 16:23:50', 'JetBlue', false, 'MGF', 'ABC', '$584.84', '$329.67', '$425.16', '5:10 AM', '9:54 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (10, true, '2022-03-15 07:26:33', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 45, 14, 96, 82, 65, '2022-07-24 11:45:01', 'JetBlue', false, 'YWO', 'YAO', '$117.88', '$592.37', '$550.12', '11:16 PM', '7:50 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (11, true, '2021-12-19 10:30:21', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', 'Mauris lacinia sapien quis libero.', 36, 39, 24, 23, 36, '2022-10-20 08:32:25', 'Alaskan Airlines', true, 'EPA', 'SVV', '$992.55', '$629.13', '$880.29', '4:38 AM', '8:04 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (12, true, '2022-07-16 10:57:00', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', 1, 10, 62, 87, 59, '2022-03-13 13:24:48', 'Alaskan Airlines', false, 'ERH', 'HEX', '$686.13', '$749.60', '$710.06', '7:10 AM', '4:28 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (13, true, '2022-01-13 03:32:16', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 'Morbi non lectus.', 59, 63, 88, 46, 11, '2022-01-01 03:15:20', 'Hawaiian Airlines', false, 'SZI', 'ZOF', '$297.47', '$576.44', '$687.17', '2:15 AM', '10:48 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (14, true, '2022-11-18 10:09:05', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 90, 46, 23, 88, 84, '2022-05-29 16:43:58', 'Delta', true, 'GRK', 'RBQ', '$469.16', '$90.26', '$372.88', '8:23 PM', '5:47 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (15, true, '2022-09-08 14:45:26', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 21, 38, 61, 63, 64, '2022-10-29 11:51:28', 'United', false, 'HDN', 'BFR', '$130.44', '$916.22', '$725.46', '6:28 PM', '9:34 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (16, true, '2022-10-15 12:00:22', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', 'Sed ante.', 2, 39, 61, 92, 10, '2022-01-18 15:07:37', 'Southwest', false, 'CGD', 'JDH', '$577.64', '$305.25', '$397.39', '1:29 PM', '9:26 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (17, true, '2021-12-10 16:34:44', 'Sed ante. Vivamus tortor.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 22, 95, 14, 92, 88, '2022-04-12 23:16:06', 'United', false, 'WWK', 'SGQ', '$670.86', '$401.91', '$116.52', '6:01 PM', '2:56 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (18, true, '2022-06-17 12:52:22', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 'Fusce consequat.', 50, 81, 46, 77, 9, '2022-07-28 15:16:43', 'American', false, 'CGH', 'CRD', '$976.58', '$726.50', '$134.76', '4:17 PM', '10:14 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (19, true, '2022-03-15 18:08:07', 'Ut tellus. Nulla ut erat id mauris vulputate elementum.', 'In congue. Etiam justo.', 9, 65, 100, 98, 30, '2022-04-09 23:12:32', 'Alaskan Airlines', false, 'RVT', 'SLI', '$389.31', '$558.84', '$416.78', '4:25 AM', '6:58 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (20, false, '2022-05-14 11:05:35', 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', 1, 80, 47, 69, 27, '2022-03-18 00:10:19', 'American', false, 'BSA', 'YUM', '$458.47', '$227.74', '$538.50', '2:05 PM', '3:31 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (21, true, '2022-05-12 03:42:30', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 23, 43, 97, 8, 74, '2022-06-21 14:56:04', 'United', true, 'SUV', 'AWE', '$900.78', '$984.28', '$296.23', '10:12 AM', '8:46 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (22, false, '2022-01-09 18:37:43', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 83, 47, 63, 93, 60, '2022-11-18 04:07:46', 'Southwest', false, 'DEI', 'CQF', '$583.06', '$942.38', '$506.41', '4:23 AM', '4:02 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (23, true, '2022-10-20 01:42:51', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', 'Aliquam non mauris. Morbi non lectus.', 30, 51, 86, 62, 26, '2021-12-10 14:37:31', 'Alaskan Airlines', true, 'PMZ', 'AGY', '$311.29', '$61.65', '$340.62', '9:03 AM', '3:01 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (24, true, '2021-12-23 22:25:20', 'Maecenas ut massa quis augue luctus tincidunt.', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 52, 59, 55, 67, 89, '2022-09-26 18:46:32', 'JetBlue', false, 'ZIS', 'ATL', '$728.39', '$876.22', '$625.51', '5:45 AM', '7:53 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (25, true, '2022-01-13 05:46:41', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 32, 91, 7, 34, 19, '2022-04-07 12:10:39', 'Hawaiian Airlines', true, 'SKJ', 'KVA', '$977.76', '$513.58', '$806.02', '1:48 PM', '1:58 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (26, true, '2022-06-11 15:11:34', 'In quis justo.', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 82, 32, 14, 58, 77, '2022-11-30 13:40:32', 'Southwest', false, 'MCB', 'QCP', '$712.08', '$143.39', '$875.82', '11:03 PM', '5:27 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (27, false, '2022-07-27 06:00:06', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 41, 84, 72, 2, 5, '2022-10-15 13:55:44', 'American', false, 'LSO', 'BFU', '$328.97', '$720.84', '$927.00', '9:00 AM', '6:21 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (28, false, '2022-02-21 21:02:51', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 'Ut tellus. Nulla ut erat id mauris vulputate elementum.', 91, 46, 63, 68, 54, '2022-02-22 02:01:03', 'American', true, 'BTZ', 'ABG', '$614.70', '$475.26', '$215.56', '7:48 AM', '12:52 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (29, false, '2022-06-22 13:19:29', 'Mauris lacinia sapien quis libero.', 'Pellentesque viverra pede ac diam.', 64, 4, 77, 21, 27, '2022-05-27 03:36:46', 'Hawaiian Airlines', true, 'RSL', 'TCE', '$444.30', '$895.14', '$200.87', '8:25 AM', '4:49 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (30, false, '2022-03-26 17:36:24', 'Morbi non quam nec dui luctus rutrum.', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 76, 89, 92, 16, 50, '2022-07-03 20:38:39', 'Delta', false, 'TMJ', 'PHN', '$788.80', '$864.53', '$405.25', '7:18 PM', '11:55 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (31, true, '2022-06-22 11:37:56', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 88, 12, 15, 31, 74, '2022-09-10 12:49:01', 'Southwest', true, 'DNX', 'YMH', '$148.69', '$647.32', '$183.19', '11:44 AM', '2:25 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (32, false, '2022-08-15 05:39:51', 'Nam dui.', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', 29, 18, 77, 59, 59, '2022-08-09 13:25:47', 'Delta', false, 'QDY', 'YGM', '$93.56', '$701.90', '$240.57', '10:19 AM', '6:37 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (33, false, '2022-07-24 00:38:03', 'Suspendisse potenti.', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 62, 90, 80, 2, 27, '2022-10-21 01:24:06', 'JetBlue', true, 'NRB', 'NKP', '$790.64', '$131.25', '$936.44', '6:19 PM', '1:55 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (34, true, '2022-01-06 12:46:00', 'Maecenas tincidunt lacus at velit.', 'Sed ante.', 36, 48, 12, 83, 29, '2022-07-30 17:45:32', 'United', true, 'BMY', 'AST', '$995.99', '$840.45', '$456.87', '9:39 PM', '8:37 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (35, true, '2022-01-08 01:36:01', 'Donec posuere metus vitae ipsum.', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', 56, 92, 42, 8, 76, '2022-06-12 12:14:45', 'Southwest', false, 'QNV', 'UAP', '$498.83', '$987.98', '$335.14', '2:19 PM', '7:04 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (36, true, '2022-07-17 13:08:23', 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 'Sed ante. Vivamus tortor.', 49, 95, 40, 10, 9, '2022-10-19 02:52:06', 'Hawaiian Airlines', false, 'SHX', 'HAY', '$93.93', '$249.99', '$630.41', '10:33 AM', '8:37 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (37, false, '2022-06-28 09:58:08', 'Duis aliquam convallis nunc.', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 35, 99, 17, 34, 86, '2022-06-29 22:41:31', 'JetBlue', true, 'ORM', 'ETS', '$304.89', '$158.15', '$55.17', '3:05 PM', '8:42 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (38, false, '2022-04-21 07:50:56', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 76, 6, 44, 95, 40, '2022-03-12 21:10:38', 'JetBlue', true, 'NSN', 'MRS', '$261.97', '$776.37', '$65.83', '3:25 AM', '6:38 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (39, true, '2022-05-28 10:49:03', 'Sed sagittis.', 'Aenean lectus.', 20, 45, 29, 23, 5, '2022-06-15 04:08:42', 'Southwest', false, 'FMC', 'SFZ', '$925.71', '$110.91', '$294.78', '7:15 PM', '4:59 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (40, true, '2022-03-27 22:35:56', 'Donec semper sapien a libero.', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 24, 14, 65, 75, 76, '2022-07-26 14:51:45', 'Hawaiian Airlines', false, 'WTO', 'ELG', '$372.68', '$752.97', '$904.03', '12:52 PM', '5:03 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (41, false, '2022-09-29 22:22:44', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 'Aliquam sit amet diam in magna bibendum imperdiet.', 26, 79, 67, 33, 56, '2022-06-17 21:41:24', 'Alaskan Airlines', true, 'ZBE', 'BCL', '$210.90', '$843.76', '$148.62', '12:47 AM', '11:14 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (42, true, '2022-05-31 22:44:56', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 'Etiam faucibus cursus urna. Ut tellus.', 90, 98, 42, 81, 47, '2022-09-13 14:42:44', 'Southwest', true, 'YUB', 'NOZ', '$281.93', '$930.49', '$964.14', '6:32 AM', '9:25 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (43, false, '2022-07-30 00:29:15', 'Nunc purus.', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 4, 83, 69, 92, 96, '2022-01-10 11:35:47', 'American', false, 'EUM', 'CBG', '$312.32', '$464.71', '$792.58', '12:13 PM', '7:00 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (44, true, '2022-04-22 20:19:46', 'Nulla tellus. In sagittis dui vel nisl.', 'In quis justo.', 44, 1, 35, 88, 80, '2022-11-14 11:17:20', 'Delta', true, 'KML', 'AKI', '$221.26', '$821.29', '$646.67', '1:41 PM', '3:10 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (45, false, '2022-02-20 02:43:36', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', 39, 23, 67, 46, 69, '2022-03-26 13:35:59', 'JetBlue', false, 'KEO', 'LSI', '$764.56', '$386.54', '$344.29', '3:53 AM', '7:53 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (46, true, '2022-06-15 23:55:30', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 53, 94, 32, 66, 76, '2022-01-14 15:37:22', 'United', false, 'TFY', 'GML', '$335.31', '$699.65', '$533.23', '2:31 AM', '10:34 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (47, false, '2022-03-30 10:39:35', 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', 90, 91, 52, 87, 82, '2022-10-17 20:19:33', 'United', true, 'KEP', 'UNU', '$466.22', '$995.73', '$338.75', '3:19 AM', '3:53 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (48, true, '2022-08-13 04:21:05', 'Duis bibendum. Morbi non quam nec dui luctus rutrum.', 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 48, 17, 2, 91, 33, '2022-04-06 17:34:00', 'Delta', true, 'YBR', 'BRO', '$453.33', '$788.98', '$434.98', '12:44 AM', '9:57 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (49, false, '2022-04-12 21:29:13', 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 16, 12, 33, 70, 2, '2022-05-25 01:00:37', 'Hawaiian Airlines', false, 'JSY', 'O62', '$941.27', '$482.11', '$516.48', '1:44 PM', '9:27 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (50, true, '2022-08-28 12:10:51', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 'Donec ut dolor.', 19, 2, 53, 41, 63, '2022-03-01 05:06:02', 'American', true, 'ECH', 'KZB', '$452.30', '$816.59', '$932.53', '3:42 AM', '8:35 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (51, true, '2022-09-07 15:06:31', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.', 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', 46, 60, 56, 35, 5, '2021-12-27 11:53:03', 'Alaskan Airlines', true, 'CTF', 'HVS', '$767.85', '$281.38', '$509.29', '2:56 PM', '6:15 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (52, true, '2022-11-13 21:43:40', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 'Donec vitae nisi.', 93, 94, 10, 11, 100, '2022-08-04 07:54:29', 'United', true, 'RBD', 'MPK', '$65.57', '$846.08', '$595.12', '9:18 PM', '1:34 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (53, false, '2022-08-25 13:48:35', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 14, 49, 92, 42, 29, '2022-03-20 16:11:31', 'Hawaiian Airlines', false, 'YIV', 'LXS', '$342.16', '$740.31', '$341.93', '11:10 AM', '3:49 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (54, true, '2022-10-24 14:43:37', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 25, 80, 90, 5, 6, '2021-12-20 12:54:19', 'Alaskan Airlines', false, 'MIH', 'DSG', '$838.14', '$256.75', '$647.45', '10:43 AM', '7:44 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (55, false, '2022-03-24 04:21:48', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 70, 56, 68, 19, 34, '2022-12-03 10:32:21', 'United', false, 'PJC', 'ORZ', '$311.25', '$516.50', '$347.64', '8:50 PM', '5:27 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (56, true, '2022-09-14 21:47:31', 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 'Pellentesque at nulla.', 12, 42, 9, 68, 12, '2022-07-23 20:56:47', 'JetBlue', true, 'EFK', 'TZL', '$723.21', '$725.76', '$467.37', '11:15 PM', '4:05 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (57, true, '2021-12-28 00:45:50', 'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 92, 55, 22, 61, 31, '2022-09-24 07:33:02', 'Alaskan Airlines', true, 'CFD', 'TSD', '$451.14', '$220.11', '$69.48', '2:35 PM', '3:17 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (58, true, '2022-01-04 22:41:04', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 'Sed ante. Vivamus tortor.', 39, 16, 90, 35, 48, '2022-09-24 12:32:52', 'Delta', true, 'AQB', 'WEP', '$718.15', '$659.09', '$962.28', '4:09 PM', '5:38 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (59, false, '2022-03-17 11:27:06', 'Morbi quis tortor id nulla ultrices aliquet.', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', 76, 10, 38, 97, 90, '2022-10-30 20:23:20', 'Southwest', false, 'BZR', 'CDQ', '$295.42', '$402.52', '$534.12', '7:09 PM', '8:40 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (60, false, '2022-04-29 11:33:56', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 16, 37, 71, 51, 1, '2022-03-16 17:12:56', 'Alaskan Airlines', false, 'FOY', 'SQV', '$837.68', '$669.40', '$282.43', '3:33 PM', '9:51 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (61, false, '2022-09-24 08:53:12', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 43, 45, 7, 100, 9, '2022-01-22 02:06:58', 'Southwest', false, 'BXP', 'PGM', '$67.62', '$740.36', '$168.12', '12:31 AM', '4:53 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (62, false, '2022-05-18 16:42:33', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 'Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.', 30, 73, 59, 74, 41, '2022-07-18 19:32:55', 'Alaskan Airlines', false, 'YRQ', 'RWN', '$50.25', '$801.28', '$466.27', '8:24 AM', '1:11 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (63, false, '2022-07-19 09:38:03', 'Fusce consequat. Nulla nisl.', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 70, 20, 22, 44, 87, '2022-06-29 08:32:11', 'Delta', true, 'VCS', 'BAZ', '$982.23', '$432.67', '$741.47', '7:23 PM', '6:45 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (64, false, '2021-12-23 01:11:43', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 32, 93, 89, 39, 9, '2022-03-14 09:34:12', 'Southwest', false, 'IXE', 'LUY', '$131.08', '$513.32', '$440.18', '7:00 PM', '10:55 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (65, true, '2022-03-11 01:30:44', 'Proin risus.', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', 78, 3, 95, 64, 26, '2022-09-13 19:24:25', 'American', true, 'LUW', 'LDY', '$759.96', '$796.73', '$625.48', '1:50 AM', '10:55 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (66, false, '2022-04-27 07:34:29', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 45, 19, 91, 26, 37, '2022-11-08 13:48:37', 'Hawaiian Airlines', false, 'SZL', 'KNR', '$198.01', '$784.08', '$407.89', '7:10 AM', '8:53 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (67, false, '2022-04-03 02:53:33', 'Vivamus vestibulum sagittis sapien.', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.', 34, 36, 66, 7, 76, '2022-01-27 20:19:43', 'American', true, 'ART', 'LRG', '$354.59', '$134.78', '$294.55', '4:09 PM', '8:19 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (68, true, '2022-05-23 15:14:21', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 100, 96, 48, 53, 93, '2022-08-31 06:50:37', 'JetBlue', true, 'OKU', 'MQF', '$116.83', '$633.80', '$777.51', '9:48 PM', '6:58 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (69, true, '2022-11-28 23:38:16', 'Ut at dolor quis odio consequat varius.', 'Aliquam erat volutpat. In congue.', 29, 65, 56, 82, 85, '2022-10-14 04:38:08', 'Hawaiian Airlines', false, 'CST', 'GKL', '$609.26', '$643.45', '$57.33', '7:25 AM', '7:11 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (70, true, '2022-02-10 01:29:05', 'In blandit ultrices enim.', 'Ut tellus.', 58, 77, 47, 34, 29, '2022-08-01 11:13:53', 'Hawaiian Airlines', false, 'PFC', 'BGR', '$597.69', '$607.90', '$537.84', '3:37 AM', '12:24 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (71, false, '2022-10-28 21:48:49', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 'Aliquam quis turpis eget elit sodales scelerisque.', 52, 32, 60, 60, 79, '2022-07-02 16:07:18', 'Delta', true, 'GEA', 'OCW', '$170.95', '$532.44', '$557.65', '4:42 PM', '11:16 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (72, false, '2022-02-28 15:27:41', 'Nullam porttitor lacus at turpis.', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 31, 46, 15, 81, 21, '2022-10-14 21:36:51', 'United', true, 'XNN', 'SDC', '$68.63', '$584.47', '$870.20', '5:06 AM', '12:33 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (73, true, '2022-06-17 14:43:58', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 'Nunc purus. Phasellus in felis. Donec semper sapien a libero.', 56, 44, 88, 7, 11, '2022-03-19 02:09:06', 'Alaskan Airlines', true, 'TKN', 'KNZ', '$374.85', '$187.32', '$938.89', '11:50 PM', '3:24 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (74, false, '2022-05-03 00:27:36', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 'Donec ut mauris eget massa tempor convallis.', 30, 17, 60, 65, 99, '2022-07-06 12:42:42', 'JetBlue', false, 'DWH', 'FKN', '$500.48', '$253.34', '$716.41', '12:14 PM', '5:34 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (75, false, '2022-02-26 20:11:33', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 72, 69, 99, 5, 82, '2022-06-13 10:15:32', 'JetBlue', false, 'YGG', 'UMT', '$845.84', '$666.59', '$188.70', '8:49 AM', '3:06 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (76, true, '2022-10-14 16:25:13', 'Nullam varius.', 'Nunc nisl.', 5, 74, 9, 56, 71, '2022-07-21 00:54:08', 'United', false, 'GKE', 'INB', '$288.29', '$348.67', '$721.58', '12:36 AM', '4:59 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (77, true, '2022-08-15 20:07:52', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 'Nam dui.', 5, 26, 91, 76, 88, '2022-05-28 14:04:26', 'Southwest', true, 'NRL', 'BSX', '$270.89', '$539.23', '$468.52', '5:46 PM', '11:05 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (78, false, '2022-06-22 04:53:50', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', 'Integer non velit.', 62, 94, 18, 50, 16, '2022-08-01 05:33:16', 'United', false, 'DOA', 'CPI', '$367.93', '$778.02', '$427.96', '8:01 PM', '4:52 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (79, false, '2022-11-30 14:49:41', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', 34, 71, 78, 88, 70, '2022-07-21 21:43:48', 'Delta', false, 'LQM', 'TRI', '$404.55', '$494.49', '$783.53', '7:05 PM', '5:53 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (80, false, '2022-07-02 22:28:03', 'Nam nulla.', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 54, 69, 78, 93, 20, '2022-05-11 04:09:21', 'American', false, 'WGY', 'RBE', '$502.05', '$115.98', '$684.35', '11:27 PM', '9:11 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (81, false, '2022-06-19 06:35:48', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 2, 51, 9, 81, 72, '2022-02-17 14:29:11', 'Delta', false, 'LEH', 'PPN', '$589.93', '$480.20', '$812.52', '4:54 AM', '4:16 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (82, true, '2022-09-12 18:38:32', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 'Morbi non quam nec dui luctus rutrum.', 8, 35, 24, 80, 59, '2022-07-11 13:28:29', 'Southwest', false, 'CXM', 'GZO', '$876.88', '$376.97', '$841.00', '11:07 AM', '9:06 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (83, true, '2022-05-28 05:17:57', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 'Praesent blandit. Nam nulla.', 39, 45, 96, 77, 53, '2022-06-05 10:31:33', 'United', false, 'CMW', 'OGN', '$78.01', '$274.81', '$385.31', '12:43 PM', '11:35 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (84, true, '2022-08-10 06:17:55', 'In congue.', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 32, 24, 88, 14, 99, '2022-05-10 07:01:08', 'Delta', false, 'VRU', 'YTG', '$834.26', '$817.10', '$995.19', '7:18 AM', '5:13 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (85, false, '2022-02-27 22:06:58', 'Mauris ullamcorper purus sit amet nulla.', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', 9, 42, 53, 89, 3, '2022-10-07 18:41:25', 'JetBlue', false, 'LIA', 'WMN', '$346.59', '$151.92', '$223.74', '9:04 AM', '3:54 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (86, true, '2022-08-31 19:27:24', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 59, 99, 58, 89, 79, '2022-07-30 22:00:33', 'Southwest', false, '0', 'HRB', '$551.06', '$557.54', '$708.33', '1:08 AM', '6:43 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (87, true, '2022-01-29 15:35:27', 'Praesent id massa id nisl venenatis lacinia.', 'Morbi quis tortor id nulla ultrices aliquet.', 77, 90, 24, 99, 42, '2022-02-09 21:01:22', 'Southwest', true, 'SPX', 'BEN', '$521.80', '$690.33', '$410.56', '4:17 AM', '2:43 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (88, false, '2022-02-02 01:30:08', 'Nulla tellus.', 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', 8, 88, 44, 46, 33, '2022-06-30 10:52:52', 'American', false, 'YCH', 'TCO', '$674.42', '$886.08', '$266.68', '9:05 AM', '9:57 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (89, false, '2022-04-19 17:31:39', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 'Duis at velit eu est congue elementum.', 77, 95, 93, 100, 10, '2022-06-20 09:45:33', 'Hawaiian Airlines', false, 'NDK', 'VPZ', '$195.73', '$685.58', '$151.82', '7:04 PM', '12:16 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (90, true, '2022-05-01 05:03:19', 'Aliquam erat volutpat. In congue.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 5, 16, 41, 92, 40, '2022-11-03 00:04:08', 'American', true, 'ZBY', 'YYQ', '$626.62', '$55.69', '$584.49', '11:38 AM', '2:36 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (91, false, '2022-02-12 22:24:30', 'Nulla nisl. Nunc nisl.', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', 57, 2, 35, 38, 97, '2022-07-12 00:02:56', 'American', true, 'HGA', 'QEF', '$868.90', '$507.28', '$843.52', '9:49 PM', '7:50 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (92, true, '2022-01-14 20:10:13', 'Phasellus in felis. Donec semper sapien a libero.', 'Aliquam non mauris. Morbi non lectus.', 61, 18, 35, 82, 97, '2022-08-27 01:11:04', 'JetBlue', false, 'OMD', 'LHV', '$599.13', '$409.03', '$545.41', '1:17 PM', '1:00 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (93, false, '2022-06-01 06:51:46', 'Duis aliquam convallis nunc.', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 31, 51, 90, 15, 29, '2022-05-18 16:47:31', 'JetBlue', true, 'ACR', 'JPR', '$86.08', '$339.31', '$351.63', '6:52 PM', '5:10 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (94, false, '2022-10-08 08:44:07', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 53, 56, 12, 48, 21, '2022-05-30 23:08:33', 'American', true, 'KWF', 'BNE', '$252.29', '$511.46', '$458.72', '3:39 PM', '11:24 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (95, true, '2022-07-12 05:05:39', 'Donec dapibus. Duis at velit eu est congue elementum.', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 17, 42, 94, 65, 60, '2022-07-06 12:32:51', 'American', true, 'SVI', 'NLT', '$367.68', '$123.01', '$173.63', '2:48 PM', '6:55 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (96, false, '2022-11-14 12:30:23', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 'Pellentesque at nulla.', 89, 24, 83, 18, 90, '2022-10-07 21:11:45', 'United', true, 'TSR', 'KRI', '$984.75', '$602.52', '$656.37', '10:11 PM', '6:34 PM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (97, true, '2022-04-10 10:06:06', 'Nulla mollis molestie lorem. Quisque ut erat.', 'Proin at turpis a pede posuere nonummy. Integer non velit.', 1, 100, 16, 92, 13, '2022-10-25 16:26:02', 'Southwest', false, 'GOH', 'RBU', '$362.78', '$50.00', '$920.52', '2:30 PM', '12:42 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (98, true, '2022-02-03 16:50:42', 'Morbi a ipsum.', 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 45, 75, 96, 46, 94, '2022-06-08 07:17:17', 'Hawaiian Airlines', false, 'PCJ', 'DEE', '$781.89', '$566.83', '$857.45', '9:36 PM', '8:50 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (99, false, '2022-08-14 15:26:09', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', 'Nunc purus. Phasellus in felis. Donec semper sapien a libero.', 54, 41, 36, 66, 17, '2021-12-17 07:22:48', 'Southwest', false, 'CPR', 'CSF', '$997.66', '$238.49', '$354.18', '11:15 AM', '4:30 AM');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (100, true, '2022-01-21 21:06:31', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 22, 32, 27, 37, 13, '2022-01-20 06:48:03', 'Delta', true, 'HAN', 'ALX', '$847.46', '$461.39', '$196.08', '10:06 AM', '4:16 AM');

insert into admin_login (loginID, username, password, adminID) values (1, 'dscoines0', 'F8QkA3', 34);
insert into admin_login (loginID, username, password, adminID) values (2, 'ryakunchikov1', 'WO4kGTJl', 42);
insert into admin_login (loginID, username, password, adminID) values (3, 'agiamo2', 'aFkDak', 53);
insert into admin_login (loginID, username, password, adminID) values (4, 'gsaiger3', 'NLiNC5bGZKN', 82);
insert into admin_login (loginID, username, password, adminID) values (5, 'jgoulstone4', 'd9xPA5FJ', 56);
insert into admin_login (loginID, username, password, adminID) values (6, 'bcatmull5', 'BHdqAw', 76);
insert into admin_login (loginID, username, password, adminID) values (7, 'podonohue6', 'vSB1oYWcD', 42);
insert into admin_login (loginID, username, password, adminID) values (8, 'dwrighton7', 'XJMs0DoBX5Wn', 98);
insert into admin_login (loginID, username, password, adminID) values (9, 'funderdown8', 'cG5CNZc0', 32);
insert into admin_login (loginID, username, password, adminID) values (10, 'dfishenden9', 'G0PpkhlDX9bx', 61);
insert into admin_login (loginID, username, password, adminID) values (11, 'cfollita', 'qIjxeJYaxvl', 82);
insert into admin_login (loginID, username, password, adminID) values (12, 'sdugganb', 'AdlLwnT7Eb', 78);
insert into admin_login (loginID, username, password, adminID) values (13, 'ddoolandc', 'F7mhYk', 66);
insert into admin_login (loginID, username, password, adminID) values (14, 'haskamd', 'axAYlAh', 12);
insert into admin_login (loginID, username, password, adminID) values (15, 'tlankforde', 'e7NM3r9XI', 97);
insert into admin_login (loginID, username, password, adminID) values (16, 'lpielf', 'ZothRU', 10);
insert into admin_login (loginID, username, password, adminID) values (17, 'mgarnhamg', 'ieRqUuL', 93);
insert into admin_login (loginID, username, password, adminID) values (18, 'lnorburyh', 'IdPpTn', 39);
insert into admin_login (loginID, username, password, adminID) values (19, 'dtomani', 'qpNqKoEgo', 56);
insert into admin_login (loginID, username, password, adminID) values (20, 'smairj', '2UmU6AG', 64);
insert into admin_login (loginID, username, password, adminID) values (21, 'amedwayk', '6O5MUzw6Nk', 39);
insert into admin_login (loginID, username, password, adminID) values (22, 'sdjordjevicl', 'Jqj7Rn30', 38);
insert into admin_login (loginID, username, password, adminID) values (23, 'fboutflourm', '12sygHPtKspi', 87);
insert into admin_login (loginID, username, password, adminID) values (24, 'cpirrien', 'JLlPzm31M', 90);
insert into admin_login (loginID, username, password, adminID) values (25, 'cgurlingo', 'CMgCYujDb', 89);
insert into admin_login (loginID, username, password, adminID) values (26, 'oablesonp', 'UIDrnQm', 35);
insert into admin_login (loginID, username, password, adminID) values (27, 'kdillandq', '26sKnqDY', 30);
insert into admin_login (loginID, username, password, adminID) values (28, 'jbulgenr', 'Xy5JGIY', 20);
insert into admin_login (loginID, username, password, adminID) values (29, 'imethuens', '1dO4fM', 72);
insert into admin_login (loginID, username, password, adminID) values (30, 'poxshottt', 'My4KOe', 28);
insert into admin_login (loginID, username, password, adminID) values (31, 'smeritu', 'RXQcfwfFP', 37);
insert into admin_login (loginID, username, password, adminID) values (32, 'jpoulsenv', 'DT8z9jzs', 50);
insert into admin_login (loginID, username, password, adminID) values (33, 'hclevew', 'x1hjouR', 11);
insert into admin_login (loginID, username, password, adminID) values (34, 'seltringhamx', 'lV74y2zf', 47);
insert into admin_login (loginID, username, password, adminID) values (35, 'enozzoliniiy', 'g2HefzI', 61);
insert into admin_login (loginID, username, password, adminID) values (36, 'jpinningtonz', 'OtxAZDHBP', 29);
insert into admin_login (loginID, username, password, adminID) values (37, 'ldryden10', '4VwXDVBCn', 8);
insert into admin_login (loginID, username, password, adminID) values (38, 'mmarre11', 'hQ4FEF9LIoO', 26);
insert into admin_login (loginID, username, password, adminID) values (39, 'chighman12', '82mFMv6uS7', 63);
insert into admin_login (loginID, username, password, adminID) values (40, 'arodda13', 'gnVRKal3', 6);
insert into admin_login (loginID, username, password, adminID) values (41, 'aenriques14', 'IYOOw4X1qtY', 35);
insert into admin_login (loginID, username, password, adminID) values (42, 'dhunt15', 'MXCtH7N', 17);
insert into admin_login (loginID, username, password, adminID) values (43, 'wtollemache16', 'tojvlYgbFsp', 13);
insert into admin_login (loginID, username, password, adminID) values (44, 'cinglish17', 'tHJ3nSVCcGAi', 37);
insert into admin_login (loginID, username, password, adminID) values (45, 'dklauber18', 'umaAOb3s8lPh', 24);
insert into admin_login (loginID, username, password, adminID) values (46, 'hgabites19', 'tITCjhfH4Qzu', 70);
insert into admin_login (loginID, username, password, adminID) values (47, 'rcrowder1a', 'QfdeNp', 64);
insert into admin_login (loginID, username, password, adminID) values (48, 'dwhatson1b', 'rdcQ0j4', 58);
insert into admin_login (loginID, username, password, adminID) values (49, 'mcrauford1c', 'VgZT3oVje', 14);
insert into admin_login (loginID, username, password, adminID) values (50, 'mpetrus1d', 'mOz8Z5c256VL', 43);
insert into admin_login (loginID, username, password, adminID) values (51, 'dgallafant1e', 'W0vJOp', 67);
insert into admin_login (loginID, username, password, adminID) values (52, 'mschwandermann1f', 'qR9DWrRt', 73);
insert into admin_login (loginID, username, password, adminID) values (53, 'asyncke1g', 'UBxRfuMLE', 73);
insert into admin_login (loginID, username, password, adminID) values (54, 'tgreenalf1h', 'LyoaMQB7ZLs', 66);
insert into admin_login (loginID, username, password, adminID) values (55, 'jlivingstone1i', 'audSkHuhk', 75);
insert into admin_login (loginID, username, password, adminID) values (56, 'dbenaharon1j', 'goeev0dRhZH', 31);
insert into admin_login (loginID, username, password, adminID) values (57, 'cbonafacino1k', 'ODYsaR', 94);
insert into admin_login (loginID, username, password, adminID) values (58, 'beastbury1l', 'MGbCgVdqO', 81);
insert into admin_login (loginID, username, password, adminID) values (59, 'fchartres1m', 'XA92eM', 58);
insert into admin_login (loginID, username, password, adminID) values (60, 'dvaneev1n', 'Ip3xGrT', 7);
insert into admin_login (loginID, username, password, adminID) values (61, 'lmidlar1o', 'nq9VjX', 59);
insert into admin_login (loginID, username, password, adminID) values (62, 'emcettigen1p', 'ptse47aK', 19);
insert into admin_login (loginID, username, password, adminID) values (63, 'bstitwell1q', 'kTD4ci', 33);
insert into admin_login (loginID, username, password, adminID) values (64, 'rstollhofer1r', 'TCDMhdOmm2c', 81);
insert into admin_login (loginID, username, password, adminID) values (65, 'togrogane1s', '4Cx2yJ8', 14);
insert into admin_login (loginID, username, password, adminID) values (66, 'wimlach1t', '4EeJ2Q3', 32);
insert into admin_login (loginID, username, password, adminID) values (67, 'hcreeber1u', 'LxAcksh2', 36);
insert into admin_login (loginID, username, password, adminID) values (68, 'raynscombe1v', '55EcqrZ', 9);
insert into admin_login (loginID, username, password, adminID) values (69, 'mgorner1w', '2NfvGecY', 58);
insert into admin_login (loginID, username, password, adminID) values (70, 'flutman1x', 'W4Wb9sBzY', 47);
insert into admin_login (loginID, username, password, adminID) values (71, 'lsollett1y', 'UROCzphj3pC', 52);
insert into admin_login (loginID, username, password, adminID) values (72, 'hwynne1z', 'NpsD1yTU1uIX', 48);
insert into admin_login (loginID, username, password, adminID) values (73, 'tstoggell20', 'd7OpBHCmzvo', 72);
insert into admin_login (loginID, username, password, adminID) values (74, 'ehalpine21', 'mackyVe00xD', 80);
insert into admin_login (loginID, username, password, adminID) values (75, 'mswadlen22', 'lCDxUQhdzsx', 38);
insert into admin_login (loginID, username, password, adminID) values (76, 'snore23', 'k8biwFomQGPo', 61);
insert into admin_login (loginID, username, password, adminID) values (77, 'ktattersall24', 'a9s32fnyXETi', 44);
insert into admin_login (loginID, username, password, adminID) values (78, 'linsoll25', 'mDGka9y3d', 34);
insert into admin_login (loginID, username, password, adminID) values (79, 'psnawdon26', 'u1WqFyao5', 86);
insert into admin_login (loginID, username, password, adminID) values (80, 'eboame27', 'pojufmHRAp4', 54);
insert into admin_login (loginID, username, password, adminID) values (81, 'dkahan28', 'IttfuU5', 94);
insert into admin_login (loginID, username, password, adminID) values (82, 'kraubenheimer29', 'SJqo0PZnW', 100);
insert into admin_login (loginID, username, password, adminID) values (83, 'hyanshinov2a', 'SP0zekIX79B', 5);
insert into admin_login (loginID, username, password, adminID) values (84, 'karent2b', '6MDAMBfLQh', 8);
insert into admin_login (loginID, username, password, adminID) values (85, 'mgransden2c', '2HwsoZa', 71);
insert into admin_login (loginID, username, password, adminID) values (86, 'acopnar2d', 'CF3AQq1XWTP', 27);
insert into admin_login (loginID, username, password, adminID) values (87, 'cbrehault2e', '5VkWIReE', 1);
insert into admin_login (loginID, username, password, adminID) values (88, 'vmagrane2f', 'zXGxeg2neaE', 52);
insert into admin_login (loginID, username, password, adminID) values (89, 'tseligson2g', 'c457ZBT', 56);
insert into admin_login (loginID, username, password, adminID) values (90, 'cnorcutt2h', 'aUf9hAS', 60);
insert into admin_login (loginID, username, password, adminID) values (91, 'dtreble2i', 'KHRuW0', 45);
insert into admin_login (loginID, username, password, adminID) values (92, 'clesser2j', 'MVz5M3GDnhM', 20);
insert into admin_login (loginID, username, password, adminID) values (93, 'igeggus2k', 'Oj6HILPZ7MW', 20);
insert into admin_login (loginID, username, password, adminID) values (94, 'agurnay2l', 'f1sGuZaCK', 91);
insert into admin_login (loginID, username, password, adminID) values (95, 'wlegrand2m', 'AmWRBCQ6z2fV', 28);
insert into admin_login (loginID, username, password, adminID) values (96, 'nlethby2n', 'Jb0AEjAtwTY', 33);
insert into admin_login (loginID, username, password, adminID) values (97, 'jgraybeal2o', 'Y7ltlPa', 42);
insert into admin_login (loginID, username, password, adminID) values (98, 'rdellenbroker2p', 'QHBbm02LxNS6', 78);
insert into admin_login (loginID, username, password, adminID) values (99, 'jseifert2q', 'MexYif0sRIX', 94);
insert into admin_login (loginID, username, password, adminID) values (100, 'dwarlaw2r', 'lLVuRJ', 80);


insert into user_login (loginID, username, password, userID) values (1, 'toaker0', 'O6S8nZpX', 36);
insert into user_login (loginID, username, password, userID) values (2, 'cvasyagin1', 'U7LcncgjWY', 72);
insert into user_login (loginID, username, password, userID) values (3, 'pklesl2', 'fDTfso87', 67);
insert into user_login (loginID, username, password, userID) values (4, 'jgerretsen3', 'tMjj4nty', 83);
insert into user_login (loginID, username, password, userID) values (5, 'cthrelkeld4', 'EIf1xVqnS7x', 48);
insert into user_login (loginID, username, password, userID) values (6, 'mkubiczek5', 'Ha9TrWe', 23);
insert into user_login (loginID, username, password, userID) values (7, 'mtibbits6', 'CwU7WP1WUt', 1);
insert into user_login (loginID, username, password, userID) values (8, 'avuitte7', 'GeA3JVe', 81);
insert into user_login (loginID, username, password, userID) values (9, 'rkubek8', 'ccwctmSHUVOS', 63);
insert into user_login (loginID, username, password, userID) values (10, 'rcrutchfield9', 'wSgNubOM', 98);
insert into user_login (loginID, username, password, userID) values (11, 'adekeysera', '024PhrT', 2);
insert into user_login (loginID, username, password, userID) values (12, 'adinegesb', 'VYWnC5XzMIm', 50);
insert into user_login (loginID, username, password, userID) values (13, 'cbartrumc', 'TlbNOQBU7Ho', 34);
insert into user_login (loginID, username, password, userID) values (14, 'jsexceyd', 'tjYhKV', 92);
insert into user_login (loginID, username, password, userID) values (15, 'mfairholme', 'LKebeyhGI', 81);
insert into user_login (loginID, username, password, userID) values (16, 'khagstonf', 'Dkl1mTqW', 62);
insert into user_login (loginID, username, password, userID) values (17, 'gbarnwallg', 'iPIvr6i8f', 65);
insert into user_login (loginID, username, password, userID) values (18, 'mpretswellh', 'TjRMucjfTmr', 11);
insert into user_login (loginID, username, password, userID) values (19, 'njohnsoni', 'C3vJgVn0', 31);
insert into user_login (loginID, username, password, userID) values (20, 'ppocockj', 'mekXAGa', 78);
insert into user_login (loginID, username, password, userID) values (21, 'rstuddek', '0XXs9PvB', 22);
insert into user_login (loginID, username, password, userID) values (22, 'umacneillyl', 'fZ1OcVO', 55);
insert into user_login (loginID, username, password, userID) values (23, 'fbraithwaitem', '829cqtXU', 64);
insert into user_login (loginID, username, password, userID) values (24, 'cthornleyn', 'io8OT5HBM2vt', 61);
insert into user_login (loginID, username, password, userID) values (25, 'ggrigoliiso', 'AWFIswxwa7', 88);
insert into user_login (loginID, username, password, userID) values (26, 'amayburyp', 'iuLkpL', 79);
insert into user_login (loginID, username, password, userID) values (27, 'zsemarkeq', 'iqgnEgJBDpei', 15);
insert into user_login (loginID, username, password, userID) values (28, 'craithbier', '95osI14U2', 27);
insert into user_login (loginID, username, password, userID) values (29, 'bcustys', 'ADNdYPx', 18);
insert into user_login (loginID, username, password, userID) values (30, 'ibissettt', 'llWwaXb', 81);
insert into user_login (loginID, username, password, userID) values (31, 'groeu', 'J1sY1mWP', 22);
insert into user_login (loginID, username, password, userID) values (32, 'dgiannasiv', 'pwcRGpEFQdE1', 98);
insert into user_login (loginID, username, password, userID) values (33, 'mberndtssenw', 'jEVzCHHAMJ2O', 77);
insert into user_login (loginID, username, password, userID) values (34, 'jmalonex', 'Wo2yC1We7Sd', 100);
insert into user_login (loginID, username, password, userID) values (35, 'amustiny', 'K63ch2Cc', 35);
insert into user_login (loginID, username, password, userID) values (36, 'pfrantzeniz', 'frIKWA7ADkE', 38);
insert into user_login (loginID, username, password, userID) values (37, 'ldyers10', 'Jst7BiqTcsbX', 100);
insert into user_login (loginID, username, password, userID) values (38, 'rsonschein11', 'WFuajk1u', 52);
insert into user_login (loginID, username, password, userID) values (39, 'oreedy12', 'tU0qCeuiL', 4);
insert into user_login (loginID, username, password, userID) values (40, 'grivelon13', 'hHg9WrSS', 82);
insert into user_login (loginID, username, password, userID) values (41, 'cauger14', 'w2mmm1', 22);
insert into user_login (loginID, username, password, userID) values (42, 'gwhitnell15', 'QmTWuHwh3a', 6);
insert into user_login (loginID, username, password, userID) values (43, 'nsmaling16', '2L6OajoZXk7f', 38);
insert into user_login (loginID, username, password, userID) values (44, 'rossulton17', 'iUmA2S49bv9S', 18);
insert into user_login (loginID, username, password, userID) values (45, 'aflann18', 'OatKCMC', 34);
insert into user_login (loginID, username, password, userID) values (46, 'fheinlein19', 'aoFoKf8J', 99);
insert into user_login (loginID, username, password, userID) values (47, 'lgreenslade1a', '731MZeEIKQ7V', 86);
insert into user_login (loginID, username, password, userID) values (48, 'kvignal1b', 'MAQymf', 38);
insert into user_login (loginID, username, password, userID) values (49, 'mkezar1c', 'vucSTr6Jh', 33);
insert into user_login (loginID, username, password, userID) values (50, 'bstellin1d', 'y62XfGRei', 21);
insert into user_login (loginID, username, password, userID) values (51, 'bmabley1e', 'Ytn8tAF', 10);
insert into user_login (loginID, username, password, userID) values (52, 'aturle1f', 'paBN3Z6Tj', 98);
insert into user_login (loginID, username, password, userID) values (53, 'hheinzler1g', 'e19R9Mr0F1m', 54);
insert into user_login (loginID, username, password, userID) values (54, 'vstodd1h', 'eMBbuUCK', 78);
insert into user_login (loginID, username, password, userID) values (55, 'acabble1i', 'PqH5cTOF', 49);
insert into user_login (loginID, username, password, userID) values (56, 'rballham1j', '4amODg2', 31);
insert into user_login (loginID, username, password, userID) values (57, 'lcramb1k', 'uz4TS7wCpEq', 75);
insert into user_login (loginID, username, password, userID) values (58, 'ncham1l', '1Ot4MqsfANXz', 8);
insert into user_login (loginID, username, password, userID) values (59, 'ahebbs1m', '3F2oooEdIqi2', 59);
insert into user_login (loginID, username, password, userID) values (60, 'clanfare1n', 'wjVlYLaV', 48);
insert into user_login (loginID, username, password, userID) values (61, 'snolli1o', '82NpMtH', 34);
insert into user_login (loginID, username, password, userID) values (62, 'ejellicorse1p', 'SFh66VGNNEo', 95);
insert into user_login (loginID, username, password, userID) values (63, 'ifoad1q', 'OoVetwHcB', 19);
insert into user_login (loginID, username, password, userID) values (64, 'spedrocchi1r', 'tgqo6S0vItW', 13);
insert into user_login (loginID, username, password, userID) values (65, 'agulleford1s', 'h8FUcbR', 83);
insert into user_login (loginID, username, password, userID) values (66, 'bchampneys1t', 'pxbc5efn', 7);
insert into user_login (loginID, username, password, userID) values (67, 'chartnup1u', 'ea2z5Tgd', 96);
insert into user_login (loginID, username, password, userID) values (68, 'bhaydney1v', '1naSmIb8TB', 74);
insert into user_login (loginID, username, password, userID) values (69, 'lketch1w', 'RJVhnz4rFk', 72);
insert into user_login (loginID, username, password, userID) values (70, 'bsharpin1x', 'DyTrMzgSCR', 90);
insert into user_login (loginID, username, password, userID) values (71, 'jstyles1y', '8lI7APpxWCSb', 91);
insert into user_login (loginID, username, password, userID) values (72, 'mfarney1z', '1RKjFIaBP', 45);
insert into user_login (loginID, username, password, userID) values (73, 'rharome20', 'TId078mp25u9', 73);
insert into user_login (loginID, username, password, userID) values (74, 'gseed21', 'A6xnLfrY', 54);
insert into user_login (loginID, username, password, userID) values (75, 'vsember22', 'r8A5vEn1WT', 32);
insert into user_login (loginID, username, password, userID) values (76, 'mveldstra23', 'rxNOybanEAVn', 95);
insert into user_login (loginID, username, password, userID) values (77, 'rdrane24', '2X6AcFcPO', 36);
insert into user_login (loginID, username, password, userID) values (78, 'jlandsberg25', 'I4GEg0yJRWT', 95);
insert into user_login (loginID, username, password, userID) values (79, 'jcarden26', 'ozL4UoxM2l', 48);
insert into user_login (loginID, username, password, userID) values (80, 'wabernethy27', 'fJSLTeMs', 35);
insert into user_login (loginID, username, password, userID) values (81, 'cdufall28', 'GsoKH8', 79);
insert into user_login (loginID, username, password, userID) values (82, 'logger29', 'XTOMVD', 3);
insert into user_login (loginID, username, password, userID) values (83, 'ghanvey2a', 'q68GAM', 11);
insert into user_login (loginID, username, password, userID) values (84, 'ccorston2b', 'D0SBwd0J3H', 56);
insert into user_login (loginID, username, password, userID) values (85, 'cchriston2c', 'ZWS7DolA', 76);
insert into user_login (loginID, username, password, userID) values (86, 'ytubb2d', 'qkXaX9', 55);
insert into user_login (loginID, username, password, userID) values (87, 'lgooddy2e', 'JuIJyOk3', 10);
insert into user_login (loginID, username, password, userID) values (88, 'rrobertazzi2f', '0mpeiEh', 91);
insert into user_login (loginID, username, password, userID) values (89, 'ashieber2g', 'Ok9C2BQi', 87);
insert into user_login (loginID, username, password, userID) values (90, 'echetwin2h', 'zUN2kl5', 48);
insert into user_login (loginID, username, password, userID) values (91, 'kreynoldson2i', 'wNVXTar71', 63);
insert into user_login (loginID, username, password, userID) values (92, 'wfloch2j', 'pCU0hFq3pi8m', 45);
insert into user_login (loginID, username, password, userID) values (93, 'jayshford2k', 'ak9hSCQTJoe', 83);
insert into user_login (loginID, username, password, userID) values (94, 'cknight2l', 'kbKI615', 52);
insert into user_login (loginID, username, password, userID) values (95, 'hmccreath2m', 'zbUuHCMbjOp', 60);
insert into user_login (loginID, username, password, userID) values (96, 'vandrich2n', 'bZwYeR3yAVjb', 26);
insert into user_login (loginID, username, password, userID) values (97, 'mvasyunin2o', 'vptlYoW8bIB', 1);
insert into user_login (loginID, username, password, userID) values (98, 'eorans2p', 'C9T2UzK8C', 65);
insert into user_login (loginID, username, password, userID) values (99, 'tscrivenor2q', 'EVBrA3Rj', 66);
insert into user_login (loginID, username, password, userID) values (100, 'ccalderon2r', 'Z8BW8BflFe', 97);


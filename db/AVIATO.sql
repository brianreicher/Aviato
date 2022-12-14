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
    `adminID` varchar(50) NOT NULL,
    PRIMARY KEY (`paymentNum`),
    KEY `bankaccount_ID` (`bankaccount_ID`),
    CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`bidID`) REFERENCES `bid` (`bidID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`buyerID`) REFERENCES `buyer` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`sellerID`) REFERENCES `seller` (`sellerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `payment_ibfk_4` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON UPDATE cascade ON DELETE restrict
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
    `expirationDate` varchar(50) NOT NULL,
    `status` VARCHAR(255) NOT NULL,
    `trade_ID` varchar(50) NOT NULL,
    `buyerID` varchar(50) NOT NULL,
    PRIMARY KEY (`bidID`),
    CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`buyerID`) REFERENCES `buyer` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`trade_ID`) REFERENCES `trade` (`trade_ID`) ON UPDATE cascade ON DELETE restrict
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `trade`(
    `trade_ID` varchar(50),
    `date` varchar(50),
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
    CONSTRAINT `flights_ibfk_4` FOREIGN KEY (`portfolioID`) REFERENCES `flight_portfolio` (`portfolioID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_5` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON UPDATE cascade ON DELETE restrict
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


insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (1, 1, '$540.03', 'jcb', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 65, 16, 9, 50);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (2, 2, '$717.61', 'jcb', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.', 8, 3, 40, 68);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (3, 3, '$337.37', 'jcb', 'Cras pellentesque volutpat dui.', 59, 77, 14, 7);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (4, 4, '$573.89', 'maestro', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', 92, 76, 36, 69);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (5, 5, '$861.67', 'jcb', 'Nam dui.', 65, 9, 77, 47);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (6, 6, '$778.83', 'jcb', 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 83, 97, 64, 44);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (7, 7, '$993.59', 'jcb', 'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.', 72, 13, 7, 57);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (8, 8, '$338.02', 'maestro', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 64, 85, 94, 74);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (9, 9, '$333.23', 'diners-club-carte-blanche', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', 4, 32, 8, 72);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (10, 10, '$417.50', 'mastercard', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 73, 45, 23, 88);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (11, 11, '$855.21', 'diners-club-carte-blanche', 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 45, 10, 86, 61);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (12, 12, '$436.45', 'switch', 'Etiam justo.', 60, 28, 61, 4);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (13, 13, '$383.83', 'americanexpress', 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 12, 7, 92, 33);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (14, 14, '$309.41', 'switch', 'Integer tincidunt ante vel ipsum.', 90, 19, 1, 85);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (15, 15, '$265.89', 'china-unionpay', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 63, 76, 39, 21);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (16, 16, '$76.58', 'jcb', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 22, 92, 27, 34);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (17, 17, '$136.93', 'jcb', 'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 92, 59, 28, 37);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (18, 18, '$704.27', 'jcb', 'In hac habitasse platea dictumst.', 20, 41, 11, 65);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (19, 19, '$743.50', 'jcb', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 60, 25, 16, 4);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (20, 20, '$869.14', 'jcb', 'Nunc purus. Phasellus in felis.', 76, 85, 22, 25);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (21, 21, '$221.69', 'maestro', 'Nullam varius. Nulla facilisi.', 30, 11, 43, 28);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (22, 22, '$940.25', 'diners-club-carte-blanche', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 8, 31, 42, 7);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (23, 23, '$639.85', 'china-unionpay', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 82, 85, 8, 48);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (24, 24, '$361.77', 'jcb', 'Maecenas pulvinar lobortis est.', 36, 78, 5, 52);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (25, 25, '$369.44', 'jcb', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat.', 65, 46, 37, 37);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (26, 26, '$857.89', 'jcb', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 10, 5, 100, 88);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (27, 27, '$518.58', 'jcb', 'Duis bibendum.', 29, 18, 46, 14);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (28, 28, '$773.99', 'jcb', 'Proin at turpis a pede posuere nonummy. Integer non velit.', 29, 57, 67, 60);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (29, 29, '$50.92', 'bankcard', 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', 51, 91, 1, 83);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (30, 30, '$58.55', 'americanexpress', 'In hac habitasse platea dictumst.', 51, 37, 29, 46);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (31, 31, '$852.78', 'jcb', 'Sed accumsan felis. Ut at dolor quis odio consequat varius.', 67, 56, 8, 71);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (32, 32, '$831.41', 'jcb', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', 12, 87, 4, 41);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (33, 33, '$108.79', 'maestro', 'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 43, 19, 16, 86);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (34, 34, '$727.15', 'jcb', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', 14, 84, 37, 9);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (35, 35, '$607.47', 'diners-club-enroute', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 36, 27, 33, 34);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (36, 36, '$317.96', 'jcb', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 5, 84, 93, 90);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (37, 37, '$889.07', 'instapayment', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', 92, 69, 78, 10);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (38, 38, '$674.60', 'diners-club-carte-blanche', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 54, 57, 69, 38);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (39, 39, '$999.77', 'jcb', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.', 75, 74, 44, 41);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (40, 40, '$994.58', 'bankcard', 'Nulla mollis molestie lorem.', 13, 44, 97, 35);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (41, 41, '$130.54', 'laser', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', 45, 36, 7, 24);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (42, 42, '$580.48', 'jcb', 'Morbi porttitor lorem id ligula.', 32, 57, 42, 71);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (43, 43, '$988.52', 'jcb', 'In congue. Etiam justo.', 14, 77, 32, 83);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (44, 44, '$371.49', 'mastercard', 'Proin at turpis a pede posuere nonummy. Integer non velit.', 73, 87, 1, 64);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (45, 45, '$561.50', 'mastercard', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', 60, 28, 87, 90);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (46, 46, '$631.28', 'jcb', 'Morbi a ipsum. Integer a nibh. In quis justo.', 77, 48, 65, 93);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (47, 47, '$637.69', 'jcb', 'Sed ante. Vivamus tortor.', 50, 24, 55, 100);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (48, 48, '$825.36', 'jcb', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 73, 69, 97, 84);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (49, 49, '$875.02', 'americanexpress', 'Suspendisse ornare consequat lectus.', 88, 4, 34, 90);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (50, 50, '$382.45', 'diners-club-carte-blanche', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', 75, 86, 38, 31);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (51, 51, '$884.32', 'maestro', 'Integer ac leo.', 98, 31, 24, 88);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (52, 52, '$197.54', 'mastercard', 'Vivamus tortor. Duis mattis egestas metus.', 92, 17, 76, 77);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (53, 53, '$507.53', 'jcb', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 97, 31, 80, 12);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (54, 54, '$113.84', 'jcb', 'In hac habitasse platea dictumst.', 62, 13, 56, 89);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (55, 55, '$132.93', 'visa-electron', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.', 18, 94, 5, 64);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (56, 56, '$929.20', 'jcb', 'Suspendisse accumsan tortor quis turpis. Sed ante.', 32, 10, 10, 32);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (57, 57, '$394.14', 'laser', 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', 32, 59, 81, 73);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (58, 58, '$289.78', 'jcb', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 9, 98, 81, 7);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (59, 59, '$94.15', 'mastercard', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', 88, 64, 23, 65);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (60, 60, '$201.47', 'diners-club-carte-blanche', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 1, 90, 49, 57);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (61, 61, '$411.18', 'americanexpress', 'Duis ac nibh.', 47, 40, 30, 76);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (62, 62, '$130.70', 'jcb', 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', 68, 70, 41, 13);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (63, 63, '$426.19', 'maestro', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.', 37, 27, 67, 71);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (64, 64, '$790.04', 'jcb', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 80, 13, 74, 26);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (65, 65, '$881.46', 'jcb', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', 5, 18, 88, 91);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (66, 66, '$850.36', 'switch', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', 74, 17, 2, 28);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (67, 67, '$301.71', 'jcb', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.', 83, 73, 72, 50);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (68, 68, '$563.63', 'jcb', 'Suspendisse ornare consequat lectus.', 98, 85, 62, 94);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (69, 69, '$981.11', 'americanexpress', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 58, 100, 77, 21);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (70, 70, '$518.92', 'bankcard', 'Nullam molestie nibh in lectus.', 1, 61, 90, 35);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (71, 71, '$843.25', 'jcb', 'Proin interdum mauris non ligula pellentesque ultrices.', 49, 100, 28, 90);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (72, 72, '$431.01', 'china-unionpay', 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 71, 28, 55, 17);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (73, 73, '$787.91', 'china-unionpay', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 41, 4, 85, 86);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (74, 74, '$101.30', 'maestro', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', 6, 28, 86, 29);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (75, 75, '$914.40', 'jcb', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', 73, 49, 2, 18);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (76, 76, '$272.51', 'jcb', 'In hac habitasse platea dictumst.', 89, 2, 45, 7);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (77, 77, '$136.32', 'jcb', 'Fusce posuere felis sed lacus.', 75, 29, 39, 24);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (78, 78, '$208.77', 'mastercard', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 17, 27, 61, 69);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (79, 79, '$260.23', 'jcb', 'Praesent blandit lacinia erat.', 81, 16, 44, 79);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (80, 80, '$480.39', 'jcb', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 39, 16, 66, 91);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (81, 81, '$904.69', 'diners-club-enroute', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 100, 79, 41, 62);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (82, 82, '$416.47', 'mastercard', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 9, 74, 97, 6);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (83, 83, '$315.98', 'jcb', 'Donec dapibus. Duis at velit eu est congue elementum.', 68, 3, 100, 92);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (84, 84, '$114.32', 'switch', 'Duis mattis egestas metus. Aenean fermentum.', 21, 26, 30, 44);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (85, 85, '$378.35', 'visa-electron', 'Etiam pretium iaculis justo. In hac habitasse platea dictumst.', 31, 57, 47, 22);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (86, 86, '$329.55', 'switch', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 69, 45, 93, 34);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (87, 87, '$554.23', 'switch', 'Nunc nisl.', 64, 33, 39, 35);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (88, 88, '$209.95', 'diners-club-carte-blanche', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', 18, 86, 23, 4);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (89, 89, '$819.07', 'mastercard', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', 66, 84, 43, 31);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (90, 90, '$46.68', 'bankcard', 'Aenean auctor gravida sem.', 58, 93, 55, 63);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (91, 91, '$827.40', 'maestro', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 12, 11, 8, 30);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (92, 92, '$883.86', 'switch', 'Etiam justo.', 9, 36, 8, 97);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (93, 93, '$212.20', 'jcb', 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', 29, 12, 42, 53);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (94, 94, '$131.92', 'maestro', 'Phasellus in felis. Donec semper sapien a libero.', 88, 31, 48, 15);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (95, 95, '$412.10', 'diners-club-enroute', 'Suspendisse accumsan tortor quis turpis.', 45, 6, 35, 17);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (96, 96, '$678.12', 'jcb', 'Aenean fermentum.', 90, 32, 96, 89);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (97, 97, '$467.55', 'jcb', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 71, 69, 80, 91);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (98, 98, '$251.43', 'visa-electron', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', 14, 65, 9, 79);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (99, 99, '$549.43', 'mastercard', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 37, 40, 71, 100);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID, adminID) values (100, 100, '$492.51', 'jcb', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 54, 86, 86, 5);
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


insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (1, false, '2021-12-31 20:15:42', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 26, 65, 83, 83, 85, '2022-04-19 19:12:35', 'Delta', true, 'PRI', 'OTI', 725.22, 265.04, 819.29, '2022-02-01 01:42:14', '2022-03-25 16:42:55');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (2, true, '2022-01-16 09:13:06', 'Phasellus in felis. Donec semper sapien a libero.', 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', 71, 6, 33, 33, 56, '2022-11-13 13:03:31', 'American', false, 'COD', 'KDO', 548.78, 610.46, 643.81, '2022-09-18 20:13:04', '2022-04-12 02:32:09');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (3, true, '2022-04-27 08:41:03', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 'Nullam sit amet turpis elementum ligula vehicula consequat.', 62, 98, 81, 81, 56, '2022-08-06 12:49:31', 'United', false, 'BUZ', 'AIS', 354.37, 948.66, 662.16, '2022-08-07 14:55:26', '2022-07-20 16:24:35');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (4, true, '2022-06-29 20:32:06', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.', 'Maecenas rhoncus aliquam lacus.', 79, 61, 65, 65, 77, '2022-09-10 05:07:49', 'Hawaiian Airlines', true, 'ORK', 'AEK', 946.29, 307.18, 142.88, '2022-09-13 17:13:17', '2022-07-25 13:27:39');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (5, false, '2022-05-27 16:42:25', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 35, 7, 46, 46, 59, '2022-05-28 23:13:56', 'American', true, 'IAR', 'TJL', 569.93, 150.03, 801.83, '2022-01-22 17:08:29', '2022-05-06 21:04:47');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (6, false, '2022-08-13 10:14:18', 'Morbi porttitor lorem id ligula.', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 85, 95, 45, 45, 65, '2022-02-22 04:50:14', 'Alaskan Airlines', false, 'TLC', 'ROB', 917.67, 499.84, 330.56, '2022-01-12 19:34:12', '2022-05-27 18:16:24');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (7, true, '2022-06-06 10:54:34', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 'Maecenas pulvinar lobortis est.', 25, 68, 35, 35, 33, '2022-07-19 03:52:19', 'Delta', true, 'RDU', '0', 482.35, 716.2, 947.9, '2022-09-25 13:34:00', '2022-07-18 02:51:41');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (8, true, '2022-07-15 02:04:28', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', 'Etiam pretium iaculis justo.', 22, 10, 32, 32, 17, '2022-07-25 04:40:40', 'United', false, 'FNR', 'DXE', 565.65, 132.9, 190.56, '2022-05-09 10:21:21', '2022-06-20 15:42:42');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (9, false, '2022-10-12 13:10:11', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', 'Morbi ut odio.', 85, 12, 27, 27, 45, '2022-09-06 05:03:12', 'Alaskan Airlines', true, 'MHO', 'ILZ', 747.3, 592.76, 770.97, '2022-03-21 21:14:34', '2022-05-24 02:38:49');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (10, false, '2022-10-16 18:03:59', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 'Donec semper sapien a libero. Nam dui.', 41, 76, 71, 71, 13, '2021-12-15 16:09:49', 'JetBlue', true, 'KBM', 'BZN', 235.5, 856.72, 929.46, '2022-01-27 03:40:46', '2022-10-31 14:43:22');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (11, true, '2022-01-25 03:14:46', 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 52, 61, 2, 2, 37, '2022-11-27 15:42:04', 'Delta', false, 'YMW', 'MES', 850.07, 900.17, 418.48, '2022-03-19 22:21:10', '2022-01-24 08:07:34');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (12, true, '2021-12-25 08:43:02', 'Duis aliquam convallis nunc.', 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 79, 43, 31, 31, 53, '2022-08-10 11:53:56', 'American', true, 'MZW', 'TGI', 114.66, 204.64, 869.43, '2022-01-15 12:07:25', '2022-11-24 07:46:50');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (13, true, '2022-04-09 10:57:02', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.', 47, 94, 70, 70, 74, '2022-04-12 16:06:54', 'American', true, 'ISW', 'VCT', 735.29, 863.36, 577.85, '2022-08-27 07:10:39', '2022-08-28 06:56:05');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (14, true, '2022-07-24 22:22:43', 'Mauris sit amet eros.', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 55, 17, 7, 7, 43, '2021-12-29 12:04:43', 'Delta', false, 'PWM', 'STL', 956.09, 389.64, 216.46, '2022-05-13 07:30:34', '2022-02-15 06:40:38');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (15, true, '2022-03-30 08:33:18', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 'Cras pellentesque volutpat dui.', 51, 56, 61, 61, 43, '2022-06-12 18:20:15', 'Alaskan Airlines', true, '0', 'LAG', 601.36, 414.53, 572.57, '2022-04-27 16:28:23', '2022-05-25 11:32:23');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (16, true, '2022-04-21 12:14:13', 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', 25, 82, 6, 6, 20, '2022-10-28 02:59:28', 'Southwest', false, 'ILD', 'IRI', 565.35, 305.29, 625.68, '2022-01-02 00:05:13', '2022-03-21 04:28:46');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (17, true, '2022-01-27 05:11:50', 'Phasellus in felis. Donec semper sapien a libero.', 'In hac habitasse platea dictumst.', 81, 65, 50, 50, 52, '2022-03-08 17:31:37', 'United', true, 'IDO', 'LCJ', 941.92, 274.34, 757.39, '2021-12-08 06:15:40', '2022-01-14 07:50:45');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (18, true, '2022-09-13 03:59:09', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.', 'Aliquam non mauris.', 96, 67, 28, 28, 49, '2022-04-19 08:12:42', 'Hawaiian Airlines', false, 'SYP', 'TJV', 818.52, 149.57, 790.85, '2022-04-02 11:46:26', '2022-06-02 10:38:22');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (19, true, '2022-06-03 17:53:14', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 'Duis consequat dui nec nisi volutpat eleifend.', 28, 43, 26, 26, 38, '2022-03-10 02:52:28', 'United', true, 'KSM', 'KKL', 597.01, 906.82, 987.71, '2022-06-19 14:17:31', '2022-07-15 23:36:13');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (20, false, '2022-01-20 22:46:26', 'Integer non velit.', 'Aenean sit amet justo.', 50, 11, 88, 88, 53, '2022-07-09 15:40:10', 'Delta', true, 'GCJ', 'ICC', 663.35, 468.32, 254.26, '2022-06-27 00:11:13', '2022-08-21 00:15:10');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (21, true, '2021-12-08 02:21:14', 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 34, 25, 37, 37, 92, '2022-07-20 23:05:22', 'Hawaiian Airlines', true, 'HUC', 'SPW', 287.62, 536.98, 554.54, '2022-08-05 10:12:29', '2022-07-06 23:02:36');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (22, false, '2022-01-27 05:08:36', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.', 26, 85, 78, 78, 75, '2022-04-30 06:27:03', 'Delta', false, 'HZP', 'WGA', 148.0, 417.54, 732.73, '2022-09-26 10:03:20', '2022-06-02 15:40:01');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (23, true, '2022-09-30 10:20:22', 'Donec posuere metus vitae ipsum.', 'Proin risus. Praesent lectus.', 41, 73, 64, 64, 1, '2022-05-04 12:27:23', 'Southwest', true, 'URD', 'RNL', 700.32, 125.27, 414.0, '2022-06-30 05:50:23', '2022-07-13 18:57:17');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (24, false, '2022-08-21 09:00:57', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 'Nam dui.', 17, 93, 49, 49, 31, '2022-04-02 08:35:07', 'American', true, 'TGQ', 'MOE', 419.67, 567.96, 374.26, '2022-09-14 22:23:43', '2022-01-28 20:31:04');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (25, false, '2022-10-21 10:44:32', 'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Integer a nibh. In quis justo.', 11, 11, 12, 12, 9, '2022-11-05 03:53:50', 'JetBlue', true, 'SGD', 'GYR', 753.92, 218.0, 383.83, '2022-03-26 02:13:30', '2022-10-30 16:30:42');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (26, false, '2022-08-06 15:12:06', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', 56, 52, 55, 55, 91, '2022-05-17 00:26:18', 'Delta', false, 'DAS', 'TYP', 752.58, 774.24, 549.04, '2022-05-09 17:32:12', '2022-08-08 19:27:26');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (27, false, '2022-11-05 14:31:44', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 34, 83, 62, 62, 27, '2022-05-17 11:38:09', 'Alaskan Airlines', true, 'NNU', 'RUK', 609.23, 251.37, 513.38, '2022-12-04 18:06:18', '2022-04-06 02:33:49');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (28, false, '2021-12-07 10:06:00', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', 92, 22, 56, 56, 57, '2021-12-17 10:54:25', 'American', false, 'MRE', 'LPO', 658.85, 565.54, 114.28, '2022-04-12 16:11:33', '2021-12-14 18:23:35');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (29, true, '2022-11-22 09:19:13', 'Suspendisse potenti.', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 68, 44, 44, 44, 44, '2022-06-22 16:42:27', 'Delta', true, 'XBO', 'EVX', 728.0, 800.21, 555.39, '2022-05-08 15:55:43', '2022-01-12 00:58:25');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (30, true, '2022-07-12 02:31:19', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', 'Phasellus in felis. Donec semper sapien a libero.', 7, 18, 58, 58, 69, '2022-04-22 17:50:33', 'Alaskan Airlines', false, 'GTT', 'WBA', 462.48, 838.56, 415.17, '2022-01-03 11:25:30', '2022-01-10 07:13:25');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (31, true, '2022-06-23 21:55:55', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 61, 82, 74, 74, 26, '2022-06-24 07:59:35', 'JetBlue', true, 'APG', 'MAF', 163.77, 209.67, 549.6, '2022-05-10 18:24:43', '2022-05-14 16:33:44');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (32, false, '2022-06-10 16:54:20', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', 5, 25, 31, 31, 44, '2022-11-22 15:49:57', 'Southwest', true, 'CNX', 'PJC', 772.05, 872.14, 362.64, '2022-01-26 08:24:28', '2022-03-28 13:40:58');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (33, true, '2022-01-14 01:33:17', 'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', 9, 99, 92, 92, 3, '2022-04-07 05:22:13', 'Delta', false, 'CSQ', 'AML', 446.63, 988.92, 132.66, '2022-07-13 21:16:45', '2022-11-15 02:07:17');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (34, false, '2021-12-24 07:57:54', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 'Nullam porttitor lacus at turpis.', 97, 53, 55, 55, 23, '2022-04-26 16:27:14', 'Southwest', true, 'TIL', 'AGC', 859.17, 488.24, 256.23, '2021-12-26 22:12:35', '2022-03-27 21:55:14');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (35, true, '2022-01-22 21:15:36', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', 'Proin at turpis a pede posuere nonummy. Integer non velit.', 9, 62, 46, 46, 80, '2022-06-01 09:46:51', 'Delta', true, 'SSW', 'CEI', 458.39, 577.64, 995.39, '2022-08-15 18:57:01', '2022-03-29 02:31:50');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (36, true, '2022-11-08 00:34:03', 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', 'Proin eu mi. Nulla ac enim.', 70, 37, 54, 54, 33, '2022-01-17 02:17:35', 'Hawaiian Airlines', false, 'MBM', 'NBN', 733.92, 876.05, 187.96, '2022-07-27 17:54:20', '2022-06-28 16:13:10');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (37, false, '2022-04-04 07:52:06', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 'Sed accumsan felis. Ut at dolor quis odio consequat varius.', 51, 39, 61, 61, 36, '2022-09-07 17:33:53', 'Southwest', true, 'CXL', 'WRB', 488.13, 495.7, 857.85, '2022-08-16 13:40:42', '2022-07-09 16:06:25');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (38, true, '2022-09-13 05:43:54', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 'Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.', 36, 47, 22, 22, 54, '2022-09-02 12:35:27', 'Alaskan Airlines', false, 'WBC', 'PSF', 627.2, 485.77, 698.79, '2022-04-28 22:56:00', '2021-12-12 18:16:43');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (39, false, '2022-08-09 19:58:16', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 80, 32, 62, 62, 46, '2022-06-10 01:28:19', 'United', true, 'PRQ', 'GND', 797.77, 473.18, 752.54, '2022-03-23 07:01:47', '2022-03-13 17:52:08');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (40, true, '2022-11-28 00:14:05', 'Nulla tempus.', 'Cras pellentesque volutpat dui.', 99, 33, 45, 45, 6, '2022-01-26 02:59:33', 'Hawaiian Airlines', true, 'PMK', 'WLP', 812.86, 161.85, 567.48, '2022-10-25 04:59:43', '2022-05-19 20:01:13');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (41, false, '2021-12-16 05:47:04', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', 58, 77, 23, 23, 98, '2022-02-23 20:32:50', 'United', false, 'DET', 'CCN', 893.72, 312.62, 308.95, '2022-04-23 13:41:42', '2022-10-11 12:24:56');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (42, true, '2022-07-16 19:44:05', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', 15, 64, 19, 19, 55, '2022-01-17 23:53:19', 'Delta', false, 'FAB', 'GVA', 257.2, 715.71, 802.22, '2022-03-23 16:53:18', '2022-04-24 16:04:05');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (43, true, '2022-03-22 20:36:21', 'Donec semper sapien a libero.', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', 93, 27, 70, 70, 43, '2022-06-21 04:25:28', 'JetBlue', false, 'SVQ', 'CBO', 293.15, 740.16, 672.41, '2022-10-11 16:59:21', '2022-08-18 03:05:06');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (44, true, '2022-08-19 06:57:49', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.', 74, 96, 42, 42, 9, '2022-10-12 00:26:41', 'JetBlue', false, 'QPH', 'ZQL', 352.11, 223.54, 441.61, '2022-10-30 10:29:16', '2022-09-06 09:55:24');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (45, true, '2022-09-07 08:32:21', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 89, 65, 95, 95, 62, '2022-01-28 19:24:12', 'Hawaiian Airlines', false, 'MPF', 'THA', 655.04, 454.61, 747.17, '2022-09-19 10:37:44', '2022-02-21 14:00:41');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (46, true, '2021-12-12 12:19:36', 'Nullam molestie nibh in lectus. Pellentesque at nulla.', 'Nam tristique tortor eu pede.', 66, 29, 37, 37, 54, '2022-09-17 18:01:09', 'Southwest', true, 'KRL', 'VLC', 727.77, 755.53, 751.92, '2022-05-12 18:58:37', '2022-08-16 05:47:20');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (47, false, '2022-09-02 07:18:51', 'Aliquam non mauris.', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 12, 94, 56, 56, 4, '2022-07-13 01:49:50', 'Delta', true, 'KCS', 'FLZ', 169.07, 824.91, 930.08, '2022-08-22 03:45:16', '2022-04-22 18:21:03');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (48, true, '2022-09-19 13:13:35', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', 72, 87, 89, 89, 32, '2022-11-18 10:58:27', 'American', true, 'XAL', 'VPZ', 892.24, 973.71, 940.46, '2022-08-28 18:19:14', '2022-06-01 14:04:44');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (49, false, '2022-04-10 00:03:22', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', 'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', 34, 61, 71, 71, 10, '2022-01-14 04:41:20', 'Southwest', false, 'AIM', 'IIS', 548.52, 163.87, 164.0, '2022-07-24 19:52:09', '2022-10-26 05:28:05');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (50, false, '2021-12-11 21:49:55', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.', 'Nulla tellus. In sagittis dui vel nisl.', 96, 11, 77, 77, 60, '2022-05-23 23:59:19', 'Delta', true, 'RAI', 'MQD', 112.7, 188.51, 233.69, '2022-02-18 11:30:48', '2022-07-17 03:08:51');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (51, true, '2021-12-14 18:16:14', 'Suspendisse potenti. In eleifend quam a odio.', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 76, 25, 87, 87, 83, '2022-01-02 21:34:47', 'Delta', false, 'BDV', '0', 917.08, 465.72, 177.38, '2022-09-05 04:49:55', '2022-05-30 21:28:14');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (52, true, '2022-04-26 15:16:04', 'Duis mattis egestas metus.', 'Nulla tellus.', 15, 41, 100, 100, 20, '2022-01-22 19:17:54', 'Hawaiian Airlines', false, 'MCQ', 'UTP', 818.94, 392.07, 856.24, '2022-05-24 22:20:41', '2022-11-19 06:09:00');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (53, true, '2022-09-19 05:41:25', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 'Nam tristique tortor eu pede.', 14, 10, 4, 4, 8, '2022-10-05 18:35:26', 'Alaskan Airlines', true, 'MJP', 'REH', 414.92, 680.97, 775.43, '2022-02-15 08:28:41', '2022-09-16 16:02:35');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (54, false, '2022-02-04 10:37:16', 'Nulla facilisi.', 'Nunc nisl.', 84, 74, 77, 77, 16, '2022-08-08 22:15:22', 'Southwest', false, 'CLH', 'AKD', 976.79, 380.02, 596.0, '2022-11-14 14:38:39', '2022-05-31 02:36:39');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (55, false, '2022-01-15 22:58:34', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', 83, 61, 3, 3, 1, '2022-01-02 15:20:30', 'Hawaiian Airlines', true, 'MMM', 'YSK', 295.92, 616.57, 219.02, '2022-10-20 12:11:16', '2022-11-17 00:44:40');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (56, false, '2022-05-08 01:08:39', 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.', 50, 41, 32, 32, 39, '2022-01-01 16:27:52', 'Hawaiian Airlines', false, 'YBG', 'HHI', 612.03, 584.61, 778.36, '2022-03-08 17:54:04', '2022-09-15 01:01:39');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (57, true, '2022-05-11 23:47:37', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 'Donec ut dolor.', 14, 61, 95, 95, 90, '2022-09-24 05:43:22', 'American', false, 'DIU', 'BLO', 579.23, 843.69, 218.76, '2022-11-30 19:01:02', '2022-10-11 11:54:55');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (58, false, '2022-06-05 01:51:13', 'Curabitur at ipsum ac tellus semper interdum.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 11, 62, 75, 75, 64, '2022-01-26 01:34:28', 'JetBlue', false, 'JAU', 'CKK', 332.42, 471.02, 957.07, '2022-07-04 17:15:32', '2022-06-25 14:04:57');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (59, true, '2022-03-31 19:25:29', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 61, 42, 10, 10, 26, '2022-09-02 08:20:27', 'Hawaiian Airlines', true, 'IWS', 'SNZ', 539.94, 300.98, 219.02, '2022-02-23 23:43:47', '2022-08-11 15:48:26');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (60, false, '2022-04-13 12:43:34', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', 66, 49, 86, 86, 35, '2022-11-21 15:33:24', 'JetBlue', false, 'ADP', 'PUK', 962.86, 187.53, 903.08, '2022-05-10 22:03:58', '2022-03-16 19:29:06');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (61, true, '2022-09-23 04:47:47', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', 88, 66, 15, 15, 43, '2022-08-27 04:46:32', 'Southwest', true, 'VRC', 'TQQ', 615.08, 157.87, 201.36, '2022-01-18 22:16:52', '2022-03-18 10:29:47');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (62, false, '2022-09-03 09:26:16', 'Integer ac neque.', 'Morbi non quam nec dui luctus rutrum.', 94, 4, 10, 10, 89, '2021-12-13 02:58:41', 'American', false, 'YDL', 'MXU', 358.2, 336.14, 363.18, '2022-10-07 09:37:53', '2022-05-21 01:42:03');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (63, false, '2022-08-12 15:31:16', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 97, 99, 53, 53, 21, '2022-09-29 04:34:11', 'JetBlue', true, 'YYC', 'KWJ', 895.63, 853.04, 565.48, '2022-03-30 10:02:59', '2022-01-18 10:03:30');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (64, true, '2022-10-09 10:45:51', 'Mauris ullamcorper purus sit amet nulla.', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 66, 48, 28, 28, 91, '2022-04-16 05:19:14', 'Hawaiian Airlines', true, 'SIE', '0', 422.07, 893.92, 698.85, '2021-12-17 19:50:38', '2022-08-28 14:27:42');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (65, true, '2022-02-24 19:42:40', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 72, 66, 79, 79, 96, '2022-06-16 03:54:51', 'Hawaiian Airlines', false, 'ODD', 'WLS', 173.77, 200.83, 123.73, '2022-02-18 19:27:15', '2021-12-06 22:22:30');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (66, true, '2022-08-06 08:45:27', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', 'Vestibulum sed magna at nunc commodo placerat.', 35, 48, 73, 73, 22, '2022-01-28 12:27:37', 'Hawaiian Airlines', false, 'NYE', 'AMI', 835.32, 693.06, 359.6, '2022-10-07 15:55:52', '2022-04-21 12:36:08');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (67, true, '2022-10-16 00:18:19', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 'Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.', 28, 14, 62, 62, 56, '2022-04-05 02:35:12', 'Hawaiian Airlines', false, 'UTT', 'OLC', 966.35, 230.61, 872.89, '2022-02-12 19:53:49', '2022-01-02 22:16:18');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (68, true, '2022-08-17 23:03:07', 'Quisque porta volutpat erat.', 'Proin at turpis a pede posuere nonummy. Integer non velit.', 15, 23, 5, 5, 77, '2022-08-24 00:26:07', 'Delta', false, 'ADS', 'CPG', 908.06, 876.25, 750.75, '2022-06-03 20:54:58', '2022-03-28 19:55:14');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (69, false, '2022-02-08 23:38:33', 'Ut tellus.', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.', 64, 68, 77, 77, 28, '2022-06-07 03:25:47', 'United', true, 'CEE', 'MME', 380.14, 809.74, 303.18, '2022-11-16 16:58:56', '2022-10-03 14:31:14');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (70, true, '2022-03-27 19:30:02', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 'Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.', 84, 3, 96, 96, 16, '2022-02-21 22:45:16', 'Delta', true, 'YSY', 'AGP', 636.3, 998.48, 104.36, '2022-09-26 05:24:17', '2022-05-16 23:57:23');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (71, false, '2022-05-08 23:25:16', 'Duis bibendum. Morbi non quam nec dui luctus rutrum.', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 38, 30, 14, 14, 32, '2021-12-20 23:36:09', 'United', true, 'NDB', 'NUD', 157.82, 773.88, 553.84, '2022-07-22 19:28:46', '2022-09-05 01:35:04');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (72, true, '2022-04-01 11:16:15', 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 'Donec semper sapien a libero.', 70, 52, 65, 65, 99, '2022-02-11 16:29:51', 'Delta', true, 'BYH', 'SCQ', 767.19, 375.09, 684.43, '2022-06-27 14:18:16', '2022-11-20 19:57:19');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (73, true, '2022-09-04 13:38:38', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', 29, 21, 72, 72, 87, '2022-08-17 12:28:43', 'Alaskan Airlines', false, 'YGE', 'DGD', 685.65, 329.9, 124.85, '2022-04-25 02:29:32', '2022-04-25 08:02:10');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (74, false, '2022-10-10 22:52:31', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.', 'Suspendisse accumsan tortor quis turpis.', 47, 62, 96, 96, 74, '2022-10-10 00:26:34', 'Delta', false, 'DLZ', 'MRH', 305.18, 143.45, 678.64, '2022-10-14 10:57:28', '2022-01-04 20:34:03');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (75, false, '2022-06-13 02:55:04', 'In sagittis dui vel nisl.', 'Nam dui.', 90, 9, 64, 64, 66, '2022-09-13 12:37:45', 'Delta', false, 'IGU', 'MUK', 953.23, 678.16, 399.73, '2022-04-04 16:12:24', '2021-12-16 07:23:48');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (76, false, '2022-03-20 23:27:40', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 'Curabitur in libero ut massa volutpat convallis.', 86, 40, 64, 64, 39, '2022-03-12 16:12:58', 'Southwest', false, 'EAA', 'HSV', 475.99, 741.09, 129.73, '2022-10-23 05:17:57', '2022-05-17 12:45:53');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (77, false, '2022-02-22 20:41:10', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 75, 80, 49, 49, 88, '2022-02-26 09:05:01', 'JetBlue', true, 'WMD', 'SYI', 393.65, 634.18, 229.15, '2022-06-08 12:16:51', '2021-12-18 19:05:58');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (78, false, '2022-05-26 20:06:31', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 41, 86, 58, 58, 53, '2022-11-08 08:56:09', 'Alaskan Airlines', true, 'BLW', 'SBE', 511.68, 537.69, 338.95, '2022-07-24 10:23:49', '2022-04-23 03:23:03');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (79, false, '2022-07-10 15:55:41', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 'Aenean lectus.', 82, 98, 67, 67, 95, '2021-12-14 23:01:12', 'Hawaiian Airlines', true, 'MAQ', 'IVH', 420.85, 994.44, 473.79, '2022-05-19 15:14:33', '2022-09-26 19:40:43');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (80, false, '2022-07-22 07:43:53', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 17, 96, 38, 38, 43, '2022-04-27 13:20:30', 'Southwest', false, 'CVN', 'GFK', 815.14, 573.35, 660.83, '2022-05-23 19:02:25', '2021-12-25 12:47:22');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (81, true, '2022-06-04 16:53:04', 'Nunc purus. Phasellus in felis. Donec semper sapien a libero.', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', 56, 96, 84, 84, 50, '2022-05-04 20:26:50', 'Hawaiian Airlines', false, 'MSR', 'TUA', 881.72, 688.03, 355.52, '2022-04-21 02:37:37', '2022-11-07 00:06:02');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (82, true, '2022-10-01 12:42:14', 'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', 41, 40, 2, 2, 74, '2022-09-30 15:22:31', 'Southwest', false, 'MRX', 'YHH', 201.03, 604.04, 786.05, '2022-10-12 10:03:01', '2022-05-22 12:50:38');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (83, true, '2022-07-14 07:45:28', 'Etiam justo.', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 36, 36, 21, 21, 15, '2022-01-23 23:45:07', 'Southwest', false, 'VDA', 'STH', 169.09, 960.39, 660.07, '2022-02-09 10:51:15', '2022-02-03 12:56:46');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (84, true, '2022-11-10 00:10:33', 'Suspendisse potenti. In eleifend quam a odio.', 'Donec semper sapien a libero.', 55, 51, 17, 17, 45, '2022-08-26 04:11:13', 'United', true, 'KSG', 'WRY', 538.64, 999.51, 834.4, '2022-09-02 12:07:07', '2022-10-21 14:50:20');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (85, false, '2022-04-18 05:35:17', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 'Ut tellus.', 4, 42, 76, 76, 97, '2022-08-17 20:24:26', 'JetBlue', true, 'CBE', 'TPP', 520.63, 885.45, 810.78, '2022-03-16 20:30:11', '2022-04-02 00:09:30');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (86, true, '2022-08-22 19:32:14', 'Phasellus in felis. Donec semper sapien a libero.', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 27, 94, 71, 71, 75, '2022-05-17 09:29:20', 'JetBlue', false, 'NCR', 'QRA', 848.15, 291.43, 587.8, '2022-05-13 23:45:17', '2022-07-22 15:16:30');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (87, true, '2022-02-03 12:36:00', 'Curabitur at ipsum ac tellus semper interdum.', 'Praesent blandit. Nam nulla.', 10, 46, 1, 1, 95, '2022-09-21 07:25:05', 'American', false, 'IQQ', 'RZS', 918.99, 512.9, 848.27, '2021-12-31 18:49:10', '2022-04-16 03:05:28');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (88, true, '2022-11-01 05:27:00', 'Nulla ut erat id mauris vulputate elementum.', 'Aenean sit amet justo.', 68, 94, 93, 93, 75, '2022-07-11 20:56:39', 'United', false, 'KAF', 'PWM', 603.25, 869.49, 245.28, '2022-10-06 01:07:36', '2022-08-07 00:31:34');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (89, false, '2022-04-26 21:25:40', 'Nulla mollis molestie lorem. Quisque ut erat.', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 56, 40, 23, 23, 52, '2022-06-01 06:33:06', 'Southwest', false, 'DWC', 'QEO', 363.2, 267.45, 713.21, '2022-08-05 09:17:32', '2022-04-15 11:31:57');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (90, true, '2022-12-01 13:38:19', 'Nullam sit amet turpis elementum ligula vehicula consequat.', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 1, 4, 81, 81, 74, '2022-03-13 16:20:15', 'Southwest', false, 'RIE', 'DOC', 317.47, 824.24, 866.34, '2022-01-26 05:12:09', '2022-07-23 04:49:40');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (91, false, '2022-04-14 01:19:27', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 55, 32, 29, 29, 8, '2022-10-24 11:15:25', 'Southwest', false, 'YKZ', 'BUF', 338.97, 712.58, 618.49, '2022-09-06 14:59:24', '2022-06-27 19:55:33');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (92, false, '2022-09-16 19:28:57', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 'Phasellus id sapien in sapien iaculis congue.', 18, 9, 9, 9, 72, '2022-03-25 16:11:10', 'Hawaiian Airlines', false, 'MUF', 'YQD', 421.66, 836.06, 299.55, '2022-09-14 00:48:48', '2022-08-07 08:40:07');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (93, true, '2022-05-05 16:33:54', 'Fusce consequat.', 'Phasellus in felis. Donec semper sapien a libero.', 56, 79, 52, 52, 80, '2022-05-07 00:29:28', 'United', false, 'SPJ', 'ETL', 957.81, 964.87, 662.76, '2022-07-20 19:35:23', '2022-08-17 05:29:09');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (94, false, '2022-02-15 20:33:14', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 74, 30, 74, 74, 61, '2022-11-21 18:26:34', 'American', false, 'CML', 'SFQ', 384.16, 362.56, 634.34, '2022-05-12 03:40:28', '2022-10-17 07:06:00');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (95, true, '2022-01-16 11:31:35', 'Sed sagittis.', 'Nulla mollis molestie lorem.', 87, 24, 25, 25, 9, '2022-10-30 15:34:24', 'Hawaiian Airlines', false, 'TUF', 'TNF', 235.5, 146.55, 194.97, '2022-03-15 06:31:00', '2022-12-05 11:55:52');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (96, true, '2022-02-09 13:18:36', 'Pellentesque at nulla.', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', 29, 86, 95, 95, 30, '2022-04-28 16:48:52', 'American', true, 'GOE', 'MBS', 160.72, 522.62, 839.86, '2022-07-20 00:37:07', '2022-07-03 14:08:12');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (97, true, '2022-10-04 19:37:02', 'Cras in purus eu magna vulputate luctus.', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', 80, 98, 84, 84, 70, '2022-04-22 13:37:36', 'American', true, 'AUN', 'RUH', 549.26, 828.53, 344.83, '2022-05-14 08:03:12', '2022-11-02 15:16:45');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (98, false, '2022-06-21 10:57:42', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 'Nulla ut erat id mauris vulputate elementum.', 11, 4, 9, 9, 47, '2022-03-14 15:43:37', 'Hawaiian Airlines', false, 'AUL', 'EGO', 789.04, 524.88, 978.71, '2022-05-11 06:49:33', '2022-08-02 17:48:57');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (99, false, '2022-03-04 01:01:00', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 16, 10, 80, 80, 16, '2022-08-02 07:31:57', 'Delta', false, 'ADR', 'SSA', 290.74, 394.5, 336.39, '2022-03-04 04:51:38', '2022-05-09 21:09:23');
insert into flights (tripID, for_sale, datePosted, airline_message, special_requests, bidID, trade_ID, buyerID, portfolioID, adminID, date_purchased, airline, is_layover, depart_airport, arrive_airport, purchased_price, current_price, asking_price, takeoff, land) values (100, false, '2022-11-20 05:52:41', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', 22, 70, 26, 26, 17, '2022-01-12 14:42:27', 'Alaskan Airlines', true, 'VDM', 'GYY', 798.08, 494.91, 180.88, '2022-04-08 09:21:03', '2022-03-20 09:14:09');
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


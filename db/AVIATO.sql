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
    `takeoff` DATETIME NOT NULL,
    `land` DATETIME NOT NULL,
    PRIMARY KEY (`tripID`),
    CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`bidID`) REFERENCES `bid` (`bidID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`trade_ID`) REFERENCES `trade` (`trade_ID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`buyerID`) REFERENCES `buyer` (`buyerID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_4` FOREIGN KEY (`portfolioID`) REFERENCES `flights_portfolio` (`portfolioID`) ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT `flights_ibfk_5` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON UPDATE cascade ON DELETE restrict
    CONSTRAINT `flights_ibfk_6` FOREIGN KEY (`trade_ID`) REFERENCES `trade` (`trade_ID`) ON UPDATE cascade ON DELETE restrict,
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
    `pemissions` VARCHAR(255) NOT NULL,
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





insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (71458, 'Male', '2022-05-22 22:07:32', 'Hodge', 'McGinnis', '975-485-9886', 'hmcginnis0@archive.org', '4b84a6c94b267f78a22b3e957baa3be902d24f7b207a291a3bedec22227234d9', '404', '408');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (75001, 'Male', '2021-12-12 06:10:59', 'Ely', 'Haresign', '930-339-2160', 'eharesign1@tripadvisor.com', 'aac3c0de40d8e20923f48091f36ea84285761ed311cbb7f98cf38a46d1a6e8d4', '340', '899');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (59464, 'Male', '2022-06-13 04:33:39', 'Donaugh', 'Kinneally', '562-478-5411', 'dkinneally2@answers.com', '832d01beecf96cc5d8e7e38f40ab4e3a57c7365a0e80aa5068954269060e692c', '232', '1000');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (91596, 'Female', '2022-07-29 14:48:06', 'Annabell', 'Annesley', '349-332-9770', 'aannesley3@rediff.com', '2794a65af953d77c3a95aeca7dcc78631588f806b0ba8d76f200ded3e3e05699', '131', '824');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (74570, 'Male', '2022-04-13 00:27:16', 'Ephrayim', 'Calterone', '941-343-5403', 'ecalterone4@php.net', '22776387111d262237159cca476f0d45555f8e7b8a75f3f518e7d6c17d6bb1ae', '2', '466');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (77498, 'Female', '2022-09-05 00:48:11', 'Kellsie', 'Johnsee', '730-483-0797', 'kjohnsee5@nifty.com', '47cd718055914c7aca84b625ace77e7450af0254febeb133be202dfe948b4629', '381', '516');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (44594, 'Male', '2022-07-06 01:20:42', 'Benjie', 'Kopje', '826-935-6861', 'bkopje6@google.de', 'b67432676c5248cd39246ce8de06b73941f439e4259df49cb3bae543edf81f15', '877', '929');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (75158, 'Female', '2022-03-18 01:31:20', 'Judith', 'Maron', '848-398-0335', 'jmaron7@tuttocitta.it', 'd03caf45ebf949979b7ea890fa1f4d34f74d485c17d192fadfe8d33e3d289b7a', '978', '426');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (29097, 'Male', '2022-03-27 19:10:50', 'Haroun', 'Leigh', '719-800-8215', 'hleigh8@eepurl.com', 'a0cab3ed0e4446f8b46d3d299437636674f84f092dd50b9104500e95089f5bfe', '749', '248');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (47492, 'Female', '2022-06-09 09:25:35', 'Adaline', 'Tinman', '297-132-2226', 'atinman9@typepad.com', 'f7690d3aa71254c15fb1adbb7d799a15b3edda7f60c0f04c7ff7dd47b09ae09f', '5', '198');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (92081, 'Male', '2022-03-06 11:34:22', 'Bron', 'Caveney', '334-923-2010', 'bcaveneya@youtu.be', '7485c66b9956ae25186afebfdf9e3404ba4862e5a1562109d66e4496e56fc06d', '330', '150');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (25871, 'Male', '2022-10-17 03:32:46', 'Wright', 'Agett', '765-781-2661', 'wagettb@independent.co.uk', '4d480e44d8d730f6c067d322b44bc04369e7ca27489a6a80126548e91381fa91', '821', '261');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (96765, 'Male', '2022-04-10 06:10:23', 'Corny', 'Dutteridge', '831-976-0359', 'cdutteridgec@nbcnews.com', 'a188236689a17b7c1b4fcbaaed4c1ba66f842afafb27fcad8ec4c022f3ed02b7', '393', '980');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (89924, 'Female', '2022-07-07 04:42:10', 'Daron', 'Medlin', '380-549-7594', 'dmedlind@zdnet.com', 'eb2fc4dbb58d29492d2d5bc461884b9fd2257f3fe195891b7b7fc560b977630f', '964', '387');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (68213, 'Male', '2022-11-29 16:52:02', 'Arty', 'Brickham', '445-861-3942', 'abrickhame@photobucket.com', '9d6c531ccb0856c3df113cd234162e2ef9ac030a6e3d8a50b16eb7b592cdb06b', '436', '868');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (67303, 'Female', '2022-08-09 18:40:58', 'Anya', 'Lonnon', '141-683-2793', 'alonnonf@techcrunch.com', 'a5618a6953d08a323c083dabad8557f4f88c1246c161f0f37c64bf7903405175', '916', '661');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (9921, 'Female', '2022-05-22 20:13:18', 'Simone', 'Sproat', '210-465-0242', 'ssproatg@columbia.edu', '5932431e6011e86e259e7e81145c8f519c25c907a88bc5db7bab7653619252e5', '443', '821');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (5380, 'Female', '2022-09-29 18:05:21', 'Faunie', 'Haddington', '187-258-9282', 'fhaddingtonh@spotify.com', 'd4567c9e30add558beaad53f977e7f659b3d52c1d3e900e2325f01c643915f33', '977', '34');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (70827, 'Polygender', '2022-04-25 22:17:17', 'Carmel', 'Peacock', '425-321-6037', 'cpeacocki@mtv.com', '793dbfd546463e38e058344dec766403b4750c231ef9860157dd841bf4ae8ba3', '545', '356');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (89025, 'Male', '2022-08-26 20:11:32', 'Dieter', 'Arden', '297-433-3075', 'dardenj@gravatar.com', 'f64ecdf1aec86c55b79c021c47e1264f0acf7e240a4e96764e5c0993e2ef3138', '867', '596');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (27533, 'Female', '2022-07-24 06:00:44', 'Kipp', 'Orbell', '593-627-7627', 'korbellk@phoca.cz', 'd9a937144620acdc5055137b9174fa917409feeb6c0690f21cc44fdc17b5bde6', '572', '747');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (982, 'Male', '2022-07-31 04:36:03', 'Natty', 'Scholig', '656-399-6311', 'nscholigl@tmall.com', '41435550298905b1227b089afd8435b5ab26f20d2be2c51c16ef7e430f1ae63b', '627', '462');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (24064, 'Male', '2022-09-11 06:34:22', 'Herby', 'Wiggington', '687-967-2583', 'hwiggingtonm@dell.com', 'b4d9cbc6cf4ab938a922114bd574aa847453be541399b08e2db111317d0a35e8', '35', '186');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (99983, 'Male', '2022-04-12 14:40:23', 'Myles', 'Longmore', '777-724-7296', 'mlongmoren@jugem.jp', '135fe5f93b29e190ca931bcb46a7c8fd85a500745ab1a4080c90b8eac1b6fe87', '336', '787');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (98740, 'Male', '2022-11-10 20:23:34', 'Valdemar', 'Thomelin', '489-695-4027', 'vthomelino@tripadvisor.com', '986d4730caeb3ba201349d95d625362f09c9c449b658d5be37c40890f44fcd67', '266', '656');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (95038, 'Female', '2022-07-20 23:30:01', 'Sioux', 'Barwis', '386-225-2846', 'sbarwisp@paypal.com', 'c3c82881dfc7b5e146364dd64221ca4250e9540fe778c4fa47de31c9dd399cc9', '707', '696');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (47217, 'Male', '2022-08-21 17:06:02', 'Goraud', 'Dillingstone', '972-583-3263', 'gdillingstoneq@oakley.com', 'a8294db340b4404a695667fe27cb592f0ec0cd018498f5ac57a60eaeb1cd1625', '735', '240');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (68017, 'Agender', '2022-08-17 17:49:07', 'Michail', 'Stoter', '375-731-3508', 'mstoterr@nydailynews.com', '4c96d6f1596c0fc859a13323f5691d4655e3a0e49109a411278cf4d6d8861b46', '997', '863');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (14553, 'Female', '2022-11-22 08:34:45', 'Othilie', 'Laphorn', '154-186-2198', 'olaphorns@illinois.edu', '9b4fd4a959dce605e93a0fce7c36d66023e24292fb78e670776723c8b83f35c9', '905', '883');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (37239, 'Female', '2022-09-26 02:47:36', 'Tallia', 'Sabin', '209-999-9093', 'tsabint@smugmug.com', '00f7b559008577987fda1133931f768bfd165756808cf5ef15fcb6b1c634d92f', '365', '664');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (50116, 'Male', '2021-12-14 04:20:24', 'Marmaduke', 'Gravy', '685-161-3934', 'mgravyu@spiegel.de', '4db432d445764b0c858fd6c0bea15ce94efb8bd78b769eb6e1792165e5340b30', '163', '53');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (21530, 'Female', '2022-01-02 18:05:20', 'Antonetta', 'MacCheyne', '677-978-3065', 'amaccheynev@zimbio.com', '73697b47240f1d96e0e5579b11366d005cd7b9cd9006e9408f0a0ba3b8e04ddf', '331', '327');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (21572, 'Male', '2022-02-03 02:21:50', 'Pryce', 'Jewers', '691-911-3708', 'pjewersw@redcross.org', '2eeff2feba3399eb81e4917388ee4a4ebd588117a5d2a33bad85fa9a741084c2', '681', '635');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (1392, 'Non-binary', '2022-05-26 03:44:08', 'Inga', 'Livett', '492-798-5934', 'ilivettx@guardian.co.uk', '2ca4c18c7ab183755b258d94dc28ca66733165353ba1922760ea22fce6a8ab9a', '424', '92');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (64470, 'Male', '2022-07-18 02:22:43', 'Laird', 'Ruckert', '902-891-6355', 'lruckerty@irs.gov', '77001a3b03aa935707881e3a8ee395432818a89d8ea8f07039e962f79fa1035e', '731', '178');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (72763, 'Female', '2022-08-13 21:34:06', 'Deonne', 'Bugg', '824-967-2483', 'dbuggz@prlog.org', '63be4d495d5928977ee79990019f6c9789df02bf2c2b8fdc59332939934627c1', '984', '86');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (89591, 'Female', '2022-05-26 18:05:41', 'Reyna', 'Risdale', '618-630-8026', 'rrisdale10@csmonitor.com', 'c5e30c0463305ea615ae893568cfe09e1e228bda85b1ff0121e16d9e804369d6', '669', '757');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (94158, 'Female', '2022-09-04 05:57:36', 'Sella', 'Jimmes', '971-927-9690', 'sjimmes11@shareasale.com', 'f268367192e2b431ae67b15938c8b1d9a056ae23aea494b8c069c38429be355e', '128', '605');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (99057, 'Male', '2022-07-12 22:54:19', 'Rockwell', 'Race', '759-769-0861', 'rrace12@myspace.com', 'c372d5b33eabc233be6638ca8cb7a2c710830ed57ee44ef1501981b841b965fa', '169', '130');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (74161, 'Male', '2022-11-15 06:00:56', 'Donal', 'Suthren', '926-406-6334', 'dsuthren13@home.pl', 'd9b7ce230eec4a057d662d1b63ac0913c61f41a264ced6562a459241781256d3', '12', '60');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (88626, 'Male', '2022-04-01 21:03:32', 'Mario', 'Cranfield', '629-113-4080', 'mcranfield14@newsvine.com', '24fb27573c8d236e6a2dba73e14c6de43d6c3f252652e13cd622aed75a773d21', '420', '183');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (69107, 'Genderqueer', '2022-10-07 04:44:45', 'Stoddard', 'Guarnier', '335-197-4613', 'sguarnier15@si.edu', '3feb9f503b3d597fbe6592c2b445f79778fd2fb721716211c01304ab8fc7c983', '72', '425');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (88485, 'Male', '2021-12-18 13:45:49', 'Dal', 'Punter', '186-880-9073', 'dpunter16@nyu.edu', '2bd53936ddc3d1c0c1892366cf2958074e4910ab213e77cfa1ccc95e9a1fb252', '697', '703');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (91662, 'Female', '2022-07-12 20:27:32', 'Rina', 'Mateev', '265-547-4266', 'rmateev17@thetimes.co.uk', '587b1a023d2ab4f02323fe01dbcf5997412b8aafba77b4393600a5c281455a51', '63', '715');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (54669, 'Female', '2022-05-07 02:41:02', 'Helen', 'Purry', '310-300-9095', 'hpurry18@mysql.com', '393e9b7e6edd9229603b9e341762de66edea39b63648e572ac71f0eb9583c41f', '865', '557');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (34665, 'Male', '2022-06-12 13:38:16', 'Hershel', 'McQuarter', '749-938-2399', 'hmcquarter19@toplist.cz', '399da5b67fc1f329091bc8dea66dac324e212051e3fefc45bd8484cf2700cd7a', '718', '537');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (48886, 'Male', '2022-04-15 00:40:00', 'Benedick', 'Derl', '165-993-0327', 'bderl1a@51.la', 'a12a70b73fdf06c464ad3098bbdc7b5d4af1862b0e7f30d80da1134f13c4789b', '557', '87');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (95037, 'Male', '2022-03-05 00:41:25', 'Budd', 'Pladen', '523-570-5889', 'bpladen1b@yale.edu', 'f86e4796897572571bb50129a0e3978bca1f5e6b579f42994e6517c073cf2c2c', '176', '32');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (86699, 'Male', '2022-01-10 09:52:21', 'Enoch', 'Ferroni', '580-169-6294', 'eferroni1c@myspace.com', 'b9274dae5c26395f10d9821ecca45fb0e31877b3a7dcb08793b44cd3ac2c574a', '711', '127');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (42569, 'Male', '2021-12-25 01:37:06', 'Ambrosius', 'Waulker', '146-763-2944', 'awaulker1d@nih.gov', '7f9fe3bb332703627de281783afbd2aef3b4d549951a246ec10d855b47e4544e', '297', '296');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (7762, 'Female', '2021-12-20 12:54:04', 'Gui', 'Shilstone', '136-691-5431', 'gshilstone1e@t-online.de', '6725b43262931cba127473073ab89b264aa70ce60a987f69cab154d718a83957', '753', '243');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (76694, 'Female', '2022-02-26 06:48:42', 'Tarra', 'Crowdson', '490-849-2731', 'tcrowdson1f@bloomberg.com', 'e9b3c09a00250a36ce9c70f0d6f8370f7393ee860277fdd3874f6cfcd11d59d3', '434', '963');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (61222, 'Male', '2022-08-16 02:17:14', 'Jard', 'McQuarrie', '510-221-3744', 'jmcquarrie1g@123-reg.co.uk', '749621300adb55fa353b190e6acd7b545bf18046c9421be28b7bbdfb50d6f77f', '318', '911');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (31910, 'Male', '2022-02-10 16:37:01', 'Benjamen', 'Zanuciolii', '461-326-4134', 'bzanuciolii1h@purevolume.com', 'd48aa66c7d3f8db05a1167143d8fbf5a94dbe268f2aeb5022708624b0b7527e1', '27', '947');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (44439, 'Female', '2021-12-28 21:05:12', 'Trix', 'Mease', '259-217-7339', 'tmease1i@economist.com', '5922f600e0a79ade0f8db6254b628942de4aa86944e3478e7b1ca7f8940b77d8', '689', '197');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (7909, 'Polygender', '2022-03-30 15:16:32', 'Suellen', 'Jozef', '143-719-7187', 'sjozef1j@unblog.fr', '565d7ed7d8f1d97b761046b12858a4259ef9b869c80625dbd2383aa0947cc283', '816', '352');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (20750, 'Genderfluid', '2022-09-05 04:45:59', 'Elisabeth', 'Wittrington', '229-715-8599', 'ewittrington1k@creativecommons.org', '97d9e9ae81c1a08a98d0f945cc7d78e5dcd677da5d76aa53d318a33a7ba9f82a', '966', '758');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (19541, 'Male', '2022-08-11 08:25:19', 'Nathanil', 'Oulner', '610-683-5036', 'noulner1l@china.com.cn', '5257e1c72a8142ca23f852c9de06532ed6ac7319ee44182d67c1a045b76a579e', '180', '870');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (66764, 'Male', '2022-01-25 00:50:23', 'Taite', 'Domeny', '590-874-3020', 'tdomeny1m@marriott.com', '2d46951ffd018958e6f945191d7352eb70f016272b17228784bdc807be09f719', '750', '802');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (49374, 'Male', '2022-09-11 23:38:53', 'Sonnie', 'Stoffer', '633-372-9400', 'sstoffer1n@barnesandnoble.com', '405e1bd96d405e670fab70880785dc28153e6d22e544f722a8f1a6433418c6d7', '17', '234');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (68093, 'Female', '2022-07-13 04:54:56', 'Cathe', 'Banfield', '617-476-4942', 'cbanfield1o@ucoz.ru', 'eb656e1ddadbd5b76c668b6f4844b80fb9de8fcc382b0a2bafeab78935f5ae9f', '763', '12');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (6654, 'Female', '2022-09-03 22:23:03', 'Madalena', 'Cruickshank', '602-477-5999', 'mcruickshank1p@squidoo.com', '39062add4a9b27e590860c29f53c9b1642169424f5bac007b48d53a44907f48b', '584', '163');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (55686, 'Male', '2022-04-14 07:49:23', 'Archy', 'Wadesworth', '978-614-5716', 'awadesworth1q@t.co', '889aa0f0526862f062bb2f5856d9bb761d2c604a7d9c84ef34af7716da79f7fa', '279', '365');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (73676, 'Male', '2022-06-22 21:24:48', 'Gregor', 'Backson', '702-743-0507', 'gbackson1r@webeden.co.uk', 'bd26f562b64ad876f2d0c07f222ebded0b2fb201c3944cbf9396d216c9c19e3b', '910', '76');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (33343, 'Female', '2022-08-21 16:31:12', 'Kara-lynn', 'Venn', '214-852-9238', 'kvenn1s@digg.com', '1fb03b204435401ef5f32f477d578f7c4303752169f595168b4db07fd6c3d9d8', '475', '842');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (624, 'Female', '2022-06-27 14:15:44', 'Cinnamon', 'Grzesiewicz', '630-353-4809', 'cgrzesiewicz1t@geocities.jp', '6ba70fa05c5059e879a084f3cf8080a89c19b74cd3115f34bf518a43004ca652', '126', '813');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (2684, 'Female', '2022-01-19 08:36:29', 'Roseann', 'Fearey', '998-178-5948', 'rfearey1u@google.com.br', 'd6583e107923119906bbe440ffcb967b98e004d114965ebbe496405c1151477c', '224', '608');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (79897, 'Female', '2022-07-02 04:03:57', 'Leisha', 'Durrett', '790-708-3893', 'ldurrett1v@aboutads.info', '3e33bb2ed58a2b7e509389d60621551c886cd6b38cdc75ae31107ae9dbff1508', '683', '435');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (56604, 'Genderfluid', '2022-08-30 05:43:27', 'Marshal', 'Jenkison', '957-239-9060', 'mjenkison1w@blogtalkradio.com', 'e21df6e8b33594d7a08fa139e78553e1e9167a3ae9646ff80640906b1c617efb', '320', '217');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (72291, 'Female', '2022-07-16 13:36:24', 'Gwynne', 'Nevison', '179-134-3958', 'gnevison1x@kickstarter.com', '474313c70ab7f42929094d4a61ee755e852cd8166a660071a1c4e4f5b62b287f', '62', '763');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (16602, 'Genderfluid', '2021-12-09 20:31:33', 'Glynis', 'Timms', '658-382-5855', 'gtimms1y@biblegateway.com', 'fc38050d4cd21fb47a1d53a5a15e2974b7ceee6f384a38f48f3fd7115e888f77', '647', '153');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (68922, 'Female', '2022-12-01 08:55:32', 'Kipp', 'Axelbee', '819-842-8133', 'kaxelbee1z@alexa.com', 'ee37de8eafab30e65553490ec36405b8f98de94e9f339fdb9fefab6d6530e47a', '400', '65');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (4056, 'Male', '2022-06-12 10:12:55', 'Burtie', 'Speed', '540-976-7067', 'bspeed20@google.com.hk', '4ce55963695ff731ef2ac601ab2a5a8661379920a3812d335340d9b704af8f90', '344', '543');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (88310, 'Male', '2022-11-13 14:03:50', 'Clayborn', 'Ivanyushkin', '350-114-2494', 'civanyushkin21@go.com', '4f4b37f0f04aca96d7742c006a3c890ee4d3ade232a843e7162e212d579cf259', '996', '412');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (72488, 'Male', '2022-08-03 21:55:03', 'Lamar', 'Yushankin', '665-390-1639', 'lyushankin22@mail.ru', '75c8cc759f7e3c2d640fccebd37551223b60fb401b8934d00157d29912681d6d', '657', '176');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (10099, 'Male', '2022-10-14 21:33:06', 'Abeu', 'Shovlin', '618-148-8657', 'ashovlin23@comsenz.com', '91ca4a9d78ae7c9a44b36a4d7ecfef88af69aedfac0815b217c5c4bca5f0c451', '195', '961');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (96416, 'Male', '2022-03-27 02:47:53', 'Casar', 'Teideman', '821-593-5194', 'cteideman24@toplist.cz', 'f782bdb086f8acc1d2fa2882edf8c6acd2a1eedf9d7756e95bfd2e8b9495c64c', '117', '668');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (16346, 'Polygender', '2022-08-26 01:53:34', 'Cloe', 'De Cristoforo', '993-668-9549', 'cdecristoforo25@fastcompany.com', 'de76a932024934c561e7fc5e46dd70bd39f59fbdb83f5143f1fcef3adef5273f', '553', '48');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (15499, 'Female', '2022-07-20 14:38:23', 'Diane', 'Worms', '483-810-1140', 'dworms26@google.es', '1af29ca4b575b3f551f32a25749b2cdf2d72767fc4c2da267caabbed2bd92413', '806', '717');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (54204, 'Male', '2022-08-31 15:32:52', 'Kilian', 'Dulwich', '631-472-1024', 'kdulwich27@sogou.com', 'a69e25605ac038ebc29b588194854f3eecff02720c784fe1a94842aa2b0a803b', '577', '396');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (53418, 'Male', '2022-04-17 14:33:44', 'Gav', 'Lyle', '497-503-3540', 'glyle28@va.gov', 'e33792e7c3939963af15c548e2836ec0b28cda87b3772dcb6b766bfb3653c655', '337', '991');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (12520, 'Female', '2022-11-11 10:25:20', 'Brittany', 'Ormond', '880-966-2887', 'bormond29@go.com', 'bdfc4aecb978574eea43750ad1f6afb60fb64798d5ef3deaa3f36aacf321409b', '967', '525');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (59273, 'Female', '2022-01-24 20:48:43', 'Annnora', 'Batting', '957-904-5863', 'abatting2a@bizjournals.com', 'e2fe8f8184552fadaa081d93f1353805489f53d06dc6577e2cd3018970c30936', '487', '64');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (40636, 'Male', '2022-12-04 19:59:07', 'Zebedee', 'Chappel', '916-626-9062', 'zchappel2b@nyu.edu', '6450ec50cf883c96b01b69c2056446607dd97069b7518d806b3594ab80b2c280', '96', '869');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (59842, 'Female', '2022-05-10 23:22:23', 'Sharai', 'Chappel', '614-750-9414', 'schappel2c@constantcontact.com', '833c512cc893f4d29b9778f9e8841f0c1fc8898134ac5403a1ad63ca3a538faf', '634', '237');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (42659, 'Male', '2022-09-29 15:21:50', 'Dwayne', 'Valance', '424-192-9576', 'dvalance2d@nbcnews.com', '23667742113d62751eb3f4d15778a64d490155b7ccd584bb7c33a9d756386fdf', '385', '448');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (60271, 'Male', '2021-12-25 12:13:47', 'Nicky', 'Lile', '125-568-0378', 'nlile2e@bloomberg.com', 'acd8709bab1507b2bc1f3e0def2e9df548ff13ffbc1f50b61b4248d6818fe36f', '150', '882');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (3313, 'Female', '2022-02-09 17:12:44', 'Anitra', 'Guilaem', '421-400-8003', 'aguilaem2f@sogou.com', '3f406342abaa39c0017054df171fe19cbc701a8aa80385ea0bf51f23582ed8f5', '311', '872');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (28223, 'Female', '2022-05-04 03:54:17', 'Carmina', 'Mingasson', '974-780-1256', 'cmingasson2g@ameblo.jp', '9476947fa2295ceb13f8a2d7d681a592e7fd3031072d83673b8f4148b88bfc99', '147', '471');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (81366, 'Female', '2022-08-27 03:34:19', 'Phelia', 'Rawlence', '711-767-8807', 'prawlence2h@sphinn.com', 'abd78728e98eff43f2318cb152b89af8b9717381150f8790742678bbeb7d93d2', '834', '556');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (37686, 'Female', '2022-05-29 12:35:01', 'Lanae', 'Adamowitz', '697-594-1166', 'ladamowitz2i@edublogs.org', '0bbc06c95b747b13dd0b4a6a16de8316e829e0c52f6d97f6025e07ddcaab0420', '769', '174');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (84458, 'Female', '2022-03-09 19:47:40', 'Cortney', 'Nuton', '745-308-6037', 'cnuton2j@huffingtonpost.com', '29011538c5b2ef9822d91b1deb2a086107a5cc2805987c7f1cb96c555b000353', '25', '610');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (7171, 'Male', '2022-02-22 12:49:49', 'Casar', 'Haxell', '998-427-9320', 'chaxell2k@jiathis.com', 'dfb83c895387be4347d9f3a89e9cdc7aa38e910c9b73c38955df33648e811b2e', '133', '583');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (2004, 'Male', '2022-03-04 09:20:31', 'Marlon', 'Scotchmoor', '932-790-3788', 'mscotchmoor2l@topsy.com', '39ec67d44a6b1aa879d21e19a9f17f3f5afb17b3ab9a38a66ba24d9674ed0c49', '398', '423');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (80348, 'Female', '2022-06-12 01:18:35', 'Piper', 'Rothwell', '548-459-4988', 'prothwell2m@geocities.jp', '2a889de81ab140ab7a00822dc51b6f90187351463a998d4c3c29cbcdbac3a802', '995', '875');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (58644, 'Male', '2022-02-05 23:19:15', 'Dunn', 'Attrey', '344-329-0592', 'dattrey2n@1688.com', 'aa73815eaaa84cbc7a74fedbc27ce7864890c1bf7ab696f2e2618c107822dff4', '111', '171');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (14871, 'Male', '2022-10-26 10:06:14', 'Davin', 'Woodley', '645-203-3259', 'dwoodley2o@dmoz.org', '0aec18308a5f66f161805605449c54424da5ba105b4372072e60e661e67203a4', '644', '215');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (68376, 'Male', '2022-02-26 11:46:15', 'Orlan', 'Neylon', '628-529-6023', 'oneylon2p@cnbc.com', 'a5b01e48a2891230760c278181dd8d2736f293c3ba74ca30f0ee033f3f670529', '670', '241');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (46488, 'Genderfluid', '2022-06-17 06:46:59', 'Andriette', 'Tarling', '209-950-9035', 'atarling2q@i2i.jp', '98a7deff308d2e6f7364ac5bb0cd6b1cc18bed3a23779274fec9ec0f2d34a699', '92', '456');
insert into user (userID, gender, birthdate, firstName, lastName, phone, email, permissions, buyerID, sellerID) values (88192, 'Female', '2021-12-08 08:03:11', 'Bryn', 'Zarfai', '597-743-2099', 'bzarfai2r@bing.com', 'b12e10338bd861b68f55da4785367ae8c93320d3d61ee4215791cc720bcc8095', '566', '407');


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
insert into trade (trade_ID, date, price, buyerID, sellerID) values (1, '2022-08-05 19:25:03', '$430.48', '565', '453');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (2, '2022-02-06 14:16:44', '$668.63', '878', '55');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (3, '2022-08-19 15:07:28', '$481.63', '37', '273');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (4, '2022-09-19 07:40:58', '$526.89', '631', '741');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (5, '2022-10-05 06:12:55', '$65.44', '656', '307');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (6, '2022-10-30 17:44:44', '$691.20', '187', '368');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (7, '2022-04-21 00:29:18', '$684.37', '768', '284');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (8, '2022-04-03 12:42:04', '$532.23', '924', '799');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (9, '2021-12-14 08:45:29', '$904.88', '42', '667');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (10, '2022-11-09 12:20:13', '$971.54', '376', '457');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (11, '2022-07-13 19:05:18', '$195.55', '35', '247');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (12, '2022-07-19 03:10:50', '$291.58', '855', '114');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (13, '2022-07-18 12:28:25', '$263.71', '988', '550');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (14, '2022-07-06 20:09:10', '$631.40', '896', '102');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (15, '2022-10-01 13:40:04', '$482.94', '910', '135');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (16, '2022-01-05 06:39:12', '$383.18', '395', '886');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (17, '2021-12-08 23:07:27', '$901.73', '473', '866');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (18, '2022-10-04 14:46:46', '$594.91', '366', '85');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (19, '2022-10-16 04:43:58', '$195.52', '858', '553');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (20, '2022-05-23 11:30:31', '$210.01', '560', '216');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (21, '2021-12-07 08:27:08', '$330.73', '304', '298');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (22, '2022-04-12 06:22:01', '$961.21', '447', '899');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (23, '2022-04-05 22:24:14', '$324.27', '99', '66');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (24, '2022-02-16 05:17:45', '$226.44', '431', '319');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (25, '2022-09-01 15:48:06', '$731.45', '953', '362');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (26, '2022-06-20 16:22:59', '$207.73', '2', '331');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (27, '2022-10-30 19:47:03', '$80.24', '719', '592');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (28, '2022-08-02 18:37:45', '$266.68', '694', '227');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (29, '2022-10-03 16:29:33', '$388.26', '500', '39');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (30, '2022-10-31 15:06:02', '$263.98', '601', '987');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (31, '2022-01-05 16:10:52', '$783.05', '269', '72');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (32, '2022-05-20 08:23:36', '$533.95', '403', '385');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (33, '2022-05-03 13:08:14', '$790.69', '287', '986');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (34, '2022-08-02 03:15:04', '$638.33', '681', '679');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (35, '2022-11-06 23:02:32', '$774.97', '276', '942');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (36, '2021-12-18 23:47:32', '$372.19', '459', '361');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (37, '2022-06-11 19:59:35', '$697.19', '62', '295');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (38, '2022-09-01 06:59:52', '$275.35', '132', '458');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (39, '2022-01-14 03:25:35', '$222.84', '209', '30');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (40, '2022-02-15 20:27:58', '$289.52', '207', '165');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (41, '2022-03-03 20:33:58', '$123.72', '235', '607');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (42, '2022-06-13 23:58:55', '$873.51', '477', '342');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (43, '2022-10-24 12:56:41', '$620.15', '342', '106');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (44, '2022-10-05 21:25:49', '$494.31', '242', '281');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (45, '2022-11-25 01:02:28', '$797.62', '199', '648');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (46, '2022-08-29 09:37:48', '$866.03', '821', '56');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (47, '2021-12-28 21:17:06', '$720.89', '57', '221');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (48, '2022-10-05 18:42:26', '$879.16', '542', '639');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (49, '2022-05-13 21:15:55', '$921.81', '189', '113');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (50, '2022-11-15 22:50:30', '$283.48', '168', '61');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (51, '2021-12-06 02:21:36', '$919.85', '371', '723');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (52, '2022-05-11 03:11:05', '$604.39', '465', '653');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (53, '2021-12-12 13:58:23', '$498.78', '328', '65');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (54, '2022-02-13 05:57:20', '$484.16', '483', '226');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (55, '2021-12-24 04:42:44', '$81.40', '587', '875');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (56, '2022-04-11 22:00:52', '$997.25', '752', '914');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (57, '2022-04-25 00:42:27', '$446.43', '208', '194');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (58, '2022-11-24 16:14:06', '$772.85', '628', '522');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (59, '2022-07-30 12:05:28', '$939.77', '480', '397');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (60, '2022-09-08 17:48:30', '$860.11', '886', '833');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (61, '2022-07-11 22:12:09', '$370.68', '435', '432');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (62, '2022-08-11 20:33:17', '$585.86', '361', '968');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (63, '2022-09-25 18:34:41', '$540.68', '692', '401');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (64, '2022-04-06 11:34:31', '$320.95', '515', '403');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (65, '2022-03-19 17:08:37', '$549.20', '667', '502');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (66, '2022-09-16 06:53:16', '$503.08', '401', '334');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (67, '2022-07-13 06:02:32', '$282.97', '369', '604');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (68, '2022-09-12 15:17:16', '$395.50', '217', '210');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (69, '2022-01-20 13:08:58', '$658.52', '385', '112');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (70, '2022-05-25 18:22:35', '$924.86', '660', '795');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (71, '2022-02-24 12:19:23', '$119.85', '237', '703');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (72, '2022-09-05 15:14:20', '$690.50', '557', '104');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (73, '2022-11-15 14:59:49', '$942.18', '484', '275');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (74, '2022-04-25 05:26:20', '$85.91', '879', '486');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (75, '2022-01-05 08:47:40', '$477.52', '759', '374');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (76, '2022-04-27 00:04:02', '$126.96', '470', '207');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (77, '2022-11-10 21:07:07', '$317.67', '684', '794');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (78, '2022-05-22 04:39:26', '$683.25', '221', '231');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (79, '2021-12-27 18:52:59', '$926.70', '780', '144');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (80, '2022-03-10 14:27:10', '$247.40', '131', '831');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (81, '2022-10-27 23:41:07', '$753.79', '826', '929');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (82, '2022-07-11 13:37:05', '$693.77', '206', '609');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (83, '2022-07-21 11:34:04', '$216.27', '441', '849');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (84, '2022-09-10 16:15:43', '$317.00', '171', '861');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (85, '2022-06-13 04:21:30', '$739.75', '205', '788');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (86, '2022-06-01 20:54:58', '$938.93', '917', '328');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (87, '2022-05-19 09:25:44', '$323.57', '92', '481');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (88, '2022-07-14 22:03:10', '$341.79', '550', '77');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (89, '2022-07-02 15:30:51', '$407.68', '729', '208');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (90, '2022-12-01 01:31:11', '$151.47', '223', '521');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (91, '2022-08-12 16:43:14', '$84.04', '406', '998');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (92, '2022-04-14 02:22:04', '$278.02', '957', '463');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (93, '2022-11-30 19:06:58', '$224.07', '76', '467');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (94, '2022-08-07 23:51:32', '$76.76', '608', '45');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (95, '2022-07-14 15:15:10', '$412.24', '471', '412');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (96, '2022-01-18 10:20:22', '$757.25', '781', '200');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (97, '2022-08-24 23:42:08', '$910.30', '317', '575');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (98, '2022-09-19 23:46:06', '$241.92', '835', '852');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (99, '2022-11-12 18:30:45', '$929.30', '954', '762');
insert into trade (trade_ID, date, price, buyerID, sellerID) values (100, '2021-12-25 12:58:35', '$228.45', '919', '691');

insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (1, true, '2022-07-06 20:02:00', 'Maecenas tincidunt lacus at velit.', '337', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (2, false, '2022-01-11 03:51:43', 'Vestibulum rutrum rutrum neque.', '236', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (3, false, '2022-02-12 15:41:59', 'Morbi non lectus.', '209', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (4, true, '2022-02-18 20:53:44', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.', '19', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (5, true, '2021-12-18 15:48:59', 'Quisque ut erat.', '589', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (6, true, '2022-05-13 16:31:42', 'Morbi ut odio.', '846', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (7, true, '2022-08-08 11:06:33', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '691', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (8, true, '2022-04-14 22:41:12', 'Praesent blandit.', '108', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (9, true, '2022-09-08 00:04:37', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '898', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (10, false, '2022-05-28 15:59:35', 'Fusce consequat.', '610', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (11, false, '2022-10-14 17:04:16', 'Integer ac leo.', '211', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (12, false, '2022-01-23 07:10:03', 'Ut tellus.', '724', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (13, true, '2022-04-23 00:36:53', 'Curabitur in libero ut massa volutpat convallis.', '353', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (14, false, '2022-10-13 02:15:24', 'Morbi porttitor lorem id ligula.', '864', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (15, true, '2021-12-07 14:11:10', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', '657', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (16, false, '2022-09-17 17:30:04', 'Curabitur in libero ut massa volutpat convallis.', '515', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (17, false, '2021-12-14 16:45:26', 'Donec posuere metus vitae ipsum.', '505', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (18, false, '2022-09-29 05:51:06', 'Morbi vel lectus in quam fringilla rhoncus.', '785', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (19, false, '2022-01-17 06:27:56', 'Vivamus vel nulla eget eros elementum pellentesque.', '901', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (20, false, '2021-12-09 19:40:05', 'Integer ac leo.', '50', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (21, true, '2022-10-30 11:38:35', 'Nullam sit amet turpis elementum ligula vehicula consequat.', '839', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (22, true, '2022-01-25 15:03:29', 'Maecenas rhoncus aliquam lacus.', '524', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (23, false, '2022-08-15 04:28:09', 'Duis consequat dui nec nisi volutpat eleifend.', '983', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (24, true, '2022-10-28 01:34:35', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', '385', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (25, true, '2022-03-17 12:46:36', 'Duis consequat dui nec nisi volutpat eleifend.', '615', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (26, false, '2022-10-05 17:43:05', 'Vivamus in felis eu sapien cursus vestibulum.', '677', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (27, true, '2022-01-16 03:36:10', 'Proin risus.', '175', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (28, true, '2022-11-04 02:16:22', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '98', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (29, true, '2022-02-15 01:06:01', 'Vestibulum rutrum rutrum neque.', '14', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (30, true, '2022-09-19 14:21:02', 'Curabitur in libero ut massa volutpat convallis.', '809', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (31, false, '2022-02-10 04:38:51', 'Vivamus vestibulum sagittis sapien.', '382', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (32, true, '2022-11-17 22:39:50', 'Nulla justo.', '543', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (33, false, '2021-12-09 12:52:20', 'Morbi vel lectus in quam fringilla rhoncus.', '666', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (34, true, '2022-02-22 04:43:47', 'Suspendisse potenti.', '780', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (35, false, '2022-03-24 07:02:38', 'Cras in purus eu magna vulputate luctus.', '206', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (36, true, '2022-11-23 07:47:58', 'Maecenas tincidunt lacus at velit.', '635', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (37, true, '2022-07-12 06:27:32', 'In est risus, auctor sed, tristique in, tempus sit amet, sem.', '10', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (38, true, '2022-01-29 06:11:49', 'Nulla tempus.', '331', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (39, true, '2022-04-19 03:04:16', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '232', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (40, false, '2022-05-28 19:32:33', 'Sed sagittis.', '29', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (41, true, '2022-07-06 21:46:03', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '257', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (42, false, '2022-07-19 05:22:59', 'Pellentesque eget nunc.', '632', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (43, false, '2022-01-05 17:13:57', 'Aliquam sit amet diam in magna bibendum imperdiet.', '87', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (44, false, '2022-11-11 15:41:13', 'In sagittis dui vel nisl.', '426', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (45, false, '2021-12-17 13:43:03', 'Integer ac neque.', '574', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (46, false, '2021-12-06 16:02:27', 'In hac habitasse platea dictumst.', '774', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (47, true, '2022-08-11 22:11:41', 'Sed ante.', '251', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (48, false, '2022-03-18 08:29:58', 'Vivamus vel nulla eget eros elementum pellentesque.', '64', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (49, false, '2022-01-20 23:56:58', 'Vestibulum sed magna at nunc commodo placerat.', '330', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (50, false, '2022-03-27 17:25:32', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '916', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (51, false, '2022-03-21 12:14:36', 'Aliquam sit amet diam in magna bibendum imperdiet.', '969', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (52, false, '2022-07-14 16:08:24', 'Nulla justo.', '224', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (53, true, '2022-03-08 14:37:43', 'Curabitur convallis.', '660', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (54, false, '2022-10-15 00:27:35', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', '870', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (55, false, '2022-07-15 13:54:21', 'Curabitur at ipsum ac tellus semper interdum.', '228', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (56, false, '2022-09-17 07:46:14', 'Vivamus in felis eu sapien cursus vestibulum.', '11', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (57, false, '2022-09-19 10:59:23', 'Suspendisse potenti.', '618', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (58, false, '2022-10-06 21:05:17', 'Suspendisse accumsan tortor quis turpis.', '869', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (59, false, '2022-09-13 00:20:33', 'Nulla tempus.', '566', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (60, false, '2022-07-02 15:55:29', 'Suspendisse ornare consequat lectus.', '591', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (61, false, '2022-03-29 07:06:19', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '727', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (62, false, '2022-05-21 11:42:57', 'Integer ac neque.', '73', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (63, false, '2022-08-05 13:16:31', 'Maecenas tincidunt lacus at velit.', '948', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (64, false, '2022-02-12 00:57:32', 'Donec dapibus.', '783', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (65, false, '2022-04-04 16:11:03', 'Integer ac leo.', '729', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (66, false, '2022-03-06 10:54:52', 'Curabitur gravida nisi at nibh.', '13', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (67, false, '2022-04-04 00:13:33', 'Integer tincidunt ante vel ipsum.', '719', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (68, true, '2022-11-24 12:28:23', 'Nunc purus.', '355', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (69, true, '2022-11-22 01:38:11', 'Integer a nibh.', '658', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (70, false, '2022-06-25 12:03:30', 'Sed ante.', '939', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (71, false, '2022-10-18 22:02:45', 'Mauris ullamcorper purus sit amet nulla.', '217', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (72, true, '2022-01-23 05:41:22', 'Aenean sit amet justo.', '470', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (73, true, '2022-05-31 17:50:00', 'Aliquam erat volutpat.', '588', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (74, false, '2021-12-07 00:28:56', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '929', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (75, false, '2022-07-31 00:52:28', 'Donec quis orci eget orci vehicula condimentum.', '554', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (76, false, '2022-08-29 13:11:05', 'Nullam varius.', '153', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (77, false, '2022-08-28 21:47:13', 'In hac habitasse platea dictumst.', '145', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (78, false, '2022-06-19 09:48:41', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '393', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (79, false, '2022-07-23 02:57:03', 'Phasellus id sapien in sapien iaculis congue.', '798', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (80, false, '2022-09-16 15:13:16', 'Nunc nisl.', '468', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (81, false, '2022-02-24 03:05:04', 'Curabitur at ipsum ac tellus semper interdum.', '542', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (82, false, '2022-05-29 13:00:55', 'Morbi quis tortor id nulla ultrices aliquet.', '296', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (83, true, '2022-09-26 00:11:29', 'Etiam faucibus cursus urna.', '258', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (84, true, '2022-06-18 17:43:21', 'Morbi porttitor lorem id ligula.', '940', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (85, false, '2022-01-11 16:03:00', 'Curabitur in libero ut massa volutpat convallis.', '918', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (86, false, '2022-04-06 01:51:43', 'Mauris sit amet eros.', '805', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (87, false, '2022-07-14 16:39:17', 'Nulla justo.', '253', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (88, false, '2022-01-04 18:37:27', 'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', '617', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (89, false, '2022-07-10 20:01:17', 'Morbi non quam nec dui luctus rutrum.', '289', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (90, true, '2022-03-11 22:52:17', 'Praesent lectus.', '233', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (91, false, '2022-04-23 16:46:34', 'Morbi a ipsum.', '349', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (92, true, '2022-10-25 18:54:14', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '511', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (93, false, '2022-10-07 12:15:14', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '57', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (94, false, '2022-01-15 15:39:42', 'Nulla facilisi.', '928', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (95, true, '2022-11-28 09:42:02', 'Sed vel enim sit amet nunc viverra dapibus.', '156', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (96, true, '2022-10-16 22:14:34', 'Nam nulla.', '575', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (97, false, '2022-05-15 07:24:26', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '799', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (98, true, '2022-07-06 18:31:28', 'Praesent blandit.', '985', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (99, false, '2022-04-27 00:23:32', 'Morbi non lectus.', '836', null);
insert into bid (bidID, submit, expirationDate, status, buyerID, trade_ID) values (100, false, '2022-03-07 14:06:44', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '63', null);


insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (1, 1, '$210.16', 'mastercard', 'Morbi vel lectus in quam fringilla rhoncus.', '347', '631', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (2, 2, '$354.79', 'jcb', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', '926', '645', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (3, 3, '$627.85', 'switch', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', '393', '922', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (4, 4, '$917.65', 'jcb', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '91', '567', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (5, 5, '$899.67', 'diners-club-carte-blanche', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', '539', '864', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (6, 6, '$269.02', 'jcb', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', '463', '303', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (7, 7, '$737.68', 'jcb', 'Donec ut mauris eget massa tempor convallis.', '744', '876', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (8, 8, '$277.10', 'jcb', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '588', '882', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (9, 9, '$940.43', 'jcb', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', '989', '68', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (10, 10, '$696.57', 'jcb', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', '788', '101', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (11, 11, '$179.16', 'jcb', 'Suspendisse ornare consequat lectus.', '884', '887', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (12, 12, '$869.85', 'jcb', 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', '917', '565', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (13, 13, '$573.41', 'visa-electron', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', '46', '782', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (14, 14, '$735.52', 'jcb', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '391', '992', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (15, 15, '$826.21', 'visa-electron', 'Sed vel enim sit amet nunc viverra dapibus.', '217', '857', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (16, 16, '$984.22', 'visa-electron', 'Donec posuere metus vitae ipsum.', '202', '590', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (17, 17, '$990.16', 'bankcard', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '341', '817', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (18, 18, '$969.04', 'jcb', 'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', '713', '272', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (19, 19, '$629.04', 'jcb', 'Integer a nibh.', '900', '264', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (20, 20, '$678.13', 'jcb', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', '531', '97', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (21, 21, '$165.30', 'mastercard', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '680', '43', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (22, 22, '$328.34', 'diners-club-enroute', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', '303', '271', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (23, 23, '$872.99', 'solo', 'Maecenas ut massa quis augue luctus tincidunt.', '534', '720', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (24, 24, '$130.81', 'mastercard', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '865', '16', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (25, 25, '$272.50', 'china-unionpay', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '976', '357', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (26, 26, '$618.99', 'maestro', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '499', '965', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (27, 27, '$66.49', 'switch', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', '929', '31', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (28, 28, '$532.60', 'jcb', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', '486', '746', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (29, 29, '$474.59', 'china-unionpay', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '182', '282', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (30, 30, '$971.98', 'diners-club-enroute', 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.', '12', '342', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (31, 31, '$40.73', 'mastercard', 'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '516', '670', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (32, 32, '$138.10', 'jcb', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '180', '545', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (33, 33, '$802.75', 'jcb', 'Pellentesque ultrices mattis odio. Donec vitae nisi.', '837', '212', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (34, 34, '$486.30', 'jcb', 'In sagittis dui vel nisl.', '999', '838', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (35, 35, '$657.79', 'china-unionpay', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', '946', '371', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (36, 36, '$505.22', 'solo', 'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.', '704', '532', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (37, 37, '$988.15', 'jcb', 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '307', '496', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (38, 38, '$340.62', 'maestro', 'Sed vel enim sit amet nunc viverra dapibus.', '200', '439', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (39, 39, '$712.06', 'jcb', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.', '205', '175', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (40, 40, '$607.07', 'jcb', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', '412', '434', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (41, 41, '$457.85', 'diners-club-carte-blanche', 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', '122', '569', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (42, 42, '$260.58', 'jcb', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '911', '482', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (43, 43, '$924.63', 'diners-club-us-ca', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '750', '166', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (44, 44, '$985.28', 'jcb', 'Aliquam sit amet diam in magna bibendum imperdiet.', '932', '311', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (45, 45, '$643.24', 'jcb', 'Integer ac leo. Pellentesque ultrices mattis odio.', '490', '750', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (46, 46, '$219.39', 'china-unionpay', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.', '224', '265', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (47, 47, '$175.27', 'jcb', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '295', '835', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (48, 48, '$753.41', 'jcb', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '136', '104', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (49, 49, '$505.18', 'jcb', 'Morbi non lectus.', '784', '242', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (50, 50, '$133.23', 'switch', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '591', '259', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (51, 51, '$675.79', 'jcb', 'Pellentesque viverra pede ac diam.', '528', '89', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (52, 52, '$706.49', 'jcb', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '444', '911', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (53, 53, '$553.38', 'jcb', 'Sed ante. Vivamus tortor.', '354', '355', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (54, 54, '$703.55', 'jcb', 'Proin at turpis a pede posuere nonummy. Integer non velit.', '495', '129', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (55, 55, '$287.29', 'diners-club-carte-blanche', 'Integer ac leo.', '314', '130', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (56, 56, '$935.37', 'laser', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', '306', '189', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (57, 57, '$680.75', 'visa-electron', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.', '429', '863', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (58, 58, '$89.48', 'diners-club-carte-blanche', 'Mauris ullamcorper purus sit amet nulla.', '763', '616', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (59, 59, '$764.87', 'mastercard', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.', '980', '891', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (60, 60, '$583.42', 'diners-club-enroute', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '273', '815', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (61, 61, '$133.74', 'jcb', 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.', '852', '529', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (62, 62, '$902.46', 'visa-electron', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '927', '323', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (63, 63, '$827.74', 'jcb', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '219', '566', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (64, 64, '$580.63', 'bankcard', 'Donec quis orci eget orci vehicula condimentum.', '331', '744', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (65, 65, '$182.19', 'solo', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', '279', '451', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (66, 66, '$471.20', 'jcb', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', '414', '274', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (67, 67, '$257.43', 'china-unionpay', 'Vivamus vestibulum sagittis sapien.', '899', '209', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (68, 68, '$56.42', 'maestro', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '505', '674', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (69, 69, '$877.73', 'jcb', 'Duis at velit eu est congue elementum.', '537', '615', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (70, 70, '$296.37', 'laser', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '587', '990', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (71, 71, '$844.78', 'jcb', 'Nullam varius. Nulla facilisi.', '863', '712', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (72, 72, '$592.48', 'americanexpress', 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', '52', '866', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (73, 73, '$336.46', 'visa-electron', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', '403', '644', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (74, 74, '$573.04', 'jcb', 'Maecenas pulvinar lobortis est.', '152', '890', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (75, 75, '$113.05', 'china-unionpay', 'Mauris ullamcorper purus sit amet nulla.', '37', '168', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (76, 76, '$771.51', 'switch', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '698', '12', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (77, 77, '$88.42', 'switch', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.', '73', '983', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (78, 78, '$354.16', 'maestro', 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '541', '844', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (79, 79, '$650.90', 'solo', 'Nulla mollis molestie lorem. Quisque ut erat.', '615', '603', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (80, 80, '$366.85', 'jcb', 'In congue. Etiam justo. Etiam pretium iaculis justo.', '940', '834', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (81, 81, '$791.21', 'jcb', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '13', '516', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (82, 82, '$252.04', 'jcb', 'Praesent blandit.', '321', '862', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (83, 83, '$746.71', 'jcb', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque.', '40', '521', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (84, 84, '$859.63', 'jcb', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '749', '494', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (85, 85, '$789.51', 'jcb', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '441', '629', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (86, 86, '$673.09', 'switch', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '238', '547', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (87, 87, '$599.57', 'switch', 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', '739', '962', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (88, 88, '$946.82', 'china-unionpay', 'Pellentesque ultrices mattis odio. Donec vitae nisi.', '252', '622', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (89, 89, '$817.57', 'bankcard', 'In blandit ultrices enim.', '609', '76', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (90, 90, '$780.28', 'visa-electron', 'Etiam faucibus cursus urna.', '544', '602', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (91, 91, '$591.17', 'jcb', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '270', '500', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (92, 92, '$479.00', 'mastercard', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '209', '986', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (93, 93, '$301.07', 'jcb', 'Phasellus in felis. Donec semper sapien a libero.', '31', '893', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (94, 94, '$58.69', 'jcb', 'Duis consequat dui nec nisi volutpat eleifend.', '61', '792', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (95, 95, '$869.97', 'diners-club-enroute', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '519', '18', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (96, 96, '$133.42', 'jcb', 'Phasellus id sapien in sapien iaculis congue.', '610', '913', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (97, 97, '$94.79', 'mastercard', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.', '227', '667', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (98, 98, '$564.50', 'jcb', 'Fusce consequat.', '674', '429', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (99, 99, '$803.78', 'jcb', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', '695', '289', null);
insert into payment (paymentNum, bankaccount_ID, amount, types, admin_message, sellerID, buyerID, bidID) values (100, 100, '$338.91', 'laser', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '712', '520', null);


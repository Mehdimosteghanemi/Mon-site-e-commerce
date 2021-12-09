-- Adminer 4.8.1 MySQL 8.0.27-0ubuntu0.20.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D4E6F81A76ED395` (`user_id`),
  CONSTRAINT `FK_D4E6F81A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `address` (`id`, `user_id`, `name`, `firstname`, `lastname`, `company`, `address`, `postal`, `city`, `country`, `phone`) VALUES
(4,	12,	'Home',	'Audrey',	'Thev',	NULL,	'2 rue du BS',	'59200',	'Tourtour',	'FR',	'0611223344'),
(5,	12,	'Travail',	'audrey',	'Thec',	'Amazon',	'23 rue des arres',	'59000',	'Lille',	'FR',	'0611223344'),
(6,	23,	'Maison',	'John',	'Doe',	NULL,	'15 rue des ponts',	'59200',	'Lille',	'FR',	'0601020304'),
(7,	25,	'home',	'test',	'test',	NULL,	'8 avenue du mur',	'59200',	'tourcoing',	'FR',	'06.01.02.03.04');

DROP TABLE IF EXISTS `carrier`;
CREATE TABLE `carrier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `carrier` (`id`, `name`, `description`, `price`) VALUES
(1,	'Colissimo',	'profitez d\'une livraison premium avec un colis chez dans les prochaines 72h.',	990),
(2,	'Chronopost',	'Livraison rapide et soignée avant 13h le lendemain',	1490);

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `category` (`id`, `name`) VALUES
(1,	'Manteaux'),
(2,	'Bonnets'),
(3,	'T-shirts'),
(4,	'Echarpes');

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20211103091751',	'2021-11-03 10:20:00',	23),
('DoctrineMigrations\\Version20211103094633',	'2021-11-03 10:46:54',	16),
('DoctrineMigrations\\Version20211110105250',	'2021-11-10 11:53:33',	44),
('DoctrineMigrations\\Version20211110111525',	'2021-11-10 12:15:35',	39),
('DoctrineMigrations\\Version20211115204244',	'2021-11-15 21:42:56',	101),
('DoctrineMigrations\\Version20211125121406',	'2021-11-25 13:14:19',	20),
('DoctrineMigrations\\Version20211125123013',	'2021-11-25 13:30:19',	69),
('DoctrineMigrations\\Version20211125140225',	'2021-11-25 15:02:37',	16),
('DoctrineMigrations\\Version20211129131218',	'2021-11-29 14:12:30',	57),
('DoctrineMigrations\\Version20211129143730',	'2021-11-29 15:37:36',	17),
('DoctrineMigrations\\Version20211205160859',	'2021-12-05 17:09:08',	34),
('DoctrineMigrations\\Version20211205184519',	'2021-12-05 19:45:25',	24),
('DoctrineMigrations\\Version20211205190226',	'2021-12-05 20:02:31',	18),
('DoctrineMigrations\\Version20211206082900',	'2021-12-06 09:29:10',	52),
('DoctrineMigrations\\Version20211206092907',	'2021-12-06 10:29:24',	121),
('DoctrineMigrations\\Version20211208103445',	'2021-12-08 11:34:52',	77),
('DoctrineMigrations\\Version20211208130024',	'2021-12-08 14:00:33',	112),
('DoctrineMigrations\\Version20211208140221',	'2021-12-08 15:02:28',	65);

DROP TABLE IF EXISTS `header`;
CREATE TABLE `header` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `btn_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `illustration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `btn_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `carrier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `carrier_price` double NOT NULL,
  `delivery` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5299398A76ED395` (`user_id`),
  CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `order` (`id`, `user_id`, `created_at`, `carrier_name`, `carrier_price`, `delivery`, `reference`, `stripe_session_id`, `state`) VALUES
(1,	12,	'2021-11-25 15:30:29',	'Chronopost',	14.9,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'',	NULL,	0),
(2,	12,	'2021-11-29 14:21:21',	'Colissimo',	9.9,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'29112021-61a4d3d1c29cf',	NULL,	0),
(3,	12,	'2021-11-29 14:22:12',	'Colissimo',	9.9,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'29112021-61a4d404aa297',	NULL,	0),
(4,	12,	'2021-11-29 14:45:24',	'Colissimo',	9.9,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'29112021-61a4d9742f856',	NULL,	0),
(5,	12,	'2021-11-29 14:46:29',	'Colissimo',	9.9,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'29112021-61a4d9b5c4d1c',	NULL,	0),
(6,	12,	'2021-11-29 14:46:33',	'Colissimo',	9.9,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'29112021-61a4d9b9461a0',	NULL,	0),
(7,	12,	'2021-11-29 14:46:44',	'Colissimo',	9.9,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'29112021-61a4d9c407fdd',	NULL,	0),
(8,	12,	'2021-11-29 14:46:57',	'Colissimo',	9.9,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'29112021-61a4d9d113e9b',	NULL,	0),
(9,	12,	'2021-11-29 15:16:46',	'Colissimo',	9.9,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'29112021-61a4e0ce0df7d',	NULL,	0),
(10,	12,	'2021-11-29 15:31:39',	'Chronopost',	14.9,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4e44b7fdf1',	NULL,	0),
(11,	12,	'2021-11-29 15:39:17',	'Chronopost',	14.9,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4e6155d9c8',	NULL,	0),
(12,	12,	'2021-11-29 15:45:29',	'Chronopost',	14.9,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4e78971042',	'cs_test_b1J2slB2XfPx0VLx8WecHm5i4F5j3vitscsOXiqn3SafFgGU0WRCsKnmS4',	0),
(13,	12,	'2021-11-29 16:09:32',	'Colissimo',	9.9,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4ed2c0baa5',	'cs_test_b1pGwVOH5yJMsTfh8ZGLLH9PO8Kkc0MsLBWelUNHQuGEAR687swXyueYHc',	0),
(14,	12,	'2021-11-29 16:10:13',	'Colissimo',	9.9,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4ed557c937',	'cs_test_b11Uzht1zPrSaZmsWGRi3wCIzinZxhFYDDZZYS0Cj19rWQ8Iv5oOkR1R8K',	0),
(15,	12,	'2021-11-29 16:23:49',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4f085a74e5',	NULL,	0),
(16,	12,	'2021-11-29 16:24:21',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4f0a51f531',	NULL,	0),
(17,	12,	'2021-11-29 16:24:38',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4f0b6a8955',	NULL,	0),
(18,	12,	'2021-11-29 16:25:00',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4f0ccc20f2',	NULL,	0),
(19,	12,	'2021-11-29 16:25:21',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4f0e1e782b',	NULL,	0),
(20,	12,	'2021-11-29 16:25:29',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'29112021-61a4f0e91e581',	'cs_test_b1GPiyA3BeRUwWs4TOuQJXS9MLugAyZs2pQpeXHM88VQXUx47dVwsh4wqJ',	0),
(21,	12,	'2021-11-30 13:51:36',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'30112021-61a61e5836fa2',	'cs_test_b1dyeUqUtMfIOQA3s8j1KQyUUeo9QFEI1PYohl3ERNKpRJH9djIvge236E',	0),
(22,	12,	'2021-11-30 13:51:46',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'30112021-61a61e62eead6',	'cs_test_b1GZnmmhnH8IAFUU1BtRi2l89vlYqpbfJO7bpgJ5hIAykMmQ4NlZxoHBO5',	0),
(23,	12,	'2021-11-30 14:07:18',	'Chronopost',	1490,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'30112021-61a62206cee1b',	NULL,	0),
(24,	12,	'2021-12-02 12:36:10',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'02122021-61a8afaaae197',	'cs_test_b1zIOx4giiYIOvrvir0IDeedzcSt8G6qTB9e2wjYEIQdsTdWbmiOBahzX9',	0),
(25,	23,	'2021-12-02 23:26:22',	'Colissimo',	990,	'John Doe<br/>15 rue des ponts<br/>59200 Lille<br/>FR',	'02122021-61a9480e2a640',	'cs_test_b1rWbSTwuUl3DEPewj1gsYen8C9iMI8qcjoMDiWcxGWthzh24N8aSjcfyF',	0),
(26,	12,	'2021-12-05 17:13:43',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'05122021-61ace5375f689',	'cs_test_b1aMvKchbqOwMyvinzkYs2sMaoqBJ14K4AaSlHRsSqgIPlykcFhh5RlVrx',	0),
(27,	12,	'2021-12-05 17:16:18',	'Chronopost',	1490,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'05122021-61ace5d25e4de',	'cs_test_b1un5j6nR6lQDEPOfMJ4aeAxDFwSU8Qg7jV60bE32SEU6n0UkMjUuMlwmS',	0),
(28,	12,	'2021-12-05 17:40:01',	'Colissimo',	990,	'audrey Thec<br/>Amazon<br/>23 rue des arres<br/>59000 Lille<br/>FR',	'05122021-61aceb61a17ba',	'cs_test_b1awd5qgtAaZB4YHmjnCpYFraPo4WzeM5yCWzYGKTGloSEVLyelCZ9n1kj',	0),
(29,	12,	'2021-12-09 15:27:13',	'Colissimo',	990,	'Audrey Thev<br/>2 rue du BS<br/>59200 Tourtour<br/>FR',	'09122021-61b2124192512',	'cs_test_b1Z37IVsn7fUd2TrjYYvu5WTwqBapfsN3I7JOMB6V8kaZ2AWQyGaaSLPah',	1),
(30,	25,	'2021-12-09 15:30:41',	'Colissimo',	990,	'test test<br/>8 avenue du mur<br/>59200 tourcoing<br/>FR',	'09122021-61b21311504ab',	'cs_test_b1TyofeyPXFLxTok9WFl7cD6iGSbjnaewmngtwnUk4SOJLE3oFp1DTgoaf',	1);

DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `my_order_id` int NOT NULL,
  `product` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_845CA2C1BFCDF877` (`my_order_id`),
  CONSTRAINT `FK_845CA2C1BFCDF877` FOREIGN KEY (`my_order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `order_details` (`id`, `my_order_id`, `product`, `quantity`, `price`, `total`) VALUES
(1,	1,	'bonnet rouge',	1,	990,	990),
(2,	1,	'Bonnet du skieur',	1,	1490,	1490),
(3,	1,	'Echarpe rouge',	1,	1990,	1990),
(4,	2,	'bonnet rouge',	1,	990,	990),
(5,	2,	'Bonnet du skieur',	1,	1490,	1490),
(6,	3,	'bonnet rouge',	1,	990,	990),
(7,	3,	'Bonnet du skieur',	1,	1490,	1490),
(8,	4,	'bonnet rouge',	1,	990,	990),
(9,	4,	'Bonnet du skieur',	1,	1490,	1490),
(10,	5,	'bonnet rouge',	1,	990,	990),
(11,	5,	'Bonnet du skieur',	1,	1490,	1490),
(12,	6,	'bonnet rouge',	1,	990,	990),
(13,	6,	'Bonnet du skieur',	1,	1490,	1490),
(14,	7,	'bonnet rouge',	1,	990,	990),
(15,	7,	'Bonnet du skieur',	1,	1490,	1490),
(16,	8,	'bonnet rouge',	1,	990,	990),
(17,	8,	'Bonnet du skieur',	1,	1490,	1490),
(18,	9,	'bonnet rouge',	1,	990,	990),
(19,	9,	'Bonnet du skieur',	1,	1490,	1490),
(20,	10,	'bonnet rouge',	1,	990,	990),
(21,	10,	'Bonnet du skieur',	1,	1490,	1490),
(22,	11,	'bonnet rouge',	1,	990,	990),
(23,	11,	'Bonnet du skieur',	1,	1490,	1490),
(24,	12,	'bonnet rouge',	1,	990,	990),
(25,	12,	'Bonnet du skieur',	1,	1490,	1490),
(26,	13,	'bonnet rouge',	1,	990,	990),
(27,	13,	'Bonnet du skieur',	1,	1490,	1490),
(28,	14,	'bonnet rouge',	1,	990,	990),
(29,	14,	'Bonnet du skieur',	1,	1490,	1490),
(30,	15,	'bonnet rouge',	1,	990,	990),
(31,	15,	'Bonnet du skieur',	1,	1490,	1490),
(32,	16,	'bonnet rouge',	1,	990,	990),
(33,	16,	'Bonnet du skieur',	1,	1490,	1490),
(34,	17,	'bonnet rouge',	1,	990,	990),
(35,	17,	'Bonnet du skieur',	1,	1490,	1490),
(36,	18,	'bonnet rouge',	1,	990,	990),
(37,	18,	'Bonnet du skieur',	1,	1490,	1490),
(38,	19,	'bonnet rouge',	1,	990,	990),
(39,	19,	'Bonnet du skieur',	1,	1490,	1490),
(40,	20,	'bonnet rouge',	1,	990,	990),
(41,	20,	'Bonnet du skieur',	1,	1490,	1490),
(42,	21,	'bonnet rouge',	1,	990,	990),
(43,	21,	'Bonnet du skieur',	1,	1490,	1490),
(44,	21,	'Meanteau enfant doublé',	1,	5990,	5990),
(45,	22,	'bonnet rouge',	1,	990,	990),
(46,	22,	'Bonnet du skieur',	1,	1490,	1490),
(47,	22,	'Meanteau enfant doublé',	1,	5990,	5990),
(48,	23,	'bonnet rouge',	1,	990,	990),
(49,	23,	'Echarpe rouge',	1,	1990,	1990),
(50,	24,	'Tee-shirt blanc',	1,	1290,	1290),
(51,	24,	'Manteau long femme ceintré',	1,	17900,	17900),
(52,	25,	'bonnet rouge',	1,	990,	990),
(53,	26,	'bonnet rouge',	1,	990,	990),
(54,	27,	'bonnet rouge',	1,	990,	990),
(55,	27,	'Echarpe rouge',	1,	1990,	1990),
(56,	27,	'Echarpe marron et beige',	1,	6490,	6490),
(57,	28,	'bonnet rouge',	1,	990,	990),
(58,	28,	'Echarpe rouge',	1,	1990,	1990),
(59,	28,	'Echarpe marron et beige',	1,	6490,	6490),
(60,	28,	'Manteau long femme ceintré',	1,	17900,	17900),
(61,	29,	'Bonnet rouge',	2,	990,	1980),
(62,	29,	'Bonnet du skieur',	1,	1490,	1490),
(63,	29,	'Echarpe rouge',	2,	1990,	3980),
(64,	30,	'Bonnet rouge',	1,	990,	990),
(65,	30,	'Bonnet du skieur',	1,	1490,	1490),
(66,	30,	'Echarpe rouge',	1,	1990,	1990);

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `illustration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `is_best` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD12469DE2` (`category_id`),
  CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `product` (`id`, `category_id`, `name`, `slug`, `illustration`, `subtitle`, `description`, `price`, `is_best`) VALUES
(8,	2,	'Bonnet rouge',	'bonnet-rouge',	'6bf5778cb78b9e635d33c4576a2b83483e1d7696.jpg',	'Le bonnet parfait pour l\'hiver',	'Bonnet à pompons rouge.\r\n\r\nDétails produit\r\n• Etiquette déchirable\r\n• Laine côtelée solide\r\n• Pompon en fausse fourrure amovible pour faciliter l\'entretien.\r\n\r\nComposition\r\n• 100% acrylique.',	990,	1),
(9,	2,	'Bonnet du skieur',	'bonnet-du-skieur',	'722c48eac2771fb10755347847a5c30ce48f5a57.jpg',	'Le bonnet parfait pour skier',	'Très joli bonnet à pompon en fausse fourrure.\r\n\r\nIl est tricoté en torsades avec une finition côtelée sur le bord du bonnet.\r\n\r\nPour être encore plus au chaud cet hiver, accordez-le avec l\'écharpe bleu beige, elle aussi tricotée en 100% laine mérinos.',	1490,	0),
(10,	4,	'Echarpe rouge',	'echarpe-rouge',	'30571aeb5a61a2ac7eee43de804ab14090440d58.jpg',	'Écharpe en tissu souple rouge',	'Elle pèse environ 190g\r\n\r\nComposition Acrylique 100%',	1990,	1),
(11,	4,	'Echarpe marron et beige',	'echarpe-marron-et-beige',	'3780cd1ded79a6163cbae9f0fc6090cd401d7d2b.jpg',	'Echarpe laine vierge marron et beige',	'Une laine super fine et un long processus de production confèrent à notre écharpe un toucher et une douceur incomparable proche du cachemire.',	6490,	0),
(12,	1,	'Manteau long femme ceintré',	'manteau-long-femme-ceintre',	'ddb6b6989ebd91a8808a426b9a6eace5f3e888f3.jpg',	'Manteau long ceintré avec ceinture',	'Polyester,laine\r\nLavage à la main seulement\r\nType de col: Col V\r\nTaille normale\r\nManche longue',	17900,	1),
(13,	1,	'Meanteau enfant doublé',	'meanteau-enfant-double',	'e5a0b2ad6b8f267720ff6fca7278839eeb4c122a.jpg',	'Manteau enfant mixte doublé',	'Manteau enfant mixte doublé avec une doudoune détachable.',	5990,	1),
(14,	3,	'Tee-shirt blanc',	'tee-shirt-blanc',	'47c9f20bebf96450297d73d84020b2e99c825275.jpg',	'T-shirt blanc manches courtes',	'T-shirt manches courtes blanc, col rond.\r\n\r\n100% coton.',	1290,	0),
(15,	3,	'Tee-shirt noir',	'tee-shirt-noir',	'7ed4c125f15ed0d99ba7f3f2b028a8d1b758a56b.jpg',	'T-shirt noir manches longues',	'T-shirt noir manches longues, col rond.\r\n\r\n100% coton.',	1490,	0);

DROP TABLE IF EXISTS `reset_password`;
CREATE TABLE `reset_password` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_B9983CE5A76ED395` (`user_id`),
  CONSTRAINT `FK_B9983CE5A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `reset_password` (`id`, `user_id`, `token`, `created_at`) VALUES
(1,	23,	'61b0ac7a32441',	'2021-12-08 14:00:42'),
(2,	23,	'61b0ac7cc3309',	'2021-12-08 14:00:44'),
(3,	23,	'61b0af6367f34',	'2021-12-08 14:13:07'),
(4,	23,	'61b0b0bcc97a6',	'2021-12-08 14:18:52'),
(5,	23,	'61b0b148549e8',	'2021-12-08 14:21:12'),
(6,	23,	'61b0b1539dc1a',	'2021-12-08 14:21:23'),
(7,	23,	'61b0b15f8d331',	'2021-12-08 14:21:35'),
(8,	23,	'61b0b169864fd',	'2021-12-08 14:21:45'),
(9,	23,	'61b0b17823d63',	'2021-12-08 14:22:00'),
(10,	23,	'61b0b1bc75b90',	'2021-12-08 14:23:08'),
(11,	23,	'61b0b1cc57f2a',	'2021-12-08 14:23:24'),
(12,	23,	'61b0b20a88709',	'2021-12-08 14:24:26'),
(13,	23,	'61b0b24d3b55c',	'2021-12-08 14:25:33'),
(14,	23,	'61b0b41c7258b',	'2021-12-08 14:33:16'),
(15,	23,	'61b0b7c840ed1',	'2021-12-08 14:48:56');

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`) VALUES
(12,	'aud@gmail.com',	'[\"ROLE_ADMIN\"]',	'$2y$13$DqT2DXCVcaZyqXEN5uBoeO7zBvwJlEywJ4TUt4EywjybqzC/AKzsC',	'aud',	'Thev'),
(23,	'maboutique@yopmail.com',	'[]',	'$2y$13$YBM31XOqcPzYj4iF1veCOemxz4TI1rpCJAnpzy/7T1UxtHyfkGwZe',	'John',	'Doe'),
(25,	'mapetiteboutique@yopmail.com',	'[]',	'$2y$13$p5OlKidOA6F7duxHcRmeYuwIVWZbgIs/AV5exMOyHILhmwO6WmIWy',	'test',	'test');
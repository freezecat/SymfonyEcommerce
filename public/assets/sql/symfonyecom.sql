-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 17 mars 2022 à 17:19
-- Version du serveur :  5.7.26
-- Version de PHP :  7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `symfonyecom`
--

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `name`, `description`) VALUES
(121, 'Chaise', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n     Aliquam fringilla semper ligula vestibulum mattis.\n     Ut in aliquam sapien, in fermentum turpis. Morbi vel mollis est.\n      Nulla nec consequat nisi. Pellentesque auctor posuere enim in egestas. \n      Donec suscipit augue eget pulvinar convallis.'),
(122, 'Bureau', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n     Aliquam fringilla semper ligula vestibulum mattis.\n     Ut in aliquam sapien, in fermentum turpis. Morbi vel mollis est.\n      Nulla nec consequat nisi. Pellentesque auctor posuere enim in egestas. \n      Donec suscipit augue eget pulvinar convallis.'),
(123, 'Lit', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n     Aliquam fringilla semper ligula vestibulum mattis.\n     Ut in aliquam sapien, in fermentum turpis. Morbi vel mollis est.\n      Nulla nec consequat nisi. Pellentesque auctor posuere enim in egestas. \n      Donec suscipit augue eget pulvinar convallis.'),
(124, 'Canape', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n     Aliquam fringilla semper ligula vestibulum mattis.\n     Ut in aliquam sapien, in fermentum turpis. Morbi vel mollis est.\n      Nulla nec consequat nisi. Pellentesque auctor posuere enim in egestas. \n      Donec suscipit augue eget pulvinar convallis.'),
(125, 'Armoire', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n     Aliquam fringilla semper ligula vestibulum mattis.\n     Ut in aliquam sapien, in fermentum turpis. Morbi vel mollis est.\n      Nulla nec consequat nisi. Pellentesque auctor posuere enim in egestas. \n      Donec suscipit augue eget pulvinar convallis.'),
(126, 'Autre', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n     Aliquam fringilla semper ligula vestibulum mattis.\n     Ut in aliquam sapien, in fermentum turpis. Morbi vel mollis est.\n      Nulla nec consequat nisi. Pellentesque auctor posuere enim in egestas. \n      Donec suscipit augue eget pulvinar convallis.');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20220317084509', '2022-03-17 08:45:33', 3316),
('DoctrineMigrations\\Version20220317085013', '2022-03-17 08:50:28', 838),
('DoctrineMigrations\\Version20220317085404', '2022-03-17 08:54:24', 1624);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5299398A76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `order`
--

INSERT INTO `order` (`id`, `status`, `creation_date`, `user_id`) VALUES
(1, 'validee', '2022-03-14 14:32:03', NULL),
(2, 'validee', '2022-03-14 14:41:36', NULL),
(3, 'validee', '2022-03-15 09:32:58', NULL),
(4, 'validee', '2022-03-15 09:49:11', NULL),
(5, 'validee', '2022-03-15 09:54:56', NULL),
(10, 'validee', '2022-03-15 11:25:35', NULL),
(11, 'validee', '2022-03-15 11:31:22', NULL),
(25, 'validee', '2022-03-15 14:51:24', NULL),
(29, 'validee', '2022-03-17 10:54:27', NULL),
(33, 'validee', '2022-03-17 11:49:00', NULL),
(35, 'validee', '2022-03-17 11:52:19', NULL),
(36, 'validee', '2022-03-17 15:20:59', 4),
(40, 'validee', '2022-03-17 15:57:10', 4),
(43, 'validee', '2022-03-17 15:58:44', 3);

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `stock` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD12469DE2` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=380 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `stock`) VALUES
(295, 126, 'Table Maecenas', 'Ceci est une Table, aenean gravida ante a placerat rhoncus. Mauris odio magna, aliquet id massa ut, convallis porttitor enim. Aenean sit amet leo eu nibh dictum scelerisque sit amet sed elit. Aliquam in hendrerit urna. Donec mollis commodo massa vel congue. Fusce ullamcorper nec diam non elementum. Nulla risus nulla, scelerisque sit amet est vel, sollicitudin suscipit erat. ', 150, 20),
(296, 121, 'Chaise Mauris', 'Ceci est une Chaise, aliquam rhoncus lacus eget mattis. Cras sed porttitor mauris. Curabitur sit amet laoreet nisi, molestie interdum mi. Cras ullamcorper quam eu magna volutpat, eu consectetur lacus tincidunt. Cras vitae felis pretium mi blandit pellentesque vel quis sem. Sed scelerisque mi mauris, quis vehicula augue commodo non. Donec dui justo, convallis nec lacus congue, pretium faucibus mauris', 20, 146),
(298, 122, 'Bureau Vestibulum', 'Ceci est un Bureau, consequat rutrum aliquam. Morbi fringilla fringilla euismod. Nullam blandit tincidunt nulla, at porttitor dolor interdum nec.', 200, 0),
(299, 123, 'Lit Nulla', 'Ceci est un Lit, vitae felis pretium mi blandit pellentesque vel quis sem. Sed scelerisque mi mauris, quis vehicula augue commodo non. Donec dui justo, convallis nec lacus congue, pretium faucibus mauris. Ut risus arcu, mattis non magna at, tincidunt egestas eros. Pellentesque sollicitudin, neque id euismod maximus, odio libero iaculis ligula, sed fringilla nulla nulla et magna. Quisque luctus ante orci. ', 400, 87),
(300, 126, 'Table Craseget', 'Ceci est une Table, vehicula feugiat leo. Aliquam nunc enim, feugiat at dolor et, hendrerit pharetra diam. Vivamus nec consectetur nunc. Donec dapibus turpis a laoreet ullamcorper. Donec eleifend arcu non sapien vehicula scelerisque nec at risus. Morbi non augue semper, luctus turpis vitae, tristique nunc.', 150, 234),
(301, 121, 'Chaise Suspendisse', 'Ceci est une Chaise,  pellentesque odio et velit luctus, vitae gravida sem sollicitudin. Proin ipsum dui, luctus at auctor at, rhoncus non elit. In nec nisl id odio pulvinar viverra at et mi. Integer ac suscipit ante, vitae ultrices dolor. Cras consequat rutrum aliquam. Morbi fringilla fringilla euismod.', 20, 31),
(302, 125, 'Armoire Pellentesque', 'Ceci est une Armoire, ac velit eu quam imperdiet laoreet nec vel mi. Donec commodo orci eu nisi tincidunt facilisis nec quis sapien. Fusce lobortis turpis nec sem vulputate, interdum gravida magna porttitor. Sed lacus elit, feugiat et fermentum ac, pellentesque eget neque.', 500, 280),
(303, 122, 'Bureau Donec', 'Ceci est un Bureau, in hendrerit urna. Donec mollis commodo massa vel congue. Fusce ullamcorper nec diam non elementum. Nulla risus nulla, scelerisque sit amet est vel, sollicitudin suscipit erat. ', 200, 97),
(304, 123, 'Lit', 'Ceci est un Lit, pellentesque odio et velit luctus, vitae gravida sem sollicitudin. Proin ipsum dui, luctus at auctor at, rhoncus non elit. In nec nisl id odio pulvinar viverra at et mi. Integer ac suscipit ante, vitae ultrices dolor. Cras consequat rutrum aliquam. Morbi fringilla fringilla euismod. Nullam blandit tincidunt nulla, at porttitor dolor interdum nec. Donec dapibus, tortor at rhoncus vehicula, lorem ante ultricies mauris, auctor scelerisque ligula dui quis nisi. Quisque posuere eros sed sodales malesuada. ', 400, 16),
(305, 123, 'Lit adulte 140x190 cm', 'Créez une ambiance moderne et chaleureuse dans votre chambre grâce au lit adulte TEMPO 1 de coloris chêne nature de dimension 140x190cm. Ses lignes droites à l’esprit intemporel en feront une pièce de choix. Sa tête de lit impose un réel confort pour un sommeil de qualité. De plus, son épaisseur et la qualité de sa finition en font une pièce robuste et pérenne. De finition papier décor, il est fabriqué en France. Il existe aussi en coloris chêne relief, chêne argile, noyer brun et blanc brillant.', 119.99, 195),
(306, 123, 'Lit 140x190 cm', 'Alliez confort, design et praticité avec le lit WILLIAM de 140x190 cm et ses multiples rangements. Son cadre à lattes inclus apporte un soutien qui promet des nuits confortables. Surtout, il réunit en un espace minimum de multiples rangements. Ses deux chevets intégrés munis de deux tiroirs coulissent pour venir se loger dans la structure du lit de chaque côté. D’autres espaces de rangement dont deux tiroirs de bonne hauteur de part et d’autre du lit sont disponibles. Ils permettent de loger sans mal une couette ou des oreillers supplémentaires. ', 339.8, 245),
(307, 123, 'Lit adulte 140x190 cm', ' Créez une ambiance moderne et chaleureuse dans votre chambre grâce au lit adulte TEMPO 2 de coloris chêne argile de dimension 140x190cm. Ses lignes droites à l’esprit intemporel en feront une pièce de choix. Sa tête de lit impose un réel confort pour un sommeil de qualité. De plus, son épaisseur et la qualité de sa finition en font une pièce robuste et pérenne. De finition papier décor, il est fabriqué en France. Il existe aussi en coloris chêne nature, noyer brun, chêne relief et blanc brillant. ', 119.99, 277),
(308, 122, 'Bureau 4 tiroirs', 'Pratique : 4 tiroirs et 1 niche de rangement; Permet de travailler en toute sécurité avec tiroir à serrure; Existe aussi en d\'autres coloris;', 99.99, 117),
(309, 122, 'Bureau 1 tiroir', 'Le bureau ALPIN blanc donnera le ton à un intérieur contemporain épuré. De finition papier décor, son plateau mesure 100,8cm de long. Idéal pour y abriter vos documents, il possède un tiroir. Robuste et stable, il est fabriqué en France.', 39.99, 155),
(310, 122, 'Bureau 123 cm', 'Compact et fonctionnel, ce bureau a été conçu pour ceux qui aiment voir chaque chose à sa place! Grâce à sa partie supérieure dotée de niches et d\'étagères et son caisson pourvu d\'un tiroir et d\'un rangement à porte battante, il vous permettra de ranger bien distinctement tout votre matériel. Malin, son sur-meuble est paré de trois élastiques pour retenir vos mémos ou vos courriers en cours de traitement! A la pointe de la technologie, il est muni d\'un port USB et d\'un passe-câbles hyper-pratique. Son revêtement à l\'aspect chêne et blanc apportera de la clarté à votre espace de travail.', 161, 140),
(311, 121, 'Chaise HAWAI anthracite', 'Existe en deux coloris; Inspiration industrielle; Pieds en métal;', 79.48, 17),
(312, 126, 'Table 180cm allonge', 'Finition laquée brillante; Design avec ses glaces argentées sérigraphiées; Fabriqué en France;', 499.55, 140),
(313, 124, 'Canapé d\'angle réversible', 'Dimanche en famille ou soirée entre amis? Ce canapé d\'angle réversible quatre places en tissu gris va devenir la pièce maîtresse de votre intérieur pour tous vos moments de convivialité et de détente. Son garnissage en mousse généreux et ses coussins moelleux assurent une assise enveloppante et idéale. Vos invités restent pour la nuit? Pas de problème, il se déplie en un seul geste en un couchage spacieux et ultra-confortable pour deux personnes. Pratique, il est doté d\'un coffre pour y ranger vos couettes et coussins. Sa structure en panneau de particules et ses pieds en bois promettent une solidité et une stabilité durables.', 479, 200),
(314, 124, 'Canapé d\'angle droit', 'Têtières ajustables; Bimatière; Existe en version convertible;', 987.4, 28),
(315, 124, 'Canapé d\'angle convertible', 'Sobre et élégant, le canapé d\'angle convertible et réversible ROMY apportera de la personnalité à votre séjour. Son revêtement en polyuréthane est un gage de qualité et facile à entretenir. Pratique pour sa modularité (angle gauche ou droit), le canapé 4 places ROMY se transforme également en lit en toute simplicité et assura de bonnes nuits de sommeil à vos invités.', 529.38, 230),
(316, 124, 'Canapé d\'angle tolbiac', 'Le canapé TOLBIAC est un magnifique canapé d\'angle au revêtement en simili très confortable. Un canapé d\'angle avec un effet lounge bar qui invite au repos et à la détente dans votre salon. Ce grand canapé familial sera idéal dans tous les intérieurs contemporains avec son espace de rangement ultra pratique caché sous la méridienne. Ses pieds en métal apportent encore plus de modernité à son look déjà très contemporain. Quand vous êtes assis sur ce canapé, la méridienne se situe sur votre gauche.', 599, 149),
(317, 124, 'Canape 6227787d517c2', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 79.99, 70),
(318, 124, 'Canape 6227787d517e8', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 26.99, 30),
(319, 126, 'Autre 6227787d5180a', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 47.99, 99),
(320, 123, 'Lit 6227787d51833', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 114.99, 86),
(321, 126, 'Autre 6227787d51856', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 123.99, 92),
(322, 122, 'Bureau 6227787d51878', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 195.99, 5),
(323, 123, 'Lit 6227787d51899', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 216.99, 51),
(324, 124, 'Canape 6227787d518bb', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 154.99, 280),
(325, 121, 'Chaise 6227787d518db', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 116.99, 226),
(326, 123, 'Lit 6227787d518fd', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 247.99, 263),
(327, 123, 'Lit 6227787d5191e', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 127.99, 271),
(328, 121, 'Chaise 6227787d5193f', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 33.99, 159),
(329, 123, 'Lit 6227787d51960', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 71.99, 240),
(330, 125, 'Armoire 6227787d51981', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 153.99, 10),
(331, 123, 'Lit 6227787d519a2', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 136.99, 72),
(332, 125, 'Armoire 6227787d519c3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 72.99, 122),
(333, 125, 'Armoire 6227787d519e4', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 226.99, 234),
(334, 126, 'Autre 6227787d51a04', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 215.99, 57),
(335, 122, 'Bureau 6227787d51a25', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 152.99, 285),
(336, 121, 'Chaise 6227787d51a46', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 109.99, 89),
(337, 125, 'Armoire 6227787d51a67', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 113.99, 32),
(338, 125, 'Armoire 6227787d51a89', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 136.99, 238),
(339, 124, 'Canape 6227787d51aae', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 151.99, 29),
(340, 125, 'Armoire 6227787d51ad1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 244.99, 40),
(341, 123, 'Lit 6227787d51af3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 167.99, 200),
(342, 125, 'Armoire 6227787d51b20', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 215.99, 31),
(343, 125, 'Armoire 6227787d51b49', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 69.99, 16),
(344, 123, 'Lit 6227787d51b73', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 195.99, 262),
(345, 123, 'Lit 6227787d51b9f', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 211.99, 108),
(346, 126, 'Autre 6227787d51bc2', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 167.99, 69),
(347, 124, 'Canape 6227787d51be3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 190.99, 288),
(348, 122, 'Bureau 6227787d51c05', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 72.99, 135),
(349, 125, 'Armoire 6227787d51c26', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 128.99, 6),
(350, 125, 'Armoire 6227787d51c47', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 192.99, 3),
(351, 124, 'Canape 6227787d51c68', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 168.99, 217),
(352, 126, 'Autre 6227787d51c89', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 206.99, 7),
(353, 121, 'Chaise 6227787d51caa', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 132.99, 160),
(354, 124, 'Canape 6227787d51cd1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 173.99, 200),
(355, 124, 'Canape 6227787d51cf3', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 215.99, 43),
(356, 122, 'Bureau 6227787d51d14', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 195.99, 153),
(357, 124, 'Canape 6227787d51d35', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 190.99, 1),
(358, 125, 'Armoire 6227787d51d56', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 229.99, 258),
(359, 125, 'Armoire 6227787d51d77', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 168.99, 268),
(360, 123, 'Lit 6227787d51d98', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 46.99, 63),
(361, 123, 'Lit 6227787d51db9', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 188.99, 29),
(362, 121, 'Chaise 6227787d51dda', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 153.99, 104),
(363, 126, 'Autre 6227787d51dfb', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 155.99, 155),
(364, 124, 'Canape 6227787d51e1c', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 79.99, 200),
(365, 122, 'Bureau 6227787d51e3d', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 12.99, 6),
(366, 125, 'Armoire 6227787d51e5e', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at sapien ut sem convallis euismod. Phasellus eu condimentum augue. Praesent feugiat sem dolor, quis pharetra risus ullamcorper sed. Vivamus quis lacus id mi mollis vehicula ac in leo. Etiam aliquam sagittis euismod. Pellentesque sed viverra arcu, in tristique leo. Ut dui mauris, ullamcorper ut enim sit amet, vehicula gravida eros.\n        Maecenas quis sapien a lorem tempor semper. Donec tempor mollis vestibulum. Integer a posuere eros. Aenean feugiat ut velit non tincidunt. Vivamus egestas nisi sit amet magna pharetra facilisis. Nam finibus dictum turpis, vel feugiat orci rhoncus pulvinar. Nunc pretium pretium purus sit amet vulputate. Nulla et erat nulla. Nam eget nisi massa. ', 87.99, 237),
(372, 126, 'GG', 'GG', 0, 1),
(373, 126, 'TOTOYYDD', 'FZEF', 5, 1),
(374, 126, 'XXXX', 'XXXX', 4, 4),
(377, 126, 'UUU', 'UUU', 65, 0),
(378, 126, 'ZZZB', 'ZZZ', 100, 0),
(379, 126, 'wwwwww', 'wwwwww', 88, 56);

-- --------------------------------------------------------

--
-- Structure de la table `product_tag`
--

DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE IF NOT EXISTS `product_tag` (
  `product_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`tag_id`),
  KEY `IDX_E3A6E39C4584665A` (`product_id`),
  KEY `IDX_E3A6E39CBAD26311` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_tag`
--

INSERT INTO `product_tag` (`product_id`, `tag_id`) VALUES
(374, 5),
(374, 7),
(377, 7),
(378, 7),
(379, 9);

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_42C849554584665A` (`product_id`),
  KEY `IDX_42C849558D9F6D38` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`id`, `product_id`, `order_id`, `quantity`, `creation_date`) VALUES
(1, 307, NULL, 14, '2022-03-14 14:05:24'),
(2, 303, NULL, 37, '2022-03-14 14:10:57'),
(3, 364, NULL, 44, '2022-03-14 14:11:29'),
(4, 359, NULL, 7, '2022-03-14 14:11:43'),
(5, 311, NULL, 4, '2022-03-14 14:12:04'),
(7, 305, 1, 9, '2022-03-14 14:32:03'),
(10, 318, 2, 11, '2022-03-14 14:41:36'),
(11, 313, 3, 10, '2022-03-15 09:32:58'),
(14, 312, 3, 4, '2022-03-15 09:34:09'),
(15, 296, 4, 30, '2022-03-15 09:49:11'),
(16, 312, 4, 10, '2022-03-15 09:49:29'),
(18, 340, 4, 11, '2022-03-15 09:49:58'),
(20, 312, 5, 10, '2022-03-15 09:55:11'),
(29, 295, 10, 1, '2022-03-15 11:25:35'),
(32, 305, 11, 5, '2022-03-15 11:32:06'),
(55, 296, 25, 9, '2022-03-15 14:51:24'),
(56, 295, 25, 9, '2022-03-15 14:51:32'),
(64, 353, 29, 4, '2022-03-17 11:01:10'),
(65, 324, 29, 7, '2022-03-17 11:28:46'),
(69, 307, 33, 3, '2022-03-17 11:49:00'),
(71, 312, 35, 10, '2022-03-17 11:52:19'),
(72, 314, 35, 99, '2022-03-17 12:00:18'),
(73, 295, 35, 33, '2022-03-17 12:01:02'),
(74, 296, 36, 4, '2022-03-17 15:20:59'),
(79, 295, 40, 7, '2022-03-17 15:57:10'),
(83, 309, 43, 45, '2022-03-17 15:58:44'),
(84, 313, 43, 10, '2022-03-17 15:58:56');

-- --------------------------------------------------------

--
-- Structure de la table `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `tag`
--

INSERT INTO `tag` (`id`, `name`) VALUES
(3, 'C'),
(4, 'A'),
(5, 'B'),
(6, 'C'),
(7, 'TTop'),
(9, 'yyybb'),
(10, 'yy'),
(11, 'y'),
(12, 'pp');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649F85E0677` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `username`, `roles`, `password`) VALUES
(3, 'Admin', '[\"ROLE_USER\", \"ROLE_ADMIN\"]', '$2y$13$X3sTNrPEsd0BaDyhfanJp.hYnhdTZgbrdwWPDQ3MUo1rntENt7vMu'),
(4, 'User', '[\"ROLE_USER\", \"ROLE_CLIENT\"]', '$2y$13$FEcSq1Law.U0t8jQe.G6PefiERoJAT.r05SsIVFdhSZr/mQsw.Pxi');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

--
-- Contraintes pour la table `product_tag`
--
ALTER TABLE `product_tag`
  ADD CONSTRAINT `FK_E3A6E39C4584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_E3A6E39CBAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `FK_42C849554584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_42C849558D9F6D38` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

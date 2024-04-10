-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 10 avr. 2024 à 11:23
-- Version du serveur : 8.0.31
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `symfony_fighter`
--

-- --------------------------------------------------------

--
-- Structure de la table `champion`
--

DROP TABLE IF EXISTS `champion`;
CREATE TABLE IF NOT EXISTS `champion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pv` int NOT NULL,
  `power` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `champion`
--

INSERT INTO `champion` (`id`, `name`, `pv`, `power`) VALUES
(1, 'Coq Creole', 3000, 500),
(2, 'Coq Armé', 4000, 1000),
(3, 'Coq La Kour', 3000, 800),
(4, 'Coq Malbar', 7000, 200),
(5, 'Coq La Thaï', 1000, 300);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20240409171751', '2024-04-10 05:43:51', 7988);

-- --------------------------------------------------------

--
-- Structure de la table `fight`
--

DROP TABLE IF EXISTS `fight`;
CREATE TABLE IF NOT EXISTS `fight` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user1_id` int NOT NULL,
  `user2_id` int NOT NULL,
  `winner_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_21AA445656AE248B` (`user1_id`),
  KEY `IDX_21AA4456441B8B65` (`user2_id`),
  KEY `IDX_21AA44565DFCD4B8` (`winner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `roles`, `password`) VALUES
(1, 'testAdmin', 'testAdmin@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$10$nA39nwzgLHJuClDUmeDhye6UPqmlOm6D5xzHdLX3X3EnV0ZLUUTdG'),
(2, 'john', 'john@mail.to', '[\"ROLE_USER\"]', '$2y$10$.h1NhGj/fRtLxDs9cwpzIO./I/HO9YXvaMLNm3yQhM6Qoxdj5rB/u');

-- --------------------------------------------------------

--
-- Structure de la table `user_champion`
--

DROP TABLE IF EXISTS `user_champion`;
CREATE TABLE IF NOT EXISTS `user_champion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `champion_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A5CE9AB4A76ED395` (`user_id`),
  KEY `IDX_A5CE9AB4FA7FD7EB` (`champion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `fight`
--
ALTER TABLE `fight`
  ADD CONSTRAINT `FK_21AA4456441B8B65` FOREIGN KEY (`user2_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_21AA445656AE248B` FOREIGN KEY (`user1_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_21AA44565DFCD4B8` FOREIGN KEY (`winner_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `user_champion`
--
ALTER TABLE `user_champion`
  ADD CONSTRAINT `FK_A5CE9AB4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_A5CE9AB4FA7FD7EB` FOREIGN KEY (`champion_id`) REFERENCES `champion` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";




DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `IDC` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `prenom` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `age` int NOT NULL,
  `cin` int NOT NULL,
  `adresse` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `login` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`IDC`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `client` (`IDC`, `nom`, `prenom`, `age`, `cin`, `adresse`, `login`, `password`) VALUES
(1, 'essid', 'baha', 23, 33145789, 'nefta', 'bahaessid45@gmail.com', '123456789'),
(2, 'tlili', 'amin', 21, 1111111, 'tunis', 'tlilimedamine5@gmail.com', '123456789'),
(3, 'frih', 'aicha', 21, 155861618, 'monastir', 'aicha123@gmail.com', '123456789');



DROP TABLE IF EXISTS `projet`;
CREATE TABLE IF NOT EXISTS `projet` (
  `IDP` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `prix` int NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `delailiv` date NOT NULL,
  `IDC` int NOT NULL,
  `IDR` int NOT NULL,
  PRIMARY KEY (`IDP`),
  KEY `IDC` (`IDC`),
  KEY `IDR` (`IDR`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



DROP TABLE IF EXISTS `redacteur`;
CREATE TABLE IF NOT EXISTS `redacteur` (
  `IDR` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `prenom` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `age` int NOT NULL,
  `cin` int NOT NULL,
  `adresse` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `profession` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `numcompte` int NOT NULL,
  `cv` longblob NOT NULL,
  `login` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`IDR`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `projet`
  ADD CONSTRAINT `IDC` FOREIGN KEY (`IDC`) REFERENCES `client` (`IDC`),
  ADD CONSTRAINT `IDR` FOREIGN KEY (`IDR`) REFERENCES `redacteur` (`IDR`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

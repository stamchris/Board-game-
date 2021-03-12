

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `Cerber_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `rel_action_effet`
--

CREATE TABLE `rel_action_effet` (
  `id_effet_carte` varchar(255) NOT NULL,
  `id_action_effet` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `rel_score`
--

CREATE TABLE `rel_score` (
  `id_session` varchar(255) NOT NULL,
  `id_joueur` varchar(255) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `etat_partie` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `rel_session_joueur_carte`
--

CREATE TABLE `rel_session_joueur_carte` (
  `id_session` varchar(255) NOT NULL,
  `id_joueur` varchar(255) NOT NULL,
  `id_carte` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `rel_session_joueur_case`
--

CREATE TABLE `rel_session_joueur_case` (
  `id_session` varchar(255) NOT NULL,
  `id_joueur` varchar(255) NOT NULL,
  `id_case` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tab_action_effet`
--

CREATE TABLE `tab_action_effet` (
  `id_action_effet` varchar(255) NOT NULL,
  `libelle_action_effet` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tab_carte`
--

CREATE TABLE `tab_carte` (
  `id_carte` varchar(255) NOT NULL,
  `libelle_carte` varchar(255) DEFAULT NULL,
  `id_pack_carte` varchar(255) DEFAULT NULL,
  `id_type_carte` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tab_carte`
--

INSERT INTO `tab_carte` (`id_carte`, `libelle_carte`, `id_pack_carte`, `id_type_carte`) VALUES
('007', 'Carte_Couardise', '002', '005'),
('008', 'Carte_Opportunisme', '002', '005'),
('009', 'Carte_Favoritisme', '002', '005'),
('010', 'Carte_Arrogance', '002', '005'),
('011', 'Carte_Sacrifice', '002', '005'),
('012', 'Carte_Egoïsme', '002', '005'),
('013', 'Carte_Fatalisme', '002', '005'),
('014', 'Carte_Couardise', '002', '005'),
('015', 'Carte_Action1', '001', '005'),
('016', 'Carte_Action2', '001', '004'),
('017', 'Carte_Action3', '001', '004'),
('018', 'Carte_Action4', '001', '004'),
('019', 'Carte_Rancune', '003', '004'),
('020', 'Carte_Violence', '003', '004'),
('021', 'Carte_Sabotage', '003', '004'),
('022', 'Carte_Perfidie', '003', '004'),
('023', 'Carte_Fourberie', '003', '004'),
('024', 'Carte_Embuscade', '003', '004'),
('025', 'Carte_Violence', '003', '004');

-- --------------------------------------------------------

--
-- Structure de la table `tab_case`
--

CREATE TABLE `tab_case` (
  `id_case` varchar(255) NOT NULL,
  `libelle_case` varchar(255) DEFAULT NULL,
  `specification` varchar(255) DEFAULT NULL,
  `id_zone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tab_effet_carte`
--

CREATE TABLE `tab_effet_carte` (
  `id_effet_carte` varchar(255) NOT NULL,
  `libelle_effet_carte` varchar(255) DEFAULT NULL,
  `cout_effet_carte` varchar(255) DEFAULT NULL,
  `id_carte` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tab_joueur`
--

CREATE TABLE `tab_joueur` (
  `id_joueur` varchar(255) NOT NULL,
  `pseudo_joueur` varchar(255) DEFAULT NULL,
  `login_joueur` varchar(255) DEFAULT NULL,
  `password_joueur` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tab_pack_carte`
--

CREATE TABLE `tab_pack_carte` (
  `id_pack_carte` varchar(255) NOT NULL,
  `libelle_pack_carte` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tab_pack_carte`
--

INSERT INTO `tab_pack_carte` (`id_pack_carte`, `libelle_pack_carte`) VALUES
('001', 'Pack_Action'),
('002', 'Pack_Survie'),
('003', 'Pack_trahison');

-- --------------------------------------------------------

--
-- Structure de la table `tab_plateau`
--

CREATE TABLE `tab_plateau` (
  `id_plateau` varchar(255) NOT NULL,
  `libelle_plateau` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tab_session`
--

CREATE TABLE `tab_session` (
  `id_session` varchar(255) NOT NULL,
  `libelle_session` varchar(255) DEFAULT NULL,
  `date_session` datetime DEFAULT NULL,
  `heure_session` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tab_type_carte`
--

CREATE TABLE `tab_type_carte` (
  `id_type_carte` varchar(255) NOT NULL,
  `libelle_type_carte` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tab_type_carte`
--

INSERT INTO `tab_type_carte` (`id_type_carte`, `libelle_type_carte`) VALUES
('004', 'Type_Cerbere'),
('005', 'Type_Aventurier');

-- --------------------------------------------------------

--
-- Structure de la table `tab_zone`
--

CREATE TABLE `tab_zone` (
  `id_zone` varchar(255) NOT NULL,
  `libelle_zone` varchar(255) DEFAULT NULL,
  `id_plateau` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `rel_action_effet`
--
ALTER TABLE `rel_action_effet`
  ADD PRIMARY KEY (`id_effet_carte`,`id_action_effet`),
  ADD KEY `id_action_effet` (`id_action_effet`),
  ADD KEY `id_effet_carte` (`id_effet_carte`);

--
-- Index pour la table `rel_score`
--
ALTER TABLE `rel_score`
  ADD PRIMARY KEY (`id_session`,`id_joueur`),
  ADD KEY `id_joueur` (`id_joueur`),
  ADD KEY `id_session` (`id_session`);

--
-- Index pour la table `rel_session_joueur_carte`
--
ALTER TABLE `rel_session_joueur_carte`
  ADD PRIMARY KEY (`id_session`,`id_joueur`,`id_carte`),
  ADD KEY `id_carte` (`id_carte`),
  ADD KEY `id_joueur` (`id_joueur`),
  ADD KEY `id_session` (`id_session`);

--
-- Index pour la table `rel_session_joueur_case`
--
ALTER TABLE `rel_session_joueur_case`
  ADD PRIMARY KEY (`id_session`,`id_joueur`,`id_case`),
  ADD KEY `id_case` (`id_case`),
  ADD KEY `id_joueur` (`id_joueur`),
  ADD KEY `id_session` (`id_session`);

--
-- Index pour la table `tab_action_effet`
--
ALTER TABLE `tab_action_effet`
  ADD PRIMARY KEY (`id_action_effet`),
  ADD UNIQUE KEY `id_action_effet` (`id_action_effet`);

--
-- Index pour la table `tab_carte`
--
ALTER TABLE `tab_carte`
  ADD PRIMARY KEY (`id_carte`),
  ADD UNIQUE KEY `id_carte` (`id_carte`),
  ADD KEY `id_pack_carte` (`id_pack_carte`),
  ADD KEY `id_type_carte` (`id_type_carte`);

--
-- Index pour la table `tab_case`
--
ALTER TABLE `tab_case`
  ADD PRIMARY KEY (`id_case`),
  ADD UNIQUE KEY `id_case` (`id_case`),
  ADD KEY `id_zone` (`id_zone`);

--
-- Index pour la table `tab_effet_carte`
--
ALTER TABLE `tab_effet_carte`
  ADD PRIMARY KEY (`id_effet_carte`),
  ADD UNIQUE KEY `id_effet_carte` (`id_effet_carte`),
  ADD KEY `id_carte` (`id_carte`);

--
-- Index pour la table `tab_joueur`
--
ALTER TABLE `tab_joueur`
  ADD PRIMARY KEY (`id_joueur`),
  ADD UNIQUE KEY `id_joueur` (`id_joueur`);

--
-- Index pour la table `tab_pack_carte`
--
ALTER TABLE `tab_pack_carte`
  ADD PRIMARY KEY (`id_pack_carte`),
  ADD UNIQUE KEY `id_pack_carte` (`id_pack_carte`);

--
-- Index pour la table `tab_plateau`
--
ALTER TABLE `tab_plateau`
  ADD PRIMARY KEY (`id_plateau`),
  ADD UNIQUE KEY `id_plateau` (`id_plateau`);

--
-- Index pour la table `tab_session`
--
ALTER TABLE `tab_session`
  ADD PRIMARY KEY (`id_session`),
  ADD UNIQUE KEY `id_session` (`id_session`);

--
-- Index pour la table `tab_type_carte`
--
ALTER TABLE `tab_type_carte`
  ADD PRIMARY KEY (`id_type_carte`),
  ADD UNIQUE KEY `id_type_carte` (`id_type_carte`);

--
-- Index pour la table `tab_zone`
--
ALTER TABLE `tab_zone`
  ADD PRIMARY KEY (`id_zone`),
  ADD UNIQUE KEY `id_zone` (`id_zone`),
  ADD KEY `id_plateau` (`id_plateau`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `rel_action_effet`
--
ALTER TABLE `rel_action_effet`
  ADD CONSTRAINT `rel_action_effet_ibfk_1` FOREIGN KEY (`id_action_effet`) REFERENCES `tab_action_effet` (`id_action_effet`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_action_effet_ibfk_2` FOREIGN KEY (`id_effet_carte`) REFERENCES `tab_effet_carte` (`id_effet_carte`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rel_score`
--
ALTER TABLE `rel_score`
  ADD CONSTRAINT `rel_score_ibfk_1` FOREIGN KEY (`id_joueur`) REFERENCES `tab_joueur` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_score_ibfk_2` FOREIGN KEY (`id_session`) REFERENCES `tab_session` (`id_session`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rel_session_joueur_carte`
--
ALTER TABLE `rel_session_joueur_carte`
  ADD CONSTRAINT `rel_session_joueur_carte_ibfk_1` FOREIGN KEY (`id_carte`) REFERENCES `tab_carte` (`id_carte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_session_joueur_carte_ibfk_2` FOREIGN KEY (`id_joueur`) REFERENCES `tab_joueur` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_session_joueur_carte_ibfk_3` FOREIGN KEY (`id_session`) REFERENCES `tab_session` (`id_session`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rel_session_joueur_case`
--
ALTER TABLE `rel_session_joueur_case`
  ADD CONSTRAINT `rel_session_joueur_case_ibfk_1` FOREIGN KEY (`id_case`) REFERENCES `tab_case` (`id_case`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_session_joueur_case_ibfk_2` FOREIGN KEY (`id_joueur`) REFERENCES `tab_joueur` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_session_joueur_case_ibfk_3` FOREIGN KEY (`id_session`) REFERENCES `tab_session` (`id_session`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `tab_carte`
--
ALTER TABLE `tab_carte`
  ADD CONSTRAINT `tab_carte_ibfk_1` FOREIGN KEY (`id_pack_carte`) REFERENCES `tab_pack_carte` (`id_pack_carte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tab_carte_ibfk_2` FOREIGN KEY (`id_type_carte`) REFERENCES `tab_type_carte` (`id_type_carte`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `tab_case`
--
ALTER TABLE `tab_case`
  ADD CONSTRAINT `tab_case_ibfk_1` FOREIGN KEY (`id_zone`) REFERENCES `tab_zone` (`id_zone`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `tab_effet_carte`
--
ALTER TABLE `tab_effet_carte`
  ADD CONSTRAINT `tab_effet_carte_ibfk_1` FOREIGN KEY (`id_carte`) REFERENCES `tab_carte` (`id_carte`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `tab_zone`
--
ALTER TABLE `tab_zone`
  ADD CONSTRAINT `tab_zone_ibfk_1` FOREIGN KEY (`id_plateau`) REFERENCES `tab_plateau` (`id_plateau`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

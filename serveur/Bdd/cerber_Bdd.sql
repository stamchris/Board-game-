

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";




--
-- Base de données: `cerber`
--

-- --------------------------------------------------------

--
-- Structure de la table `rel_action_effet`
--

CREATE TABLE IF NOT EXISTS `rel_action_effet` (
  `id_effet_carte` varchar(255) NOT NULL,
  `id_action_effet` varchar(255) NOT NULL,
  PRIMARY KEY (`id_effet_carte`,`id_action_effet`),
  KEY `id_action_effet` (`id_action_effet`),
  KEY `id_effet_carte` (`id_effet_carte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `rel_action_effet`
--


-- --------------------------------------------------------

--
-- Structure de la table `rel_score`
--

CREATE TABLE IF NOT EXISTS `rel_score` (
  `id_session` varchar(255) NOT NULL,
  `id_joueur` varchar(255) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `etat_partie` varchar(255) DEFAULT NULL,
  `achievement` varchar(255) DEFAULT NULL,

  PRIMARY KEY (`id_session`,`id_joueur`),
  KEY `id_joueur` (`id_joueur`),
  KEY `id_session` (`id_session`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `rel_score`
--


-- --------------------------------------------------------

--
-- Structure de la table `rel_session_joueur_carte`
--

CREATE TABLE IF NOT EXISTS `rel_session_joueur_carte` (
  `id_session` varchar(255) NOT NULL,
  `id_joueur` varchar(255) NOT NULL,
  `id_carte` varchar(255) NOT NULL,
  PRIMARY KEY (`id_session`,`id_joueur`,`id_carte`),
  KEY `id_carte` (`id_carte`),
  KEY `id_joueur` (`id_joueur`),
  KEY `id_session` (`id_session`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `rel_session_joueur_carte`
--


-- --------------------------------------------------------

--
-- Structure de la table `rel_session_joueur_case`
--

CREATE TABLE IF NOT EXISTS `rel_session_joueur_case` (
  `id_session` varchar(255) NOT NULL,
  `id_joueur` varchar(255) NOT NULL,
  `id_case` varchar(255) NOT NULL,
  PRIMARY KEY (`id_session`,`id_joueur`,`id_case`),
  KEY `id_case` (`id_case`),
  KEY `id_joueur` (`id_joueur`),
  KEY `id_session` (`id_session`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `rel_session_joueur_case`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_action_effet`
--

CREATE TABLE IF NOT EXISTS `tab_action_effet` (
  `id_action_effet` varchar(255) NOT NULL,
  `libelle_action_effet` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_action_effet`),
  UNIQUE KEY `id_action_effet` (`id_action_effet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_action_effet`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_carte`
--

CREATE TABLE IF NOT EXISTS `tab_carte` (
  `id_carte` varchar(255) NOT NULL,
  `libelle_carte` varchar(255) DEFAULT NULL,
  `id_pack_carte` varchar(255) DEFAULT NULL,
  `id_type_carte` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_carte`),
  UNIQUE KEY `id_carte` (`id_carte`),
  KEY `id_pack_carte` (`id_pack_carte`),
  KEY `id_type_carte` (`id_type_carte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_carte`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_case`
--

CREATE TABLE IF NOT EXISTS `tab_case` (
  `id_case` varchar(255) NOT NULL,
  `libelle_case` varchar(255) DEFAULT NULL,
  `specification` varchar(255) DEFAULT NULL,
  `id_zone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_case`),
  UNIQUE KEY `id_case` (`id_case`),
  KEY `id_zone` (`id_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_case`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_effet_carte`
--

CREATE TABLE IF NOT EXISTS `tab_effet_carte` (
  `id_effet_carte` varchar(255) NOT NULL,
  `libelle_effet_carte` varchar(255) DEFAULT NULL,
  `cout_effet_carte` varchar(255) DEFAULT NULL,
  `id_carte` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_effet_carte`),
  UNIQUE KEY `id_effet_carte` (`id_effet_carte`),
  KEY `id_carte` (`id_carte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_effet_carte`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_joueur`
--

CREATE TABLE IF NOT EXISTS `tab_joueur` (
  `id_joueur` varchar(255) NOT NULL,
  `pseudo_joueur` varchar(255) DEFAULT NULL,
  `login_joueur` varchar(255) DEFAULT NULL,
  `password_joueur` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_joueur`),
  UNIQUE KEY `id_joueur` (`id_joueur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_joueur`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_pack_carte`
--

CREATE TABLE IF NOT EXISTS `tab_pack_carte` (
  `id_pack_carte` varchar(255) NOT NULL,
  `libelle_pack_carte` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_pack_carte`),
  UNIQUE KEY `id_pack_carte` (`id_pack_carte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_pack_carte`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_plateau`
--

CREATE TABLE IF NOT EXISTS `tab_plateau` (
  `id_plateau` varchar(255) NOT NULL,
  `libelle_plateau` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_plateau`),
  UNIQUE KEY `id_plateau` (`id_plateau`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_plateau`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_session`
--

CREATE TABLE IF NOT EXISTS `tab_session` (
  `id_session` varchar(255) NOT NULL,
  `libelle_session` varchar(255) DEFAULT NULL,
  `date_session` datetime DEFAULT NULL,
  `heure_session` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_session`),
  UNIQUE KEY `id_session` (`id_session`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_session`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_type_carte`
--

CREATE TABLE IF NOT EXISTS `tab_type_carte` (
  `id_type_carte` varchar(255) NOT NULL,
  `libelle_type_carte` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_type_carte`),
  UNIQUE KEY `id_type_carte` (`id_type_carte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_type_carte`
--


-- --------------------------------------------------------

--
-- Structure de la table `tab_zone`
--

CREATE TABLE IF NOT EXISTS `tab_zone` (
  `id_zone` varchar(255) NOT NULL,
  `libelle_zone` varchar(255) DEFAULT NULL,
  `id_plateau` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_zone`),
  UNIQUE KEY `id_zone` (`id_zone`),
  KEY `id_plateau` (`id_plateau`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `tab_zone`
--


--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `rel_action_effet`
--
ALTER TABLE `rel_action_effet`
  ADD CONSTRAINT `rel_action_effet_ibfk_2` FOREIGN KEY (`id_effet_carte`) REFERENCES `tab_effet_carte` (`id_effet_carte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_action_effet_ibfk_1` FOREIGN KEY (`id_action_effet`) REFERENCES `tab_action_effet` (`id_action_effet`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rel_score`
--
ALTER TABLE `rel_score`
  ADD CONSTRAINT `rel_score_ibfk_2` FOREIGN KEY (`id_session`) REFERENCES `tab_session` (`id_session`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_score_ibfk_1` FOREIGN KEY (`id_joueur`) REFERENCES `tab_joueur` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rel_session_joueur_carte`
--
ALTER TABLE `rel_session_joueur_carte`
  ADD CONSTRAINT `rel_session_joueur_carte_ibfk_3` FOREIGN KEY (`id_session`) REFERENCES `tab_session` (`id_session`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_session_joueur_carte_ibfk_1` FOREIGN KEY (`id_carte`) REFERENCES `tab_carte` (`id_carte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_session_joueur_carte_ibfk_2` FOREIGN KEY (`id_joueur`) REFERENCES `tab_joueur` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rel_session_joueur_case`
--
ALTER TABLE `rel_session_joueur_case`
  ADD CONSTRAINT `rel_session_joueur_case_ibfk_3` FOREIGN KEY (`id_session`) REFERENCES `tab_session` (`id_session`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_session_joueur_case_ibfk_1` FOREIGN KEY (`id_case`) REFERENCES `tab_case` (`id_case`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_session_joueur_case_ibfk_2` FOREIGN KEY (`id_joueur`) REFERENCES `tab_joueur` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `tab_carte`
--
ALTER TABLE `tab_carte`
  ADD CONSTRAINT `tab_carte_ibfk_2` FOREIGN KEY (`id_type_carte`) REFERENCES `tab_type_carte` (`id_type_carte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tab_carte_ibfk_1` FOREIGN KEY (`id_pack_carte`) REFERENCES `tab_pack_carte` (`id_pack_carte`) ON DELETE CASCADE ON UPDATE CASCADE;

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

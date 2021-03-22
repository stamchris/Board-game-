SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";




--
-- Base de données : `Cerber_db`
--
--
-- Structure de la table `rel_achievement_s_j`
--

CREATE TABLE `rel_achievement_s_j` (
  `id_session` varchar(255) NOT NULL,
  `id_joueur` varchar(255) NOT NULL,
  `id_achievement` varchar(255) NOT NULL,
  `id_temps_realisaion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Structure de la table `rel_action_effet`
--

CREATE TABLE `tab_action_effet` (
  `id_action_effet` varchar(255) NOT NULL,
  `libelle_action_effet` varchar(255) DEFAULT NULL,
  `Descriptif_action_effet` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Déchargement des données de la table `rel_action_effet`
--

INSERT INTO `rel_action_effet` (`id_effet_carte`, `id_action_effet`) VALUES
('034', '001'),
('035', '002'),
('036', '003'),
('037', '004'),
('038', '005'),
('039', '006'),
('040', '008'),
('041', '007'),
('042', '009'),
('043', '010'),
('044', '011'),
('045', '012'),
('045', '013'),
('046', '015'),
('047', '014'),
('048', '017'),
('049', '016'),
('050', '019'),
('051', '018'),
('052', '021'),
('053', '023'),
('054', '023'),
('055', '022'),
('055', '023'),
('056', '024'),
('057', '025'),
('058', '026'),
('059', '027'),
('060', '028'),
('061', '029'),
('061', '030'),
('062', '031'),
('063', '032'),
('064', '033'),
('065', '034'),
('066', '035'),
('067', '036'),
('070', '037'),
('071', '050'),
('072', '038'),
('073', '039'),
('074', '040'),
('075', '041'),
('076', '043'),
('077', '042');
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
-- Structure de la table `tab_achievement`
--

CREATE TABLE `tab_achievement` (
  `id_achievement` varchar(255) NOT NULL,
  `libelle_achievement` varchar(255) DEFAULT NULL,
  `descriptif_achievement` varchar(255) DEFAULT NULL,
  `niveau_achievement` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tab_achievement`
--

INSERT INTO `tab_achievement` (`id_achievement`, `libelle_achievement`, `descriptif_achievement`, `niveau_achievement`) VALUES
('001', 'Une petite faim ', 'Manger son premier Aventurier en tant que Cerbère', 'Niveau Facile'),
('002', 'On a réussi! ', 'Réussir à s\'enfuir pour la première fois en barque en tant qu\'Aventurier', 'Niveau Facile'),
('003', 'Vitesse lumière ', 'Avancer son pion de 5 cases en un seul tour', 'Niveau Facile'),
('004', 'Dépression avancée', 'Jouer la carte Fatalisme et atterrir sur la case de Cerbère', 'Niveau Facile'),
('005', 'Personne ne m\'aime', 'Être devoré par Cerbère sur le 1er plateau', 'Niveau Facile'),
('006', 'La faim justifie les moyens', 'Trahir une promesse faite à un joueur', 'Niveau Facile'),
('007', 'Victoire à l\'aveugle', 'Retourner la barque en entrant sur le 4ème plateau sans que la personne n\'ait regardé les barques pendant la partie', 'Niveau Facile'),
('008', 'Désir de vivre', 'Réussir a gagner en Aventurier en partant seul(e) avec la barque à 1 place dans une partie de difficulté 14', 'Niveau Impossible'),
('009', 'J\'ai les crocs ', 'Gagner en tant que Cerbère dans une partie de difficulté 8', 'Niveau Impossible'),
('010', 'Chien de Troupeau', 'Gagner en Cerbère avant qu\'un seul Aventurier ne rentre sur le 4ème plateau', 'Niveau Impossible'),
('011', 'Plus fort que la mort', 'Avoir réussi toutes les Réussites Magistrales du jeu', 'Niveau Impossible'),
('012', 'Vous ne passerez pas!', 'Dévorer le dernier Aventurier sur la dernière case du dernier plateau et gagner en tant que Cerbère', 'Niveau Difficile'),
('013', 'D\'un cheveu', 'Gagner en tant qu\'Aventurier alors que Cerbère est à moins de 4 cases de la barque', 'Niveau Difficile'),
('014', 'Fin négociateur', 'Réussir à faire payer le coût de la carte Favoritisme par 3 autres joueurs ', 'Niveau Difficile'),
('015', 'La fin d\'une amitié', 'Faire payer le coût de la carte Opportunisme à un joueur et le reculer au lieu de l\'avancer', 'Niveau Difficile'),
('016', 'Tous pour 1 et 1 pour tous', 'Réussir à gagner avec la barque à 3 places dans une partie à 3 joueurs', 'Niveau Difficile'),
('017', 'Oups!', 'Se faire attraper par Cerbère alors qu\'on a au moins 4 cartes Survie en main', 'Niveau Difficile'),
('018', 'Tous aux abris!', 'Tous les Aventuriers encore en jeu survivent à une chasse de Cerbère de 8 cases', 'Niveau Difficile'),
('019', 'La vraie victoire', 'Réussir à gagner en Aventurier en partant seul(e) avec la barque à 1 place', 'Niveau Difficile'),
('020', 'Égoïsme total', 'Réussir à gagner en Aventurier en partant seul(e) avec la barque à 1 place dans une partie avec 5 joueurs ou plus', 'Niveau Difficile'),
('021', 'Ça croque sous la dent ', 'Réussir en tant que Cerbère à dévorer d\'un coup 2 Aventuriers ou plus', 'Niveau Difficile'),
('022', 'Effet 3 en 1', 'Réussir en tant que Cerbère à dévorer d\'un coup 3 Aventuriers ou plus ', 'Niveau Difficile');

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
-- Déchargement des données de la table `tab_action_effet`
--

INSERT INTO `tab_action_effet` (`id_action_effet`, `libelle_action_effet`, `Descriptif_action_effet`) VALUES
('001', 'Action Sup1', 'Piocher Carte Récupérer Carte Action'),
('002', 'Action Inf1', 'Voir Barque Récupérer Carte'),
('003', 'Action Sup2', 'Piocher Carte 2'),
('004', 'Action Inf2', 'Piocher Moi 1 Piocher Autres 2'),
('005', 'Action Sup3', 'Avancer Moi 2'),
('006', 'Action Inf3', 'Avancer Autre 2 Avancer Autre 1'),
('007', 'Action Sup4', 'Avancer Moi 2 Avancer Autre 1'),
('008', 'Action Inf4', 'Avancer Autre 2 Avancer Autre 1'),
('009', 'Survie Sup1', 'Voir Barque'),
('010', 'Survie Inf1', 'Couardise'),
('011', 'Survie Sup2', 'Avancer Moi 1 Reculer Autre 1'),
('012', 'Survie Inf2', 'Avancer Moi 1 Avancer Autre 2'),
('013', 'Survie Inf2', 'Avancer Moi 1 Reculer Autre 2'),
('014', 'Survie Sup3', 'Avancer Autre 1 Avancer Autre 1'),
('015', 'Survie Inf3', 'Changer Rage 1 Avancer Autre 3'),
('016', 'Survie Sup4', 'Avancer Moi 1 Avancer Autre 1'),
('017', 'Survie Inf4', 'Avancer Moi 3 Avancer Autre 2 Avancer Autre 1'),
('018', 'Survie Sup5', 'Reculer Autre 1 Changer Rage -1'),
('019', 'Survie Inf5', 'Reculer Autre 2 Changer Rage -2'),
('020', 'Survie Sup6', 'Avancer Moi 1'),
('021', 'Survie Inf6', 'Avancer Moi 2'),
('022', 'Survie Sup7', 'Reculer Moi 1'),
('023', 'Survie Inf7', 'Avancer Autre 3'),
('024', 'Trahison Sup1', 'Reculer Autre 2'),
('025', 'Trahison Inf1', 'Reculer Autres3 2'),
('026', 'Trahison Sup2', 'Changer Rage 1'),
('027', 'Trahison Inf2', 'Changer Vitesse 2'),
('028', 'Trahison Sup3', 'Defausser Survie 2'),
('029', 'Trahison Inf3', 'Defausser Survie 3'),
('030', 'Trahison Inf3', 'Reculer Autre3 2'),
('031', 'Trahison Sup4', 'Changer Vitesse 1'),
('032', 'Trahison Inf4', 'Changer Rage 2'),
('033', 'Trahison Sup5', 'Voir Barque'),
('034', 'Trahison Inf5', 'Reculer Autre -3'),
('035', 'Trahison Sup6', 'Avancer Cerbère 1'),
('036', 'Trahison Inf6', 'Avancer Cerbère 2'),
('037', 'Cerbère Sup1', 'Récupérer Carte'),
('038', 'Cerbère Sup2', 'Changer Vitesse 1'),
('039', 'Cerbère Inf2', 'Piocher Moi 2 Piocher Autre 1'),
('040', 'Cerbère Sup3', 'Reculer Survivant3 1'),
('041', 'Cerbère Inf3', 'Changer Rage 1'),
('042', 'Cerbère Sup4', 'Avancer Moi 1'),
('043', 'Cerbère Inf4', 'Piocher Moi 1'),
('050', 'Cerbère Inf1', 'Récupe1rer Carte Piocher Moi 1');




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
('025', 'Carte_Cerbere_1', '001', '005'),
('026', 'Carte_Cerbere_2', '001', '005'),
('027', 'Carte_Cerbere_3', '001', '005'),
('028', 'Carte_Cerbere_4', '001', '005');

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
-- Déchargement des données de la table `tab_case`
--

INSERT INTO `tab_case` (`id_case`, `libelle_case`, `specification`, `id_zone`) VALUES
('042', 'Case1', 'Rien', '038'),
('043', 'Case2', 'Cerbere', '039'),
('044', 'Case3', 'Rien', '041'),
('045', 'Case4', 'Pioche', '042'),
('046', 'Case5', 'Cerbere', '043'),
('047', 'Case6', 'Rien', '044'),
('048', 'Case7', 'Rien', '045'),
('049', 'case8', 'Cerbère', '045'),
('050', 'case9', 'Pont', '046'),
('051', 'case10', 'Rien', '047'),
('052', 'case11', 'Cerbère', '048'),
('053', 'case12', 'Rien', '049'),
('054', 'case13', 'Pont_2', '050'),
('055', 'case14', 'Cerbère', '051'),
('056', 'case15', 'Portail', '052'),
('057', 'case16', 'Cerbère', '053'),
('058', 'case17', 'Clé', '054'),
('059', 'case18', 'Portail_2', '055'),
('060', 'Case19', 'Cerbère', '057'),
('061', 'Case20', 'Rien', '058'),
('062', 'Case21', 'Rien', '059'),
('063', 'Case22', 'Rien', '060'),
('064', 'Case23', 'Changer_Rage', '061'),
('065', 'Barque_1', 'Rien', '061'),
('066', 'Barque_1', 'Rien', '061'),
('067', 'Barque_1', 'Rien', '061');

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
INSERT INTO `tab_effet_carte` (`id_effet_carte`, `libelle_effet_carte`, `cout_effet_carte`, `id_carte`) VALUES
('034', 'Effet_Sup1', 'Changer_Vitesse', '015'),
('035', 'Effet_Inf1', 'Changer_Rage', '015'),
('036', 'Effet_Sup2', 'Changer_Rage', '016'),
('037', 'Effet_Inf2', 'Changer_Rage', '016'),
('038', 'Effet_Sup3', 'Changer_Rage', '017'),
('039', 'Effet_Inf3', 'Changer_Rage', '017'),
('040', 'Effet_Inf4', 'Defausser_Carte', '018'),
('041', 'Effet_Sup4', 'Changer_Vitesse', '018'),
('042', 'Effet_Sup1', 'Rien', '007'),
('043', 'Effet_Inf1', 'Defausser_Partage', '007'),
('044', 'Effet_Sup2', 'Rien', '008'),
('045', 'Effet_Inf2', 'Defausser_Partage', '008'),
('046', 'Effet_Inf3', 'Rien', '010'),
('047', 'Effet_Sup3', 'Defausser_Partage', '010'),
('048', 'Effet_Inf4', 'Rien', '009'),
('049', 'Effet_Sup4', 'Defausser_Partage_3', '009'),
('050', 'Effet_Inf5', 'Rien', '011'),
('051', 'Effet_Sup5', 'Defausser_Partage', '011'),
('052', 'Effet_Inf6', 'Rien', '012'),
('053', 'Effet_Sup6', 'Defausser_Partage', '012'),
('054', 'Effet_Inf7', 'Rien', '013'),
('055', 'Effet_Sup7', 'Reculer_Moi_1', '013'),
('056', 'Effet_Sup1', 'Rien', '019'),
('057', 'Effet_Inf1', 'Defausser_Partage_2', '019'),
('058', 'Effet_Sup2', 'Rien', '020'),
('059', 'Effet_Inf2', 'Defausser_Partage_2', '020'),
('060', 'Effet_Sup3', 'Rien', '021'),
('061', 'Effet_Inf3', 'Defausser_Partage', '021'),
('062', 'Effet_Sup4', 'Rien', '022'),
('063', 'Effet_Inf4', 'Defausser_Partage', '022'),
('064', 'Effet_Sup5', 'Rien', '023'),
('065', 'Effet_Inf5', 'Avancer_Autre', '023'),
('066', 'Effet_Sup6', 'Rien', '024'),
('067', 'Effet_Inf6', 'Defausser_Partage', '024'),
('070', 'Cerebere_Effet_Sup_1', 'Rien', '025'),
('071', 'Cerebere_Effet_Inf_1', 'Avancer_Survivant_2', '025'),
('072', 'Cerebere_Effet_Sup_2', 'Rien', '026'),
('073', 'Cerebere_Effet_Inf_2', 'Changer_Vitesse_-1', '026'),
('074', 'Cerebere_Effet_Sup_3', 'Avancer_Survivant_1', '027'),
('075', 'Cerebere_Effet_Inf_3', 'Rien', '027'),
('076', 'Cerebere_Effet_Sup_4', 'Rien', '028'),
('077', 'Cerebere_Effet_Inf_4', 'Rien', '028');
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
-- Structure de la table `tab_temps_realisation`
--

CREATE TABLE `tab_temps_realisation` (
  `id_temps_relaisation` varchar(255) NOT NULL,
  `jour_realisation` datetime DEFAULT NULL,
  `heure_relaisation` datetime DEFAULT NULL
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
-- Déchargement des données de la table `tab_zone`
--

INSERT INTO `tab_zone` (`id_zone`, `libelle_zone`, `id_plateau`) VALUES
('038', 'Zone1', '034'),
('039', 'zone2', '034'),
('040', 'zone3', '034'),
('041', 'zone4', '034'),
('042', 'zone5', '034'),
('043', 'zone6', '034'),
('044', 'zone7', '034'),
('045', 'zone1', '035'),
('046', 'zone2', '035'),
('047', 'zone3', '035'),
('048', 'zone4', '035'),
('049', 'zone5', '035'),
('050', 'zone6', '035'),
('051', 'zone1', '036'),
('052', 'zone2', '036'),
('053', 'zone3', '036'),
('054', 'zone4', '036'),
('055', 'zone5', '036'),
('056', 'zone1', '037'),
('057', 'zone2', '037'),
('058', 'zone3', '037'),
('059', 'zone4', '037'),
('060', 'zone5', '037'),
('061', 'zone6', '037');

--
-- Index pour les tables déchargées
--
ALTER TABLE `rel_achievement_s_j`
  ADD PRIMARY KEY (`id_session`,`id_joueur`,`id_achievement`,`id_temps_realisaion`),
  ADD KEY `id_achievement` (`id_achievement`),
  ADD KEY `id_joueur` (`id_joueur`),
  ADD KEY `id_session` (`id_session`),
  ADD KEY `id_temps_realisaion` (`id_temps_realisaion`);
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
-- Index pour la table `tab_achievement`
--
ALTER TABLE `tab_achievement`
  ADD PRIMARY KEY (`id_achievement`),
  ADD UNIQUE KEY `id_achievement` (`id_achievement`);

--
-- Index pour la table `tab_temps_realisation`
--
ALTER TABLE `tab_temps_realisation`
  ADD PRIMARY KEY (`id_temps_relaisation`),
  ADD UNIQUE KEY `id_temps_relaisation` (`id_temps_relaisation`);


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
-- Contraintes pour la table `rel_achievement_s_j`
--
ALTER TABLE `rel_achievement_s_j`
  ADD CONSTRAINT `rel_achievement_s_j_ibfk_1` FOREIGN KEY (`id_achievement`) REFERENCES `tab_achievement` (`id_achievement`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_achievement_s_j_ibfk_2` FOREIGN KEY (`id_joueur`) REFERENCES `tab_joueur` (`id_joueur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_achievement_s_j_ibfk_3` FOREIGN KEY (`id_session`) REFERENCES `tab_session` (`id_session`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rel_achievement_s_j_ibfk_4` FOREIGN KEY (`id_temps_realisaion`) REFERENCES `tab_temps_realisation` (`id_temps_relaisation`) ON DELETE CASCADE ON UPDATE CASCADE;

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


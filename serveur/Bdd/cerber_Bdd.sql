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
('001', 'Achiev1', 'Une petite faim : Manger son premiEr Aventurier en tant que cerbère', 'Niveau Facile'),
('002', 'Achiev2', 'On a reussi : Réussir a s enfuir pour la première fois en barque en tant qu aventurier', 'Niveau Facile'),
('003', 'Achiev3', 'Vitesse lumière : Avancer son pion de 5 cases en un seul tour', 'Niveau Facile'),
('004', 'Achiev4', 'Depression avancée: Jouer la carte Fatalisme et atterrir sur la case de cerbère', 'Niveau Facile'),
('005', 'Achiev5', 'Personne ne m aime: etre devoré par cerbère sur le 1er plateau', 'Niveau Facile'),
('006', 'Achiev6', 'La faim justifie les moyens: Trahir une promesse faite à un joueur', 'Niveau Facile'),
('007', 'Achiev7', 'Victoire à l aveugle: Retourner la barque en entrant sur le 4eme plateau sans que la personne n ait regardé les barques pendant la partie', 'Niveau Facile'),
('008', 'Achiev8', 'Desir de vivre: Réussir a gagner en Aventurier en partant seul(e) avec la barque à 1 place dans une partie de difficulté 14', 'Niveau Impossible'),
('009', 'Achiev9', 'J ai les crocs :Gagner en tant que cerbère dans une partie de difficulté 8', 'Niveau Impossible'),
('010', 'Achiev10', 'Chien de Troupeau: Gagner en cerbère avant qu un seul aventurier ne rentre sur le 4ème plateau', 'Niveau Impossible'),
('011', 'Achiev11', 'Plus fort que la mort:Avoir reussi toutes les Réussites Magistrales de jeu', 'Niveau Impossible'),
('012', 'Achiev12', 'Vous ne passerez pas !: Dévorer le dernier Aventurier sur la dernière case du dernier plateau et gagner en tant que cerbère', 'Niveau Difficile'),
('013', 'Achiev13', 'D un cheveu: Gagner entant qu aventurier alors que Cerbère est a moins de 4 cases de la barque', 'Niveau Difficile'),
('014', 'Achiev14', 'Fin négociateur: Réussir à faire payer le coût de la carte favoritisme par 3 autres joueurs ', 'Niveau Difficile'),
('015', 'Achiev15', 'La fin d une amitié : Faire payer le coût de la carte opportinisme à un joueur et reculer au lieu de l avancer', 'Niveau Difficile'),
('016', 'Achiev16', 'Tous pour 1 et 1 pour tous: Reussir à gagner avec la barque à 3 dans une partie à 3 joueurs', 'Niveau Difficile'),
('017', 'Achiev17', 'Oups!:Se faire attraper par cerbère alors qu on a au moins 4 cartes survie en main', 'Niveau Difficile'),
('018', 'Achiev18', 'Tous aux abris !: Tous les aventuriers encore en jeu survivant à une chasse de cerbere de 8 cases', 'Niveau Difficile'),
('019', 'Achiev19', 'La vraie victoire : Reussir a gagner en aventuruier en partant seul(e) avec la barque a 1 place', 'Niveau Difficile'),
('020', 'Achiev20', 'Egoisme total : Reussir a gagner en Aventurier en partant seul(e) avec la barque a 1 place dans une partie avec 5 joueurs ou plus', 'Niveau Difficile'),
('021', 'Achiev21', 'Ca croque sous la dent : Reussir en tant que cerbere a devorer d un coup 2 aventurier ou plus', 'Niveau Difficile'),
('022', 'Achiev22', 'Effet 3 en 1 : Reussir en tant que cerber e a devorer d un coup 3 aventurier ou plus ', 'Niveau Difficile');

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
('001', 'Action_Sup1', 'Piocher_Carte_Recuperer_Carte_Action'),
('002', 'Action_Inf1', 'Voir_Barque_Recuperer_Carte'),
('003', 'Action_Sup2', 'Piocher_Carte_2'),
('004', 'Action_Inf2', 'Piocher_Moi_1_Piocher_Autres_2'),
('005', 'Action_Sup3', 'Avancer_Moi_2'),
('006', 'Action_Inf3', 'Avancer_Autre_2_Avancer_Autre_1'),
('007', 'Action_Sup4', 'Avancer_Moi_2_Avancer_Autre_1'),
('008', 'Action_Inf4', 'Avancer_Autre_2_Avancer_Autre_1'),
('009', 'Survie_Sup1', 'Voir_Barque'),
('010', 'Survie_Inf1', 'Couardise'),
('011', 'Survie_Sup2', 'Avancer_Moi_1_Reculer_Autre_1'),
('012', 'Survie_Inf2', 'Avancer_Moi_1_Avancer_Autre_2'),
('013', 'Survie_Inf2', 'Avancer_Moi_1_Reculer_Autre_2'),
('014', 'Survie_Sup3', 'Avancer_Autre_1_Avancer_Autre_1'),
('015', 'Survie_Inf3', 'Changer_Rage_-1_Avancer_Autre_3'),
('016', 'Survie_Sup4', 'Avancer_Moi_1_Avancer_Autre_1'),
('017', 'Survie_Inf4', 'Avancer_Moi_3_Avancer_Autre_2_Avancer_Autre_1'),
('018', 'Survie_Sup5', 'Reculer_Autre_1_Changer_Rage_-1'),
('019', 'Survie_Inf5', 'Reculer_Autre_2_Changer_Rage_-2'),
('020', 'Survie_Sup6', 'Avancer_Moi_1'),
('021', 'Survie_Inf6', 'Avancer_Moi_2'),
('022', 'Survie_Sup7', 'Reculer_Moi_1'),
('023', 'Survie_Inf7', 'Avancer_Autre_3'),
('024', 'Trahison_Sup1', 'Reculer_Autre_2'),
('025', 'Trahison_Inf1', 'Reculer_Autres3_2'),
('026', 'Trahison_Sup2', 'Changer_Rage_1'),
('027', 'Trahison_Inf2', 'Changer_Vitesse_2'),
('028', 'Trahison_Sup3', 'Defausser_Survie_2'),
('029', 'Trahison_Inf3', 'Defausser_Survie_3'),
('030', 'Trahison_Inf3', 'Reculer_Autre3_2'),
('031', 'Trahison_Sup4', 'Changer_Vitesse_1'),
('032', 'Trahison_Inf4', 'Changer_Rage_2'),
('033', 'Trahison_Sup5', 'Voir_Barque'),
('034', 'Trahison_Inf5', 'Reculer_Autre_-3'),
('035', 'Trahison_Sup6', 'Avancer_Cerbere_1'),
('036', 'Trahison_Inf6', 'Avancer_Cerbere_2'),
('037', 'Cerbère_Sup_1', 'Recuperer_Carte'),
('038', 'Cerbère_Sup_2', 'Changer_Vitesse_1'),
('039', 'Cerbère_Inf_2', 'Piocher_Moi_2_Piocher_Autre_1'),
('040', 'Cerbère_Sup_3', 'Reculer_Survivant3_1'),
('041', 'Cerbère_Inf_3', 'Changer_Rage_1'),
('042', 'Cerbère_Sup_4', 'Avancer_Moi_1'),
('043', 'Cerbère_Inf_4', 'Piocher_Moi_1'),
('050', 'Cerbère_Inf_1', 'Recuperer_Carte_Piocher_Moi_1');




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


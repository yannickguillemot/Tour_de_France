-- -----------------------------------------------------------------------------
--       TABLE : COUREUR
-- -----------------------------------------------------------------------------

ALTER TABLE COUREUR
   (
   ADD CONSTRAINT PK_COUREUR PRIMARY KEY (NUM_COUREUR)  USING INDEX TABLESPACE BD50_IND 
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIE
-- -----------------------------------------------------------------------------

ALTER TABLE CATEGORIE
   (
   ADD CONSTRAINT PK_CATEGORIE PRIMARY KEY (CODE_TYPE, CODE_CATEGORIE)  USING INDEX TABLESPACE BD50_IND 
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : TYPE
-- -----------------------------------------------------------------------------

ALTER TABLE TYPE
   (
   ADD CONSTRAINT PK_TYPE PRIMARY KEY (CODE_TYPE)  USING INDEX TABLESPACE BD50_IND 
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : PARTICIPANT
-- -----------------------------------------------------------------------------

ALTER TABLE PARTICIPANT
   (
   ADD CONSTRAINT PK_PARTICIPANT PRIMARY KEY (NUM_COURSE, NUM_DOSSARD)  USING INDEX TABLESPACE BD50_IND 
   )  ;
   
-- -----------------------------------------------------------------------------
--       TABLE : PAYS
-- -----------------------------------------------------------------------------

ALTER TABLE PAYS
   (
   ADD CONSTRAINT PK_PAYS PRIMARY KEY (CODE_PAYS)  USING INDEX TABLESPACE BD50_IND 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : BAREME
-- -----------------------------------------------------------------------------

ALTER TABLE BAREME
   (
   ADD CONSTRAINT PK_BAREME PRIMARY KEY (CODE_TYPE, CODE_CATEGORIE, PLACE_BAREME)  USING INDEX TABLESPACE BD50_IND 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : POINT_KM
-- -----------------------------------------------------------------------------

ALTER TABLE POINT_KM
   (
   ADD CONSTRAINT PK_POINT_KM PRIMARY KEY (NUM_COURSE, NUM_ETAPE, KM)  USING INDEX TABLESPACE BD50_IND 
   )  ;
   
-- -----------------------------------------------------------------------------
--       TABLE : EQUIPE
-- -----------------------------------------------------------------------------

ALTER TABLE EQUIPE
   (
   ADD CONSTRAINT PK_EQUIPE PRIMARY KEY (NUM_COURSE, CODE_EQUIPE)  USING INDEX TABLESPACE BD50_IND 
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : MEMBRE_JURY
-- -----------------------------------------------------------------------------

ALTER TABLE MEMBRE_JURY
   (
   ADD CONSTRAINT PK_MEMBRE_JURY PRIMARY KEY (NUM_MEMBRE_JURY)  USING INDEX TABLESPACE BD50_IND 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : VILLE
-- -----------------------------------------------------------------------------

ALTER TABLE VILLE
   (
   ADD CONSTRAINT PK_VILLE PRIMARY KEY (CODE_PAYS, CODE_COMMUNE)  USING INDEX TABLESPACE BD50_IND 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : COURSE
-- -----------------------------------------------------------------------------

ALTER TABLE COURSE
   (
   ADD CONSTRAINT PK_COURSE PRIMARY KEY (NUM_COURSE)  USING INDEX TABLESPACE BD50_IND 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : TYPE_ETAPE
-- -----------------------------------------------------------------------------

ALTER TABLE TYPE_ETAPE
   (
   ADD CONSTRAINT PK_TYPE_ETAPE PRIMARY KEY (NUM_TYPE_ETAPE)  USING INDEX TABLESPACE BD50_IND 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : PARTENAIRE
-- -----------------------------------------------------------------------------

ALTER TABLE PARTENAIRE
   (
   ADD CONSTRAINT PK_PARTENAIRE PRIMARY KEY (NUM_PARTENAIRE)  USING INDEX TABLESPACE BD50_IND 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : ETAPE
-- -----------------------------------------------------------------------------

ALTER TABLE ETAPE
   (
   ADD CONSTRAINT PK_ETAPE PRIMARY KEY (NUM_COURSE, NUM_ETAPE)  USING INDEX TABLESPACE BD50_IND 
   )  ;
   
-- -----------------------------------------------------------------------------
--       TABLE : COURIR
-- -----------------------------------------------------------------------------

ALTER TABLE COURIR
   (
   ADD CONSTRAINT PK_COURIR PRIMARY KEY (NUM_DOSSARD, NUM_COURSE, NUM_ETAPE)  USING INDEX TABLESPACE BD50_IND 
   )  ;

-- -----------------------------------------------------------------------------
--       TABLE : FAIRE_PARTIE
-- -----------------------------------------------------------------------------

ALTER TABLE ATTEINDRE
   (
   ADD CONSTRAINT PK_ATTEINDRE PRIMARY KEY (NUM_DOSSARD, NUM_COURSE, NUM_ETAPE, KM)  USING INDEX TABLESPACE BD50_IND 
   )  ;
   
-- -----------------------------------------------------------------------------
--       TABLE : FAIRE_PARTIE
-- -----------------------------------------------------------------------------

ALTER TABLE FAIRE_PARTIE
   (
   ADD CONSTRAINT PK_FAIRE_PARTIE PRIMARY KEY (NUM_COUREUR, NUM_COURSE, CODE_EQUIPE)  USING INDEX TABLESPACE BD50_IND 
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : VOTE_COMBATIF_ETAPE
-- -----------------------------------------------------------------------------

ALTER TABLE VOTE_COMBATIF_ETAPE
   (
   ADD CONSTRAINT PK_VOTE_COMBATIF_ETAPE PRIMARY KEY (NUM_MEMBRE_JURY, NUM_COURSE, NUM_ETAPE)  USING INDEX TABLESPACE BD50_IND 
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : CARAVANE
-- -----------------------------------------------------------------------------

ALTER TABLE CARAVANE
   (
   ADD CONSTRAINT PK_CARAVANE PRIMARY KEY (NUM_COURSE, NUM_PARTENAIRE)  USING INDEX TABLESPACE BD50_IND 
   ) ;

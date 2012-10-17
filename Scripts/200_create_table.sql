-- -----------------------------------------------------------------------------
--       TABLE : COUREUR
-- -----------------------------------------------------------------------------

CREATE TABLE COUREUR
   (
    NUM_COUREUR NUMBER(2)  NOT NULL,
    CODE_PAYS CHAR(2)  NOT NULL,
    NOM_COUREUR VARCHAR2(128)  NOT NULL,
    PRENOM_COUREUR VARCHAR2(128)  NOT NULL,
    DATE_NAISSANCE_COUREUR DATE  NOT NULL,
    TAILLE_COUREUR NUMBER(3)  NULL,
    POIDS_COUREUR NUMBER(3)  NULL,
    VILLE_NAISSANCE_COUREUR VARCHAR2(128)  NULL,
    NOM_PAYS VARCHAR2(128)  NULL
    
   ) ORGANIZATION INDEX;
   
-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIE
-- -----------------------------------------------------------------------------

CREATE TABLE CATEGORIE
   (
    CODE_TYPE CHAR(5)  NOT NULL,
    CODE_CATEGORIE CHAR(5)  NOT NULL,
    LIBELLE_CATEGORIE CHAR(32)  NULL,
    LIBELLE_TYPE VARCHAR2(128)  NULL
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : TYPE
-- -----------------------------------------------------------------------------

CREATE TABLE TYPE
   (
    CODE_TYPE CHAR(5)  NOT NULL,
    LIBELLE_TYPE VARCHAR2(128)  NULL
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : PAYS
-- -----------------------------------------------------------------------------

CREATE TABLE PAYS
   (
    CODE_PAYS CHAR(2)  NOT NULL,
    NOM_PAYS VARCHAR2(128)  NOT NULL
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : BAREME
-- -----------------------------------------------------------------------------

CREATE TABLE BAREME
   (
    CODE_TYPE CHAR(5)  NOT NULL,
    CODE_CATEGORIE CHAR(5)  NOT NULL,
    PLACE_BAREME NUMBER(2)  NOT NULL,
    PTS_MONTAGNE_BAREME NUMBER(2)  NULL,
    PTS_SPRINT_BAREME NUMBER(2)  NULL,
    SEC_BONIF_BAREME NUMBER(2)  NULL
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : EQUIPE
-- -----------------------------------------------------------------------------

CREATE TABLE EQUIPE
   (
    NUM_COURSE NUMBER(4)  NOT NULL,
    CODE_EQUIPE CHAR(3)  NOT NULL,
    NOM_EQUIPE VARCHAR2(128)  NOT NULL,
    DIRECTEUR_SPORTIF_EQUIPE VARCHAR2(128)  NOT NULL,
    BUDGET_EQUIPE NUMBER(2)  NULL
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : MEMBRE_JURY
-- -----------------------------------------------------------------------------

CREATE TABLE MEMBRE_JURY
   (
    NUM_MEMBRE_JURY NUMBER(2)  NOT NULL,
    NOM_MEMBRE_JURY VARCHAR2(128)  NULL,
    PRENOM_MEMBRE_JURY VARCHAR2(128)  NULL
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : VILLE
-- -----------------------------------------------------------------------------

CREATE TABLE VILLE
   (
    CODE_PAYS CHAR(2)  NOT NULL,
    CODE_COMMUNE NUMBER(5)  NOT NULL,
    NOM_VILLE VARCHAR2(128)  NOT NULL,
    NOM_PAYS VARCHAR2(128)  NOT NULL,
    NB_HABITANTS_VILLE NUMBER(8)  NULL,
    REGION_VILLE VARCHAR2(128)  NULL,
    ALTITUDE_VILLE NUMBER(4)  NULL
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : COURSE
-- -----------------------------------------------------------------------------

CREATE TABLE COURSE
   (
    NUM_COURSE NUMBER(4)  NOT NULL,
    NOM_COURSE CHAR(32)  NOT NULL,
    DEBUT_COURSE TIMESTAMP(3)  NULL,
    FIN_COURSE TIMESTAMP(3)  NULL
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : TYPE_ETAPE
-- -----------------------------------------------------------------------------

CREATE TABLE TYPE_ETAPE
   (
    NUM_TYPE_ETAPE NUMBER(2)  NOT NULL,
    LIBELLE_TYPE_ETAPE CHAR(32)  NULL
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : PARTENAIRE
-- -----------------------------------------------------------------------------

CREATE TABLE PARTENAIRE
   (
    NUM_PARTENAIRE NUMBER(4)  NOT NULL,
    NOM_PARTENAIRE VARCHAR2(50)  NOT NULL
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : FAIRE_PARTIE
-- -----------------------------------------------------------------------------

CREATE TABLE FAIRE_PARTIE
   (
    NUM_COUREUR NUMBER(2)  NOT NULL,
    NUM_COURSE NUMBER(4)  NOT NULL,
    CODE_EQUIPE CHAR(3)  NOT NULL,
    DATE_INSCRIPTION_EQUIPE DATE  NULL
   ) ;
   
-- -----------------------------------------------------------------------------
--       TABLE : VOTE_COMBATIF_ETAPE
-- -----------------------------------------------------------------------------

CREATE TABLE VOTE_COMBATIF_ETAPE
   (
    NUM_MEMBRE_JURY NUMBER(2)  NOT NULL,
    NUM_COURSE NUMBER(4)  NOT NULL,
    NUM_ETAPE NUMBER(2)  NOT NULL,
    NUM_DOSSARD NUMBER(3)  NOT NULL
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : CARAVANE
-- -----------------------------------------------------------------------------

CREATE TABLE CARAVANE
   (
    NUM_COURSE NUMBER(4)  NOT NULL,
    NUM_PARTENAIRE NUMBER(4)  NOT NULL
   ) ;
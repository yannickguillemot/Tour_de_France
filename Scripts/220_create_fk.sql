-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COUREUR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COUREUR_PAYS
     ON COUREUR (CODE_PAYS ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CATEGORIE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CATEGORIE_TYPE
     ON CATEGORIE (CODE_TYPE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PARTICIPANT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PARTICIPANT_COUREUR
     ON PARTICIPANT (NUM_COUREUR ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_PARTICIPANT_POINT_KM
     ON PARTICIPANT (NUM_ETAPE ASC, KM ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_PARTICIPANT_COURSE
     ON PARTICIPANT (NUM_COURSE ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_PARTICIPANT_EQUIPE
     ON PARTICIPANT (NUM_COURSE ASC, CODE_EQUIPE ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_PARTICIPANT_EQUIPE1
     ON PARTICIPANT (NUM_COURSE ASC, CODE_EQUIPE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE BAREME
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_BAREME_CATEGORIE
     ON BAREME (CODE_TYPE ASC, CODE_CATEGORIE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE POINT_KM
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_POINT_KM_VILLE
     ON POINT_KM (CODE_PAYS ASC, CODE_COMMUNE ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_POINT_KM_CATEGORIE
     ON POINT_KM (CODE_TYPE ASC, CODE_CATEGORIE ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_POINT_KM_ETAPE
     ON POINT_KM (NUM_COURSE ASC, NUM_ETAPE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE EQUIPE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_EQUIPE_COURSE
     ON EQUIPE (NUM_COURSE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE VILLE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_VILLE_PAYS
     ON VILLE (CODE_PAYS ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ETAPE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ETAPE_COURSE
     ON ETAPE (NUM_COURSE ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_ETAPE_TYPE_ETAPE
     ON ETAPE (NUM_TYPE_ETAPE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COURIR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COURIR_PARTICIPANT
     ON COURIR (NUM_DOSSARD ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_COURIR_ETAPE
     ON COURIR (NUM_COURSE ASC, NUM_ETAPE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ATTEINDRE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ATTEINDRE_PARTICIPANT
     ON ATTEINDRE (NUM_DOSSARD ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_ATTEINDRE_POINT_KM
     ON ATTEINDRE (NUM_COURSE ASC, NUM_ETAPE ASC, KM ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE FAIRE_PARTIE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_FAIRE_PARTIE_COUREUR
     ON FAIRE_PARTIE (NUM_COUREUR ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_FAIRE_PARTIE_EQUIPE
     ON FAIRE_PARTIE (NUM_COURSE ASC, CODE_EQUIPE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE VOTE_COMBATIF_ETAPE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_VOTE_COMBATIF_ETAPE_MEMBR
     ON VOTE_COMBATIF_ETAPE (NUM_MEMBRE_JURY ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOTE_COMBATIF_ETAPE_PARTI
     ON VOTE_COMBATIF_ETAPE (NUM_DOSSARD ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_VOTE_COMBATIF_ETAPE_ETAPE
     ON VOTE_COMBATIF_ETAPE (NUM_COURSE ASC, NUM_ETAPE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CARAVANE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CARAVANE_COURSE
     ON CARAVANE (NUM_COURSE ASC)
   
   TABLESPACE BD50_IND ;

CREATE  INDEX I_FK_CARAVANE_PARTENAIRE
     ON CARAVANE (NUM_PARTENAIRE ASC)
   
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE COUREUR ADD (
     CONSTRAINT FK_COUREUR_PAYS
          FOREIGN KEY (CODE_PAYS)
               REFERENCES PAYS (CODE_PAYS)) ;

ALTER TABLE CATEGORIE ADD (
     CONSTRAINT FK_CATEGORIE_TYPE
          FOREIGN KEY (CODE_TYPE)
               REFERENCES TYPE (CODE_TYPE)) ;

ALTER TABLE PARTICIPANT ADD (
     CONSTRAINT FK_PARTICIPANT_COUREUR
          FOREIGN KEY (NUM_COUREUR)
               REFERENCES COUREUR (NUM_COUREUR)) ;

ALTER TABLE PARTICIPANT ADD (
     CONSTRAINT FK_PARTICIPANT_POINT_KM
          FOREIGN KEY (NUM_COURSE, NUM_ETAPE, KM)
               REFERENCES POINT_KM (NUM_COURSE, NUM_ETAPE, KM)) ;

ALTER TABLE PARTICIPANT ADD (
     CONSTRAINT FK_PARTICIPANT_COURSE
          FOREIGN KEY (NUM_COURSE)
               REFERENCES COURSE (NUM_COURSE)) ;

ALTER TABLE PARTICIPANT ADD (
     CONSTRAINT FK_PARTICIPANT_EQUIPE
          FOREIGN KEY (NUM_COURSE, CODE_EQUIPE)
               REFERENCES EQUIPE (NUM_COURSE, CODE_EQUIPE)) ;

ALTER TABLE PARTICIPANT ADD (
     CONSTRAINT FK_PARTICIPANT_EQUIPE1
          FOREIGN KEY (NUM_COURSE, CODE_EQUIPE)
               REFERENCES EQUIPE (NUM_COURSE, CODE_EQUIPE)) ;

ALTER TABLE BAREME ADD (
     CONSTRAINT FK_BAREME_CATEGORIE
          FOREIGN KEY (CODE_TYPE, CODE_CATEGORIE)
               REFERENCES CATEGORIE (CODE_TYPE, CODE_CATEGORIE)) ;

ALTER TABLE POINT_KM ADD (
     CONSTRAINT FK_POINT_KM_VILLE
          FOREIGN KEY (CODE_PAYS, CODE_COMMUNE)
               REFERENCES VILLE (CODE_PAYS, CODE_COMMUNE)) ;

ALTER TABLE POINT_KM ADD (
     CONSTRAINT FK_POINT_KM_CATEGORIE
          FOREIGN KEY (CODE_TYPE, CODE_CATEGORIE)
               REFERENCES CATEGORIE (CODE_TYPE, CODE_CATEGORIE)) ;

ALTER TABLE POINT_KM ADD (
     CONSTRAINT FK_POINT_KM_ETAPE
          FOREIGN KEY (NUM_COURSE, NUM_ETAPE)
               REFERENCES ETAPE (NUM_COURSE, NUM_ETAPE)) ;

ALTER TABLE EQUIPE ADD (
     CONSTRAINT FK_EQUIPE_COURSE
          FOREIGN KEY (NUM_COURSE)
               REFERENCES COURSE (NUM_COURSE)) ;

ALTER TABLE VILLE ADD (
     CONSTRAINT FK_VILLE_PAYS
          FOREIGN KEY (CODE_PAYS)
               REFERENCES PAYS (CODE_PAYS)) ;

ALTER TABLE ETAPE ADD (
     CONSTRAINT FK_ETAPE_COURSE
          FOREIGN KEY (NUM_COURSE)
               REFERENCES COURSE (NUM_COURSE)) ;

ALTER TABLE ETAPE ADD (
     CONSTRAINT FK_ETAPE_TYPE_ETAPE
          FOREIGN KEY (NUM_TYPE_ETAPE)
               REFERENCES TYPE_ETAPE (NUM_TYPE_ETAPE));

ALTER TABLE COURIR ADD (
     CONSTRAINT FK_COURIR_PARTICIPANT
          FOREIGN KEY (NUM_COURSE, NUM_DOSSARD)
               REFERENCES PARTICIPANT (NUM_COURSE, NUM_DOSSARD)) ;

ALTER TABLE COURIR ADD (
     CONSTRAINT FK_COURIR_ETAPE
          FOREIGN KEY (NUM_COURSE, NUM_ETAPE)
               REFERENCES ETAPE (NUM_COURSE, NUM_ETAPE)) ;

ALTER TABLE ATTEINDRE ADD (
     CONSTRAINT FK_ATTEINDRE_PARTICIPANT
          FOREIGN KEY (NUM_COURSE, NUM_DOSSARD)
               REFERENCES PARTICIPANT (NUM_COURSE, NUM_DOSSARD)) ;

ALTER TABLE ATTEINDRE ADD (
     CONSTRAINT FK_ATTEINDRE_POINT_KM
          FOREIGN KEY (NUM_COURSE, NUM_ETAPE, KM)
               REFERENCES POINT_KM (NUM_COURSE, NUM_ETAPE, KM)) ;

ALTER TABLE FAIRE_PARTIE ADD (
     CONSTRAINT FK_FAIRE_PARTIE_COUREUR
          FOREIGN KEY (NUM_COUREUR)
               REFERENCES COUREUR (NUM_COUREUR)) ;

ALTER TABLE FAIRE_PARTIE ADD (
     CONSTRAINT FK_FAIRE_PARTIE_EQUIPE
          FOREIGN KEY (NUM_COURSE, CODE_EQUIPE)
               REFERENCES EQUIPE (NUM_COURSE, CODE_EQUIPE)) ;

ALTER TABLE VOTE_COMBATIF_ETAPE ADD (
     CONSTRAINT FK_VOTE_COMBATIF_ETAPE_MEMBRE_
          FOREIGN KEY (NUM_MEMBRE_JURY)
               REFERENCES MEMBRE_JURY (NUM_MEMBRE_JURY)) ;

ALTER TABLE VOTE_COMBATIF_ETAPE ADD (
     CONSTRAINT FK_VOTE_COMBATIF_ETAPE_PARTICI
          FOREIGN KEY (NUM_COURSE, NUM_DOSSARD)
               REFERENCES PARTICIPANT (NUM_COURSE, NUM_DOSSARD)) ;

ALTER TABLE VOTE_COMBATIF_ETAPE ADD (
     CONSTRAINT FK_VOTE_COMBATIF_ETAPE_ETAPE
          FOREIGN KEY (NUM_COURSE, NUM_ETAPE)
               REFERENCES ETAPE (NUM_COURSE, NUM_ETAPE)) ;

ALTER TABLE CARAVANE ADD (
     CONSTRAINT FK_CARAVANE_COURSE
          FOREIGN KEY (NUM_COURSE)
               REFERENCES COURSE (NUM_COURSE)) ;

ALTER TABLE CARAVANE ADD (
     CONSTRAINT FK_CARAVANE_PARTENAIRE
          FOREIGN KEY (NUM_PARTENAIRE)
               REFERENCES PARTENAIRE (NUM_PARTENAIRE)) ;
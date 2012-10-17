-- ------------------------------------------------------------------------------- 
--   Génération des triggers de la base 
--   de données : Course__
--   (31/5/2012 21:58:19)
-- ------------------------------------------------------------------------------- 

-- ------------------------------------------------------------------------------- 
--   Table : COUREUR
-- ------------------------------------------------------------------------------- 

drop trigger TD_COUREUR;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_COUREUR
after delete on COUREUR for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table FAIRE_PARTIE.

     delete from FAIRE_PARTIE
     where
          FAIRE_PARTIE.NUM_COUREUR = :old.NUM_COUREUR;
     -- Interdire la suppression d'une occurrence de COUREUR s'il existe des
     -- occurrences correspondantes de la table PARTICIPANT.

     select count(*) into numrows
     from PARTICIPANT
     where
          PARTICIPANT.NUM_COUREUR = :old.NUM_COUREUR;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "COUREUR". Des occurrences de "PARTICIPANT" existent.');
     end if;

end;
/

drop trigger TU_COUREUR;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_COUREUR
after update on COUREUR for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table COUREUR s'il n'existe pas d'occurrence correspondante de la 
     -- table PAYS.

     if
          :old.NUM_COUREUR <> :new.NUM_COUREUR
     then
          select count(*) into numrows
          from PAYS
          where
               :new.CODE_PAYS = PAYS.CODE_PAYS;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "COUREUR" car "PAYS" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de COUREUR sur les 
     -- occurrences correspondantes de la table FAIRE_PARTIE.

     if
          :old.NUM_COUREUR <> :new.NUM_COUREUR
     then
          update FAIRE_PARTIE
          set
               FAIRE_PARTIE.NUM_COUREUR = :new.NUM_COUREUR
          where
               FAIRE_PARTIE.NUM_COUREUR = :old.NUM_COUREUR;
     end if;
     -- Répercuter la modification de la clé primaire de COUREUR sur les 
     -- occurrences correspondantes de la table PARTICIPANT.

     if
          :old.NUM_COUREUR <> :new.NUM_COUREUR
     then
          update PARTICIPANT
          set
               PARTICIPANT.NUM_COUREUR = :new.NUM_COUREUR
          where
               PARTICIPANT.NUM_COUREUR = :old.NUM_COUREUR;
     end if;

end;
/

drop trigger TI_COUREUR;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_COUREUR
after insert on COUREUR for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de COUREUR 
     -- s'il n'existe pas d'occurrence correspondante dans la table PAYS.

     select count(*) into numrows
     from PAYS
     where
          :new.CODE_PAYS = PAYS.CODE_PAYS;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "COUREUR" car "PAYS" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : CATEGORIE
-- ------------------------------------------------------------------------------- 

drop trigger TD_CATEGORIE;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_CATEGORIE
after delete on CATEGORIE for each row
declare numrows INTEGER;
begin

     -- Mettre à NULL la clé étrangère des occurrences correspondantes de la
     -- table POINT_KM.

     update POINT_KM
     set
          POINT_KM.CODE_TYPE = NULL,
          POINT_KM.CODE_CATEGORIE = NULL
     where
          POINT_KM.CODE_TYPE = :old.CODE_TYPE and
          POINT_KM.CODE_CATEGORIE = :old.CODE_CATEGORIE;
     -- Interdire la suppression d'une occurrence de CATEGORIE s'il existe des
     -- occurrences correspondantes de la table BAREME.

     select count(*) into numrows
     from BAREME
     where
          BAREME.CODE_TYPE = :old.CODE_TYPE and
          BAREME.CODE_CATEGORIE = :old.CODE_CATEGORIE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "CATEGORIE". Des occurrences de "BAREME" existent.');
     end if;

end;
/

drop trigger TU_CATEGORIE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_CATEGORIE
after update on CATEGORIE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- TYPE.

     if
          :old.CODE_TYPE <> :new.CODE_TYPE or 
          :old.CODE_CATEGORIE <> :new.CODE_CATEGORIE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "TYPE" interdite.');
     end if;
     -- Répercuter la modification de la clé primaire de CATEGORIE sur les 
     -- occurrences correspondantes de la table POINT_KM.

     if
          :old.CODE_TYPE <> :new.CODE_TYPE or 
          :old.CODE_CATEGORIE <> :new.CODE_CATEGORIE
     then
          update POINT_KM
          set
               POINT_KM.CODE_TYPE = :new.CODE_TYPE,
               POINT_KM.CODE_CATEGORIE = :new.CODE_CATEGORIE
          where
               POINT_KM.CODE_TYPE = :old.CODE_TYPE and
               POINT_KM.CODE_CATEGORIE = :old.CODE_CATEGORIE;
     end if;
     -- Répercuter la modification de la clé primaire de CATEGORIE sur les 
     -- occurrences correspondantes de la table BAREME.

     if
          :old.CODE_TYPE <> :new.CODE_TYPE or 
          :old.CODE_CATEGORIE <> :new.CODE_CATEGORIE
     then
          update BAREME
          set
               BAREME.CODE_TYPE = :new.CODE_TYPE,
               BAREME.CODE_CATEGORIE = :new.CODE_CATEGORIE
          where
               BAREME.CODE_TYPE = :old.CODE_TYPE and
               BAREME.CODE_CATEGORIE = :old.CODE_CATEGORIE;
     end if;

end;
/

drop trigger TI_CATEGORIE;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_CATEGORIE
after insert on CATEGORIE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de CATEGORIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table TYPE.

     select count(*) into numrows
     from TYPE
     where
          :new.CODE_TYPE = TYPE.CODE_TYPE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "CATEGORIE" car "TYPE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : TYPE
-- ------------------------------------------------------------------------------- 

drop trigger TD_TYPE;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_TYPE
after delete on TYPE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de TYPE s'il existe des
     -- occurrences correspondantes de la table CATEGORIE.

     select count(*) into numrows
     from CATEGORIE
     where
          CATEGORIE.CODE_TYPE = :old.CODE_TYPE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "TYPE". Des occurrences de "CATEGORIE" existent.');
     end if;

end;
/

drop trigger TU_TYPE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_TYPE
after update on TYPE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de TYPE sur les 
     -- occurrences correspondantes de la table CATEGORIE.

     if
          :old.CODE_TYPE <> :new.CODE_TYPE
     then
          update CATEGORIE
          set
               CATEGORIE.CODE_TYPE = :new.CODE_TYPE
          where
               CATEGORIE.CODE_TYPE = :old.CODE_TYPE;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : PARTICIPANT
-- ------------------------------------------------------------------------------- 

DROP TRIGGER TI_PARTICIPANT_COURIR;

CREATE OR REPLACE TRIGGER TI_PARTICIPANT_COURIR 
AFTER INSERT ON PARTICIPANT 
FOR EACH ROW
BEGIN
  INSERT INTO COURIR
  VALUES (:new.NUM_DOSSARD, :new.NUM_COURSE, 1, NULL, 0, 0);
END;

drop trigger TD_PARTICIPANT;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_PARTICIPANT
after delete on PARTICIPANT for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table COURIR.

     delete from COURIR
     where
          COURIR.NUM_COURSE = :old.NUM_COURSE and
          COURIR.NUM_DOSSARD = :old.NUM_DOSSARD;
     -- Supprimer les occurrences correspondantes de la table ATTEINDRE.

     delete from ATTEINDRE
     where
          ATTEINDRE.NUM_COURSE = :old.NUM_COURSE and
          ATTEINDRE.NUM_DOSSARD = :old.NUM_DOSSARD;
     -- Supprimer les occurrences correspondantes de la table VOTE_COMBATIF_ETAPE.

     delete from VOTE_COMBATIF_ETAPE
     where
          VOTE_COMBATIF_ETAPE.NUM_COURSE = :old.NUM_COURSE and
          VOTE_COMBATIF_ETAPE.NUM_DOSSARD = :old.NUM_DOSSARD;

end;
/

drop trigger TU_PARTICIPANT;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_PARTICIPANT
after update on PARTICIPANT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table PARTICIPANT s'il n'existe pas d'occurrence correspondante de la 
     -- table COUREUR.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD
     then
          select count(*) into numrows
          from COUREUR
          where
               :new.NUM_COUREUR = COUREUR.NUM_COUREUR;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "PARTICIPANT" car "COUREUR" n''existe pas.');
          end if;
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- COURSE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "COURSE" interdite.');
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table PARTICIPANT s'il n'existe pas d'occurrence correspondante de la 
     -- table EQUIPE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD
     then
          select count(*) into numrows
          from EQUIPE
          where
               :new.NUM_COURSE = EQUIPE.NUM_COURSE and
               :new.CODE_EQUIPE = EQUIPE.CODE_EQUIPE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "PARTICIPANT" car "EQUIPE" n''existe pas.');
          end if;
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table PARTICIPANT s'il n'existe pas d'occurrence correspondante de la 
     -- table EQUIPE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD
     then
          select count(*) into numrows
          from EQUIPE
          where
               :new.NUM_COURSE = EQUIPE.NUM_COURSE and
               :new.CODE_EQUIPE = EQUIPE.CODE_EQUIPE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "PARTICIPANT" car "EQUIPE" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de PARTICIPANT sur les 
     -- occurrences correspondantes de la table COURIR.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD
     then
          update COURIR
          set
               COURIR.NUM_COURSE = :new.NUM_COURSE,
               COURIR.NUM_DOSSARD = :new.NUM_DOSSARD
          where
               COURIR.NUM_COURSE = :old.NUM_COURSE and
               COURIR.NUM_DOSSARD = :old.NUM_DOSSARD;
     end if;
     -- Répercuter la modification de la clé primaire de PARTICIPANT sur les 
     -- occurrences correspondantes de la table ATTEINDRE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD
     then
          update ATTEINDRE
          set
               ATTEINDRE.NUM_COURSE = :new.NUM_COURSE,
               ATTEINDRE.NUM_DOSSARD = :new.NUM_DOSSARD
          where
               ATTEINDRE.NUM_COURSE = :old.NUM_COURSE and
               ATTEINDRE.NUM_DOSSARD = :old.NUM_DOSSARD;
     end if;
     -- Répercuter la modification de la clé primaire de PARTICIPANT sur les 
     -- occurrences correspondantes de la table VOTE_COMBATIF_ETAPE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD
     then
          update VOTE_COMBATIF_ETAPE
          set
               VOTE_COMBATIF_ETAPE.NUM_COURSE = :new.NUM_COURSE,
               VOTE_COMBATIF_ETAPE.NUM_DOSSARD = :new.NUM_DOSSARD
          where
               VOTE_COMBATIF_ETAPE.NUM_COURSE = :old.NUM_COURSE and
               VOTE_COMBATIF_ETAPE.NUM_DOSSARD = :old.NUM_DOSSARD;
     end if;

end;
/

drop trigger TI_PARTICIPANT;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_PARTICIPANT
before insert on PARTICIPANT for each row
declare numrows INTEGER;
begin
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PARTICIPANT 
     -- s'il n'existe pas d'occurrence correspondante dans la table COUREUR.

     select count(*) into numrows
     from COUREUR
     where
          :new.NUM_COUREUR = COUREUR.NUM_COUREUR;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PARTICIPANT" car "COUREUR" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PARTICIPANT 
     -- s'il n'existe pas d'occurrence correspondante dans la table POINT_KM.

     select count(*) into numrows
     from POINT_KM
     where
          :new.NUM_COURSE = POINT_KM.NUM_COURSE and
          :new.NUM_ETAPE = POINT_KM.NUM_ETAPE and
          :new.KM = POINT_KM.KM;
     if 
          (
          :new.NUM_COURSE is not null and
          :new.NUM_ETAPE is not null and
          :new.KM is not null and
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PARTICIPANT" car "POINT_KM" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PARTICIPANT 
     -- s'il n'existe pas d'occurrence correspondante dans la table COURSE.

     select count(*) into numrows
     from COURSE
     where
          :new.NUM_COURSE = COURSE.NUM_COURSE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PARTICIPANT" car "COURSE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PARTICIPANT 
     -- s'il n'existe pas d'occurrence correspondante dans la table EQUIPE.

     select count(*) into numrows
     from EQUIPE
     where
          :new.NUM_COURSE = EQUIPE.NUM_COURSE and
          :new.CODE_EQUIPE = EQUIPE.CODE_EQUIPE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PARTICIPANT" car "EQUIPE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PARTICIPANT 
     -- s'il n'existe pas d'occurrence correspondante dans la table EQUIPE.

     select count(*) into numrows
     from EQUIPE
     where
          :new.NUM_COURSE = EQUIPE.NUM_COURSE and
          :new.CODE_EQUIPE = EQUIPE.CODE_EQUIPE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PARTICIPANT" car "EQUIPE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : PAYS
-- ------------------------------------------------------------------------------- 

drop trigger TD_PAYS;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_PAYS
after delete on PAYS for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de PAYS s'il existe des
     -- occurrences correspondantes de la table COUREUR.

     select count(*) into numrows
     from COUREUR
     where
          COUREUR.CODE_PAYS = :old.CODE_PAYS;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PAYS". Des occurrences de "COUREUR" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de PAYS s'il existe des
     -- occurrences correspondantes de la table VILLE.

     select count(*) into numrows
     from VILLE
     where
          VILLE.CODE_PAYS = :old.CODE_PAYS;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "PAYS". Des occurrences de "VILLE" existent.');
     end if;

end;
/

drop trigger TU_PAYS;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_PAYS
after update on PAYS for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de PAYS sur les 
     -- occurrences correspondantes de la table COUREUR.

     if
          :old.CODE_PAYS <> :new.CODE_PAYS
     then
          update COUREUR
          set
               COUREUR.CODE_PAYS = :new.CODE_PAYS
          where
               COUREUR.CODE_PAYS = :old.CODE_PAYS;
     end if;
     -- Répercuter la modification de la clé primaire de PAYS sur les 
     -- occurrences correspondantes de la table VILLE.

     if
          :old.CODE_PAYS <> :new.CODE_PAYS
     then
          update VILLE
          set
               VILLE.CODE_PAYS = :new.CODE_PAYS
          where
               VILLE.CODE_PAYS = :old.CODE_PAYS;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : BAREME
-- ------------------------------------------------------------------------------- 

drop trigger TU_BAREME;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_BAREME
after update on BAREME for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- CATEGORIE.

     if
          :old.CODE_TYPE <> :new.CODE_TYPE or 
          :old.CODE_CATEGORIE <> :new.CODE_CATEGORIE or 
          :old.PLACE_BAREME <> :new.PLACE_BAREME
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CATEGORIE" interdite.');
     end if;

end;
/

drop trigger TI_BAREME;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_BAREME
after insert on BAREME for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de BAREME 
     -- s'il n'existe pas d'occurrence correspondante dans la table CATEGORIE.

     select count(*) into numrows
     from CATEGORIE
     where
          :new.CODE_TYPE = CATEGORIE.CODE_TYPE and
          :new.CODE_CATEGORIE = CATEGORIE.CODE_CATEGORIE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "BAREME" car "CATEGORIE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : POINT_KM
-- ------------------------------------------------------------------------------- 

drop trigger TD_POINT_KM;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_POINT_KM
after delete on POINT_KM for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table ATTEINDRE.

     delete from ATTEINDRE
     where
          ATTEINDRE.NUM_COURSE = :old.NUM_COURSE and
          ATTEINDRE.NUM_ETAPE = :old.NUM_ETAPE and
          ATTEINDRE.KM = :old.KM;
     -- Mettre à NULL la clé étrangère des occurrences correspondantes de la
     -- table PARTICIPANT.

     update PARTICIPANT
     set
          PARTICIPANT.NUM_COURSE = NULL,
          PARTICIPANT.NUM_ETAPE = NULL,
          PARTICIPANT.KM = NULL
     where
          PARTICIPANT.NUM_COURSE = :old.NUM_COURSE and
          PARTICIPANT.NUM_ETAPE = :old.NUM_ETAPE and
          PARTICIPANT.KM = :old.KM;

end;
/

drop trigger TU_POINT_KM;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_POINT_KM
after update on POINT_KM for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- ETAPE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE or 
          :old.KM <> :new.KM
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "ETAPE" interdite.');
     end if;
     -- Répercuter la modification de la clé primaire de POINT_KM sur les 
     -- occurrences correspondantes de la table ATTEINDRE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE or 
          :old.KM <> :new.KM
     then
          update ATTEINDRE
          set
               ATTEINDRE.NUM_COURSE = :new.NUM_COURSE,
               ATTEINDRE.NUM_ETAPE = :new.NUM_ETAPE,
               ATTEINDRE.KM = :new.KM
          where
               ATTEINDRE.NUM_COURSE = :old.NUM_COURSE and
               ATTEINDRE.NUM_ETAPE = :old.NUM_ETAPE and
               ATTEINDRE.KM = :old.KM;
     end if;
     -- Répercuter la modification de la clé primaire de POINT_KM sur les 
     -- occurrences correspondantes de la table PARTICIPANT.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE or 
          :old.KM <> :new.KM
     then
          update PARTICIPANT
          set
               PARTICIPANT.NUM_COURSE = :new.NUM_COURSE,
               PARTICIPANT.NUM_ETAPE = :new.NUM_ETAPE,
               PARTICIPANT.KM = :new.KM
          where
               PARTICIPANT.NUM_COURSE = :old.NUM_COURSE and
               PARTICIPANT.NUM_ETAPE = :old.NUM_ETAPE and
               PARTICIPANT.KM = :old.KM;
     end if;

end;
/

drop trigger TI_POINT_KM;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_POINT_KM
after insert on POINT_KM for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de POINT_KM 
     -- s'il n'existe pas d'occurrence correspondante dans la table VILLE.

     select count(*) into numrows
     from VILLE
     where
          :new.CODE_PAYS = VILLE.CODE_PAYS and
          :new.CODE_COMMUNE = VILLE.CODE_COMMUNE;
     if 
          (
          :new.CODE_PAYS is not null and
          :new.CODE_COMMUNE is not null and
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "POINT_KM" car "VILLE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de POINT_KM 
     -- s'il n'existe pas d'occurrence correspondante dans la table CATEGORIE.

     select count(*) into numrows
     from CATEGORIE
     where
          :new.CODE_TYPE = CATEGORIE.CODE_TYPE and
          :new.CODE_CATEGORIE = CATEGORIE.CODE_CATEGORIE;
     if 
          (
          :new.CODE_TYPE is not null and
          :new.CODE_CATEGORIE is not null and
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "POINT_KM" car "CATEGORIE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de POINT_KM 
     -- s'il n'existe pas d'occurrence correspondante dans la table ETAPE.

     select count(*) into numrows
     from ETAPE
     where
          :new.NUM_COURSE = ETAPE.NUM_COURSE and
          :new.NUM_ETAPE = ETAPE.NUM_ETAPE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "POINT_KM" car "ETAPE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : EQUIPE
-- ------------------------------------------------------------------------------- 

drop trigger TD_EQUIPE;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_EQUIPE
after delete on EQUIPE for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table FAIRE_PARTIE.

     delete from FAIRE_PARTIE
     where
          FAIRE_PARTIE.NUM_COURSE = :old.NUM_COURSE and
          FAIRE_PARTIE.CODE_EQUIPE = :old.CODE_EQUIPE;
     -- Interdire la suppression d'une occurrence de EQUIPE s'il existe des
     -- occurrences correspondantes de la table PARTICIPANT.

     select count(*) into numrows
     from PARTICIPANT
     where
          PARTICIPANT.NUM_COURSE = :old.NUM_COURSE and
          PARTICIPANT.CODE_EQUIPE = :old.CODE_EQUIPE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "EQUIPE". Des occurrences de "PARTICIPANT" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de EQUIPE s'il existe des
     -- occurrences correspondantes de la table PARTICIPANT.

     select count(*) into numrows
     from PARTICIPANT
     where
          PARTICIPANT.NUM_COURSE = :old.NUM_COURSE and
          PARTICIPANT.CODE_EQUIPE = :old.CODE_EQUIPE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "EQUIPE". Des occurrences de "PARTICIPANT" existent.');
     end if;

end;
/

drop trigger TU_EQUIPE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_EQUIPE
after update on EQUIPE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- COURSE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.CODE_EQUIPE <> :new.CODE_EQUIPE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "COURSE" interdite.');
     end if;
     -- Répercuter la modification de la clé primaire de EQUIPE sur les 
     -- occurrences correspondantes de la table FAIRE_PARTIE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.CODE_EQUIPE <> :new.CODE_EQUIPE
     then
          update FAIRE_PARTIE
          set
               FAIRE_PARTIE.NUM_COURSE = :new.NUM_COURSE,
               FAIRE_PARTIE.CODE_EQUIPE = :new.CODE_EQUIPE
          where
               FAIRE_PARTIE.NUM_COURSE = :old.NUM_COURSE and
               FAIRE_PARTIE.CODE_EQUIPE = :old.CODE_EQUIPE;
     end if;
     -- Ne pas modifier la clé primaire de la table EQUIPE s'il existe des 
     -- occurrences correspondantes dans la table PARTICIPANT.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.CODE_EQUIPE <> :new.CODE_EQUIPE
     then
          select count(*) into numrows
          from PARTICIPANT
          where
               PARTICIPANT.NUM_COURSE = :old.NUM_COURSE and
               PARTICIPANT.CODE_EQUIPE = :old.CODE_EQUIPE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "EQUIPE" car "PARTICIPANT" existe.');
          end if;
     end if;
     -- Ne pas modifier la clé primaire de la table EQUIPE s'il existe des 
     -- occurrences correspondantes dans la table PARTICIPANT.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.CODE_EQUIPE <> :new.CODE_EQUIPE
     then
          select count(*) into numrows
          from PARTICIPANT
          where
               PARTICIPANT.NUM_COURSE = :old.NUM_COURSE and
               PARTICIPANT.CODE_EQUIPE = :old.CODE_EQUIPE;
          if (numrows > 0)
          then 
               raise_application_error(
                    -20005,
                    'Impossible de modifier "EQUIPE" car "PARTICIPANT" existe.');
          end if;
     end if;

end;
/

drop trigger TI_EQUIPE;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_EQUIPE
after insert on EQUIPE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de EQUIPE 
     -- s'il n'existe pas d'occurrence correspondante dans la table COURSE.

     select count(*) into numrows
     from COURSE
     where
          :new.NUM_COURSE = COURSE.NUM_COURSE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "EQUIPE" car "COURSE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : MEMBRE_JURY
-- ------------------------------------------------------------------------------- 

drop trigger TD_MEMBRE_JURY;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_MEMBRE_JURY
after delete on MEMBRE_JURY for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table VOTE_COMBATIF_ETAPE.

     delete from VOTE_COMBATIF_ETAPE
     where
          VOTE_COMBATIF_ETAPE.NUM_MEMBRE_JURY = :old.NUM_MEMBRE_JURY;

end;
/

drop trigger TU_MEMBRE_JURY;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_MEMBRE_JURY
after update on MEMBRE_JURY for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de MEMBRE_JURY sur les 
     -- occurrences correspondantes de la table VOTE_COMBATIF_ETAPE.

     if
          :old.NUM_MEMBRE_JURY <> :new.NUM_MEMBRE_JURY
     then
          update VOTE_COMBATIF_ETAPE
          set
               VOTE_COMBATIF_ETAPE.NUM_MEMBRE_JURY = :new.NUM_MEMBRE_JURY
          where
               VOTE_COMBATIF_ETAPE.NUM_MEMBRE_JURY = :old.NUM_MEMBRE_JURY;
     end if;

end;
/

-- Trigger d'insertion ----------------------------------------------
create or REPLACE trigger TI_MEMBRE_JURY
BEFORE insert on MEMBRE_JURY FOR EACH ROW
begin
	SELECT sq_membre_jury.NEXTVAL INTO :new.NUM_MEMBRE_JURY FROM DUAL;
end;
/

-- ------------------------------------------------------------------------------- 
--   Table : VILLE
-- ------------------------------------------------------------------------------- 

drop trigger TD_VILLE;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_VILLE
after delete on VILLE for each row
declare numrows INTEGER;
begin

     -- Mettre à NULL la clé étrangère des occurrences correspondantes de la
     -- table POINT_KM.

     update POINT_KM
     set
          POINT_KM.CODE_PAYS = NULL,
          POINT_KM.CODE_COMMUNE = NULL
     where
          POINT_KM.CODE_PAYS = :old.CODE_PAYS and
          POINT_KM.CODE_COMMUNE = :old.CODE_COMMUNE;

end;
/

drop trigger TU_VILLE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_VILLE
after update on VILLE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- PAYS.

     if
          :old.CODE_PAYS <> :new.CODE_PAYS or 
          :old.CODE_COMMUNE <> :new.CODE_COMMUNE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "PAYS" interdite.');
     end if;
     -- Répercuter la modification de la clé primaire de VILLE sur les 
     -- occurrences correspondantes de la table POINT_KM.

     if
          :old.CODE_PAYS <> :new.CODE_PAYS or 
          :old.CODE_COMMUNE <> :new.CODE_COMMUNE
     then
          update POINT_KM
          set
               POINT_KM.CODE_PAYS = :new.CODE_PAYS,
               POINT_KM.CODE_COMMUNE = :new.CODE_COMMUNE
          where
               POINT_KM.CODE_PAYS = :old.CODE_PAYS and
               POINT_KM.CODE_COMMUNE = :old.CODE_COMMUNE;
     end if;

end;
/

drop trigger TI_VILLE;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_VILLE
after insert on VILLE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VILLE 
     -- s'il n'existe pas d'occurrence correspondante dans la table PAYS.

     select count(*) into numrows
     from PAYS
     where
          :new.CODE_PAYS = PAYS.CODE_PAYS;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VILLE" car "PAYS" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : COURSE
-- ------------------------------------------------------------------------------- 

drop trigger TD_COURSE;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_COURSE
after delete on COURSE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de COURSE s'il existe des
     -- occurrences correspondantes de la table ETAPE.

     select count(*) into numrows
     from ETAPE
     where
          ETAPE.NUM_COURSE = :old.NUM_COURSE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "COURSE". Des occurrences de "ETAPE" existent.');
     end if;
     -- Supprimer les occurrences correspondantes de la table CARAVANE.

     delete from CARAVANE
     where
          CARAVANE.NUM_COURSE = :old.NUM_COURSE;
     -- Interdire la suppression d'une occurrence de COURSE s'il existe des
     -- occurrences correspondantes de la table EQUIPE.

     select count(*) into numrows
     from EQUIPE
     where
          EQUIPE.NUM_COURSE = :old.NUM_COURSE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "COURSE". Des occurrences de "EQUIPE" existent.');
     end if;
     -- Interdire la suppression d'une occurrence de COURSE s'il existe des
     -- occurrences correspondantes de la table PARTICIPANT.

     select count(*) into numrows
     from PARTICIPANT
     where
          PARTICIPANT.NUM_COURSE = :old.NUM_COURSE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "COURSE". Des occurrences de "PARTICIPANT" existent.');
     end if;

end;
/

drop trigger TU_COURSE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_COURSE
after update on COURSE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de COURSE sur les 
     -- occurrences correspondantes de la table ETAPE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE
     then
          update ETAPE
          set
               ETAPE.NUM_COURSE = :new.NUM_COURSE
          where
               ETAPE.NUM_COURSE = :old.NUM_COURSE;
     end if;
     -- Répercuter la modification de la clé primaire de COURSE sur les 
     -- occurrences correspondantes de la table CARAVANE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE
     then
          update CARAVANE
          set
               CARAVANE.NUM_COURSE = :new.NUM_COURSE
          where
               CARAVANE.NUM_COURSE = :old.NUM_COURSE;
     end if;
     -- Répercuter la modification de la clé primaire de COURSE sur les 
     -- occurrences correspondantes de la table EQUIPE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE
     then
          update EQUIPE
          set
               EQUIPE.NUM_COURSE = :new.NUM_COURSE
          where
               EQUIPE.NUM_COURSE = :old.NUM_COURSE;
     end if;
     -- Répercuter la modification de la clé primaire de COURSE sur les 
     -- occurrences correspondantes de la table PARTICIPANT.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE
     then
          update PARTICIPANT
          set
               PARTICIPANT.NUM_COURSE = :new.NUM_COURSE
          where
               PARTICIPANT.NUM_COURSE = :old.NUM_COURSE;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : TYPE_ETAPE
-- ------------------------------------------------------------------------------- 

drop trigger TD_TYPE_ETAPE;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_TYPE_ETAPE
after delete on TYPE_ETAPE for each row
declare numrows INTEGER;
begin

     -- Mettre à NULL la clé étrangère des occurrences correspondantes de la
     -- table ETAPE.

     update ETAPE
     set
          ETAPE.NUM_TYPE_ETAPE = NULL
     where
          ETAPE.NUM_TYPE_ETAPE = :old.NUM_TYPE_ETAPE;

end;
/

drop trigger TU_TYPE_ETAPE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_TYPE_ETAPE
after update on TYPE_ETAPE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de TYPE_ETAPE sur les 
     -- occurrences correspondantes de la table ETAPE.

     if
          :old.NUM_TYPE_ETAPE <> :new.NUM_TYPE_ETAPE
     then
          update ETAPE
          set
               ETAPE.NUM_TYPE_ETAPE = :new.NUM_TYPE_ETAPE
          where
               ETAPE.NUM_TYPE_ETAPE = :old.NUM_TYPE_ETAPE;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : PARTENAIRE
-- ------------------------------------------------------------------------------- 

drop trigger TD_PARTENAIRE;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_PARTENAIRE
after delete on PARTENAIRE for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table CARAVANE.

     delete from CARAVANE
     where
          CARAVANE.NUM_PARTENAIRE = :old.NUM_PARTENAIRE;

end;
/

drop trigger TU_PARTENAIRE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_PARTENAIRE
after update on PARTENAIRE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de PARTENAIRE sur les 
     -- occurrences correspondantes de la table CARAVANE.

     if
          :old.NUM_PARTENAIRE <> :new.NUM_PARTENAIRE
     then
          update CARAVANE
          set
               CARAVANE.NUM_PARTENAIRE = :new.NUM_PARTENAIRE
          where
               CARAVANE.NUM_PARTENAIRE = :old.NUM_PARTENAIRE;
     end if;

end;
/

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_PARTENAIRE
before insert on PARTENAIRE for each row
begin
	SELECT sq_partenaire.NEXTVAL INTO :new.NUM_PARTENAIRE FROM DUAL;
end;
/

-- ------------------------------------------------------------------------------- 
--   Table : ETAPE
-- ------------------------------------------------------------------------------- 

drop trigger TD_ETAPE;

-- Trigger de suppression ----------------------------------------------
create or replace trigger TD_ETAPE
after delete on ETAPE for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table COURIR.

     delete from COURIR
     where
          COURIR.NUM_COURSE = :old.NUM_COURSE and
          COURIR.NUM_ETAPE = :old.NUM_ETAPE;
     -- Supprimer les occurrences correspondantes de la table VOTE_COMBATIF_ETAPE.

     delete from VOTE_COMBATIF_ETAPE
     where
          VOTE_COMBATIF_ETAPE.NUM_COURSE = :old.NUM_COURSE and
          VOTE_COMBATIF_ETAPE.NUM_ETAPE = :old.NUM_ETAPE;
     -- Interdire la suppression d'une occurrence de ETAPE s'il existe des
     -- occurrences correspondantes de la table POINT_KM.

     select count(*) into numrows
     from POINT_KM
     where
          POINT_KM.NUM_COURSE = :old.NUM_COURSE and
          POINT_KM.NUM_ETAPE = :old.NUM_ETAPE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "ETAPE". Des occurrences de "POINT_KM" existent.');
     end if;

end;
/

drop trigger TU_ETAPE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_ETAPE
after update on ETAPE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- COURSE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "COURSE" interdite.');
     end if;
     -- Répercuter la modification de la clé primaire de ETAPE sur les 
     -- occurrences correspondantes de la table COURIR.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
          update COURIR
          set
               COURIR.NUM_COURSE = :new.NUM_COURSE,
               COURIR.NUM_ETAPE = :new.NUM_ETAPE
          where
               COURIR.NUM_COURSE = :old.NUM_COURSE and
               COURIR.NUM_ETAPE = :old.NUM_ETAPE;
     end if;
     -- Répercuter la modification de la clé primaire de ETAPE sur les 
     -- occurrences correspondantes de la table VOTE_COMBATIF_ETAPE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
          update VOTE_COMBATIF_ETAPE
          set
               VOTE_COMBATIF_ETAPE.NUM_COURSE = :new.NUM_COURSE,
               VOTE_COMBATIF_ETAPE.NUM_ETAPE = :new.NUM_ETAPE
          where
               VOTE_COMBATIF_ETAPE.NUM_COURSE = :old.NUM_COURSE and
               VOTE_COMBATIF_ETAPE.NUM_ETAPE = :old.NUM_ETAPE;
     end if;
     -- Répercuter la modification de la clé primaire de ETAPE sur les 
     -- occurrences correspondantes de la table POINT_KM.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
          update POINT_KM
          set
               POINT_KM.NUM_COURSE = :new.NUM_COURSE,
               POINT_KM.NUM_ETAPE = :new.NUM_ETAPE
          where
               POINT_KM.NUM_COURSE = :old.NUM_COURSE and
               POINT_KM.NUM_ETAPE = :old.NUM_ETAPE;
     end if;

end;
/

drop trigger TI_ETAPE;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_ETAPE
after insert on ETAPE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETAPE 
     -- s'il n'existe pas d'occurrence correspondante dans la table COURSE.

     select count(*) into numrows
     from COURSE
     where
          :new.NUM_COURSE = COURSE.NUM_COURSE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETAPE" car "COURSE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETAPE 
     -- s'il n'existe pas d'occurrence correspondante dans la table TYPE_ETAPE.

     select count(*) into numrows
     from TYPE_ETAPE
     where
          :new.NUM_TYPE_ETAPE = TYPE_ETAPE.NUM_TYPE_ETAPE;
     if 
          (
          :new.NUM_TYPE_ETAPE is not null and
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETAPE" car "TYPE_ETAPE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : COURIR
-- ------------------------------------------------------------------------------- 

drop trigger TU_COURIR;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_COURIR
after update on COURIR for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- PARTICIPANT.

     if
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "PARTICIPANT" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- ETAPE.

     if
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "ETAPE" interdite.');
     end if;

end;
/

drop trigger TI_COURIR;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_COURIR
after insert on COURIR for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de COURIR 
     -- s'il n'existe pas d'occurrence correspondante dans la table PARTICIPANT.

     select count(*) into numrows
     from PARTICIPANT
     where
          :new.NUM_COURSE = PARTICIPANT.NUM_COURSE and
          :new.NUM_DOSSARD = PARTICIPANT.NUM_DOSSARD;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "COURIR" car "PARTICIPANT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de COURIR 
     -- s'il n'existe pas d'occurrence correspondante dans la table ETAPE.

     select count(*) into numrows
     from ETAPE
     where
          :new.NUM_COURSE = ETAPE.NUM_COURSE and
          :new.NUM_ETAPE = ETAPE.NUM_ETAPE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "COURIR" car "ETAPE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : ATTEINDRE
-- ------------------------------------------------------------------------------- 

-- Trigger de la table COURIR -------------------------------------------

drop trigger TI_ATTEINDRE_COURIR;

create or replace
TRIGGER TI_ATTEINDRE_COURIR
	BEFORE INSERT OR UPDATE
	ON ATTEINDRE
  REFERENCING old AS old new AS new
	FOR EACH ROW
DECLARE
	code_cate CHAR(5);
	code_typ CHAR(5);
	points_mont NUMBER;
	points_sprint NUMBER;
  new_points_sprint NUMBER;
  new_points_mont NUMBER;
	is_prochaine_etape NUMBER;
	v_etape ETAPE%rowtype;
	v_last_courir COURIR%rowtype;
	v_courir COURIR%rowtype;
BEGIN


-- Récupération du code_type, code_cate et de l'étape
	SELECT 
		CODE_CATEGORIE  
		, CODE_TYPE
    INTO code_cate, code_typ
	FROM POINT_KM
	WHERE POINT_KM.NUM_COURSE = :new.NUM_COURSE
    AND POINT_KM.NUM_ETAPE = :new.NUM_ETAPE
    AND POINT_KM.KM = :new.KM
	;
  
  SELECT
    e.*
    INTO v_etape
  FROM ETAPE e
  WHERE
    e.NUM_ETAPE = :new.NUM_ETAPE
    AND e.NUM_COURSE = :new.NUM_COURSE
	;
	
--si on n'est pas à l'étape 1, on récupère l'entrée "courir" de l'étape précédente
	IF :new.NUM_ETAPE != 1
	THEN
		SELECT * INTO v_last_courir
		FROM COURIR
		WHERE COURIR.NUM_COURSE = :new.NUM_COURSE
		AND COURIR.NUM_ETAPE = :new.NUM_ETAPE - 1
		AND COURIR.NUM_DOSSARD = :new.NUM_DOSSARD
    ;
	END IF;
	
	
--on récupère l'entrée "courir" de l'étape
	SELECT * into v_courir
	FROM COURIR
	WHERE
    	COURIR.NUM_DOSSARD = :new.NUM_DOSSARD
    	AND COURIR.NUM_COURSE = :new.NUM_COURSE
    	AND COURIR.NUM_ETAPE = :new.NUM_ETAPE
    ;

--on récupère le barème du point km courant
	SELECT 
		b.PTS_MONTAGNE_BAREME  
		, b.PTS_SPRINT_BAREME  
    INTO points_mont, points_sprint
	FROM BAREME b
	WHERE
		b.CODE_TYPE = code_typ
		AND b.CODE_CATEGORIE = code_cate
		AND b.PLACE_BAREME = :new.CLASSEMENT
	;

    
--si il y a quelque chose dans le bareme du point km actuel, on ajoute
	IF points_mont IS NOT NULL
  THEN
		UPDATE COURIR
		SET
			COURIR.POINTS_MONTAGNE_GENERAL = COURIR.POINTS_MONTAGNE_GENERAL + points_mont
    WHERE
        COURIR.NUM_DOSSARD = v_courir.NUM_DOSSARD
        AND COURIR.NUM_COURSE = v_courir.NUM_COURSE
        AND COURIR.NUM_ETAPE = v_courir.NUM_ETAPE
    ;
	END IF;
	
	IF points_sprint IS NOT NULL
  THEN
		UPDATE COURIR
		SET
			COURIR.POINTS_SPRINT_GENERAL = COURIR.POINTS_SPRINT_GENERAL + points_sprint		
    WHERE
        COURIR.NUM_DOSSARD = v_courir.NUM_DOSSARD
        AND COURIR.NUM_COURSE = v_courir.NUM_COURSE
        AND COURIR.NUM_ETAPE = v_courir.NUM_ETAPE
    ;
	END IF;
  
  SELECT
    POINTS_SPRINT_GENERAL
    , POINTS_MONTAGNE_GENERAL
    INTO new_points_sprint, new_points_mont
  FROM
    COURIR
  WHERE
      COURIR.NUM_DOSSARD = v_courir.NUM_DOSSARD
      AND COURIR.NUM_COURSE = v_courir.NUM_COURSE
      AND COURIR.NUM_ETAPE = v_courir.NUM_ETAPE
  ;
	
	

--si on est à l'arrivée
	IF code_cate IS NOT NULL AND code_typ IS NOT NULL AND code_typ = 'ARRIV'
	THEN
  --si c'est la première étape, on set
		IF v_etape.NUM_ETAPE = 1
		THEN
      UPDATE COURIR
        SET COURIR.TEMPS_GENERAL = (:new.HEURE_PASSAGE - v_etape.DATE_ETAPE)
      WHERE
        COURIR.NUM_DOSSARD = v_courir.NUM_DOSSARD
        AND COURIR.NUM_COURSE = v_courir.NUM_COURSE
        AND COURIR.NUM_ETAPE = v_courir.NUM_ETAPE
      ;
		ELSE
    -- sinon on ajoute au temps précédent
      UPDATE COURIR
        SET COURIR.TEMPS_GENERAL = v_last_courir.TEMPS_GENERAL + (:new.HEURE_PASSAGE - v_etape.DATE_ETAPE)
      WHERE
        COURIR.NUM_DOSSARD = v_courir.NUM_DOSSARD
        AND COURIR.NUM_COURSE = v_courir.NUM_COURSE
        AND COURIR.NUM_ETAPE = v_courir.NUM_ETAPE
      ;
    END IF;
    
    --on test s'il existe une prochaine étape
    SELECT count(*) into is_prochaine_etape
    FROM ETAPE e
    WHERE e.NUM_ETAPE = :new.NUM_ETAPE + 1
    AND e.NUM_COURSE = :new.NUM_COURSE
    ;
    	
    --si oui, on initialise la prochaine entrée dans "courir"
    IF is_prochaine_etape = 1
    THEN
      INSERT INTO COURIR
    	VALUES(:new.NUM_DOSSARD, :new.NUM_COURSE, :new.NUM_ETAPE + 1, NULL, new_points_sprint, new_points_mont);
  	END IF;
  END IF;
    
END TI_ATTEINDRE_COURIR;

drop trigger TU_ATTEINDRE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_ATTEINDRE
after update on ATTEINDRE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- PARTICIPANT.

     if
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE or 
          :old.KM <> :new.KM
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "PARTICIPANT" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- POINT_KM.

     if
          :old.NUM_DOSSARD <> :new.NUM_DOSSARD or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE or 
          :old.KM <> :new.KM
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "POINT_KM" interdite.');
     end if;

end;
/

drop trigger TI_ATTEINDRE;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_ATTEINDRE
after insert on ATTEINDRE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ATTEINDRE 
     -- s'il n'existe pas d'occurrence correspondante dans la table PARTICIPANT.

     select count(*) into numrows
     from PARTICIPANT
     where
          :new.NUM_COURSE = PARTICIPANT.NUM_COURSE and
          :new.NUM_DOSSARD = PARTICIPANT.NUM_DOSSARD;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ATTEINDRE" car "PARTICIPANT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ATTEINDRE 
     -- s'il n'existe pas d'occurrence correspondante dans la table POINT_KM.

     select count(*) into numrows
     from POINT_KM
     where
          :new.NUM_COURSE = POINT_KM.NUM_COURSE and
          :new.NUM_ETAPE = POINT_KM.NUM_ETAPE and
          :new.KM = POINT_KM.KM;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ATTEINDRE" car "POINT_KM" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : FAIRE_PARTIE
-- ------------------------------------------------------------------------------- 

drop trigger TU_FAIRE_PARTIE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_FAIRE_PARTIE
after update on FAIRE_PARTIE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- COUREUR.

     if
          :old.NUM_COUREUR <> :new.NUM_COUREUR or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.CODE_EQUIPE <> :new.CODE_EQUIPE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "COUREUR" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- EQUIPE.

     if
          :old.NUM_COUREUR <> :new.NUM_COUREUR or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.CODE_EQUIPE <> :new.CODE_EQUIPE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "EQUIPE" interdite.');
     end if;

end;
/

drop trigger TI_FAIRE_PARTIE;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_FAIRE_PARTIE
after insert on FAIRE_PARTIE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de FAIRE_PARTIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table COUREUR.

     select count(*) into numrows
     from COUREUR
     where
          :new.NUM_COUREUR = COUREUR.NUM_COUREUR;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "FAIRE_PARTIE" car "COUREUR" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de FAIRE_PARTIE 
     -- s'il n'existe pas d'occurrence correspondante dans la table EQUIPE.

     select count(*) into numrows
     from EQUIPE
     where
          :new.NUM_COURSE = EQUIPE.NUM_COURSE and
          :new.CODE_EQUIPE = EQUIPE.CODE_EQUIPE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "FAIRE_PARTIE" car "EQUIPE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : VOTE_COMBATIF_ETAPE
-- ------------------------------------------------------------------------------- 

drop trigger TU_VOTE_COMBATIF_ETAPE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_VOTE_COMBATIF_ETAPE
after update on VOTE_COMBATIF_ETAPE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- MEMBRE_JURY.

     if
          :old.NUM_MEMBRE_JURY <> :new.NUM_MEMBRE_JURY or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "MEMBRE_JURY" interdite.');
     end if;
     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VOTE_COMBATIF_ETAPE s'il n'existe pas d'occurrence correspondante de la 
     -- table PARTICIPANT.

     if
          :old.NUM_MEMBRE_JURY <> :new.NUM_MEMBRE_JURY or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
          select count(*) into numrows
          from PARTICIPANT
          where
               :new.NUM_COURSE = PARTICIPANT.NUM_COURSE and
               :new.NUM_DOSSARD = PARTICIPANT.NUM_DOSSARD;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VOTE_COMBATIF_ETAPE" car "PARTICIPANT" n''existe pas.');
          end if;
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- ETAPE.

     if
          :old.NUM_MEMBRE_JURY <> :new.NUM_MEMBRE_JURY or 
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_ETAPE <> :new.NUM_ETAPE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "ETAPE" interdite.');
     end if;

end;
/

drop trigger TI_VOTE_COMBATIF_ETAPE;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_VOTE_COMBATIF_ETAPE
after insert on VOTE_COMBATIF_ETAPE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOTE_COMBATIF_ETAPE 
     -- s'il n'existe pas d'occurrence correspondante dans la table MEMBRE_JURY.

     select count(*) into numrows
     from MEMBRE_JURY
     where
          :new.NUM_MEMBRE_JURY = MEMBRE_JURY.NUM_MEMBRE_JURY;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOTE_COMBATIF_ETAPE" car "MEMBRE_JURY" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOTE_COMBATIF_ETAPE 
     -- s'il n'existe pas d'occurrence correspondante dans la table PARTICIPANT.

     select count(*) into numrows
     from PARTICIPANT
     where
          :new.NUM_COURSE = PARTICIPANT.NUM_COURSE and
          :new.NUM_DOSSARD = PARTICIPANT.NUM_DOSSARD;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOTE_COMBATIF_ETAPE" car "PARTICIPANT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOTE_COMBATIF_ETAPE 
     -- s'il n'existe pas d'occurrence correspondante dans la table ETAPE.

     select count(*) into numrows
     from ETAPE
     where
          :new.NUM_COURSE = ETAPE.NUM_COURSE and
          :new.NUM_ETAPE = ETAPE.NUM_ETAPE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOTE_COMBATIF_ETAPE" car "ETAPE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : CARAVANE
-- ------------------------------------------------------------------------------- 

drop trigger TU_CARAVANE;

-- Trigger de modification ----------------------------------------------
create or replace trigger TU_CARAVANE
after update on CARAVANE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- COURSE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_PARTENAIRE <> :new.NUM_PARTENAIRE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "COURSE" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- PARTENAIRE.

     if
          :old.NUM_COURSE <> :new.NUM_COURSE or 
          :old.NUM_PARTENAIRE <> :new.NUM_PARTENAIRE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "PARTENAIRE" interdite.');
     end if;

end;
/

drop trigger TI_CARAVANE;

-- Trigger d'insertion ----------------------------------------------
create or replace trigger TI_CARAVANE
after insert on CARAVANE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de CARAVANE 
     -- s'il n'existe pas d'occurrence correspondante dans la table COURSE.

     select count(*) into numrows
     from COURSE
     where
          :new.NUM_COURSE = COURSE.NUM_COURSE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "CARAVANE" car "COURSE" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de CARAVANE 
     -- s'il n'existe pas d'occurrence correspondante dans la table PARTENAIRE.

     select count(*) into numrows
     from PARTENAIRE
     where
          :new.NUM_PARTENAIRE = PARTENAIRE.NUM_PARTENAIRE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "CARAVANE" car "PARTENAIRE" n''existe pas.');
     end if;

end;
/


-- ------------------------------------------------------------------------------- 
--   GESTION DES ATTRIBUTS REDONDANTS
-- ------------------------------------------------------------------------------- 

CREATE OR REPLACE TRIGGER TAU_CATEGORIE
AFTER UPDATE OF "LIBELLE_CATEGORIE" ON CATEGORIE
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
BEGIN
	UPDATE
		POINT_KM
	SET
		LIBELLE_CATEGORIE = :NEW.LIBELLE_CATEGORIE
	WHERE
		LIBELLE_CATEGORIE = :OLD.LIBELLE_CATEGORIE;
END;
/

CREATE OR REPLACE TRIGGER TAU_EQUIPE
AFTER UPDATE OF "NOM_EQUIPE" ON EQUIPE
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
BEGIN
	UPDATE
		PARTICIPANT
	SET
		NOM_EQUIPE = :NEW.NOM_EQUIPE
	WHERE
		NOM_EQUIPE = :OLD.NOM_EQUIPE;
END;
/

CREATE OR REPLACE TRIGGER TAU_PAYS
AFTER UPDATE OF "NOM_PAYS" ON PAYS
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
BEGIN
	UPDATE
		COUREUR
	SET
		NOM_PAYS = :NEW.NOM_PAYS
	WHERE
		NOM_PAYS = :OLD.NOM_PAYS;
	UPDATE
		VILLE
	SET
		NOM_PAYS = :NEW.NOM_PAYS
	WHERE
		NOM_PAYS = :OLD.NOM_PAYS;
END;
/

CREATE OR REPLACE TRIGGER TAU_TYPE
AFTER UPDATE OF "LIBELLE_TYPE" ON TYPE
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
BEGIN
	UPDATE
		CATEGORIE
	SET
		LIBELLE_TYPE = :NEW.LIBELLE_TYPE
	WHERE
		LIBELLE_TYPE = :OLD.LIBELLE_TYPE;
	UPDATE
		POINT_KM
	SET
		LIBELLE_TYPE = :NEW.LIBELLE_TYPE
	WHERE
		LIBELLE_TYPE = :OLD.LIBELLE_TYPE;
END;
/

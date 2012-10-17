
  CREATE OR REPLACE PACKAGE "G16_TDF"."UI_CLASSEMENT" IS
  TYPE sqlcur IS REF CURSOR;
  PROCEDURE AffTabInd;
  PROCEDURE AffTabIndForEtape(enum number);
  PROCEDURE AffTabIndForKm(enum number, km number);
  
  PROCEDURE AffTabPois;
  PROCEDURE AffTabPoisForEtape(enum number);
  
  PROCEDURE AffTabSprint;
  PROCEDURE AffTabSprintForEtape(enum number);
  
  PROCEDURE AffTabEquipe;
  PROCEDURE AffTabEquipeForEtape(enum number);
  
  PROCEDURE AffTabJeune;
  PROCEDURE AffTabJeuneForEtape(enum number);
  
  PROCEDURE AffTabCombatif;
  PROCEDURE AffTabCombatifForEtape(enum number);
  
END UI_CLASSEMENT;
/

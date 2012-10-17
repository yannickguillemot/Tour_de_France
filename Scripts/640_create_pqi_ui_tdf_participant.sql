
  CREATE OR REPLACE PACKAGE "G16_TDF"."UI_PARTICIPANT" IS
  TYPE sqlcur IS REF CURSOR;
  PROCEDURE AffTab;
  PROCEDURE AffTabForEquipe(code_equipe varchar2, cnum number);
  PROCEDURE AffTabForParticipant(pnum number);
  PROCEDURE AffTabForCoureur(cnum number);
  PROCEDURE AffTabAbForCourseForEtape(cnum number, num_etape number);
  
END UI_PARTICIPANT;
/

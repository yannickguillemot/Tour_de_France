
  CREATE OR REPLACE PACKAGE "G16_TDF"."UI_EQUIPE" IS
  TYPE sqlcur IS REF CURSOR;
  PROCEDURE AffTabForCourse(cnum number);
  PROCEDURE AffTabForEquipe(code_equipe varchar2);
END UI_EQUIPE;
/

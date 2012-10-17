
  CREATE OR REPLACE PACKAGE "G16_TDF"."UI_ETAPE" IS
  TYPE sqlcur IS REF CURSOR;
  PROCEDURE AffTabForCourse(cnum number);
  PROCEDURE AffTabForEtape(num_etape number);
END UI_ETAPE;
/


  CREATE OR REPLACE PACKAGE "G16_TDF"."UI_POINT_KM" AS 
  TYPE sqlcur IS REF CURSOR;
  PROCEDURE AffTabForCourseForEtape(cnum number, enum number);
END UI_POINT_KM;
/

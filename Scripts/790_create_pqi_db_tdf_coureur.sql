
  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_COUREUR" AS 
  TYPE sqlcur IS REF CURSOR;
  FUNCTION GetAll return sqlcur;
  FUNCTION Get(cnum number) return COUREUR%rowtype;
END PA_COUREUR;
/

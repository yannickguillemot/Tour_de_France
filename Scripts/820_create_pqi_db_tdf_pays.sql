
  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_PAYS" AS 
  TYPE sqlcur IS REF CURSOR;
  FUNCTION GetAll return sqlcur;
  FUNCTION Get(pnum in char) return PAYS%rowtype;
END PA_PAYS;
/

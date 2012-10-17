
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_COUREUR" AS 
  FUNCTION GetAll return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT *
      FROM COUREUR;
  END;
  FUNCTION Get(cnum number) return COUREUR%rowtype
  IS
  res COUREUR%rowtype;
  BEGIN
    SELECT * into res
    FROM COUREUR
    WHERE NUM_COUREUR=cnum;
    return res;
  END;
END PA_COUREUR;
/

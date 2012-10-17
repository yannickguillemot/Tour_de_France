
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_PAYS" AS 
  FUNCTION GetAll return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT *
      FROM PAYS;
    return res;
  END;
  
  FUNCTION Get(pnum in char) return PAYS%rowtype
  IS
  res PAYS%rowtype;
  BEGIN
    SELECT * into res
    FROM PAYS
    WHERE CODE_PAYS=pnum;
    return res;
  END;
END PA_PAYS;
/


  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_VILLE" AS 
  FUNCTION GetAll return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT *
      FROM VILLE;
    return res;
  END;
  
  FUNCTION Get(vnum in char,pnum in char) return VILLE%rowtype
  IS
  res VILLE%rowtype;
  BEGIN
      SELECT * into res
      FROM VILLE
      WHERE CODE_COMMUNE=vnum
      AND CODE_PAYS=pnum;
      return res;
  END;
  
  FUNCTION GetVilleDepartForEtape(cnum number, enum in number) return VILLE%rowtype
  IS
  res VILLE%rowtype;
  BEGIN
    SELECT * into res
    FROM VILLE
    WHERE (CODE_COMMUNE,CODE_PAYS) =
      (SELECT CODE_COMMUNE,CODE_PAYS
      FROM POINT_KM
      WHERE CODE_CATEGORIE = 'DEPAR'
      AND NUM_ETAPE = enum
      AND NUM_COURSE = cnum);
    return res;
  END;
  
  FUNCTION GetVilleArriveeForEtape(cnum number, enum in number) return VILLE%rowtype
  IS
    res VILLE%rowtype;
  BEGIN
        SELECT * into res
    FROM VILLE
    WHERE (CODE_COMMUNE,CODE_PAYS) =
      (SELECT CODE_COMMUNE,CODE_PAYS
      FROM POINT_KM
      WHERE CODE_TYPE = 'ARRIV'
      AND NUM_ETAPE = enum
      AND NUM_COURSE = cnum);
    return res;
  END;
END PA_VILLE;
/

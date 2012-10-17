
  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_VILLE" AS 
  TYPE sqlcur IS REF CURSOR;
  FUNCTION GetAll return sqlcur;
  FUNCTION Get(vnum in char, pnum in char) return VILLE%rowtype;
  FUNCTION GetVilleDepartForEtape(cnum number, enum in number) return VILLE%rowtype;
  FUNCTION GetVilleArriveeForEtape(cnum number, enum in number) return VILLE%rowtype;
END PA_VILLE;
/


  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_CATEGORIE" IS
TYPE sqlcur IS REF CURSOR;
FUNCTION GetAll return sqlcur;
FUNCTION GetNbCategorie return NUMBER;
FUNCTION GetForCategorie(catnum in char) return sqlcur;
FUNCTION GetForType(tnum in char) return sqlcur;
FUNCTION GetForTypeForCategorie(tnum in char, catnum in char) return sqlcur;
END;
/

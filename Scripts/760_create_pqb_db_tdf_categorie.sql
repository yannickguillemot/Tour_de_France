
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_CATEGORIE" IS
  FUNCTION GetAll return sqlcur
  IS
       res sqlcur;
  BEGIN
       OPEN res FOR
        SELECT *
        From CATEGORIE;
       Return res;
  END;

  FUNCTION GetNbCategorie return NUMBER
	IS
    res NUMBER(2);
	BEGIN
		select count(*) into res from CATEGORIE;
		return res;
	END GetNbCategorie;
	
	FUNCTION GetForCategorie (catnum char) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT C.* 
			FROM CATEGORIE C
			WHERE C.CODE_CATEGORIE LIKE catnum;
		return res;
			
	END;
	
	FUNCTION GetForType(tnum char) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT C.* 
			FROM CATEGORIE C
			WHERE C.CODE_TYPE LIKE tnum;
		return res;
			
	END;
	
	FUNCTION GetForTypeForCategorie(tnum char, catnum char) return sqlcur	
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT C.* 
			FROM CATEGORIE C
			WHERE C.CODE_CATEGORIE LIKE catnum
			AND C.CODE_TYPE LIKE tnum;
		return res;
	END;
END;
/

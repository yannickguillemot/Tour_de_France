
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_EQUIPE" IS	
	FUNCTION GetAll return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM EQUIPE;
		return res;
	END;
	
	FUNCTION Get(cnum number, enum in char) return EQUIPE%rowtype
	IS
	res EQUIPE%rowtype;
	BEGIN
		SELECT * into res
		FROM EQUIPE
		WHERE CODE_EQUIPE LIKE enum
    AND NUM_COURSE = cnum;
		return res;
	END;
	
 	FUNCTION GetPartForEquipe(enum in char) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
      SELECT *
			FROM EQUIPE
			WHERE CODE_EQUIPE LIKE enum;
		return res;
	END;
  
	FUNCTION GetForCourse(cnum in number) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
      SELECT *
			FROM EQUIPE
			WHERE NUM_COURSE = cnum;
		return res;
	END;
END;
/

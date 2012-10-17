create or replace
PACKAGE BODY PA_COURSE IS
	FUNCTION GetAll return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM COURSE;
		return res;
	END;
	
	FUNCTION Get(cnum in number) return COURSE%rowtype
	IS
		res COURSE%rowtype;
	BEGIN
		SELECT * into res
		FROM COURSE
		WHERE NUM_COURSE = cnum;
		return res;
	END;
END;
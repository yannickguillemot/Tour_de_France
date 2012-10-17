
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_COURSE" IS
	FUNCTION GetAll return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM COURSE
      ORDER BY NUM_COURSE DESC;
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
/


  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_TYPE_ETAPE" AS 
 	FUNCTION GetAll return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM TYPE_ETAPE
      ORDER BY NUM_TYPE_ETAPE;
		return res;
	END;
  
  FUNCTION Get(tenum number) return TYPE_ETAPE%rowtype
  IS
	res TYPE_ETAPE%rowtype;
  BEGIN
    SELECT * into res
		FROM TYPE_ETAPE
		WHERE NUM_TYPE_ETAPE = tenum
    ORDER BY NUM_TYPE_ETAPE;
		return res;
  END;
END PA_TYPE_ETAPE;
/

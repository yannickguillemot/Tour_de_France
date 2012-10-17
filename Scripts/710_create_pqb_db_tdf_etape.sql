
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_ETAPE" IS
	FUNCTION GetAll return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM ETAPE
      ORDER BY NUM_ETAPE;
		return res;
	END;
	
	FUNCTION Get(cnum in number, enum in number) return ETAPE%rowtype
	IS
	res ETAPE%rowtype;
	BEGIN
		SELECT * into res
		FROM ETAPE
		WHERE NUM_COURSE = cnum
    AND NUM_ETAPE = enum
    ORDER BY NUM_ETAPE;
		return res;
	END;
  
  FUNCTION GetNbEtapesForCourse(cnum number) return number
  IS
  res number;
  BEGIN
    SELECT count(*) into res
    FROM ETAPE
    WHERE NUM_COURSE=cnum;
    return res;
  END;

	FUNCTION GetForCourse(cnum in number) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			/*SELECT *
			FROM ETAPE E INNER JOIN TYPE_ETAPE TE
      ON E.NUM_TYPE_ETAPE=TE.NUM_TYPE_ETAPE
			WHERE NUM_COURSE = TO_NUMBER(cnum)
      ORDER BY NUM_ETAPE;*/
			SELECT *
			FROM ETAPE
      WHERE NUM_COURSE = cnum
      ORDER BY NUM_ETAPE;
    RETURN res;
	END;

END;
/

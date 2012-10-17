
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_POINT_KM" 
IS
	FUNCTION GetAll return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM POINT_KM
      ORDER BY KM;
		return res;
	END;
	
	FUNCTION GetForCourse(cnum in number) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM POINT_KM
			WHERE NUM_COURSE = cnum
      ORDER BY KM;
		return res;		
	END;
	
	FUNCTION GetForCourseForEtape(cnum in number, enum in number) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM POINT_KM
			WHERE NUM_ETAPE = enum
      AND NUM_COURSE = cnum
      ORDER BY KM;
		return res;		
	END;
	
	FUNCTION GetForEtapeForKM(enum in number, km in decimal) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM POINT_KM
			WHERE NUM_ETAPE = enum
			AND KM = km
      ORDER BY KM;
		return res;		
	END;
	
	FUNCTION GetForCourseForEtapeForKM(cnum in number, enum in number, km in decimal) return POINT_KM%rowtype
	IS
	res POINT_KM%rowtype;
	BEGIN
			SELECT * into res
			FROM POINT_KM
			WHERE NUM_ETAPE = enum
			AND NUM_COURSE = cnum
			AND KM = km
      ORDER BY KM;
		return res;		
	END;
END;
/

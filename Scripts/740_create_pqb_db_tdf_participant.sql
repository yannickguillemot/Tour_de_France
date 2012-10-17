
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_PARTICIPANT" IS
	FUNCTION GetAll return sqlcur
	IS
	     res sqlcur;
	BEGIN
 	    OPEN res FOR
	      SELECT *
	      From PARTICIPANT;
	     Return res;
	END;
	
	FUNCTION GetForCourse(cnum in number) return sqlcur
	IS
	     res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM PARTICIPANT	
			WHERE NUM_COURSE = cnum;
		return res;
	END;
	
	FUNCTION GetForCoureur(cnum in number) return sqlcur
	IS
	     res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM PARTICIPANT
			WHERE NUM_COUREUR = cnum;
		return res;
	END;
  
  FUNCTION GetForEquipeForCourse(enum in char, cnum in number) return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT *
      FROM PARTICIPANT
      WHERE NUM_COURSE = cnum
      AND CODE_EQUIPE = enum;
    return res;
  END;

  FUNCTION GetForDossardForCourse(dnum in number, cnum in number) return PARTICIPANT%rowtype
	IS
		res PARTICIPANT%rowtype;
	BEGIN
		SELECT * into res
		FROM PARTICIPANT
		WHERE NUM_DOSSARD = dnum
    AND NUM_COURSE = cnum;
		return res;
	END;
  
  FUNCTION GetNbForEquipeForCourse(enum in char, cnum in number) return number
  IS
  res number;
  BEGIN
      SELECT count(*) into res
      FROM PARTICIPANT
      WHERE NUM_COURSE = cnum
      AND CODE_EQUIPE = enum;
    return res;
  END;

  FUNCTION GetAbForCourseForEtape(cnum number, enum in number) return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT *
      FROM PARTICIPANT
      WHERE num_etape=enum
      AND num_course = cnum;--si num_etape => abandon
    return res;
  END;
END;
/

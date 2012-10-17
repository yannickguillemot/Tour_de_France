
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_FAIRE_PARTIE" IS
	FUNCTION GetAll return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM FAIRE_PARTIE;
		return res;
	END;
	
	FUNCTION GetForCoureur(cnum in number) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM FAIRE_PARTIE
			WHERE NUM_COUREUR = cnum;
		return res;
	END;
	
	FUNCTION GetForCourse(cnum in number) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM FAIRE_PARTIE
			WHERE NUM_COURSE = cnum;
		return res;
	END;
	
	FUNCTION GetForEquipe(enum in char) return sqlcur
	IS	
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM FAIRE_PARTIE
			WHERE CODE_EQUIPE = enum;
		return res;
	END;
	
	FUNCTION GetForCourseForEquipe(cnum in number,enum in char) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
			SELECT *
			FROM FAIRE_PARTIE
			WHERE NUM_COURSE = cnum
			AND CODE_EQUIPE = enum;
		return res;
	END;
	
	FUNCTION GetForCourseForCoureur(coursenum in number,coureurnum in number) return FAIRE_PARTIE%rowtype
	IS
	res FAIRE_PARTIE%rowtype;
	BEGIN
		SELECT * into res
		FROM FAIRE_PARTIE
		WHERE NUM_COURSE = coursenum
		AND NUM_COUREUR = coureurnum;
		return res;
	END;
	
	FUNCTION GetForCourseForEquForCoureur(coursenum in number,enum in char,coureurnum in number) return FAIRE_PARTIE%rowtype
	IS
	res FAIRE_PARTIE%rowtype;
	BEGIN
		SELECT * into res
		FROM FAIRE_PARTIE
		WHERE NUM_COURSE = coursenum
		AND CODE_EQUIPE = enum
		AND NUM_COUREUR = coureurnum;
		return res;
	END;
END;
/


  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_FAIRE_PARTIE" 
IS
	TYPE sqlcur IS REF CURSOR;
	FUNCTION GetAll return sqlcur;
	FUNCTION GetForCoureur(cnum in number) return sqlcur;
	FUNCTION GetForCourse(cnum in number) return sqlcur;
	FUNCTION GetForEquipe(enum in char) return sqlcur;
	FUNCTION GetForCourseForEquipe(cnum in number,enum in char) return sqlcur;
	FUNCTION GetForCourseForCoureur(coursenum in number,coureurnum in number) return FAIRE_PARTIE%rowtype;
	FUNCTION GetForCourseForEquForCoureur(coursenum in number,enum in char,coureurnum in number) return FAIRE_PARTIE%rowtype;
	--pas de modif de la base dans l'UI
END;
/

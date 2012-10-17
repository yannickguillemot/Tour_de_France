
  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_POINT_KM" 
IS
	TYPE sqlcur IS REF CURSOR;
	FUNCTION GetAll return sqlcur;
	FUNCTION GetForCourse(cnum in number) return sqlcur;
	FUNCTION GetForCourseForEtape(cnum in number, enum in number) return sqlcur;
	FUNCTION GetForEtapeForKM(enum in number, km in decimal) return sqlcur;
	FUNCTION GetForCourseForEtapeForKM(cnum in number, enum in number, km in decimal) return POINT_KM%rowtype;
	--pas de modif de la base dans l'UI
END;
/

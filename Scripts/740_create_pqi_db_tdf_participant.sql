
  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_PARTICIPANT" 
IS
	TYPE sqlcur IS REF CURSOR;
	FUNCTION GetAll return sqlcur;
	FUNCTION GetForCourse(cnum in number) return sqlcur;
  FUNCTION GetForCoureur(cnum in number) return sqlcur;
  FUNCTIOn GetForEquipeForCourse(enum in char, cnum in number) return sqlcur;
  FUNCTION GetForDossardForCourse(dnum in number, cnum in number) return PARTICIPANT%rowtype;
  FUNCTION GetNbForEquipeForCourse(enum in char, cnum in number) return number;
  FUNCTION GetAbForCourseForEtape(cnum number, enum in number) return sqlcur;
	--pas de modif de la base dans l'UI
END;
/

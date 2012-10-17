
  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_EQUIPE" 
IS
	TYPE sqlcur IS REF CURSOR;
	FUNCTION GetAll return sqlcur;
	FUNCTION Get(cnum number, enum in char) return EQUIPE%rowtype;
 
	FUNCTION GetForCourse(cnum in number) return sqlcur;
	FUNCTION GetPartForEquipe(enum in char) return sqlcur;

	--pas de modif de la base dans l'UI
END;
/

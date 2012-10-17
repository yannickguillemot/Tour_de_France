
  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_ETAPE" 
IS
	TYPE sqlcur IS REF CURSOR;
	FUNCTION GetAll return sqlcur;
	FUNCTION Get(cnum in number, enum in number) return ETAPE%rowtype;
  FUNCTION GetNbEtapesForCourse(cnum number) return number;
	FUNCTION GetForCourse(cnum in number) return sqlcur;

	--pas de modif de la base dans l'UI
END;
/

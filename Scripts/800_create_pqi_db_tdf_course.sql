
  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_COURSE" 
IS
	TYPE sqlcur IS REF CURSOR;
	FUNCTION GetAll return sqlcur;
	FUNCTION Get(cnum in number) return COURSE%rowtype;
	--pas de modif de la base dans l'UI
END;
/

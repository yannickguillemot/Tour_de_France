
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_PARTENAIRE" AS 
  FUNCTION GetForCourse(cnum in number) return sqlcur
	IS
	res sqlcur;
	BEGIN
		OPEN res FOR
      SELECT p.*
			FROM PARTENAIRE p
      INNER JOIN CARAVANE c ON c.num_partenaire = p.num_partenaire
      WHERE c.num_course = cnum
			ORDER BY NOM_PARTENAIRE;
		return res;
	END;
END PA_PARTENAIRE;
/


  CREATE OR REPLACE PACKAGE "G16_TDF"."PA_CLASSEMENT" AS 
  TYPE sqlcur IS REF CURSOR;
  FUNCTION GetGeneralInd(cnum number)return sqlcur;
  FUNCTION GetGeneralIndForEtape(cnum number,enum number)return sqlcur;
  FUNCTION GetEtapeIndForKm(cnum number,enum number, kmparam number)return sqlcur;

  FUNCTION GetGeneralPois(cnum number)return sqlcur;
  FUNCTION GetGeneralPoisForEtape(cnum number,enum number)return sqlcur;

  FUNCTION GetGeneralSprint(cnum number)return sqlcur;
  FUNCTION GetGeneralSprintForEtape(cnum number,enum number)return sqlcur;
  
  FUNCTION GetGeneralEquipe(cnum number)return sqlcur;
  FUNCTION GetGeneralEquipeForEtape(cnum number,enum number)return sqlcur;
  
  FUNCTION GetGeneralJeune(cnum number)return sqlcur;
  FUNCTION GetGeneralJeuneForEtape(cnum number,enum number)return sqlcur;
  
  FUNCTION GetGeneralCombatif(cnum number)return sqlcur;
  FUNCTION GetGeneralCombatifForEtape(cnum number,enum number)return sqlcur;

END PA_CLASSEMENT;
/

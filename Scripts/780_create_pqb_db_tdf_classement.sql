
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."PA_CLASSEMENT" AS 
  FUNCTION GetGeneralInd(cnum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    
    OPEN res FOR
      SELECT
              row_number() over(order by CO.TEMPS_GENERAL)
              ,CRR.NOM_PAYS
              ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
              ,PA.NUM_DOSSARD
              ,PA.NOM_EQUIPE
              ,CO.TEMPS_GENERAL        
            FROM COURIR CO inner join PARTICIPANT PA
            ON CO.NUM_DOSSARD=PA.NUM_DOSSARD AND co.num_course=pa.num_course
            inner join COUREUR CRR
            ON PA.NUM_COUREUR=CRR.NUM_COUREUR
            WHERE CO.NUM_COURSE = cnum
            AND CO.NUM_ETAPE = (select max(C1.NUM_ETAPE)
                                FROM COURIR C1
                                WHERE C1.num_course=cnum
                                AND EXISTS ( SELECT * 
                                            FROM COURIR C2
                                            WHERE C2.NUM_COURSE = cnum
                                            AND C2.NUM_ETAPE = C1.NUM_ETAPE
                                            AND C2.TEMPS_GENERAL IS NOT NULL
                                          )
                                );
    return res;
  END;
  
  FUNCTION GetEtapeIndForKm(cnum number,enum number, kmparam number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
   SELECT
         ATT.CLASSEMENT  
          ,CRR.NOM_PAYS
         ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
         ,PA.NUM_DOSSARD
         ,PA.NOM_EQUIPE
         ,ATT.HEURE_PASSAGE - E.DATE_ETAPE as TEMPS
       FROM ATTEINDRE ATT inner join PARTICIPANT PA
       ON ATT.NUM_DOSSARD=PA.NUM_DOSSARD AND ATT.num_course=pa.num_course
       inner join COUREUR CRR
       ON PA.NUM_COUREUR=CRR.NUM_COUREUR
       inner join ETAPE E
       ON E.NUM_COURSE = ATT.NUM_COURSE
       AND E.NUM_ETAPE = ATT.NUM_ETAPE
      
       WHERE ATT.NUM_COURSE = cnum
       AND ATT.NUM_ETAPE = enum
       AND ATT.KM = kmparam
      
       ORDER BY TEMPS;

    return res;
  END;

  
  FUNCTION GetGeneralIndForEtape(cnum number,enum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
        OPEN res FOR
        SELECT 
          row_number() over(order by CO.TEMPS_GENERAL)
          ,CRR.NOM_PAYS
          ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
          ,PA.NUM_DOSSARD
          ,PA.NOM_EQUIPE
          ,CO.TEMPS_GENERAL        
        FROM COURIR CO inner join PARTICIPANT PA
        ON CO.NUM_DOSSARD=PA.NUM_DOSSARD AND co.num_course=pa.num_course
        inner join COUREUR CRR
        ON PA.NUM_COUREUR=CRR.NUM_COUREUR
        WHERE CO.NUM_COURSE = cnum
        AND CO.NUM_ETAPE = enum;
    return res;
  END;
  
 /* FUNCTION GetIndForEtape(cnum number,enum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
        OPEN res FOR
          SELECT 
             CRR.NOM_PAYS
            ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
            ,PA.NUM_DOSSARD
            ,PA.NOM_EQUIPE
            ,ATT.HEURE_PASSAGE
          FROM ATTEINDRE ATT inner join PARTICIPANT PA
          ON ATT.NUM_DOSSARD=PA.NUM_DOSSARD AND ATT.num_course=pa.num_course
          inner join COUREUR CRR
          ON PA.NUM_COUREUR=CRR.NUM_COUREUR
          WHERE ATT.NUM_COURSE = cnum
          AND ATT.NUM_ETAPE=enum
          GROUP BY CRR.NOM_PAYS, UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR), PA.NUM_DOSSARD, PA.NOM_EQUIPE;
          --ORDER BY sum(CO.TEMPS_GENERAL);
    return res;
  END;*/
  
  FUNCTION GetGeneralPois(cnum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT 
          row_number() over(order by CO.POINTS_MONTAGNE_GENERAL desc)
        ,CRR.NOM_PAYS
        ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
        ,PA.NUM_DOSSARD
        ,PA.NOM_EQUIPE
        ,CO.POINTS_MONTAGNE_GENERAL

      FROM COURIR CO inner join PARTICIPANT PA
      ON CO.NUM_DOSSARD=PA.NUM_DOSSARD AND co.num_course=pa.num_course
      inner join COUREUR CRR
      ON PA.NUM_COUREUR=CRR.NUM_COUREUR
      WHERE CO.NUM_COURSE = cnum
      AND CO.NUM_ETAPE = (select max(C1.NUM_ETAPE)
                                FROM COURIR C1
                                WHERE C1.num_course=2011
                                AND EXISTS ( SELECT * 
                                            FROM COURIR C2
                                            WHERE C2.NUM_COURSE = 2011
                                            AND C2.NUM_ETAPE = C1.NUM_ETAPE
                                            AND C2.TEMPS_GENERAL IS NOT NULL
                                          )
                          );
    return res;
  END;
  
  FUNCTION GetGeneralPoisForEtape(cnum number,enum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
        OPEN res FOR
      SELECT 
         row_number() over(order by CO.POINTS_MONTAGNE_GENERAL desc)
        ,CRR.NOM_PAYS
        ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
        ,PA.NUM_DOSSARD
        ,PA.NOM_EQUIPE
        ,CO.POINTS_MONTAGNE_GENERAL
        
      FROM COURIR CO inner join PARTICIPANT PA
      ON CO.NUM_DOSSARD=PA.NUM_DOSSARD AND co.num_course=pa.num_course
      inner join COUREUR CRR
      ON PA.NUM_COUREUR=CRR.NUM_COUREUR
      WHERE CO.NUM_COURSE = cnum
      AND CO.NUM_ETAPE = enum;
    return res;
  END;

  FUNCTION GetGeneralSprint(cnum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT 
         row_number() over(order by CO.POINTS_SPRINT_GENERAL desc)
        ,CRR.NOM_PAYS
        ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
        ,PA.NUM_DOSSARD
        ,PA.NOM_EQUIPE
        ,CO.POINTS_SPRINT_GENERAL
        
      FROM COURIR CO inner join PARTICIPANT PA
      ON CO.NUM_DOSSARD=PA.NUM_DOSSARD AND co.num_course=pa.num_course
      inner join COUREUR CRR
      ON PA.NUM_COUREUR=CRR.NUM_COUREUR
      WHERE CO.NUM_COURSE = cnum
      AND CO.NUM_ETAPE = (select max(C1.NUM_ETAPE)
                                FROM COURIR C1
                                WHERE C1.num_course=2011
                                AND EXISTS ( SELECT * 
                                            FROM COURIR C2
                                            WHERE C2.NUM_COURSE = 2011
                                            AND C2.NUM_ETAPE = C1.NUM_ETAPE
                                            AND C2.TEMPS_GENERAL IS NOT NULL
                                          )
                          );
    return res;
  END;
  
  FUNCTION GetGeneralSprintForEtape(cnum number,enum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT 
         row_number() over(order by CO.POINTS_SPRINT_GENERAL desc)
        ,CRR.NOM_PAYS
        ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
        ,PA.NUM_DOSSARD
        ,PA.NOM_EQUIPE
        ,CO.POINTS_SPRINT_GENERAL
        
      FROM COURIR CO inner join PARTICIPANT PA
      ON CO.NUM_DOSSARD=PA.NUM_DOSSARD AND co.num_course=pa.num_course
      inner join COUREUR CRR
      ON PA.NUM_COUREUR=CRR.NUM_COUREUR
      WHERE CO.NUM_COURSE = cnum
      AND CO.NUM_ETAPE = enum
      ORDER BY CO.POINTS_SPRINT_GENERAL desc;
    return res;
  END;
  
  FUNCTION GetGeneralEquipe(cnum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    NULL;
  END;
  
  FUNCTION GetGeneralEquipeForEtape(cnum number,enum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    NULL;
  END;
  
  FUNCTION GetGeneralJeune(cnum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT
              row_number() over(order by CO.TEMPS_GENERAL)
              ,CRR.NOM_PAYS
              ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
              ,PA.NUM_DOSSARD
              ,PA.NOM_EQUIPE
              ,CO.TEMPS_GENERAL        
            FROM COURIR CO inner join PARTICIPANT PA
            ON CO.NUM_DOSSARD=PA.NUM_DOSSARD AND co.num_course=pa.num_course
            inner join COUREUR CRR
            ON PA.NUM_COUREUR=CRR.NUM_COUREUR
            WHERE CO.NUM_COURSE = cnum
            AND CO.NUM_ETAPE = (select max(C1.NUM_ETAPE)
                                FROM COURIR C1
                                WHERE C1.num_course=cnum
                                AND EXISTS ( SELECT * 
                                            FROM COURIR C2
                                            WHERE C2.NUM_COURSE = cnum
                                            AND C2.NUM_ETAPE = C1.NUM_ETAPE
                                            AND C2.TEMPS_GENERAL IS NOT NULL
                                          )
                                )
             AND trunc((months_between(sysdate, CRR.DATE_NAISSANCE_COUREUR))/12) < 25; 
     
    return res;
  END;
  
  FUNCTION GetGeneralJeuneForEtape(cnum number,enum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT 
         row_number() over(order by CO.TEMPS_GENERAL)
        ,CRR.NOM_PAYS
        ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
        ,PA.NUM_DOSSARD
        ,PA.NOM_EQUIPE
        ,CO.TEMPS_GENERAL
--        ,sum(CO.TEMPS_GENERAL)-(SELECT
        
      FROM COURIR CO inner join PARTICIPANT PA
      ON CO.NUM_DOSSARD=PA.NUM_DOSSARD AND co.num_course=pa.num_course
      inner join COUREUR CRR
      ON PA.NUM_COUREUR=CRR.NUM_COUREUR
      WHERE CO.NUM_COURSE = cnum
      AND CO.NUM_ETAPE = enum
      AND trunc((months_between(sysdate, CRR.DATE_NAISSANCE_COUREUR))/12) < 25 ;
      --ORDER BY sum(CO.TEMPS_GENERAL);
    return res;
  END;
  
  FUNCTION GetGeneralCombatif(cnum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT 
         CRR.NOM_PAYS
        ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
        ,PA.NUM_DOSSARD
        ,PA.NOM_EQUIPE
        --,count(*)
        
      FROM VOTE_COMBATIF_ETAPE VCE inner join PARTICIPANT PA
      ON VCE.NUM_DOSSARD=PA.NUM_DOSSARD AND VCE.num_course=pa.num_course
      inner join COUREUR CRR
      ON PA.NUM_COUREUR=CRR.NUM_COUREUR
      WHERE rownum = 1
      AND VCE.NUM_COURSE = cnum
      GROUP BY CRR.NOM_PAYS, UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR), PA.NUM_DOSSARD, PA.NOM_EQUIPE
      ORDER BY count(*) DESC;
    return res;
  END;
  
  FUNCTION GetGeneralCombatifForEtape(cnum number,enum number)return sqlcur
  IS
  res sqlcur;
  BEGIN
    OPEN res FOR
      SELECT
         CRR.NOM_PAYS
        ,UPPER(CRR.NOM_COUREUR) || ' ' || INITCAP(CRR.PRENOM_COUREUR) "Coureur"
        ,PA.NUM_DOSSARD
        ,PA.NOM_EQUIPE
        
      FROM VOTE_COMBATIF_ETAPE VCE inner join PARTICIPANT PA
      ON VCE.NUM_DOSSARD=PA.NUM_DOSSARD AND VCE.num_course=pa.num_course
      inner join COUREUR CRR
      ON PA.NUM_COUREUR=CRR.NUM_COUREUR
      WHERE rownum = 1
      AND VCE.NUM_COURSE = cnum
      AND VCE.NUM_ETAPE = enum;
    return res;
  END;

END PA_CLASSEMENT;
/

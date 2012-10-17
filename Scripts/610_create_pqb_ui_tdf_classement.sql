
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."UI_CLASSEMENT" IS
  PROCEDURE AffTabInd
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_temps COURIR.TEMPS_GENERAL%type;
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Durée');
    
    classement := pa_classement.getgeneralind(numcourse);
      LOOP
      FETCH classement
      INTO  v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_temps;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang); 
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(EXTRACT(DAY FROM v_temps) || 'j ' || EXTRACT(HOUR FROM v_temps) || ':' || EXTRACT(MINUTE FROM v_temps) || ':' || EXTRACT(SECOND FROM v_temps));

      --htp.tableData(v_ecart);
      htp.tableRowClose;

   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  
  PROCEDURE AffTabIndForEtape(enum number)
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_temps COURIR.TEMPS_GENERAL%type;
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Durée');
    
    classement := pa_classement.getgeneralindforetape(numcourse,enum);
      LOOP
      FETCH classement
      INTO  v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_temps;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang);
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(EXTRACT(DAY FROM v_temps) || 'j ' || EXTRACT(HOUR FROM v_temps) || ':' || EXTRACT(MINUTE FROM v_temps) || ':' || EXTRACT(SECOND FROM v_temps));
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabIndForKm(enum number, km number)
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_temps COURIR.TEMPS_GENERAL%type;
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.header(2, 'Classement au point kilométrique ' || km || ' de l''étape ' || enum || ' : ');
    htp.print(htf.anchor('etape_detail?num_etape=' || enum, 'Retour'));

    htp.tableOpen;
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Durée');
    
    classement := pa_classement.GetEtapeIndForKm(numcourse,enum, km);
      LOOP
      FETCH classement
      INTO  v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_temps;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang);
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(EXTRACT(DAY FROM v_temps) || 'j ' || EXTRACT(HOUR FROM v_temps) || ':' || EXTRACT(MINUTE FROM v_temps) || ':' || EXTRACT(SECOND FROM v_temps));
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
   
    htp.br; 
    htp.tableclose;
  END;
  
  
  
  PROCEDURE AffTabPois
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_points COURIR.POINTS_MONTAGNE_GENERAL%type;
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Points');
    
    classement := pa_classement.getgeneralpois(numcourse);
      LOOP
      FETCH classement
      INTO  v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_points;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang); 
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(v_points);
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabPoisForEtape(enum number)
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_points COURIR.POINTS_MONTAGNE_GENERAL%type;
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Points');
    
    classement := pa_classement.getgeneralpoisforetape(numcourse,enum);
      LOOP
      FETCH classement
      INTO  v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_points;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang); 
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(v_points);
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabSprint
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_points COURIR.POINTS_SPRINT_GENERAL%type;
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Points');
    
    classement := pa_classement.getgeneralsprint(numcourse);
      LOOP
      FETCH classement
      INTO v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_points;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang);
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(v_points);
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabSprintForEtape(enum number)
    IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_points COURIR.POINTS_SPRINT_GENERAL%type;
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Points');
    
    classement := pa_classement.getgeneralsprintforetape(numcourse,enum);
      LOOP
      FETCH classement
      INTO  v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_points;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang); 
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(v_points);
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabEquipe
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    --v_temps
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Position');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Durée');
    
    classement := pa_classement.getgeneralequipe(numcourse);
      LOOP
      FETCH classement
      INTO  v_pays, v_nomcoureur, v_numdossard, v_nomequipe;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      --htp.tableData(v_temps);
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabEquipeForEtape(enum number)
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    --v_temps
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Position');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Durée');
    
    classement := pa_classement.getgeneralequipeforetape(numcourse,enum);
      LOOP
      FETCH classement
      INTO  v_pays, v_nomcoureur, v_numdossard, v_nomequipe;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      --htp.tableData(v_temps);
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabJeune
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_temps COURIR.TEMPS_GENERAL%type;
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Durée');
    
      classement := pa_classement.getgeneraljeune(numcourse);
      LOOP
      FETCH classement
      INTO  v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_temps;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang); 
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(EXTRACT(DAY FROM v_temps) || 'j ' || EXTRACT(HOUR FROM v_temps) || ':' || EXTRACT(MINUTE FROM v_temps) || ':' || EXTRACT(SECOND FROM v_temps));
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabJeuneForEtape(enum number)
  IS
    numcourse number(4);
    classement sqlcur;
    v_rang number(3);
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
    v_temps COURIR.TEMPS_GENERAL%type;    
    --v_ecart
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Rang');
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    htp.tableheader ('Durée');

    classement := pa_classement.getgeneraljeuneforetape(numcourse,enum);
      LOOP
      FETCH classement
      INTO  v_rang, v_pays, v_nomcoureur, v_numdossard, v_nomequipe, v_temps;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_rang); 
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableData(EXTRACT(DAY FROM v_temps) || 'j ' || EXTRACT(HOUR FROM v_temps) || ':' || EXTRACT(MINUTE FROM v_temps) || ':' || EXTRACT(SECOND FROM v_temps));
      --htp.tableData(v_ecart);
      htp.tableRowClose;
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabCombatif
  IS
    numcourse number(4);
    classement sqlcur;
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    
    classement := pa_classement.getgeneralcombatif(numcourse);
      LOOP
      FETCH classement
      INTO  v_pays, v_nomcoureur, v_numdossard, v_nomequipe;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableRowClose;

   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabCombatifForEtape(enum number)
  IS
    numcourse number(4);
    classement sqlcur;
    v_pays COUREUR.nom_pays%type;
    v_nomcoureur varchar2(200);
    v_numdossard PARTICIPANT.NUM_DOSSARD%type;
    v_nomequipe PARTICIPANT.NOM_EQUIPE%type;
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.tableOpen;
    htp.tableheader ('Pays');
    htp.tableheader ('Coureur');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');
    
    classement := pa_classement.GetGeneralCombatifForEtape(numcourse,enum);
      LOOP
      FETCH classement
      INTO  v_pays, v_nomcoureur, v_numdossard, v_nomequipe;
      EXIT WHEN classement%NOTFOUND;
      htp.tableRowOpen;
      htp.tableData(v_pays); 
      htp.tableData(v_nomcoureur);
      htp.tableData(v_numdossard);
      htp.tableData(v_nomequipe);
      htp.tableRowClose;
      
   END LOOP;
   CLOSE classement;
    htp.br; 
    htp.tableclose;
  END;
  
END UI_CLASSEMENT;
/

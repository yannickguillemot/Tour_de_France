
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."UI_PARTENAIRE" IS
  PROCEDURE AffTab
  IS
    partenaires sqlcur;
    rec_partenaire partenaire%rowtype;
    numcourse number(4);
    
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));
    
    htp.tableOpen;
    htp.tableRowOpen;

    partenaires := pa_partenaire.GetForCourse(numcourse);
    fetch partenaires into rec_partenaire;
    while(partenaires%FOUND)
    loop
      htp.tableData( rec_partenaire.nom_partenaire);
      fetch partenaires into rec_partenaire;
    end loop;

    htp.tableRowClose;
    htp.tableclose;
  END;
END UI_PARTENAIRE;
/

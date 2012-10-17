
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."UI_ETAPE" IS
  PROCEDURE AffTabForCourse(cnum number)
  IS
    etapes sqlcur;
    rec_etape etape%rowtype;
    rec_typeetape type_etape%rowtype;
    rec_villedepart ville%rowtype;
    rec_villearrivee ville%rowtype;
    
  BEGIN
  
    htp.header(2, 'Liste des étapes du Tour ' || cnum || ' :');

    
    htp.tableOpen;
    htp.tableheader ('Etape');
    htp.tableheader ('Départ-Arrivée');
    htp.tableheader ('Type');
    htp.tableheader ('Nombre de KMs');
    htp.tableheader ('Date');
    
    etapes := pa_etape.GetForCourse(cnum);
    fetch etapes into rec_etape;
    while(etapes%FOUND)
    loop
      rec_typeetape := pa_type_etape.Get(rec_etape.num_type_etape);
     
      rec_villedepart := pa_ville.GetVilleDepartForEtape(cnum, rec_etape.num_etape);
      rec_villearrivee := pa_ville.GetVilleArriveeForEtape(cnum, rec_etape.num_etape);

      htp.tableRowOpen;
      htp.tableData( rec_etape.num_etape); 
      htp.tableData( htf.anchor('etape_detail?num_etape=' || rec_etape.num_etape, rec_villedepart.nom_ville || '-' || rec_villearrivee.nom_ville)); 
      htp.tableData( rec_typeetape.libelle_type_etape); 
      htp.tableData( rec_etape.nb_km_etape ); 
      htp.tableData( 'Le ' || TO_CHAR(rec_etape.date_etape, 'DD/MM/YYYY') || ' à ' || TO_CHAR(rec_etape.date_etape, 'HH24:MI'));

      htp.tableRowClose;
      fetch etapes into rec_etape;
    end loop;
  
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabForEtape(num_etape number)
  IS
    numcourse number(4);
    rec_typeetape type_etape%rowtype;
    rec_etape etape%rowtype;
    rec_villedepart ville%rowtype;
    rec_villearrivee ville%rowtype;
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    rec_etape := pa_etape.Get(numcourse, num_etape); 
 
    rec_typeetape := pa_type_etape.Get(rec_etape.num_type_etape);
    rec_villedepart := pa_ville.GetVilleDepartForEtape(numcourse, num_etape);
    rec_villearrivee := pa_ville.GetVilleArriveeForEtape(numcourse, num_etape);
        
    htp.header(2, 'Etape ' || num_etape || ' : ' || rec_typeetape.libelle_type_etape);

    htp.bold('Date de début de l''étape : ');
    htp.print(TO_CHAR(rec_etape.date_etape, 'DD/MM/YYYY') || ' à ' || TO_CHAR(rec_etape.date_etape, 'HH24:MI'));
    htp.br;
    htp.bold('Nombre de kilomètres : ');
    htp.print(rec_etape.nb_km_etape || ' kilomètres');
    htp.br;
    htp.br;

    htp.header(3, 'Ville de départ : ' || rec_villedepart.nom_ville);
    htp.bold('Code postal : ');
    htp.print(rec_villedepart.code_commune);
    htp.br;
    htp.bold('Région : ');
    htp.print(rec_villedepart.region_ville);
    htp.br;
    htp.bold('Pays : ');
    htp.print(rec_villedepart.nom_pays);
    htp.br;
    htp.br;
    
    htp.bold('Altitude : ');
    htp.print(rec_villedepart.altitude_ville || ' mètres');
    htp.br;
    htp.bold('Nombre d''habitants : ');
    htp.print(rec_villedepart.nb_habitants_ville || ' habitants');
    htp.br;
    htp.br;

    htp.header(3, 'Ville d''arrivée : ' || rec_villearrivee.nom_ville); 
    htp.bold('Code postal : ');
    htp.print(rec_villearrivee.code_commune);
    htp.br;
    htp.bold('Région : ');
    htp.print(rec_villearrivee.region_ville);
    htp.br;
    htp.bold('Pays : ');
    htp.print(rec_villearrivee.nom_pays);
    htp.br;
    htp.br;
    
    htp.bold('Altitude : ');
    htp.print(rec_villearrivee.altitude_ville || ' mètres');
    htp.br;
    htp.bold('Nombre d''habitants : ');
    htp.print(rec_villearrivee.nb_habitants_ville || ' habitants');
    htp.br;
    
    htp.header(3, 'Points kilométriques');
    UI_POINT_KM.AffTabForCourseForEtape(numcourse, num_etape);  
    
    htp.header(3, 'Abandons');
    UI_PARTICIPANT.AffTabAbForCourseForEtape(numcourse, num_etape);
    
  END;
END UI_ETAPE;
/

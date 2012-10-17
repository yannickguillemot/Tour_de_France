
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."UI_POINT_KM" IS
  PROCEDURE AffTabForCourseForEtape(cnum number, enum number)
  IS
    points_kms sqlcur;
    rec_point_km point_km%rowtype;
    rec_etape etape%rowtype;
    rec_ville ville%rowtype;
    coursecookie varchar2(4);
  BEGIN

    htp.tableOpen; 
    htp.tableheader ('Libellé');
    htp.tableheader ('Km du départ');
    htp.tableheader ('Km de l''arrivée');
    htp.tableheader ('Lieu');
    htp.tableheader ('Heure prévue');
    
    rec_etape := pa_etape.get(cnum, enum);
    points_kms := pa_point_km.getforcourseforetape(cnum, enum); --numcourse
    fetch points_kms into rec_point_km;
    while(points_kms%found)
    loop
      rec_ville := pa_ville.get(rec_point_km.code_commune, rec_point_km.code_pays);
      htp.tableRowOpen;
      htp.tableData( rec_point_km.libelle_categorie);
      htp.tableData( rec_point_km.km); 
      htp.tableData( rec_etape.nb_km_etape - rec_point_km.km); 
      htp.tableData( rec_ville.nom_ville);
      htp.tableData( TO_CHAR(rec_point_km.heure_passage_point_km, 'HH24:MI')); 
      if (rec_point_km.km != 0) THEN
        htp.tableData( htf.anchor('km_detail?point_km=' || rec_point_km.km || '&num_etape=' || enum , 'Voir classement'));
      ELSE
        htp.tableData();
      END IF;

      htp.tableRowClose;
      fetch points_kms into rec_point_km;
    end loop;
    htp.br; 
    htp.tableclose;
  END;
END;
/

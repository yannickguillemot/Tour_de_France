
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."UI_PARTICIPANT" IS
  PROCEDURE AffTab
  IS
    participants sqlcur;
    rec_participant participant%rowtype;
    numcourse NUMBER(4);
    rec_coureur coureur%rowtype;
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    htp.header(2, 'Liste des participants en lice pour l''année ' || numcourse || ' :');

    htp.tableOpen;
    htp.tableheader ('Dossard');
    htp.tableheader ('Coureur');
    htp.tableheader ('Equipe');
    
    participants := pa_participant.getforcourse(numcourse); --numcourse
    fetch participants into rec_participant;
    while(participants%found)
    loop
      rec_coureur := pa_coureur.Get(rec_participant.num_coureur);
      htp.tableRowOpen;
      htp.tableData(rec_participant.num_dossard);
      htp.tableData(htf.anchor('participant_detail?num_participant=' || rec_coureur.num_coureur, rec_coureur.nom_coureur || ' ' || rec_coureur.prenom_coureur));
      htp.tableData(htf.anchor('equipe_detail?code_equipe=' || rec_participant.code_equipe, rec_participant.nom_equipe));
      htp.tableRowClose;
      fetch participants into rec_participant;
    end loop;

    htp.br; 
    htp.tableclose;
  END;

  PROCEDURE AffTabAbForCourseForEtape(cnum number, num_etape number)
  IS
    participants sqlcur;
    rec_participant participant%rowtype;
    coursecookie varchar2(4);
    rec_coureur coureur%rowtype;
  BEGIN

    htp.tableOpen;
    htp.tableheader ('Dossard');
    htp.tableheader ('Coureur');
    htp.tableheader ('Equipe');
    htp.tableheader ('Point kilométrique');
    htp.tableheader ('Raison de l abandon');
    
    participants := pa_participant.getabforcourseforetape(cnum, num_etape); --numcourse

    fetch participants into rec_participant;
    while(participants%found)
    loop
      rec_coureur := pa_coureur.Get(rec_participant.num_coureur);
      htp.tableRowOpen;
      htp.tableData(rec_participant.num_dossard); 
      htp.tableData(htf.anchor('participant_detail?num_participant=' || rec_coureur.num_coureur, rec_coureur.nom_coureur || ' ' || rec_coureur.prenom_coureur));
      htp.tableData(htf.anchor('equipe_detail?code_equipe=' || rec_participant.code_equipe, rec_participant.nom_equipe)); 
      htp.tableData(rec_participant.km); 
      htp.tableData(rec_participant.desc_abandon); 
      htp.tableRowClose;
      fetch participants into rec_participant;
    end loop;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabForEquipe(code_equipe varchar2, cnum number)
  IS
    participants sqlcur;
    rec_participant participant%rowtype;
    rec_coureur coureur%rowtype;
  BEGIN

    htp.tableOpen;
    htp.tableheader ('Dossard');
    htp.tableheader ('Coureur');
    htp.tableheader ('Pays');

    participants := pa_participant.GetForEquipeForCourse(code_equipe, cnum); --numcourse
    fetch participants into rec_participant;
    while(participants%found)
    loop
      rec_coureur := pa_coureur.Get(rec_participant.num_coureur);
      htp.tableRowOpen;
      htp.tableData(rec_participant.num_dossard);
      htp.tableData(htf.anchor('participant_detail?num_participant=' || rec_coureur.num_coureur, rec_coureur.nom_coureur || ' ' || rec_coureur.prenom_coureur));
      htp.tableData(rec_coureur.nom_pays);
      htp.tableRowClose;
      fetch participants into rec_participant;
    end loop;
    htp.br; 
    htp.tableclose;
  END;
  
    PROCEDURE AffTabForCoureur(cnum number)
  IS
    participants sqlcur;
    rec_participant participant%rowtype;
    rec_coureur coureur%rowtype;
  BEGIN

    htp.tableOpen;
    htp.tableheader ('Année');
    htp.tableheader ('Dossard');
    htp.tableheader ('Equipe');

    participants := pa_participant.GetForCoureur(cnum); --numcourse
    fetch participants into rec_participant;
    while(participants%found)
    loop
      rec_coureur := pa_coureur.Get(rec_participant.num_coureur);
      htp.tableRowOpen;
      htp.tableData(rec_participant.num_course);
      htp.tableData(rec_participant.num_dossard);
      htp.tableData(htf.anchor('equipe_detail?code_equipe=' || rec_participant.code_equipe,rec_participant.nom_equipe));

      htp.tableRowClose;
      fetch participants into rec_participant;
    end loop;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabForParticipant(pnum number)
  IS
    rec_coureur coureur%rowtype;
  BEGIN
    rec_coureur := pa_coureur.Get(pnum);

    htp.header(3, 'Fiche du coureur ' || rec_coureur.prenom_coureur || ' ' || rec_coureur.nom_coureur || ' :');

    htp.bold('Nationalité : ');
    htp.print(rec_coureur.nom_pays);
    htp.br;
    htp.bold('Né le : ');
    htp.print(TO_CHAR(rec_coureur.date_naissance_coureur, 'DD/MM/YYYY'));
    htp.br;
    htp.bold('Né à : ');
    htp.print(rec_coureur.ville_naissance_coureur);
    htp.br;
    htp.br;

    htp.bold('Taille : ');
    htp.print(rec_coureur.taille_coureur || ' centimètres');
    htp.br;
    htp.bold('Poids : ');
    htp.print(rec_coureur.poids_coureur || ' kilogrammes');    

    htp.header(2, 'Participations du coureur :');
    ui_participant.AffTabForCoureur(rec_coureur.num_coureur);

    htp.br; 
    htp.tableclose;
  END;
END UI_PARTICIPANT;
/

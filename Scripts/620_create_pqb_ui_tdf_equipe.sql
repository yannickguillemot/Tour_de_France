
  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."UI_EQUIPE" IS
  PROCEDURE AffTabForCourse(cnum number)
  IS
    equipes sqlcur;
    rec_equipe equipe%rowtype;
    rec_typeetape type_etape%rowtype;
  BEGIN
    htp.header(2, 'Liste des équipes en lice pour l''année ' || cnum || ' :');

    htp.tableOpen;
    htp.tableheader ('Nom');
    htp.tableheader ('Code');
    htp.tableheader ('Directeur sportif');
    htp.tableheader ('Budget (Euros)');
    htp.tableheader ('Participants');

    equipes := pa_equipe.getforcourse(cnum); --numcourse
    fetch equipes into rec_equipe;
    while(equipes%found)
    loop
      htp.tableRowOpen;
      htp.tableData(htf.anchor('equipe_detail?code_equipe=' || rec_equipe.code_equipe,rec_equipe.nom_equipe));
      htp.tableData(rec_equipe.code_equipe);
      htp.tableData(rec_equipe.directeur_sportif_equipe);
      htp.tableData(rec_equipe.budget_equipe || ' Millions');
      htp.tableData(pa_participant.GetNbForEquipeForCourse(rec_equipe.code_equipe, rec_equipe.num_course)); 
      htp.tableRowClose;
      fetch equipes into rec_equipe;
    end loop;
    htp.br; 
    htp.tableclose;
  END;
  
  PROCEDURE AffTabForEquipe(code_equipe varchar2)
  IS
    numcourse number(4);

    equipes sqlcur;
    rec_equipe equipe%rowtype;
    coursecookie varchar2(4);
    rec_typeetape type_etape%rowtype;
  BEGIN
    numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

    rec_equipe := pa_equipe.Get(numcourse, code_equipe);

    htp.header(2, 'Fiche de l''équipe ' || rec_equipe.nom_equipe || ' :');

    htp.bold('Code équipe : ');
    htp.print(rec_equipe.code_equipe);
    htp.br;
    htp.bold('Directeur sportif : ');
    htp.print(rec_equipe.directeur_sportif_equipe);
    htp.br;
    htp.bold('Budget : ');
    htp.print(rec_equipe.budget_equipe || ' Millions');
    htp.br;
    
    htp.header(3, 'Coureurs membres de l''équipe :');
    UI_PARTICIPANT.AffTabForEquipe(code_equipe, numcourse);

    htp.header(3, 'Participation aux courses :');

    htp.tableOpen;
    htp.tableheader ('Participation');
    htp.tableheader ('Nom');
    htp.tableheader ('Code');
    htp.tableheader ('Directeur sportif');
    htp.tableheader ('Budget (Euros)');
    htp.tableheader ('Participants');

    equipes := pa_equipe.getpartforequipe(code_equipe); --numcourse
    fetch equipes into rec_equipe;
    while(equipes%found)
    loop
      htp.tableRowOpen;
      htp.tableData(rec_equipe.num_course);
      htp.tableData(rec_equipe.nom_equipe);
      htp.tableData(rec_equipe.code_equipe);
      htp.tableData(rec_equipe.directeur_sportif_equipe);
      htp.tableData(rec_equipe.budget_equipe || ' Millions');
      htp.tableData(pa_participant.GetNbForEquipeForCourse(rec_equipe.code_equipe, rec_equipe.num_course)); 

      htp.tableRowClose;
      fetch equipes into rec_equipe;
    end loop;
    htp.br; 
    htp.tableclose;
  END;
  
END UI_EQUIPE;
/

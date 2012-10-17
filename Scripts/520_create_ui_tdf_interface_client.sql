create or replace
PROCEDURE CLASSEMENTS_COMBATIF (num_etape varchar2 default null) AS 
  rep_css varchar2(255) :='/public/P12/G16_TDF/css/';
  rep_img varchar2(255) :='/public/P12/G16_TDF/img/';
  nbetapes number(2);
  numcourse number(4);
BEGIN
  numcourse := ui_commun.GetCookieValue('course', '2011');
  UI_COMMUN.AffHeader;
  
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    HTP.div(cattributes => 'id="desc"');
      HTP.header(2,'Classement du Combatif');
      HTP.p('Pour afficher les classements g&eacute;n&eacute;raux &agrave; l''issue d''une &eacute;tape, s&eacute;lectionnez l''&eacute;tape souhait&eacute;e dans la liste ci-dessous');
      htp.br;
      htp.br;
      nbetapes := PA_ETAPE.getnbetapesforcourse(numcourse);
      HTP.formOpen(owa_util.get_owa_service_path || 'classements_combatif', 'POST', cattributes => 'class="autosubmit2"');
      HTP.formSelectOpen('num_etape','Etape : ',cattributes => 'id="ddl_etapes"');
      HTP.formSelectOption('Sélectionnez une étape');
      FOR i in 1..nbetapes
      loop
        HTP.formSelectOption(i || ' ' || pa_ville.GetVilleDepartForEtape(numcourse,i).nom_ville || ' - ' || pa_ville.GetVilleArriveeForEtape(numcourse,i).nom_ville,cattributes => 'value="' || i || '"');
      end loop;
      HTP.formSelectClose;
      HTP.formClose;
        htp.anchor('classements_ind',htf.img(rep_img || 'maillotJaune.gif') || 'Individuel');
        htp.anchor('classements_pois',htf.img(rep_img || 'maillotApois.gif') || 'Grimpeur');
        htp.anchor('classements_sprint',htf.img(rep_img || 'maillotVert.gif') ||'Points');
        htp.anchor('classements_jeune',htf.img(rep_img || 'maillotBlanc.gif') || 'Jeune');
        htp.anchor('classements_combatif',htf.img(rep_img || 'maillotCombattif.gif') || 'Combatif');
        htp.br;
      IF num_etape IS NULL THEN
       UI_CLASSEMENT.AffTabCombatif;
      ELSE
       UI_CLASSEMENT.AffTabCombatifForEtape(to_number(num_etape));
      END IF ;
    HTP.print('</div>');
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END CLASSEMENTS_COMBATIF;

create or replace
PROCEDURE CLASSEMENTS_EQUIPE (num_etape number DEFAULT NULL) AS 
  rep_css varchar2(255) :='/public/P12/G16_TDF/css/';
  rep_img varchar2(255) :='/public/P12/G16_TDF/img/';
  nbetapes number(2);
  numcourse number(4);
BEGIN
  numcourse := ui_commun.GetCookieValue('course', '2011');
  UI_COMMUN.AffHeader;

  
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    HTP.div(cattributes => 'id="desc"');
      HTP.header(2,'Classement par équipe');
      HTP.p('Pour afficher les classements g&eacute;n&eacute;raux &agrave; l''issue d''une &eacute;tape, s&eacute;lectionnez l''&eacute;tape souhait&eacute;e dans la liste ci-dessous');
      htp.br;
      htp.br;
      nbetapes := PA_ETAPE.getnbetapesforcourse(numcourse);
      HTP.formOpen(owa_util.get_owa_service_path || 'classements_equipe', 'POST', cattributes => 'class="autosubmit2"');
      HTP.formSelectOpen('num_etape','Etape : ',cattributes => 'id="ddl_etapes"');
      HTP.formSelectOption('Sélectionnez une étape');
      FOR i in 1..nbetapes
      loop
        HTP.formSelectOption(i || ' ' || pa_ville.GetVilleDepartForEtape(numcourse,i).nom_ville || ' - ' || pa_ville.GetVilleArriveeForEtape(numcourse,i).nom_ville,cattributes => 'value="' || i || '"');
      end loop;
      HTP.formSelectClose;
      HTP.formClose;
        htp.anchor('classements_ind',htf.img(rep_img || 'maillotJaune.gif') || 'Individuel');
        htp.anchor('classements_pois',htf.img(rep_img || 'maillotApois.gif') || 'Grimpeur');
        htp.anchor('classements_sprint',htf.img(rep_img || 'maillotVert.gif') ||'Points');
        htp.anchor('classements_jeune',htf.img(rep_img || 'maillotBlanc.gif') || 'Jeune');
        htp.anchor('classements_combatif',htf.img(rep_img || 'maillotCombattif.gif') || 'Combatif');
      htp.br;
      IF num_etape IS NULL THEN
       UI_CLASSEMENT.AffTabEquipe;
      ELSE
       UI_CLASSEMENT.AffTabEquipeForEtape(num_etape);
      END IF ;
    HTP.print('</div>');
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END CLASSEMENTS_EQUIPE;

create or replace
PROCEDURE classements_ind (num_etape varchar2 DEFAULT NULL) IS
  rep_css varchar2(255) :='/public/P12/G16_TDF/css/';
  rep_img varchar2(255) :='/public/P12/G16_TDF/img/';
  nbetapes number(2);
  numcourse number(4);
BEGIN
  numcourse := ui_commun.GetCookieValue('course', '2011');
  UI_COMMUN.AffHeader;
  
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    HTP.div(cattributes => 'id="desc"');
      HTP.header(2,'Classement Général Individuel');
      HTP.p('Pour afficher les classements g&eacute;n&eacute;raux &agrave; l''issue d''une &eacute;tape, s&eacute;lectionnez l''&eacute;tape souhait&eacute;e dans la liste ci-dessous');
      htp.br;
      htp.br;
      nbetapes := PA_ETAPE.getnbetapesforcourse(numcourse);
      HTP.formOpen(owa_util.get_owa_service_path || 'classements_ind', 'POST', cattributes => 'class="autosubmit2"');
      HTP.formSelectOpen('num_etape','Etape : ',cattributes => 'id="ddl_etapes"');
      HTP.formSelectOption('Sélectionnez une étape');
      FOR i in 1..nbetapes
      loop
        HTP.formSelectOption(i || ' ' || pa_ville.GetVilleDepartForEtape(numcourse,i).nom_ville || ' - ' || pa_ville.GetVilleArriveeForEtape(numcourse,i).nom_ville,cattributes => 'value="' || i || '"');
      end loop;
      HTP.formSelectClose;
      HTP.formClose;
        htp.anchor('classements_ind',htf.img(rep_img || 'maillotJaune.gif') || 'Individuel');
        htp.anchor('classements_pois',htf.img(rep_img || 'maillotApois.gif') || 'Grimpeur');
        htp.anchor('classements_sprint',htf.img(rep_img || 'maillotVert.gif') ||'Points');
        htp.anchor('classements_jeune',htf.img(rep_img || 'maillotBlanc.gif') || 'Jeune');
        htp.anchor('classements_combatif',htf.img(rep_img || 'maillotCombattif.gif') || 'Combatif');
      htp.br;
      IF num_etape IS NULL THEN
       UI_CLASSEMENT.AffTabInd;
      ELSE
       UI_CLASSEMENT.AffTabIndForEtape(to_number(num_etape));
      END IF ;
    HTP.print('</div>');
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END classements_ind;

create or replace
PROCEDURE CLASSEMENTS_JEUNE (num_etape varchar2 DEFAULT NULL) AS 
  rep_css varchar2(255) :='/public/P12/G16_TDF/css/';
  rep_img varchar2(255) :='/public/P12/G16_TDF/img/';
  nbetapes number(2);
  numcourse number(4);
BEGIN
  numcourse := ui_commun.GetCookieValue('course', '2011');
  UI_COMMUN.AffHeader;

	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    HTP.div(cattributes => 'id="desc"');
      HTP.header(2,'Classement du meilleur Jeune');
      HTP.p('Pour afficher les classements g&eacute;n&eacute;raux &agrave; l''issue d''une &eacute;tape, s&eacute;lectionnez l''&eacute;tape souhait&eacute;e dans la liste ci-dessous');
      htp.br;
      htp.br;
      nbetapes := PA_ETAPE.getnbetapesforcourse(numcourse);
      HTP.formOpen(owa_util.get_owa_service_path || 'classements_jeune', 'POST', cattributes => 'class="autosubmit2"');
      HTP.formSelectOpen('num_etape','Etape : ',cattributes => 'id="ddl_etapes"');
      HTP.formSelectOption('Sélectionnez une étape');
      FOR i in 1..nbetapes
      loop
        HTP.formSelectOption(i || ' ' || pa_ville.GetVilleDepartForEtape(numcourse,i).nom_ville || ' - ' || pa_ville.GetVilleArriveeForEtape(numcourse,i).nom_ville,cattributes => 'value="' || i || '"');
      end loop;
      HTP.formSelectClose;
      HTP.formClose;
        htp.anchor('classements_ind',htf.img(rep_img || 'maillotJaune.gif') || 'Individuel');
        htp.anchor('classements_pois',htf.img(rep_img || 'maillotApois.gif') || 'Grimpeur');
        htp.anchor('classements_sprint',htf.img(rep_img || 'maillotVert.gif') ||'Points');
        htp.anchor('classements_jeune',htf.img(rep_img || 'maillotBlanc.gif') || 'Jeune');
        htp.anchor('classements_combatif',htf.img(rep_img || 'maillotCombattif.gif') || 'Combatif');
        htp.br;
        IF num_etape IS NULL THEN
         UI_CLASSEMENT.AffTabJeune;
        ELSE
         UI_CLASSEMENT.AffTabJeuneForEtape(to_number(num_etape));
        END IF;    
      HTP.print('</div>');
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END CLASSEMENTS_JEUNE;

create or replace
PROCEDURE CLASSEMENTS_POIS (num_etape varchar2 DEFAULT NULL) AS 
  rep_css varchar2(255) :='/public/P12/G16_TDF/css/';
  rep_img varchar2(255) :='/public/P12/G16_TDF/img/';
  nbetapes number(2);
  numcourse number(4);
BEGIN
  numcourse := ui_commun.GetCookieValue('course', '2011');
  UI_COMMUN.AffHeader;
  
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    HTP.div(cattributes => 'id="desc"');
      HTP.header(2,'Classement du meilleur Grimpeur');
      HTP.p('Pour afficher les classements g&eacute;n&eacute;raux &agrave; l''issue d''une &eacute;tape, s&eacute;lectionnez l''&eacute;tape souhait&eacute;e dans la liste ci-dessous');
      htp.br;
      htp.br;
      nbetapes := PA_ETAPE.getnbetapesforcourse(numcourse);
      HTP.formOpen(owa_util.get_owa_service_path || 'classements_pois', 'POST', cattributes => 'class="autosubmit2"');
      HTP.formSelectOpen('num_etape','Etape : ',cattributes => 'id="ddl_etapes"');
      HTP.formSelectOption('Sélectionnez une étape');
      FOR i in 1..nbetapes
      loop
        HTP.formSelectOption(i || ' ' || pa_ville.GetVilleDepartForEtape(numcourse,i).nom_ville || ' - ' || pa_ville.GetVilleArriveeForEtape(numcourse,i).nom_ville,cattributes => 'value="' || i || '"');
      end loop;
      HTP.formSelectClose;
      HTP.formClose;
        htp.anchor('classements_ind',htf.img(rep_img || 'maillotJaune.gif') || 'Individuel');
        htp.anchor('classements_pois',htf.img(rep_img || 'maillotApois.gif') || 'Grimpeur');
        htp.anchor('classements_sprint',htf.img(rep_img || 'maillotVert.gif') ||'Points');
        htp.anchor('classements_jeune',htf.img(rep_img || 'maillotBlanc.gif') || 'Jeune');
        htp.anchor('classements_combatif',htf.img(rep_img || 'maillotCombattif.gif') || 'Combatif');
        htp.br;
        IF num_etape IS NULL THEN
         UI_CLASSEMENT.AffTabPois;
        ELSE
         UI_CLASSEMENT.AffTabPoisForEtape(to_number(num_etape));
        END IF ;
    HTP.print('</div>');
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END CLASSEMENTS_POIS;

create or replace
PROCEDURE CLASSEMENTS_SPRINT (num_etape varchar2 DEFAULT NULL) AS 
  rep_css varchar2(255) :='/public/P12/G16_TDF/css/';
  rep_img varchar2(255) :='/public/P12/G16_TDF/img/';
  nbetapes number(2);
  numcourse number(4);
BEGIN
  numcourse := ui_commun.GetCookieValue('course', '2011');
  UI_COMMUN.AffHeader;
  
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    HTP.div(cattributes => 'id="desc"');
      HTP.header(2,'Classement du meilleur Sprinteur');
      HTP.p('Pour afficher les classements g&eacute;n&eacute;raux &agrave; l''issue d''une &eacute;tape, s&eacute;lectionnez l''&eacute;tape souhait&eacute;e dans la liste ci-dessous');
      htp.br;
      htp.br;
      nbetapes := PA_ETAPE.getnbetapesforcourse(numcourse);
      HTP.formOpen(owa_util.get_owa_service_path || 'classements_sprint', 'POST', cattributes => 'class="autosubmit2"');
      HTP.formSelectOpen('num_etape','Etape : ',cattributes => 'id="ddl_etapes"');
      HTP.formSelectOption('Sélectionnez une étape');
      FOR i in 1..nbetapes
      loop
        HTP.formSelectOption(i || ' ' || pa_ville.GetVilleDepartForEtape(numcourse,i).nom_ville || ' - ' || pa_ville.GetVilleArriveeForEtape(numcourse,i).nom_ville,cattributes => 'value="' || i || '"');
      end loop;
      HTP.formSelectClose;
      HTP.formClose;
        htp.anchor('classements_ind',htf.img(rep_img || 'maillotJaune.gif') || 'Individuel');
        htp.anchor('classements_pois',htf.img(rep_img || 'maillotApois.gif') || 'Grimpeur');
        htp.anchor('classements_sprint',htf.img(rep_img || 'maillotVert.gif') ||'Points');
        htp.anchor('classements_jeune',htf.img(rep_img || 'maillotBlanc.gif') || 'Jeune');
        htp.anchor('classements_combatif',htf.img(rep_img || 'maillotCombattif.gif') || 'Combatif');
        htp.br;
        IF num_etape IS NULL THEN
         UI_CLASSEMENT.AffTabSprint;
        ELSE
         UI_CLASSEMENT.AffTabSprintForEtape(to_number(num_etape));
        END IF ;
    HTP.print('</div>');
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END CLASSEMENTS_SPRINT;

create or replace
PROCEDURE equipe_detail(code_equipe varchar2) IS
BEGIN
  UI_COMMUN.AffHeader;
	
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    UI_EQUIPE.AffTabForEquipe(code_equipe);
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END;

create or replace
PROCEDURE equipes IS
  numcourse number(4);

BEGIN
    numcourse := ui_commun.GetCookieValue('course', '2011');

  UI_COMMUN.AffHeader;
	
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    UI_EQUIPE.AffTabForCourse(numcourse);
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END equipes;

create or replace
PROCEDURE etape_detail(num_etape number) IS
BEGIN
  UI_COMMUN.AffHeader;
	
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    UI_ETAPE.AffTabForEtape(num_etape);
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END ;

create or replace
PROCEDURE etapes IS
  numcourse number(4);
BEGIN
  numcourse := ui_commun.GetCookieValue('course', '2011');
    
  UI_COMMUN.AffHeader;
	
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    UI_ETAPE.AffTabForCourse(numcourse);
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END etapes;

create or replace
PROCEDURE home IS
  numcourse number(4);
BEGIN
  numcourse := TO_NUMBER(ui_commun.getcookievalue('course'));

  UI_COMMUN.AffHeader;
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
  HTP.header(2, 'Bienvenue sur la page principale de la course de ' || numcourse);
  
  HTP.header(3, 'Nos partenaires : ');
  
  UI_PARTENAIRE.AffTab;
  
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END home;

create or replace
PROCEDURE km_detail(point_km number, num_etape number) IS
BEGIN
  UI_COMMUN.AffHeader;
	
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
  UI_CLASSEMENT.AffTabIndForKm(num_etape, point_km);
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END;

create or replace
PROCEDURE participant_detail(num_participant varchar2) IS
BEGIN
  UI_COMMUN.AffHeader;
	
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    UI_PARTICIPANT.AffTabForParticipant(num_participant);
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END;

create or replace
PROCEDURE participants IS
BEGIN
  UI_COMMUN.AffHeader;
	
	--CONTENT : Modif commence ICI --
	HTP.div(cattributes => 'id="content"');
    UI_PARTICIPANT.AffTab;
	HTP.print('</div>');
	
  UI_COMMUN.AffFooter;
	HTP.bodyclose;
	HTP.htmlclose;
END participants;

  CREATE OR REPLACE PACKAGE BODY "G16_TDF"."UI_COMMUN" 
IS
  rep_css varchar2(255) :='/public/P12/G16_TDF/css/';
  rep_img varchar2(255) :='/public/P12/G16_TDF/img/';
  rep_js varchar2(255) :='/public/P12/G16_TDF/js/';

  
	PROCEDURE AffHeader
	IS
  courses sqlcur;
  rec_course COURSE%rowtype;
	BEGIN
    HTP.headopen;
    HTP.print('<link type="text/css" rel="stylesheet" href="' || rep_css || 'style.css" />');
    htp.print ('<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.js"></script>');
    htp.print ('<script type="text/javascript" src="'|| rep_js || 'script.js"></script>');
    HTP.title('Tour de France - ' || ui_commun.GetCookieValue('course'));
    HTP.headclose;
    HTP.bodyopen;
    --HEADER--
    HTP.div(cattributes => 'id="header"');
      HTP.div(cattributes => 'id="banner"');
        HTP.anchor('home', htf.img(rep_img || 'banner.png'));
        HTP.div(cattributes => 'id="title"');
          HTP.header(1,'Projet BD50 : Tour de France');
          htp.formOpen(owa_util.get_owa_service_path || 'ui_commun.removeandsendcookie', 'POST', cattributes => 'class="autosubmit"'); 
          HTP.formHidden('cookie_name','course');
          HTP.formSelectOpen('cookie_val','Année:',cattributes => 'id="selectYear"');
          courses := pa_course.getall;
          fetch courses into rec_course;
          while(courses%FOUND)
          loop
            IF getcookievalue('course') = TO_CHAR(rec_course.num_course)
            THEN
              htp.formSelectOption(rec_course.num_course,'selected');
            ELSE
              htp.formSelectOption(rec_course.num_course);
            END IF;
            fetch courses into rec_course;
          end loop;
          HTP.formSelectClose;
          HTP.formClose;
        HTP.print('</div>');
      HTP.print('</div>');
    HTP.print('</div>');
    
    --NAVIGATION--
    HTP.div(cattributes => 'id="menu"');
      HTP.ulistOpen(cattributes => 'id="navigation"');
        HTP.listItem(htf.anchor('classements_ind','Classements'));
        HTP.listItem(htf.anchor('etapes','Etapes'));
        HTP.listItem(htf.anchor('participants','Participants'));
        HTP.listItem(htf.anchor('equipes','Equipes'));
      HTP.ulistClose;
    HTP.print('</div>');
	END;
	
	PROCEDURE AffFooter
	IS
	BEGIN
    HTP.div(cattributes => 'id="footer"');
		HTP.img(rep_img || 'utbm.jpg');
		HTP.div(cattributes => 'id="names"');
			HTP.p(	'Julien Klingenmeyer' || htf.br ||
					'Bastien Scheurer' || htf.br ||
					'Benjamin Bini' || htf.br ||
					'Yannick Guillemot');
		HTP.print('</div>');
    HTP.print('</div>');
	END;
  
    
  FUNCTION GetCookieValue(cookie_name varchar2, value_default varchar2 DEFAULT '2011') return varchar2
  IS
  res owa_cookie.cookie;
  BEGIN
    res := owa_cookie.get(cookie_name);
    IF (res.num_vals != 0) THEN
      RETURN res.vals(1);
    ELSE
      RETURN value_default;
    END IF;
  END;
     
  PROCEDURE RemoveAndSendCookie (
  cookie_name IN VARCHAR2,
  cookie_val IN VARCHAR2)
  IS
  BEGIN  
     -- Cookies must be set within the header
     OWA_UTIL.mime_header ('text/html', FALSE);
     -- Send a cookie if a name was entered
     IF cookie_name IS NOT NULL
     THEN
        IF getcookievalue(cookie_name) IS NOT NULL
        THEN
          --si le cookie existe déjà, faut l'enlever et le resender
          OWA_COOKIE.remove(cookie_name, getcookievalue(cookie_name));
        END IF;
        OWA_COOKIE.send (cookie_name, cookie_val);
     END IF;

          --redirect to the caller
     --owa_util.who_called_me(owner_name,caller_name,line_number,caller_type);
     --DBMS_OUTPUT.put_line(caller_name);
     owa_util.redirect_url('home');
     
     OWA_UTIL.http_header_close;
  END;
END;
/


  CREATE OR REPLACE PACKAGE "G16_TDF"."UI_COMMUN" 
IS
  TYPE sqlcur IS REF CURSOR;
	PROCEDURE AffHeader;
	PROCEDURE AffFooter;
  FUNCTION GetCookieValue(cookie_name varchar2, value_default varchar2 DEFAULT '2011') return varchar2;

  PROCEDURE RemoveAndSendCookie(cookie_name varchar2,cookie_val varchar2);
END;
/

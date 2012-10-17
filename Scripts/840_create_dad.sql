DBMS_EPG.drop_dad(
	dad_name=> 'G16_TDF_dad'
);

DBMS_EPG.create_dad(
dad_name=> 'G16_TDF_dad',
path => '/G16_TDF_dad/*');


-- définition des attributs

BEGIN
    DBMS_EPG.set_dad_attribute (
         dad_name => 'G16_TDF_dad',
         attr_name => 'default-page',
         attr_value => 'home');

    DBMS_EPG.set_dad_attribute (
         dad_name => 'G16_TDF_dad',
         attr_name => 'authentication-mode',
         attr_value => 'Basic');
END;
/

-- Utilisateur G16_TDF : en majuscule

begin
 dbms_epg.authorize_dad('G16_TDF_dad','G16_TDF');
end;
/
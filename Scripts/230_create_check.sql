-- ----------------------------------------------------------------------------------------------------------------------
--Restrictions on Check Constraints Check constraints are subject to the following restrictions:
--    - You cannot specify a check constraint for a view. However, you can define the view using the WITH CHECK OPTION clause, which is equivalent to specifying a check constraint for the view.
--    - The condition of a check constraint can refer to any column in the table, but it cannot refer to columns of other tables.
--    - Conditions of check constraints cannot contain the following constructs:
--        * Subqueries and scalar subquery expressions
--        * Calls to the functions that are not deterministic (CURRENT_DATE, CURRENT_TIMESTAMP, DBTIMEZONE, LOCALTIMESTAMP, SESSIONTIMEZONE, SYSDATE, SYSTIMESTAMP, UID, USER, and USERENV)
--        * Calls to user-defined functions
--        * Dereferencing of REF columns (for example, using the DEREF function)
--        * Nested table columns or attributes
--        * The pseudocolumns CURRVAL, NEXTVAL, LEVEL, or ROWNUM
--        * Date constants that are not fully specified
-- ----------------------------------------------------------------------------------------------------------------------

ALTER TABLE COUREUR
   (
    ADD CONSTRAINT chk_coureur_taille CHECK (TAILLE_COUREUR BETWEEN 110 AND 250),
    ADD CONSTRAINT chk_coureur_poids CHECK (POIDS_COUREUR BETWEEN 30 AND 200)
   ) ;
   
ALTER TABLE COURSE
   (
    ADD CONSTRAINT chk_course_fin CHECK (FIN_COURSE > DEBUT_COURSE)
   ) ;
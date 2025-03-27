DECLARE
   lv_modelo_auto VARCHAR2(20) := 'Matiz';
   lv_marca_auto  VARCHAR2(20) := 'Chevrolet';
   lv_year_auto NUMBER(4,0) := 2025;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Su auto es un: ' || lv_marca_auto || ' ' || lv_modelo_auto ||
   ' ' || lv_year_auto || ' ¡espero lo disfrute!');
END;

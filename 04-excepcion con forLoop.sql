--comentario de una linea
--SELECT first_name || ' ' || last_name
--FROM hr.employees
--WHERE employee_id = 100
DECLARE
    v_nombre VARCHAR2(20) := 'Sin Nombre';
    v_empleado_id NUMBER(3) := 100;
BEGIN
    FOR v_empleado_id IN 100..106
    LOOP
        SELECT 
            first_name || ' ' || last_name
        INTO 
            v_nombre
        FROM 
            hr.employees
        WHERE
            employee_id = v_empleado_id;
        dbms_output.put_line('El empleado ['|| v_empleado_id ||'] es: ' || v_nombre);
    END LOOP;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('El empleado del id: ' || v_empleado_id || ' NO EXISTE :(');
END;

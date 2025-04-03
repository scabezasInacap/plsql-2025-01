SELECT 
    CONCAT('123-',empleado_id) as "RUT",
    primer_nombre || ' ' || apellido as "NOMBRE_COMPLETO",
    sueldo,
    -- e.departamento_id as DEPARTMENT_ID,
    d.departamento_nombre as DEPARTMENT_NAME
FROM 
    empleado e JOIN departamento d ON (e.departamento_id = d.departamento_id)
ORDER BY 
    empleado_id ASC;

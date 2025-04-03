SELECT * FROM v_vista1;

UPDATE v_vista1 SET sueldo = 5000 WHERE RUT = '123-1';
commit;

UPDATE v_vista1 SET DEPARTMENT_NAME = 'INACAP' WHERE RUT = '123-1';

rollback;

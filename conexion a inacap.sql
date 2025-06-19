user: system
pass: 123456
  
-- retornara C## que es el prefijo que debemos anteponer a cada usuario.
SHOW PARAMETER COMMON_USER_PREFIX;

-- creamos el usuario *inventario* con contraseña *clave*
CREATE USER C##inventario IDENTIFIED BY clave;
-- asignamos tablespace por defecto, temporal, desbloqueo de cuenta y que pueda iniciar sesion. todo desde la conexión system
ALTER USER C##inventario DEFAULT TABLESPACE users;
ALTER USER C##inventario TEMPORARY TABLESPACE temp;
ALTER USER C##inventario ACCOUNT UNLOCK;
GRANT CREATE SESSION TO C##inventario;

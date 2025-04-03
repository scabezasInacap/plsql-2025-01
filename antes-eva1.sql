CREATE TABLE departamento(
    departamento_id NUMBER(3,0) PRIMARY KEY,
    departamento_nombre VARCHAR2(50) NOT NULL
);
INSERT INTO departamento (departamento_id, departamento_nombre) VALUES (1, 'Informatica');
INSERT INTO departamento (departamento_id, departamento_nombre) VALUES (2, 'Ciberseguridad');

CREATE TABLE empleado(
    empleado_id NUMBER(3,0) PRIMARY KEY,
    primer_nombre VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL,
    sueldo NUMBER(10,2) NOT NULL,
    departamento_id NUMBER(3,0) NOT NULL,
    CONSTRAINT fk_empleado_departamento
    FOREIGN KEY (departamento_id)
    REFERENCES departamento(departamento_id)
);

INSERT INTO EMPLEADO VALUES (1, 'Sebastian', 'Cabezas', 10000, 1);
INSERT INTO EMPLEADO VALUES (2, 'Javier', 'Pasten', 50000, 1);
INSERT INTO EMPLEADO VALUES (3, 'Alfonso', 'Cubillos', 15000, 1);
INSERT INTO EMPLEADO VALUES (4, 'Matias', 'Saldivia', 12000, 2);
INSERT INTO EMPLEADO VALUES (5, 'Francisco', 'Aguilar', 23000, 2);

commit;

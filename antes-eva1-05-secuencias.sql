CREATE SEQUENCE seq_dpto START WITH 3;

INSERT INTO departamento (departamento_id, departamento_nombre) VALUES (seq_dpto.NEXTVAL, 'VideoJuegos');
INSERT INTO departamento (departamento_id, departamento_nombre) VALUES (seq_dpto.NEXTVAL, 'IA');

select * from departamento;

rollback;

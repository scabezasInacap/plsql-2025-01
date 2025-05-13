CREATE TABLE COUNTRIES
   (
    COUNTRY_ID CHAR (2 BYTE)  NOT NULL ,
    COUNTRY_NAME VARCHAR2 (40 BYTE) ,
    REGION_ID NUMBER
   ) LOGGING
;

COMMENT ON COLUMN COUNTRIES.COUNTRY_ID IS 'Primary key of countries table.'
;


COMMENT ON COLUMN COUNTRIES.COUNTRY_NAME IS 'Country name'
;


COMMENT ON COLUMN COUNTRIES.REGION_ID IS 'Region ID for the country. Foreign key to region_id column in the departments table.'
;


CREATE UNIQUE INDEX COUNTRY_C_ID_PKX ON COUNTRIES
   (
    COUNTRY_ID ASC
   )
;


ALTER TABLE COUNTRIES
   ADD CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY ( COUNTRY_ID ) ;






CREATE TABLE DEPARTMENTS
   (
    DEPARTMENT_ID NUMBER (4)  NOT NULL ,
    DEPARTMENT_NAME VARCHAR2 (30 BYTE)  NOT NULL ,
    MANAGER_ID NUMBER (6) ,
    LOCATION_ID NUMBER (4)
   ) LOGGING
;






COMMENT ON COLUMN DEPARTMENTS.DEPARTMENT_ID IS 'Primary key column of departments table.'
;


COMMENT ON COLUMN DEPARTMENTS.DEPARTMENT_NAME IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. '
;


COMMENT ON COLUMN DEPARTMENTS.MANAGER_ID IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.'
;


COMMENT ON COLUMN DEPARTMENTS.LOCATION_ID IS 'Location id where a department is located. Foreign key to location_id column of locations table.'
;


CREATE INDEX DEPT_LOCATION_IX ON DEPARTMENTS
   (
    LOCATION_ID ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE UNIQUE INDEX DEPT_ID_PKX ON DEPARTMENTS
   (
    DEPARTMENT_ID ASC
   )
;


ALTER TABLE DEPARTMENTS
   ADD CONSTRAINT DEPT_ID_PK PRIMARY KEY ( DEPARTMENT_ID ) ;






CREATE TABLE EMPLOYEES
   (
    EMPLOYEE_ID NUMBER (6)  NOT NULL ,
    FIRST_NAME VARCHAR2 (20 BYTE) ,
    LAST_NAME VARCHAR2 (25 BYTE)  NOT NULL ,
    EMAIL VARCHAR2 (25 BYTE)  NOT NULL ,
    PHONE_NUMBER VARCHAR2 (20 BYTE) ,
    HIRE_DATE DATE  NOT NULL ,
    JOB_ID VARCHAR2 (10 BYTE)  NOT NULL ,
    SALARY NUMBER (8,2) ,
    COMMISSION_PCT NUMBER (2,2) ,
    MANAGER_ID NUMBER (6) ,
    DEPARTMENT_ID NUMBER (4)
   ) LOGGING
;






ALTER TABLE EMPLOYEES
   ADD CONSTRAINT EMP_SALARY_MIN
   CHECK ( salary > 0)
;




COMMENT ON COLUMN EMPLOYEES.EMPLOYEE_ID IS 'Primary key of employees table.'
;


COMMENT ON COLUMN EMPLOYEES.FIRST_NAME IS 'First name of the employee. A not null column.'
;


COMMENT ON COLUMN EMPLOYEES.LAST_NAME IS 'Last name of the employee. A not null column.'
;


COMMENT ON COLUMN EMPLOYEES.EMAIL IS 'Email id of the employee'
;


COMMENT ON COLUMN EMPLOYEES.PHONE_NUMBER IS 'Phone number of the employee; includes country code and area code'
;


COMMENT ON COLUMN EMPLOYEES.HIRE_DATE IS 'Date when the employee started on this job. A not null column.'
;


COMMENT ON COLUMN EMPLOYEES.JOB_ID IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.'
;


COMMENT ON COLUMN EMPLOYEES.SALARY IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)'
;


COMMENT ON COLUMN EMPLOYEES.COMMISSION_PCT IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage'
;


COMMENT ON COLUMN EMPLOYEES.MANAGER_ID IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)'
;


COMMENT ON COLUMN EMPLOYEES.DEPARTMENT_ID IS 'Department id where employee works; foreign key to department_id
column of the departments table'
;


CREATE INDEX EMP_DEPARTMENT_IX ON EMPLOYEES
   (
    DEPARTMENT_ID ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE INDEX EMP_JOB_IX ON EMPLOYEES
   (
    JOB_ID ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE INDEX EMP_MANAGER_IX ON EMPLOYEES
   (
    MANAGER_ID ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE INDEX EMP_NAME_IX ON EMPLOYEES
   (
    LAST_NAME ASC ,
    FIRST_NAME ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE UNIQUE INDEX EMP_EMP_ID_PKX ON EMPLOYEES
   (
    EMPLOYEE_ID ASC
   )
;


ALTER TABLE EMPLOYEES
   ADD CONSTRAINT EMP_EMP_ID_PK PRIMARY KEY ( EMPLOYEE_ID ) ;


ALTER TABLE EMPLOYEES
   ADD CONSTRAINT EMP_EMAIL_UK UNIQUE ( EMAIL ) ;






CREATE TABLE JOBS
   (
    JOB_ID VARCHAR2 (10 BYTE)  NOT NULL ,
    JOB_TITLE VARCHAR2 (35 BYTE)  NOT NULL ,
    MIN_SALARY NUMBER (6) ,
    MAX_SALARY NUMBER (6)
   ) LOGGING
;






COMMENT ON COLUMN JOBS.JOB_ID IS 'Primary key of jobs table.'
;


COMMENT ON COLUMN JOBS.JOB_TITLE IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT'
;


COMMENT ON COLUMN JOBS.MIN_SALARY IS 'Minimum salary for a job title.'
;


COMMENT ON COLUMN JOBS.MAX_SALARY IS 'Maximum salary for a job title'
;


CREATE UNIQUE INDEX JOB_ID_PKX ON JOBS
   (
    JOB_ID ASC
   )
;


ALTER TABLE JOBS
   ADD CONSTRAINT JOB_ID_PK PRIMARY KEY ( JOB_ID ) ;






CREATE TABLE JOB_HISTORY
   (
    EMPLOYEE_ID NUMBER (6)  NOT NULL ,
    START_DATE DATE  NOT NULL ,
    END_DATE DATE  NOT NULL ,
    JOB_ID VARCHAR2 (10 BYTE)  NOT NULL ,
    DEPARTMENT_ID NUMBER (4)
   ) LOGGING
;






ALTER TABLE JOB_HISTORY
   ADD CONSTRAINT JHIST_DATE_CHECK
   CHECK (end_date > start_date)
       INITIALLY IMMEDIATE
       ENABLE
       VALIDATE
;




COMMENT ON COLUMN JOB_HISTORY.EMPLOYEE_ID IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table'
;


COMMENT ON COLUMN JOB_HISTORY.START_DATE IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)'
;


COMMENT ON COLUMN JOB_HISTORY.END_DATE IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)'
;


COMMENT ON COLUMN JOB_HISTORY.JOB_ID IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.'
;


COMMENT ON COLUMN JOB_HISTORY.DEPARTMENT_ID IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table'
;


CREATE INDEX JHIST_JOB_IX ON JOB_HISTORY
   (
    JOB_ID ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE INDEX JHIST_EMP_IX ON JOB_HISTORY
   (
    EMPLOYEE_ID ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE INDEX JHIST_DEPT_IX ON JOB_HISTORY
   (
    DEPARTMENT_ID ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE UNIQUE INDEX JHIST_ID_DATE_PKX ON JOB_HISTORY
   (
    EMPLOYEE_ID ASC ,
    START_DATE ASC
   )
;


ALTER TABLE JOB_HISTORY
   ADD CONSTRAINT JHIST_ID_DATE_PK PRIMARY KEY ( EMPLOYEE_ID, START_DATE ) ;






CREATE TABLE LOCATIONS
   (
    LOCATION_ID NUMBER (4)  NOT NULL ,
    STREET_ADDRESS VARCHAR2 (40 BYTE) ,
    POSTAL_CODE VARCHAR2 (12 BYTE) ,
    CITY VARCHAR2 (30 BYTE)  NOT NULL ,
    STATE_PROVINCE VARCHAR2 (25 BYTE) ,
    COUNTRY_ID CHAR (2 BYTE)
   ) LOGGING
;






COMMENT ON COLUMN LOCATIONS.LOCATION_ID IS 'Primary key of locations table'
;


COMMENT ON COLUMN LOCATIONS.STREET_ADDRESS IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name'
;


COMMENT ON COLUMN LOCATIONS.POSTAL_CODE IS 'Postal code of the location of an office, warehouse, or production site
of a company. '
;


COMMENT ON COLUMN LOCATIONS.CITY IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. '
;


COMMENT ON COLUMN LOCATIONS.STATE_PROVINCE IS 'State or Province where an office, warehouse, or production site of a
company is located.'
;


COMMENT ON COLUMN LOCATIONS.COUNTRY_ID IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.'
;


CREATE INDEX LOC_CITY_IX ON LOCATIONS
   (
    CITY ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE INDEX LOC_STATE_PROV_IX ON LOCATIONS
   (
    STATE_PROVINCE ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE INDEX LOC_COUNTRY_IX ON LOCATIONS
   (
    COUNTRY_ID ASC
   )
   LOGGING
   NOCOMPRESS
   NOPARALLEL
;


CREATE UNIQUE INDEX LOC_ID_PKX ON LOCATIONS
   (
    LOCATION_ID ASC
   )
;


ALTER TABLE LOCATIONS
   ADD CONSTRAINT LOC_ID_PK PRIMARY KEY ( LOCATION_ID ) ;






CREATE TABLE REGIONS
   (
    REGION_ID NUMBER  NOT NULL ,
    REGION_NAME VARCHAR2 (25 BYTE)
   ) LOGGING
;






CREATE UNIQUE INDEX REG_ID_PKX ON REGIONS
   (
    REGION_ID ASC
   )
;


ALTER TABLE REGIONS
   ADD CONSTRAINT REG_ID_PK PRIMARY KEY ( REGION_ID ) ;








ALTER TABLE COUNTRIES
   ADD CONSTRAINT COUNTR_REG_FK FOREIGN KEY
   (
    REGION_ID
   )
   REFERENCES REGIONS
   (
    REGION_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE DEPARTMENTS
   ADD CONSTRAINT DEPT_LOC_FK FOREIGN KEY
   (
    LOCATION_ID
   )
   REFERENCES LOCATIONS
   (
    LOCATION_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE DEPARTMENTS
   ADD CONSTRAINT DEPT_MGR_FK FOREIGN KEY
   (
    MANAGER_ID
   )
   REFERENCES EMPLOYEES
   (
    EMPLOYEE_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE EMPLOYEES
   ADD CONSTRAINT EMP_DEPT_FK FOREIGN KEY
   (
    DEPARTMENT_ID
   )
   REFERENCES DEPARTMENTS
   (
    DEPARTMENT_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE EMPLOYEES
   ADD CONSTRAINT EMP_JOB_FK FOREIGN KEY
   (
    JOB_ID
   )
   REFERENCES JOBS
   (
    JOB_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE EMPLOYEES
   ADD CONSTRAINT EMP_MANAGER_FK FOREIGN KEY
   (
    MANAGER_ID
   )
   REFERENCES EMPLOYEES
   (
    EMPLOYEE_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE JOB_HISTORY
   ADD CONSTRAINT JHIST_DEPT_FK FOREIGN KEY
   (
    DEPARTMENT_ID
   )
   REFERENCES DEPARTMENTS
   (
    DEPARTMENT_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE JOB_HISTORY
   ADD CONSTRAINT JHIST_EMP_FK FOREIGN KEY
   (
    EMPLOYEE_ID
   )
   REFERENCES EMPLOYEES
   (
    EMPLOYEE_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE JOB_HISTORY
   ADD CONSTRAINT JHIST_JOB_FK FOREIGN KEY
   (
    JOB_ID
   )
   REFERENCES JOBS
   (
    JOB_ID
   )
   NOT DEFERRABLE
;






ALTER TABLE LOCATIONS
   ADD CONSTRAINT LOC_C_ID_FK FOREIGN KEY
   (
    COUNTRY_ID
   )
   REFERENCES COUNTRIES
   (
    COUNTRY_ID
   )
   NOT DEFERRABLE
;




CREATE OR REPLACE VIEW EMP_DETAILS_VIEW AS
SELECT
 e.employee_id,
 e.job_id,
 e.manager_id,
 e.department_id,
 d.location_id,
 l.country_id,
 e.first_name,
 e.last_name,
 e.salary,
 e.commission_pct,
 d.department_name,
 j.job_title,
 l.city,
 l.state_province,
 c.country_name,
 r.region_name
FROM
 employees e,
 departments d,
 jobs j,
 locations l,
 countries c,
 regions r
WHERE e.department_id = d.department_id
 AND d.location_id = l.location_id
 AND l.country_id = c.country_id
 AND c.region_id = r.region_id
 AND j.job_id = e.job_id
WITH READ ONLY ;








CREATE SEQUENCE DEPARTMENTS_SEQ
   INCREMENT BY 10
   MAXVALUE 9990
   MINVALUE 1
   NOCACHE
;




CREATE SEQUENCE EMPLOYEES_SEQ
   INCREMENT BY 1
   MAXVALUE 9999999999999999999999999999
   MINVALUE 1
   NOCACHE
;




CREATE SEQUENCE LOCATIONS_SEQ
   INCREMENT BY 100
   MAXVALUE 9900
   MINVALUE 1
   NOCACHE
;
/


CREATE OR REPLACE TRIGGER UPDATE_JOB_HISTORY
   AFTER UPDATE OF JOB_ID, DEPARTMENT_ID ON EMPLOYEES
   FOR EACH ROW
BEGIN
 add_job_history(:old.employee_id, :old.hire_date, sysdate,
                 :old.job_id, :old.department_id);
END;
/








CREATE OR REPLACE PROCEDURE add_job_history
 (  p_emp_id          job_history.employee_id%type
  , p_start_date      job_history.start_date%type
  , p_end_date        job_history.end_date%type
  , p_job_id          job_history.job_id%type
  , p_department_id   job_history.department_id%type
  )
IS
BEGIN
 INSERT INTO job_history (employee_id, start_date, end_date,
                          job_id, department_id)
   VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;
/

INSERT INTO regions VALUES
     ( 10
     , 'Europe'
     );


 INSERT INTO regions VALUES
     ( 20
     , 'Americas'
     );


 INSERT INTO regions VALUES
     ( 30
     , 'Asia'
     );


 INSERT INTO regions VALUES
     ( 40
     , 'Oceania'
     );


 INSERT INTO regions VALUES
     ( 50
     , 'Africa'
     );


INSERT INTO countries VALUES
     ( 'IT'
     , 'Italy'
     , 10
     );


 INSERT INTO countries VALUES
     ( 'JP'
     , 'Japan'
     , 30
     );


 INSERT INTO countries VALUES
     ( 'US'
     , 'United States of America'
     , 20
     );


 INSERT INTO countries VALUES
     ( 'CA'
     , 'Canada'
     , 20
     );


 INSERT INTO countries VALUES
     ( 'CN'
     , 'China'
     , 30
     );


 INSERT INTO countries VALUES
     ( 'IN'
     , 'India'
     , 30
     );


 INSERT INTO countries VALUES
     ( 'AU'
     , 'Australia'
     , 40
     );


 INSERT INTO countries VALUES
     ( 'ZW'
     , 'Zimbabwe'
     , 50
     );


 INSERT INTO countries VALUES
     ( 'SG'
     , 'Singapore'
     , 30
     );


 INSERT INTO countries VALUES
     ( 'GB'
     , 'United Kingdom of Great Britain and Northern Ireland'
     , 10
     );


 INSERT INTO countries VALUES
     ( 'FR'
     , 'France'
     , 10
     );


 INSERT INTO countries VALUES
     ( 'DE'
     , 'Germany'
     , 10
     );


 INSERT INTO countries VALUES
     ( 'ZM'
     , 'Zambia'
     , 50
     );


 INSERT INTO countries VALUES
     ( 'EG'
     , 'Egypt'
     , 50
     );


 INSERT INTO countries VALUES
     ( 'BR'
     , 'Brazil'
     , 20
     );


 INSERT INTO countries VALUES
     ( 'CH'
     , 'Switzerland'
     , 10
     );


 INSERT INTO countries VALUES
     ( 'NL'
     , 'Netherlands'
     , 10
     );


 INSERT INTO countries VALUES
     ( 'MX'
     , 'Mexico'
     , 20
     );


 INSERT INTO countries VALUES
     ( 'KW'
     , 'Kuwait'
     , 30
     );


 INSERT INTO countries VALUES
     ( 'IL'
     , 'Israel'
     , 30
     );


 INSERT INTO countries VALUES
     ( 'DK'
     , 'Denmark'
     , 10
     );


 INSERT INTO countries VALUES
     ( 'ML'
     , 'Malaysia'
     , 30
     );


 INSERT INTO countries VALUES
     ( 'NG'
     , 'Nigeria'
     , 50
     );


 INSERT INTO countries VALUES
     ( 'AR'
     , 'Argentina'
     , 20
     );


 INSERT INTO countries VALUES
     ( 'BE'
     , 'Belgium'
     , 10
     );


INSERT INTO locations VALUES
     ( 1000
     , '1297 Via Cola di Rie'
     , '00989'
     , 'Roma'
     , NULL
     , 'IT'
     );


 INSERT INTO locations VALUES
     ( 1100
     , '93091 Calle della Testa'
     , '10934'
     , 'Venice'
     , NULL
     , 'IT'
     );


 INSERT INTO locations VALUES
     ( 1200
     , '2017 Shinjuku-ku'
     , '1689'
     , 'Tokyo'
     , 'Tokyo Prefecture'
     , 'JP'
     );


 INSERT INTO locations VALUES
     ( 1300
     , '9450 Kamiya-cho'
     , '6823'
     , 'Hiroshima'
     , NULL
     , 'JP'
     );


 INSERT INTO locations VALUES
     ( 1400
     , '2014 Jabberwocky Rd'
     , '26192'
     , 'Southlake'
     , 'Texas'
     , 'US'
     );


 INSERT INTO locations VALUES
     ( 1500
     , '2011 Interiors Blvd'
     , '99236'
     , 'South San Francisco'
     , 'California'
     , 'US'
     );


 INSERT INTO locations VALUES
     ( 1600
     , '2007 Zagora St'
     , '50090'
     , 'South Brunswick'
     , 'New Jersey'
     , 'US'
     );


 INSERT INTO locations VALUES
     ( 1700
     , '2004 Charade Rd'
     , '98199'
     , 'Seattle'
     , 'Washington'
     , 'US'
     );


 INSERT INTO locations VALUES
     ( 1800
     , '147 Spadina Ave'
     , 'M5V 2L7'
     , 'Toronto'
     , 'Ontario'
     , 'CA'
     );


 INSERT INTO locations VALUES
     ( 1900
     , '6092 Boxwood St'
     , 'YSW 9T2'
     , 'Whitehorse'
     , 'Yukon'
     , 'CA'
     );


 INSERT INTO locations VALUES
     ( 2000
     , '40-5-12 Laogianggen'
     , '190518'
     , 'Beijing'
     , NULL
     , 'CN'
     );


 INSERT INTO locations VALUES
     ( 2100
     , '1298 Vileparle (E)'
     , '490231'
     , 'Bombay'
     , 'Maharashtra'
     , 'IN'
     );


 INSERT INTO locations VALUES
     ( 2200
     , '12-98 Victoria Street'
     , '2901'
     , 'Sydney'
     , 'New South Wales'
     , 'AU'
     );


 INSERT INTO locations VALUES
     ( 2300
     , '198 Clementi North'
     , '540198'
     , 'Singapore'
     , NULL
     , 'SG'
     );


 INSERT INTO locations VALUES
     ( 2400
     , '8204 Arthur St'
     , NULL
     , 'London'
     , NULL
     , 'GB'
     );


 INSERT INTO locations VALUES
     ( 2500
     , 'Magdalen Centre, The Oxford Science Park'
     , 'OX9 9ZB'
     , 'Oxford'
     , 'Oxford'
     , 'GB'
     );


 INSERT INTO locations VALUES
     ( 2600
     , '9702 Chester Road'
     , '09629850293'
     , 'Stretford'
     , 'Manchester'
     , 'GB'
     );


 INSERT INTO locations VALUES
     ( 2700
     , 'Schwanthalerstr. 7031'
     , '80925'
     , 'Munich'
     , 'Bavaria'
     , 'DE'
     );


 INSERT INTO locations VALUES
     ( 2800
     , 'Rua Frei Caneca 1360 '
     , '01307-002'
     , 'Sao Paulo'
     , 'Sao Paulo'
     , 'BR'
     );


 INSERT INTO locations VALUES
     ( 2900
     , '20 Rue des Corps-Saints'
     , '1730'
     , 'Geneva'
     , 'Geneve'
     , 'CH'
     );


 INSERT INTO locations VALUES
     ( 3000
     , 'Murtenstrasse 921'
     , '3095'
     , 'Bern'
     , 'BE'
     , 'CH'
     );


 INSERT INTO locations VALUES
     ( 3100
     , 'Pieter Breughelstraat 837'
     , '3029SK'
     , 'Utrecht'
     , 'Utrecht'
     , 'NL'
     );


 INSERT INTO locations VALUES
     ( 3200
     , 'Mariano Escobedo 9991'
     , '11932'
     , 'Mexico City'
     , 'Distrito Federal'
     , 'MX'
     );


ALTER TABLE departments
 DISABLE CONSTRAINT dept_mgr_fk;


INSERT INTO departments VALUES
     ( 10
     , 'Administration'
     , 200
     , 1700
     );


 INSERT INTO departments VALUES
     ( 20
     , 'Marketing'
     , 201
     , 1800
     );


 INSERT INTO departments VALUES
     ( 30
     , 'Purchasing'
     , 114
     , 1700
     );


 INSERT INTO departments VALUES
     ( 40
     , 'Human Resources'
     , 203
     , 2400
     );


 INSERT INTO departments VALUES
     ( 50
     , 'Shipping'
     , 121
     , 1500
     );


 INSERT INTO departments VALUES
     ( 60
     , 'IT'
     , 103
     , 1400
     );


 INSERT INTO departments VALUES
     ( 70
     , 'Public Relations'
     , 204
     , 2700
     );


 INSERT INTO departments VALUES
     ( 80
     , 'Sales'
     , 145
     , 2500
     );


 INSERT INTO departments VALUES
     ( 90
     , 'Executive'
     , 100
     , 1700
     );


 INSERT INTO departments VALUES
     ( 100
     , 'Finance'
     , 108
     , 1700
     );


 INSERT INTO departments VALUES
     ( 110
     , 'Accounting'
     , 205
     , 1700
     );


 INSERT INTO departments VALUES
     ( 120
     , 'Treasury'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 130
     , 'Corporate Tax'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 140
     , 'Control And Credit'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 150
     , 'Shareholder Services'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 160
     , 'Benefits'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 170
     , 'Manufacturing'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 180
     , 'Construction'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 190
     , 'Contracting'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 200
     , 'Operations'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 210
     , 'IT Support'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 220
     , 'NOC'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 230
     , 'IT Helpdesk'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 240
     , 'Government Sales'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 250
     , 'Retail Sales'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 260
     , 'Recruiting'
     , NULL
     , 1700
     );


 INSERT INTO departments VALUES
     ( 270
     , 'Payroll'
     , NULL
     , 1700
     );


INSERT INTO jobs VALUES
     ( 'AD_PRES'
     , 'President'
     , 20080
     , 40000
     );
 INSERT INTO jobs VALUES
     ( 'AD_VP'
     , 'Administration Vice President'
     , 15000
     , 30000
     );


 INSERT INTO jobs VALUES
     ( 'AD_ASST'
     , 'Administration Assistant'
     , 3000
     , 6000
     );


 INSERT INTO jobs VALUES
     ( 'FI_MGR'
     , 'Finance Manager'
     , 8200
     , 16000
     );


 INSERT INTO jobs VALUES
     ( 'FI_ACCOUNT'
     , 'Accountant'
     , 4200
     , 9000
     );


 INSERT INTO jobs VALUES
     ( 'AC_MGR'
     , 'Accounting Manager'
     , 8200
     , 16000
     );


 INSERT INTO jobs VALUES
     ( 'AC_ACCOUNT'
     , 'Public Accountant'
     , 4200
     , 9000
     );
 INSERT INTO jobs VALUES
     ( 'SA_MAN'
     , 'Sales Manager'
     , 10000
     , 20080
     );


 INSERT INTO jobs VALUES
     ( 'SA_REP'
     , 'Sales Representative'
     , 6000
     , 12008
     );


 INSERT INTO jobs VALUES
     ( 'PU_MAN'
     , 'Purchasing Manager'
     , 8000
     , 15000
     );


 INSERT INTO jobs VALUES
     ( 'PU_CLERK'
     , 'Purchasing Clerk'
     , 2500
     , 5500
     );


 INSERT INTO jobs VALUES
     ( 'ST_MAN'
     , 'Stock Manager'
     , 5500
     , 8500
     );
 INSERT INTO jobs VALUES
     ( 'ST_CLERK'
     , 'Stock Clerk'
     , 2008
     , 5000
     );


 INSERT INTO jobs VALUES
     ( 'SH_CLERK'
     , 'Shipping Clerk'
     , 2500
     , 5500
     );


 INSERT INTO jobs VALUES
     ( 'IT_PROG'
     , 'Programmer'
     , 4000
     , 10000
     );


 INSERT INTO jobs VALUES
     ( 'MK_MAN'
     , 'Marketing Manager'
     , 9000
     , 15000
     );


 INSERT INTO jobs VALUES
     ( 'MK_REP'
     , 'Marketing Representative'
     , 4000
     , 9000
     );


 INSERT INTO jobs VALUES
     ( 'HR_REP'
     , 'Human Resources Representative'
     , 4000
     , 9000
     );


 INSERT INTO jobs VALUES
     ( 'PR_REP'
     , 'Public Relations Representative'
     , 4500
     , 10500
     );

INSERT INTO employees VALUES
     ( 100
     , 'Steven'
     , 'King'
     , 'SKING'
     , '1.515.555.0100'
     , TO_DATE('17-06-2013', 'dd-MM-yyyy')
     , 'AD_PRES'
     , 24000
     , NULL
     , NULL
     , 90
     );


 INSERT INTO employees VALUES
     ( 101
     , 'Neena'
     , 'Yang'
     , 'NYANG'
     , '1.515.555.0101'
     , TO_DATE('21-09-2015', 'dd-MM-yyyy')
     , 'AD_VP'
     , 17000
     , NULL
     , 100
     , 90
     );


 INSERT INTO employees VALUES
     ( 102
     , 'Lex'
     , 'Garcia'
     , 'LGARCIA'
     , '1.515.555.0102'
     , TO_DATE('13-01-2011', 'dd-MM-yyyy')
     , 'AD_VP'
     , 17000
     , NULL
     , 100
     , 90
     );


 INSERT INTO employees VALUES
     ( 103
     , 'Alexander'
     , 'James'
     , 'AJAMES'
     , '1.590.555.0103'
     , TO_DATE('03-01-2016', 'dd-MM-yyyy')
     , 'IT_PROG'
     , 9000
     , NULL
     , 102
     , 60
     );


 INSERT INTO employees VALUES
     ( 104
     , 'Bruce'
     , 'Miller'
     , 'BMILLER'
     , '1.590.555.0104'
     , TO_DATE('21-05-2017', 'dd-MM-yyyy')
     , 'IT_PROG'
     , 6000
     , NULL
     , 103
     , 60
     );


 INSERT INTO employees VALUES
     ( 105
     , 'David'
     , 'Williams'
     , 'DWILLIAMS'
     , '1.590.555.0105'
     , TO_DATE('25-06-2015', 'dd-MM-yyyy')
     , 'IT_PROG'
     , 4800
     , NULL
     , 103
     , 60
     );


 INSERT INTO employees VALUES
     ( 106
     , 'Valli'
     , 'Jackson'
     , 'VJACKSON'
     , '1.590.555.0106'
     , TO_DATE('05-02-2016', 'dd-MM-yyyy')
     , 'IT_PROG'
     , 4800
     , NULL
     , 103
     , 60
     );


 INSERT INTO employees VALUES
     ( 107
     , 'Diana'
     , 'Nguyen'
     , 'DNGUYEN'
     , '1.590.555.0107'
     , TO_DATE('07-02-2017', 'dd-MM-yyyy')
     , 'IT_PROG'
     , 4200
     , NULL
     , 103
     , 60
     );


 INSERT INTO employees VALUES
     ( 108
     , 'Nancy'
     , 'Gruenberg'
     , 'NGRUENBE'
     , '1.515.555.0108'
     , TO_DATE('17-08-2012', 'dd-MM-yyyy')
     , 'FI_MGR'
     , 12008
     , NULL
     , 101
     , 100
     );


 INSERT INTO employees VALUES
     ( 109
     , 'Daniel'
     , 'Faviet'
     , 'DFAVIET'
     , '1.515.555.0109'
     , TO_DATE('16-08-2012', 'dd-MM-yyyy')
     , 'FI_ACCOUNT'
     , 9000
     , NULL
     , 108
     , 100
     );


 INSERT INTO employees VALUES
     ( 110
     , 'John'
     , 'Chen'
     , 'JCHEN'
     , '1.515.555.0110'
     , TO_DATE('28-09-2015', 'dd-MM-yyyy')
     , 'FI_ACCOUNT'
     , 8200
     , NULL
     , 108
     , 100
     );


 INSERT INTO employees VALUES
     ( 111
     , 'Ismael'
     , 'Sciarra'
     , 'ISCIARRA'
     , '1.515.555.0111'
     , TO_DATE('30-09-2015', 'dd-MM-yyyy')
     , 'FI_ACCOUNT'
     , 7700
     , NULL
     , 108
     , 100
     );


 INSERT INTO employees VALUES
     ( 112
     , 'Jose Manuel'
     , 'Urman'
     , 'JMURMAN'
     , '1.515.555.0112'
     , TO_DATE('07-03-2016', 'dd-MM-yyyy')
     , 'FI_ACCOUNT'
     , 7800
     , NULL
     , 108
     , 100
     );


 INSERT INTO employees VALUES
     ( 113
     , 'Luis'
     , 'Popp'
     , 'LPOPP'
     , '1.515.555.0113'
     , TO_DATE('07-12-2017', 'dd-MM-yyyy')
     , 'FI_ACCOUNT'
     , 6900
     , NULL
     , 108
     , 100
     );


 INSERT INTO employees VALUES
     ( 114
     , 'Den'
     , 'Li'
     , 'DLI'
     , '1.515.555.0114'
     , TO_DATE('07-12-2012', 'dd-MM-yyyy')
     , 'PU_MAN'
     , 11000
     , NULL
     , 100
     , 30
     );


 INSERT INTO employees VALUES
     ( 115
     , 'Alexander'
     , 'Khoo'
     , 'AKHOO'
     , '1.515.555.0115'
     , TO_DATE('18-05-2013', 'dd-MM-yyyy')
     , 'PU_CLERK'
     , 3100
     , NULL
     , 114
     , 30
     );


 INSERT INTO employees VALUES
     ( 116
     , 'Shelli'
     , 'Baida'
     , 'SBAIDA'
     , '1.515.555.0116'
     , TO_DATE('24-12-2015', 'dd-MM-yyyy')
     , 'PU_CLERK'
     , 2900
     , NULL
     , 114
     , 30
     );


 INSERT INTO employees VALUES
     ( 117
     , 'Sigal'
     , 'Tobias'
     , 'STOBIAS'
     , '1.515.555.0117'
     , TO_DATE('24-07-2015', 'dd-MM-yyyy')
     , 'PU_CLERK'
     , 2800
     , NULL
     , 114
     , 30
     );


 INSERT INTO employees VALUES
     ( 118
     , 'Guy'
     , 'Himuro'
     , 'GHIMURO'
     , '1.515.555.0118'
     , TO_DATE('15-11-2016', 'dd-MM-yyyy')
     , 'PU_CLERK'
     , 2600
     , NULL
     , 114
     , 30
     );


 INSERT INTO employees VALUES
     ( 119
     , 'Karen'
     , 'Colmenares'
     , 'KCOLMENA'
     , '1.515.555.0119'
     , TO_DATE('10-08-2017', 'dd-MM-yyyy')
     , 'PU_CLERK'
     , 2500
     , NULL
     , 114
     , 30
     );


 INSERT INTO employees VALUES
     ( 120
     , 'Matthew'
     , 'Weiss'
     , 'MWEISS'
     , '1.650.555.0120'
     , TO_DATE('18-07-2014', 'dd-MM-yyyy')
     , 'ST_MAN'
     , 8000
     , NULL
     , 100
     , 50
     );


 INSERT INTO employees VALUES
     ( 121
     , 'Adam'
     , 'Fripp'
     , 'AFRIPP'
     , '1.650.555.0121'
     , TO_DATE('10-04-2015', 'dd-MM-yyyy')
     , 'ST_MAN'
     , 8200
     , NULL
     , 100
     , 50
     );


 INSERT INTO employees VALUES
     ( 122
     , 'Payam'
     , 'Kaufling'
     , 'PKAUFLIN'
     , '1.650.555.0122'
     , TO_DATE('01-05-2013', 'dd-MM-yyyy')
     , 'ST_MAN'
     , 7900
     , NULL
     , 100
     , 50
     );


 INSERT INTO employees VALUES
     ( 123
     , 'Shanta'
     , 'Vollman'
     , 'SVOLLMAN'
     , '1.650.555.0123'
     , TO_DATE('10-10-2015', 'dd-MM-yyyy')
     , 'ST_MAN'
     , 6500
     , NULL
     , 100
     , 50
     );


 INSERT INTO employees VALUES
     ( 124
     , 'Kevin'
     , 'Mourgos'
     , 'KMOURGOS'
     , '1.650.555.0124'
     , TO_DATE('16-11-2017', 'dd-MM-yyyy')
     , 'ST_MAN'
     , 5800
     , NULL
     , 100
     , 50
     );


 INSERT INTO employees VALUES
     ( 125
     , 'Julia'
     , 'Nayer'
     , 'JNAYER'
     , '1.650.555.0125'
     , TO_DATE('16-07-2015', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 3200
     , NULL
     , 120
     , 50
     );


 INSERT INTO employees VALUES
     ( 126
     , 'Irene'
     , 'Mikkilineni'
     , 'IMIKKILI'
     , '1.650.555.0126'
     , TO_DATE('28-09-2016', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2700
     , NULL
     , 120
     , 50
     );


 INSERT INTO employees VALUES
     ( 127
     , 'James'
     , 'Landry'
     , 'JLANDRY'
     , '1.650.555.0127'
     , TO_DATE('14-01-2017', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2400
     , NULL
     , 120
     , 50
     );


 INSERT INTO employees VALUES
     ( 128
     , 'Steven'
     , 'Markle'
     , 'SMARKLE'
     , '1.650.555.0128'
     , TO_DATE('08-03-2018', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2200
     , NULL
     , 120
     , 50
     );


 INSERT INTO employees VALUES
     ( 129
     , 'Laura'
     , 'Bissot'
     , 'LBISSOT'
     , '1.650.555.0129'
     , TO_DATE('20-08-2015', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 3300
     , NULL
     , 121
     , 50
     );


 INSERT INTO employees VALUES
     ( 130
     , 'Mozhe'
     , 'Atkinson'
     , 'MATKINSO'
     , '1.650.555.0130'
     , TO_DATE('30-10-2015', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2800
     , NULL
     , 121
     , 50
     );


 INSERT INTO employees VALUES
     ( 131
     , 'James'
     , 'Marlow'
     , 'JAMRLOW'
     , '1.650.555.0131'
     , TO_DATE('16-02-2015', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2500
     , NULL
     , 121
     , 50
     );


 INSERT INTO employees VALUES
     ( 132
     , 'TJ'
     , 'Olson'
     , 'TJOLSON'
     , '1.650.555.0132'
     , TO_DATE('10-04-2017', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2100
     , NULL
     , 121
     , 50
     );


 INSERT INTO employees VALUES
     ( 133
     , 'Jason'
     , 'Mallin'
     , 'JMALLIN'
     , '1.650.555.0133'
     , TO_DATE('14-06-2014', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 3300
     , NULL
     , 122
     , 50
     );


 INSERT INTO employees VALUES
     ( 134
     , 'Michael'
     , 'Rogers'
     , 'MROGERS'
     , '1.650.555.0134'
     , TO_DATE('26-08-2016', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2900
     , NULL
     , 122
     , 50
     );


 INSERT INTO employees VALUES
     ( 135
     , 'Ki'
     , 'Gee'
     , 'KGEE'
     , '1.650.555.0135'
     , TO_DATE('12-12-2017', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2400
     , NULL
     , 122
     , 50
     );


 INSERT INTO employees VALUES
     ( 136
     , 'Hazel'
     , 'Philtanker'
     , 'HPHILTAN'
     , '1.650.555.0136'
     , TO_DATE('06-02-2018', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2200
     , NULL
     , 122
     , 50
     );


 INSERT INTO employees VALUES
     ( 137
     , 'Renske'
     , 'Ladwig'
     , 'RLADWIG'
     , '1.650.555.0137'
     , TO_DATE('14-07-2013', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 3600
     , NULL
     , 123
     , 50
     );


 INSERT INTO employees VALUES
     ( 138
     , 'Stephen'
     , 'Stiles'
     , 'SSTILES'
     , '1.650.555.0138'
     , TO_DATE('26-10-2015', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 3200
     , NULL
     , 123
     , 50
     );


 INSERT INTO employees VALUES
     ( 139
     , 'John'
     , 'Seo'
     , 'JSEO'
     , '1.650.555.0139'
     , TO_DATE('12-02-2016', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2700
     , NULL
     , 123
     , 50
     );


 INSERT INTO employees VALUES
     ( 140
     , 'Joshua'
     , 'Patel'
     , 'JPATEL'
     , '1.650.555.0140'
     , TO_DATE('06-04-2016', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2500
     , NULL
     , 123
     , 50
     );


 INSERT INTO employees VALUES
     ( 141
     , 'Trenna'
     , 'Rajs'
     , 'TRAJS'
     , '1.650.555.0141'
     , TO_DATE('17-10-2013', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 3500
     , NULL
     , 124
     , 50
     );


 INSERT INTO employees VALUES
     ( 142
     , 'Curtis'
     , 'Davies'
     , 'CDAVIES'
     , '1.650.555.0142'
     , TO_DATE('29-01-2015', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 3100
     , NULL
     , 124
     , 50
     );


 INSERT INTO employees VALUES
     ( 143
     , 'Randall'
     , 'Matos'
     , 'RMATOS'
     , '1.650.555.0143'
     , TO_DATE('15-03-2016', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2600
     , NULL
     , 124
     , 50
     );


 INSERT INTO employees VALUES
     ( 144
     , 'Peter'
     , 'Vargas'
     , 'PVARGAS'
     , '1.650.555.0144'
     , TO_DATE('09-07-2016', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 2500
     , NULL
     , 124
     , 50
     );


 INSERT INTO employees VALUES
     ( 145
     , 'John'
     , 'Singh'
     , 'JSINGH'
     , '44.1632.960000'
     , TO_DATE('01-10-2014', 'dd-MM-yyyy')
     , 'SA_MAN'
     , 14000
     , .4
     , 100
     , 80
     );


 INSERT INTO employees VALUES
     ( 146
     , 'Karen'
     , 'Partners'
     , 'KPARTNER'
     , '44.1632.960001'
     , TO_DATE('05-01-2015', 'dd-MM-yyyy')
     , 'SA_MAN'
     , 13500
     , .3
     , 100
     , 80
     );


 INSERT INTO employees VALUES
     ( 147
     , 'Alberto'
     , 'Errazuriz'
     , 'AERRAZUR'
     , '44.1632.960002'
     , TO_DATE('10-03-2015', 'dd-MM-yyyy')
     , 'SA_MAN'
     , 12000
     , .3
     , 100
     , 80
     );


 INSERT INTO employees VALUES
     ( 148
     , 'Gerald'
     , 'Cambrault'
     , 'GCAMBRAU'
     , '44.1632.960003'
     , TO_DATE('15-10-2017', 'dd-MM-yyyy')
     , 'SA_MAN'
     , 11000
     , .3
     , 100
     , 80
     );


 INSERT INTO employees VALUES
     ( 149
     , 'Eleni'
     , 'Zlotkey'
     , 'EZLOTKEY'
     , '44.1632.960004'
     , TO_DATE('29-01-2018', 'dd-MM-yyyy')
     , 'SA_MAN'
     , 10500
     , .2
     , 100
     , 80
     );


 INSERT INTO employees VALUES
     ( 150
     , 'Sean'
     , 'Tucker'
     , 'STUCKER'
     , '44.1632.960005'
     , TO_DATE('30-01-2015', 'dd-MM-yyyy')
     , 'SA_REP'
     , 10000
     , .3
     , 145
     , 80
     );


 INSERT INTO employees VALUES
     ( 151
     , 'David'
     , 'Bernstein'
     , 'DBERNSTE'
     , '44.1632.960006'
     , TO_DATE('24-03-2015', 'dd-MM-yyyy')
     , 'SA_REP'
     , 9500
     , .25
     , 145
     , 80
     );


 INSERT INTO employees VALUES
     ( 152
     , 'Peter'
     , 'Hall'
     , 'PHALL'
     , '44.1632.960007'
     , TO_DATE('20-08-2015', 'dd-MM-yyyy')
     , 'SA_REP'
     , 9000
     , .25
     , 145
     , 80
     );


 INSERT INTO employees VALUES
     ( 153
     , 'Christopher'
     , 'Olsen'
     , 'COLSEN'
     , '44.1632.960008'
     , TO_DATE('30-03-2016', 'dd-MM-yyyy')
     , 'SA_REP'
     , 8000
     , .2
     , 145
     , 80
     );


 INSERT INTO employees VALUES
     ( 154
     , 'Nanette'
     , 'Cambrault'
     , 'NCAMBRAU'
     , '44.1632.960009'
     , TO_DATE('09-12-2016', 'dd-MM-yyyy')
     , 'SA_REP'
     , 7500
     , .2
     , 145
     , 80
     );


 INSERT INTO employees VALUES
     ( 155
     , 'Oliver'
     , 'Tuvault'
     , 'OTUVAULT'
     , '44.1632.960010'
     , TO_DATE('23-11-2017', 'dd-MM-yyyy')
     , 'SA_REP'
     , 7000
     , .15
     , 145
     , 80
     );


 INSERT INTO employees VALUES
     ( 156
     , 'Janette'
     , 'King'
     , 'JKING'
     , '44.1632.960011'
     , TO_DATE('30-01-2014', 'dd-MM-yyyy')
     , 'SA_REP'
     , 10000
     , .35
     , 146
     , 80
     );


 INSERT INTO employees VALUES
     ( 157
     , 'Patrick'
     , 'Sully'
     , 'PSULLY'
     , '44.1632.960012'
     , TO_DATE('04-03-2014', 'dd-MM-yyyy')
     , 'SA_REP'
     , 9500
     , .35
     , 146
     , 80
     );


 INSERT INTO employees VALUES
     ( 158
     , 'Allan'
     , 'McEwen'
     , 'AMCEWEN'
     , '44.1632.960013'
     , TO_DATE('01-08-2014', 'dd-MM-yyyy')
     , 'SA_REP'
     , 9000
     , .35
     , 146
     , 80
     );


 INSERT INTO employees VALUES
     ( 159
     , 'Lindsey'
     , 'Smith'
     , 'LSMITH'
     , '44.1632.960014'
     , TO_DATE('10-03-2015', 'dd-MM-yyyy')
     , 'SA_REP'
     , 8000
     , .3
     , 146
     , 80
     );


 INSERT INTO employees VALUES
     ( 160
     , 'Louise'
     , 'Doran'
     , 'LDORAN'
     , '44.1632.960015'
     , TO_DATE('15-12-2015', 'dd-MM-yyyy')
     , 'SA_REP'
     , 7500
     , .3
     , 146
     , 80
     );


 INSERT INTO employees VALUES
     ( 161
     , 'Sarath'
     , 'Sewall'
     , 'SSEWALL'
     , '44.1632.960016'
     , TO_DATE('03-11-2016', 'dd-MM-yyyy')
     , 'SA_REP'
     , 7000
     , .25
     , 146
     , 80
     );


 INSERT INTO employees VALUES
     ( 162
     , 'Clara'
     , 'Vishney'
     , 'CVISHNEY'
     , '44.1632.960017'
     , TO_DATE('11-11-2015', 'dd-MM-yyyy')
     , 'SA_REP'
     , 10500
     , .25
     , 147
     , 80
     );


 INSERT INTO employees VALUES
     ( 163
     , 'Danielle'
     , 'Greene'
     , 'DGREENE'
     , '44.1632.960018'
     , TO_DATE('19-03-2017', 'dd-MM-yyyy')
     , 'SA_REP'
     , 9500
     , .15
     , 147
     , 80
     );


 INSERT INTO employees VALUES
     ( 164
     , 'Mattea'
     , 'Marvins'
     , 'MMARVINS'
     , '44.1632.960019'
     , TO_DATE('24-01-2018', 'dd-MM-yyyy')
     , 'SA_REP'
     , 7200
     , .10
     , 147
     , 80
     );


 INSERT INTO employees VALUES
     ( 165
     , 'David'
     , 'Lee'
     , 'DLEE'
     , '44.1632.960020'
     , TO_DATE('23-02-2018', 'dd-MM-yyyy')
     , 'SA_REP'
     , 6800
     , .1
     , 147
     , 80
     );


 INSERT INTO employees VALUES
     ( 166
     , 'Sundar'
     , 'Ande'
     , 'SANDE'
     , '44.1632.960021'
     , TO_DATE('24-03-2018', 'dd-MM-yyyy')
     , 'SA_REP'
     , 6400
     , .10
     , 147
     , 80
     );


 INSERT INTO employees VALUES
     ( 167
     , 'Amit'
     , 'Banda'
     , 'ABANDA'
     , '44.1632.960022'
     , TO_DATE('21-04-2018', 'dd-MM-yyyy')
     , 'SA_REP'
     , 6200
     , .10
     , 147
     , 80
     );


 INSERT INTO employees VALUES
     ( 168
     , 'Lisa'
     , 'Ozer'
     , 'LOZER'
     , '44.1632.960023'
     , TO_DATE('11-03-2015', 'dd-MM-yyyy')
     , 'SA_REP'
     , 11500
     , .25
     , 148
     , 80
     );


 INSERT INTO employees VALUES
     ( 169
     , 'Harrison'
     , 'Bloom'
     , 'HBLOOM'
     , '44.1632.960024'
     , TO_DATE('23-03-2016', 'dd-MM-yyyy')
     , 'SA_REP'
     , 10000
     , .20
     , 148
     , 80
     );


 INSERT INTO employees VALUES
     ( 170
     , 'Tayler'
     , 'Fox'
     , 'TFOX'
     , '44.1632.960025'
     , TO_DATE('24-01-2016', 'dd-MM-yyyy')
     , 'SA_REP'
     , 9600
     , .20
     , 148
     , 80
     );


 INSERT INTO employees VALUES
     ( 171
     , 'William'
     , 'Smith'
     , 'WSMITH'
     , '44.1632.960026'
     , TO_DATE('23-02-2017', 'dd-MM-yyyy')
     , 'SA_REP'
     , 7400
     , .15
     , 148
     , 80
     );


 INSERT INTO employees VALUES
     ( 172
     , 'Elizabeth'
     , 'Bates'
     , 'EBATES'
     , '44.1632.960027'
     , TO_DATE('24-03-2017', 'dd-MM-yyyy')
     , 'SA_REP'
     , 7300
     , .15
     , 148
     , 80
     );


 INSERT INTO employees VALUES
     ( 173
     , 'Sundita'
     , 'Kumar'
     , 'SKUMAR'
     , '44.1632.960028'
     , TO_DATE('21-04-2018', 'dd-MM-yyyy')
     , 'SA_REP'
     , 6100
     , .10
     , 148
     , 80
     );


 INSERT INTO employees VALUES
     ( 174
     , 'Ellen'
     , 'Abel'
     , 'EABEL'
     , '44.1632.960029'
     , TO_DATE('11-05-2014', 'dd-MM-yyyy')
     , 'SA_REP'
     , 11000
     , .30
     , 149
     , 80
     );


 INSERT INTO employees VALUES
     ( 175
     , 'Alyssa'
     , 'Hutton'
     , 'AHUTTON'
     , '44.1632.960030'
     , TO_DATE('19-03-2015', 'dd-MM-yyyy')
     , 'SA_REP'
     , 8800
     , .25
     , 149
     , 80
     );


 INSERT INTO employees VALUES
     ( 176
     , 'Jonathon'
     , 'Taylor'
     , 'JTAYLOR'
     , '44.1632.960031'
     , TO_DATE('24-03-2016', 'dd-MM-yyyy')
     , 'SA_REP'
     , 8600
     , .20
     , 149
     , 80
     );


 INSERT INTO employees VALUES
     ( 177
     , 'Jack'
     , 'Livingston'
     , 'JLIVINGS'
     , '44.1632.960032'
     , TO_DATE('23-04-2016', 'dd-MM-yyyy')
     , 'SA_REP'
     , 8400
     , .20
     , 149
     , 80
     );


 INSERT INTO employees VALUES
     ( 178
     , 'Kimberely'
     , 'Grant'
     , 'KGRANT'
     , '44.1632.960033'
     , TO_DATE('24-05-2017', 'dd-MM-yyyy')
     , 'SA_REP'
     , 7000
     , .15
     , 149
     , NULL
     );


 INSERT INTO employees VALUES
     ( 179
     , 'Charles'
     , 'Johnson'
     , 'CJOHNSON'
     , '44.1632.960034'
     , TO_DATE('04-01-2018', 'dd-MM-yyyy')
     , 'SA_REP'
     , 6200
     , .10
     , 149
     , 80
     );


 INSERT INTO employees VALUES
     ( 180
     , 'Winston'
     , 'Taylor'
     , 'WTAYLOR'
     , '1.650.555.0145'
     , TO_DATE('24-01-2016', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3200
     , NULL
     , 120
     , 50
     );


 INSERT INTO employees VALUES
     ( 181
     , 'Jean'
     , 'Fleaur'
     , 'JFLEAUR'
     , '1.650.555.0146'
     , TO_DATE('23-02-2016', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3100
     , NULL
     , 120
     , 50
     );


 INSERT INTO employees VALUES
     ( 182
     , 'Martha'
     , 'Sullivan'
     , 'MSULLIVA'
     , '1.650.555.0147'
     , TO_DATE('21-06-2017', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 2500
     , NULL
     , 120
     , 50
     );


 INSERT INTO employees VALUES
     ( 183
     , 'Girard'
     , 'Geoni'
     , 'GGEONI'
     , '1.650.555.0148'
     , TO_DATE('03-02-2018', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 2800
     , NULL
     , 120
     , 50
     );


 INSERT INTO employees VALUES
     ( 184
     , 'Nandita'
     , 'Sarchand'
     , 'NSARCHAN'
     , '1.650.555.0149'
     , TO_DATE('27-01-2014', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 4200
     , NULL
     , 121
     , 50
     );


 INSERT INTO employees VALUES
     ( 185
     , 'Alexis'
     , 'Bull'
     , 'ABULL'
     , '1.650.555.0150'
     , TO_DATE('20-02-2015', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 4100
     , NULL
     , 121
     , 50
     );


 INSERT INTO employees VALUES
     ( 186
     , 'Julia'
     , 'Dellinger'
     , 'JDELLING'
     , '1.650.555.0151'
     , TO_DATE('24-06-2016', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3400
     , NULL
     , 121
     , 50
     );


 INSERT INTO employees VALUES
     ( 187
     , 'Anthony'
     , 'Cabrio'
     , 'ACABRIO'
     , '1.650.555.0152'
     , TO_DATE('07-02-2017', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3000
     , NULL
     , 121
     , 50
     );


 INSERT INTO employees VALUES
     ( 188
     , 'Kelly'
     , 'Chung'
     , 'KCHUNG'
     , '1.650.555.0153'
     , TO_DATE('14-06-2015', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3800
     , NULL
     , 122
     , 50
     );


 INSERT INTO employees VALUES
     ( 189
     , 'Jennifer'
     , 'Dilly'
     , 'JDILLY'
     , '1.650.555.0154'
     , TO_DATE('13-08-2015', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3600
     , NULL
     , 122
     , 50
     );


 INSERT INTO employees VALUES
     ( 190
     , 'Timothy'
     , 'Venzl'
     , 'TVENZL'
     , '1.650.555.0155'
     , TO_DATE('11-07-2016', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 2900
     , NULL
     , 122
     , 50
     );


 INSERT INTO employees VALUES
     ( 191
     , 'Randall'
     , 'Perkins'
     , 'RPERKINS'
     , '1.650.555.0156'
     , TO_DATE('19-12-2017', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 2500
     , NULL
     , 122
     , 50
     );


 INSERT INTO employees VALUES
     ( 192
     , 'Sarah'
     , 'Bell'
     , 'SBELL'
     , '1.650.555.0157'
     , TO_DATE('04-02-2014', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 4000
     , NULL
     , 123
     , 50
     );


 INSERT INTO employees VALUES
     ( 193
     , 'Britney'
     , 'Everett'
     , 'BEVERETT'
     , '1.650.555.0158'
     , TO_DATE('03-03-2015', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3900
     , NULL
     , 123
     , 50
     );


 INSERT INTO employees VALUES
     ( 194
     , 'Samuel'
     , 'McLeod'
     , 'SMCLEOD'
     , '1.650.555.0159'
     , TO_DATE('01-07-2016', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3200
     , NULL
     , 123
     , 50
     );


 INSERT INTO employees VALUES
     ( 195
     , 'Vance'
     , 'Jones'
     , 'VJONES'
     , '1.650.555.0160'
     , TO_DATE('17-03-2017', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 2800
     , NULL
     , 123
     , 50
     );


 INSERT INTO employees VALUES
     ( 196
     , 'Alana'
     , 'Walsh'
     , 'AWALSH'
     , '1.650.555.0161'
     , TO_DATE('24-04-2016', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3100
     , NULL
     , 124
     , 50
     );


 INSERT INTO employees VALUES
     ( 197
     , 'Kevin'
     , 'Feeney'
     , 'KFEENEY'
     , '1.650.555.0162'
     , TO_DATE('23-05-2016', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 3000
     , NULL
     , 124
     , 50
     );


 INSERT INTO employees VALUES
     ( 198
     , 'Donald'
     , 'OConnell'
     , 'DOCONNEL'
     , '1.650.555.0163'
     , TO_DATE('21-06-2017', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 2600
     , NULL
     , 124
     , 50
     );


 INSERT INTO employees VALUES
     ( 199
     , 'Douglas'
     , 'Grant'
     , 'DGRANT'
     , '1.650.555.0164'
     , TO_DATE('13-01-2018', 'dd-MM-yyyy')
     , 'SH_CLERK'
     , 2600
     , NULL
     , 124
     , 50
     );


 INSERT INTO employees VALUES
     ( 200
     , 'Jennifer'
     , 'Whalen'
     , 'JWHALEN'
     , '1.515.555.0165'
     , TO_DATE('17-09-2013', 'dd-MM-yyyy')
     , 'AD_ASST'
     , 4400
     , NULL
     , 101
     , 10
     );


 INSERT INTO employees VALUES
     ( 201
     , 'Michael'
     , 'Martinez'
     , 'MMARTINE'
     , '1.515.555.0166'
     , TO_DATE('17-02-2014', 'dd-MM-yyyy')
     , 'MK_MAN'
     , 13000
     , NULL
     , 100
     , 20
     );


 INSERT INTO employees VALUES
     ( 202
     , 'Pat'
     , 'Davis'
     , 'PDAVIS'
     , '1.603.555.0167'
     , TO_DATE('17-08-2015', 'dd-MM-yyyy')
     , 'MK_REP'
     , 6000
     , NULL
     , 201
     , 20
     );


 INSERT INTO employees VALUES
     ( 203
     , 'Susan'
     , 'Jacobs'
     , 'SJACOBS'
     , '1.515.555.0168'
     , TO_DATE('07-06-2012', 'dd-MM-yyyy')
     , 'HR_REP'
     , 6500
     , NULL
     , 101
     , 40
     );


 INSERT INTO employees VALUES
     ( 204
     , 'Hermann'
     , 'Brown'
     , 'HBROWN'
     , '1.515.555.0169'
     , TO_DATE('07-06-2012', 'dd-MM-yyyy')
     , 'PR_REP'
     , 10000
     , NULL
     , 101
     , 70
     );


 INSERT INTO employees VALUES
     ( 205
     , 'Shelley'
     , 'Higgins'
     , 'SHIGGINS'
     , '1.515.555.0170'
     , TO_DATE('07-06-2012', 'dd-MM-yyyy')
     , 'AC_MGR'
     , 12008
     , NULL
     , 101
     , 110
     );


 INSERT INTO employees VALUES
     ( 206
     , 'William'
     , 'Gietz'
     , 'WGIETZ'
     , '1.515.555.0171'
     , TO_DATE('07-06-2012', 'dd-MM-yyyy')
     , 'AC_ACCOUNT'
     , 8300
     , NULL
     , 205
     , 110
     );
    
INSERT INTO job_history
 VALUES (102
      , TO_DATE('13-01-2011', 'dd-MM-yyyy')
      , TO_DATE('24-07-2016', 'dd-MM-yyyy')
      , 'IT_PROG'
      , 60);


 INSERT INTO job_history
 VALUES (101
      , TO_DATE('21-09-2007', 'dd-MM-yyyy')
      , TO_DATE('27-10-2011', 'dd-MM-yyyy')
      , 'AC_ACCOUNT'
      , 110);


 INSERT INTO job_history
 VALUES (101
      , TO_DATE('28-10-2011', 'dd-MM-yyyy')
      , TO_DATE('15-03-2015', 'dd-MM-yyyy')
      , 'AC_MGR'
      , 110);


 INSERT INTO job_history
 VALUES (201
      , TO_DATE('17-02-2014', 'dd-MM-yyyy')
      , TO_DATE('19-12-2017', 'dd-MM-yyyy')
      , 'MK_REP'
      , 20);


 INSERT INTO job_history
 VALUES  (114
     , TO_DATE('24-03-2016', 'dd-MM-yyyy')
     , TO_DATE('31-12-2017', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 50
     );


 INSERT INTO job_history
 VALUES  (122
     , TO_DATE('01-01-2017', 'dd-MM-yyyy')
     , TO_DATE('31-12-2017', 'dd-MM-yyyy')
     , 'ST_CLERK'
     , 50
     );


 INSERT INTO job_history
 VALUES  (200
     , TO_DATE('17-09-2005', 'dd-MM-yyyy')
     , TO_DATE('17-06-2011', 'dd-MM-yyyy')
     , 'AD_ASST'
     , 90
     );


 INSERT INTO job_history
 VALUES  (176
     , TO_DATE('24-03-2016', 'dd-MM-yyyy')
     , TO_DATE('31-12-2016', 'dd-MM-yyyy')
     , 'SA_REP'
     , 80
     );


 INSERT INTO job_history
 VALUES  (176
     , TO_DATE('01-01-2017', 'dd-MM-yyyy')
     , TO_DATE('31-12-2017', 'dd-MM-yyyy')
     , 'SA_MAN'
     , 80
     );


 INSERT INTO job_history
 VALUES  (200
     , TO_DATE('01-07-2012', 'dd-MM-yyyy')
     , TO_DATE('31-12-2016', 'dd-MM-yyyy')
     , 'AC_ACCOUNT'
     , 90
     );


ALTER TABLE departments
 ENABLE CONSTRAINT dept_mgr_fk;

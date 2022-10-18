 
-- Flight management --
SELECT SYSDATE FROM DUAL;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

SELECT dbtimezone FROM DUAL;
ALTER SESSION SET TIME_ZONE = 'UTC';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT = 'DD-MM-YYYY HH:MI:SS AM TZH:TZM';

CREATE TABLE AS_SEAT
(   seat_no         VARCHAR(5) 
                        PRIMARY KEY
                        CHECK (REGEXP_LIKE (seat_no, '[A-Z]-\d{3}')),
    seat_class      VARCHAR2(10) NOT NULL
);     

CREATE TABLE AS_PLANE
(   plane_id        VARCHAR(5) 
                        PRIMARY KEY
                        CHECK (REGEXP_LIKE (plane_id, '[A-Z]{3}\d{2}')),
    plane_name      VARCHAR(20) NOT NULL,
    plane_amount    NUMBER(5) 
                        CHECK (plane_amount > 0)
);

CREATE TABLE AS_JOURNEY
(   jo_id           VARCHAR(5)  
                        PRIMARY KEY,
    jo_departure    VARCHAR(20) NOT NULL,
    jo_destination  VARCHAR(20) NOT NULL,
    international_flight  VARCHAR(1)
                        CHECK (REGEXP_LIKE (international_flight, '(x|NULL)'))
);
    
CREATE TABLE AS_SCHEDULE
(   flight_sche_id  VARCHAR(5)
                        PRIMARY KEY,
    jo_id           VARCHAR(5) 
                        REFERENCES AS_JOURNEY(jo_id),
    plane_id        VARCHAR(5)  
                        REFERENCES AS_PLANE(plane_id)
                        CHECK (REGEXP_LIKE (plane_id, '[A-Z]{3}\d{2}')),
    from_airport    VARCHAR(30) NOT NULL,
    get_on_time     TIMESTAMP WITH TIME ZONE NOT NULL,
    get_off_time    TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE TABLE AS_DEPARTMENTS
(   dept_id         VARCHAR(3)
                        CONSTRAINT pk_dept PRIMARY KEY,
    dept_name       VARCHAR(20) NOT NULL,
    manager_id      NUMBER(5)
);

CREATE TABLE AS_EMPLOYEES
(   emp_id          NUMBER(5) 
                        PRIMARY KEY,
    dept_id         VARCHAR(3) 
                        REFERENCES AS_DEPARTMENTS(dept_id),
    emp_firstname   VARCHAR(30) NOT NULL,
    emp_lastname    VARCHAR(20) NOT NULL,
    
    -- 0: female, 1: male --
    emp_gender      NUMBER(1) NOT NULL,
                        CHECK (REGEXP_LIKE (emp_gender, '1|0')),
    emp_birthday    DATE,
    emp_tel         VARCHAR(12)
                        UNIQUE
                        CHECK (REGEXP_LIKE (emp_tel, '\d{4}-\d{7}')),
    emp_email       VARCHAR(30) NOT NULL
                        UNIQUE
                        CHECK (REGEXP_LIKE (emp_email, '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}', 'i')),
    emp_role        VARCHAR(20) NOT NULL,
    hire_date       DATE NOT NULL,
    salary          NUMBER(10) 
                        CHECK (salary > 0),
    flight_sche_id VARCHAR(5)
                        REFERENCES AS_SCHEDULE(flight_sche_id)
);


CREATE TABLE AS_PASSENGERS
(
    ps_id           NUMBER(20)  PRIMARY KEY,
    passport_id     NUMBER  UNIQUE,
    passenger_name  VARCHAR(30),
   
    phone_number    NUMBER
                        UNIQUE
                        CHECK (REGEXP_LIKE (phone_number, '\d{4}-\d{7}')),
    nationality     VARCHAR(30)
);

    
CREATE TABLE AS_TICKET
(   ticket_id       VARCHAR(10) 
                        PRIMARY KEY,
--    seat_no         VARCHAR(5) 
--                         CONSTRAINT fk_sno
--                        REFERENCES AS_SEAT(seat_no),
    flight_sche_id  VARCHAR(5)
                        REFERENCES AS_SCHEDULE(flight_sche_id),
    ticket_price    VARCHAR(10) 
                        CHECK (ticket_price > 0)
);

CREATE TABLE AS_BILL
(
    bill_id         NUMBER  PRIMARY KEY,
    emp_id          NUMBER(5),
    ps_id           NUMBER(12),
    ticket_id       VARCHAR(10),
    seat_no         VARCHAR(5),
    gate_way        VARCHAR(5),
    nb_ticket       NUMBER(5),
    discount        NUMBER(3),
    age_group       VARCHAR(3)  -- A: 12+yo, C: 2-12yo, B: 0-2yo --
                        CHECK (REGEXP_LIKE (age_group, 'A||C||B')),
    FOREIGN KEY (emp_id) REFERENCES AS_EMPLOYEES(emp_id),
    FOREIGN KEY (ps_id) REFERENCES AS_PASSENGERS(ps_id),
    FOREIGN KEY (seat_no) REFERENCES AS_SEAT(seat_no),
    FOREIGN KEY (ticket_id) REFERENCES AS_TICKET(ticket_id)
);

DROP TABLE AS_BILL;
DROP TABLE AS_TICKET;
DROP TABLE AS_PASSENGERS;
DROP TABLE AS_EMPLOYEES;
DROP TABLE AS_DEPARTMENTS;
DROP TABLE AS_SCHEDULE;
DROP TABLE AS_JOURNEY;
DROP TABLE AS_PLANE;
DROP TABLE AS_SEAT;

-- insert data --

INSERT INTO AS_SEAT VALUES('A-001','ECONOMY');
INSERT INTO AS_SEAT VALUES('B-021','ECONOMY');
INSERT INTO AS_SEAT VALUES('C-033','BUSINESS');
INSERT INTO AS_SEAT VALUES('D-111','BUSINESS');
INSERT INTO AS_SEAT VALUES('Z-271','ECONOMY');

INSERT INTO AS_PLANE VALUES('AUS32','Airbus A320',10);
INSERT INTO AS_PLANE VALUES('AUS30','Airbus A300',20);
INSERT INTO AS_PLANE VALUES('BOG73','Boeing 737',15);
INSERT INTO AS_PLANE VALUES('BOG77','Boeing 777',25);
INSERT INTO AS_PLANE VALUES('BQM30','Bombardier Q300',5);

INSERT INTO AS_JOURNEY VALUES('J001','HO CHI MINH','TOKYO','x');
INSERT INTO AS_JOURNEY VALUES('J002','CAN THO','DA NANG',NULL);
INSERT INTO AS_JOURNEY VALUES('J003','KYOTO','HUE','x');
INSERT INTO AS_JOURNEY VALUES('J004','CALIFORNIA','MOSCOW','x');
INSERT INTO AS_JOURNEY VALUES('J005','BEIJING','TEXAS','x');

--
BEGIN
INSERT INTO AS_SCHEDULE VALUES 
        ( 'F001'
        , 'J001'
        , 'AUS32'
        , 'Tan Son Nhat'
        , '08-08-2022 2:00:00 AM +07:00'
        , '08-08-2022 8:00:00 AM +09:00'
        );


INSERT INTO AS_SCHEDULE VALUES 
        ( 'F002'
        , 'J002'
        , 'AUS32'
        , 'Noi Bai'
        , '18-09-2017 10:45:30 PM +07:00'
        , '18-09-2017 11:30:50 PM +07:00'
        );

INSERT INTO AS_SCHEDULE VALUES 
        ( 'F003'
        , 'J003'
        , 'BOG77'
        , 'Narita'
        , '19-08-2023 5:23:45 PM +09:00'
        , '19-08-2023 9:58:40 PM +07:00'
        );

INSERT INTO AS_SCHEDULE VALUES 
        ( 'F004'
        , 'J004'
        , 'AUS30'
        , 'Washington'
        , '22-10-2020 11:00:00 PM -04:00'
        , '23-10-2020 3:00:00 AM -05:00'
        );

INSERT INTO AS_SCHEDULE VALUES 
        ( 'F005'
        , 'J005'
        , 'BQM30'
        , 'Beijing'
        , '07-02-2021 2:27:27 PM +08:00'
        , '07-02-2021 6:36:36 PM +05:00'
        );
END;
--
INSERT INTO AS_DEPARTMENTS VALUES(10,'FLIGHT CREW',100);
INSERT INTO AS_DEPARTMENTS VALUES(20,'PASSENGER HANDLING',200);
INSERT INTO AS_DEPARTMENTS VALUES(30,'BOOKING',300);
INSERT INTO AS_DEPARTMENTS VALUES(40,'CATERING',400);
INSERT INTO AS_DEPARTMENTS VALUES(50,'TECHNICAL',500);
--
BEGIN
INSERT INTO AS_EMPLOYEES VALUES
        ( 100  
        , 10
        , 'Steven'    
        , 'King'    
        , 1       
        , '17-06-1997'  
        , '0912-1234567'    
        , 'stevenking01@gmail.com'  
        , 'CAPTAIN'   
        , '17-06-2021'    
        , 3000
        , 'F001'
        );

INSERT INTO AS_EMPLOYEES VALUES
        ( 101  
        , 10
        , 'Neena'    
        , 'Kochhar'     
        , 0       
        , '21-09-2002'  
        , '0913-1234567'    
        , 'NeenaKochhar@gmail.work.com'  
        , 'FIGHT ATTENDANT'   
        , '21-09-2022'    
        , 850
        , 'F001'
        );

INSERT INTO AS_EMPLOYEES VALUES
        ( 102  
        , 10
        , 'Alexander'    
        , 'Hunold'    
        , 1       
        , '03-01-2000'  
        , '0914-1234567'    
        , 'AlecHunold123@gmail.work.com'  
        , 'CABIN CREW'   
        , '03-01-2022'    
        , 1000
        , 'F001'
        );

INSERT INTO AS_EMPLOYEES VALUES
        ( 103  
        , 20
        , 'Diana'    
        , 'Lorentz'      
        , 0       
        , '07-02-1997'  
        , '0845-1234567'    
        , 'Diana123@gmail.com'  
        , 'CHECK-IN AGENT'   
        , '07-02-2020'    
        , 1000
        , 'F002'
        );
        
INSERT INTO AS_EMPLOYEES VALUES
        ( 104  
        , 20
        , 'Nancy'    
        , 'Greenberg'    
        , 0       
        , '17-08-2002' 
        , '0845-5556667'    
        , 'NancyGreen@gmail.com'  
        , 'TICKET SALES'   
        , '17-08-2022'    
        , 1500
        , 'F002'
        );
        

INSERT INTO AS_EMPLOYEES VALUES
        ( 105  
        , 50
        , 'John'    
        , 'Chen'    
        , 1       
        , '28-09-1995'
        , '0845-0101010'    
        , 'JohnChen@gmail.com'  
        , 'SUPPORT'   
        , '28-09-2019'   
        , 2100
        , 'F003'
        );
END;
--
INSERT INTO AS_PASSENGERS VALUES(091234565,NULL,'Taylor Swift','0125-5551251');
INSERT INTO AS_PASSENGERS VALUES(081234565,NULL,'Taylor Swift','0125-5551251');
INSERT INTO AS_PASSENGERS VALUES(071234565,NULL,'Taylor Swift','0125-5551251');
INSERT INTO AS_PASSENGERS VALUES(061234565,NULL,'Taylor Swift','0125-5551251');
INSERT INTO AS_PASSENGERS VALUES(051234565,NULL,'Taylor Swift','0125-5551251');

--
INSERT INTO AS_TICKET VALUES('10','F001',500);
INSERT INTO AS_TICKET VALUES('11','F001',500);
INSERT INTO AS_TICKET VALUES('12','F002',400);
INSERT INTO AS_TICKET VALUES('13','F003',250);
INSERT INTO AS_TICKET VALUES('14','F003',550);
--
INSERT INTO AS_BILL VALUES('10','F001',500);
INSERT INTO AS_BILL VALUES('11','F001',500);
INSERT INTO AS_BILL VALUES('12','F002',400);
INSERT INTO AS_BILL VALUES('13','F003',250);
INSERT INTO AS_BILL VALUES('14','F003',550);

-- Grant privileges to users --

-- create those upper tables and insert datas at this AS_ADMIN user
CREATE USER AS_ADMIN IDENTIFIED BY "tothemoon";
GRANT ALL PRIVILEGES TO AS_ADMIN;
GRANT SELECT ON AS_SCHEDULE TO PUBLIC;

-- create AS_MANAGER user in AS_ADMIN user
CREATE USER AS_MANAGER IDENTIFIED BY "manager01";
GRANT CREATE USER, CREATE SESSION TO AS_MANAGER;

GRANT SELECT,UPDATE,DELETE ON AS_DEPARTMENTS TO AS_MANAGER;
GRANT SELECT,UPDATE,DELETE ON AS_EMPLOYEES   TO AS_MANAGER;
GRANT SELECT,UPDATE ON        AS_JOURNEY     TO AS_MANAGER;
GRANT SELECT,UPDATE ON        AS_TICKET      TO AS_MANAGER;
GRANT SELECT ON               AS_PLANE       TO AS_MANAGER;
GRANT SELECT ON               AS_SEAT        TO AS_MANGAGER;

-- create AS_EMPLOYEE user in AS_MANAGER user
CREATE USER AS_EMPLOYEE IDENTIFIED BY "employee01";

GRANT SELECT ON AS_DEPARTMENTS TO AS_EMPLOYEE;
GRANT SELECT ON AS_EMPLOYEES   TO AS_EMPLOYEE;
GRANT SELECT ON AS_JOURNEY     TO AS_EMPLOYEE;

--
DROP USER AS_ADMIN;
DROP USER AS_MANAGER;
DROP USER AS_EMPLOYEE;

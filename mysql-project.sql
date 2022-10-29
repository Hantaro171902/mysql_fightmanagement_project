create database project;
use project;
-- Flight management --
set time_zone = '+00:00';
select now();

CREATE TABLE AS_SEAT
(   seat_no         VARCHAR(5) 
                        PRIMARY KEY
                        CHECK (REGEXP_LIKE (seat_no, '^[A-Z]')),
    seat_class      VARCHAR(10) NOT NULL
);     

CREATE TABLE AS_PLANE
(   plane_id        VARCHAR(5) 
                        PRIMARY KEY
                        CHECK (REGEXP_LIKE (plane_id, '^[A-Z]')),
    plane_name      VARCHAR(20) NOT NULL,
    plane_amount    INT
                        CHECK (plane_amount > 0)
);

CREATE TABLE AS_JOURNEY
(   jo_id           VARCHAR(5)  
                        PRIMARY KEY,
    jo_departure    VARCHAR(20) NOT NULL,
    jo_destination  VARCHAR(20),
    international_flight  VARCHAR(1)
                        CHECK (REGEXP_LIKE (international_flight, 'x|NULL'))
);
    
CREATE TABLE AS_SCHEDULE
(   flight_sche_id  VARCHAR(5)
						PRIMARY KEY,
    jo_id           VARCHAR(5) 
                        REFERENCES AS_JOURNEY(jo_id),
    plane_id        VARCHAR(5) 
                        REFERENCES AS_PLANE(plane_id),
                        CHECK (REGEXP_LIKE (plane_id, '^[A-Z]')),
    from_airport    VARCHAR(30) NOT NULL,
    get_on_time     TIMESTAMP NOT NULL,
    get_off_time    TIMESTAMP NOT NULL
);

CREATE TABLE AS_DEPARTMENTS
(   dept_id         VARCHAR(3)
                        PRIMARY KEY,
    dept_name       VARCHAR(20) NOT NULL,
    manager_id      INT
);

CREATE TABLE AS_EMPLOYEES
(   emp_id          INT 
                        PRIMARY KEY,
    dept_id         VARCHAR(3)
                        REFERENCES AS_DEPARTMENTS(dept_id),
    emp_firstname   VARCHAR(30) NOT NULL,
    emp_lastname    VARCHAR(20) NOT NULL,
    
    -- 0: female, 1: male --
    emp_gender      INT NOT NULL,
                        CHECK (REGEXP_LIKE (emp_gender, '1|0')),
    emp_birthday    DATE,
    emp_tel         VARCHAR(12)
                        UNIQUE
                        CHECK (REGEXP_LIKE (emp_tel, '[0-9]{4}-[0-9]{7}')),
    emp_email       VARCHAR(30) NOT NULL
						UNIQUE
                        CHECK (REGEXP_LIKE (emp_email, '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}', 'i')),
    emp_role        VARCHAR(20) NOT NULL,
    hire_date       DATE NOT NULL,
    salary          INT 
                        CHECK (salary > 0),
	bonus			INT
);

CREATE TABLE AS_TRIP 
(
	trip_id			INT PRIMARY KEY,
    flight_sche_id  VARCHAR(5)
                        REFERENCES AS_SCHEDULE(flight_sche_id),
	emp_id          INT 
						REFERENCES AS_EMPLOYEES(emp_id)
);

CREATE TABLE AS_PASSENGERS
(
    ps_id           INTEGER  PRIMARY KEY,
    passport_id     INT  UNIQUE,
    passenger_name  VARCHAR(30),
    phone_number    VARCHAR(12)
                        UNIQUE
                        CHECK (REGEXP_LIKE (phone_number, '[0-9]{4}-[0-9]{7}')),
    nationality     VARCHAR(30)
);

CREATE TABLE AS_TICKET
(   ticket_id       VARCHAR(8) 
                        PRIMARY KEY,
    flight_sche_id  VARCHAR(5)
						UNIQUE NOT NULL
                        REFERENCES AS_SCHEDULE(flight_sche_id),
    ticket_price    INT
                        CHECK (ticket_price > 0)
);

CREATE TABLE AS_BILL
(
    bill_id         INT  PRIMARY KEY,
    emp_id          INT,
    ps_id           INT,
    ticket_id       VARCHAR(10),
    seat_no         VARCHAR(5),
    gate_way        VARCHAR(5),
    discount        INT,
    age_group       VARCHAR(3)  -- A: 12+yo, C: 2-12yo, B: 0-2yo --
                        CHECK (REGEXP_LIKE (age_group, 'A|C|B')),
	bill_date		TIMESTAMP NOT NULL,
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
INSERT INTO AS_SEAT VALUES('A-002','BUSINESS');
INSERT INTO AS_SEAT VALUES('B-003','ECONOMY');
INSERT INTO AS_SEAT VALUES('C-004','BUSINESS');
INSERT INTO AS_SEAT VALUES('D-005','BUSINESS');
INSERT INTO AS_SEAT VALUES('E-010','ECONOMY');
INSERT INTO AS_SEAT VALUES('F-011','BUSINESS');
INSERT INTO AS_SEAT VALUES('G-012','ECONOMY');
INSERT INTO AS_SEAT VALUES('H-013','ECONOMY');
INSERT INTO AS_SEAT VALUES('Z-271','ECONOMY');
--
INSERT INTO AS_PLANE VALUES('AUS32','Airbus A320',10);
INSERT INTO AS_PLANE VALUES('AUS30','Airbus A300',20);
INSERT INTO AS_PLANE VALUES('BOG73','Boeing 737',15);
INSERT INTO AS_PLANE VALUES('BOG77','Boeing 777',25);
INSERT INTO AS_PLANE VALUES('BQM30','Bombardier Q300',5);
--
INSERT INTO AS_JOURNEY VALUES('J001','HO CHI MINH','TOKYO','x');
INSERT INTO AS_JOURNEY VALUES('J002','CAN THO','DA NANG',NULL);
INSERT INTO AS_JOURNEY VALUES('J003','KYOTO','HUE','x');
INSERT INTO AS_JOURNEY VALUES('J004','CALIFORNIA','MOSCOW','x');
INSERT INTO AS_JOURNEY VALUES('J005','BEIJING','TEXAS','x');
--

INSERT INTO AS_SCHEDULE VALUES 
        ( 'F001'
        , 'J001'
        , 'AUS32'
        , 'Tan Son Nhat'
        , '2022-08-08 2:00:00'
        , '2022-08-08 8:00:00'
        );


INSERT INTO AS_SCHEDULE VALUES 
        ( 'F002'
        , 'J002'
        , 'AUS32'
        , 'Noi Bai'
        , '2017-12-09 22:45:30'
        , '2017-12-09 23:30:50'
        );

INSERT INTO AS_SCHEDULE VALUES 
        ( 'F003'
        , 'J003'
        , 'BOG77'
        , 'Narita'
        , '2023-08-19 17:23:45'
        , '2023-08-19 21:58:40'
        );

INSERT INTO AS_SCHEDULE VALUES 
        ( 'F004'
        , 'J004'
        , 'AUS30'
        , 'Washington'
        , '2020-10-22 11:00:00'
        , '2020-10-22 3:00:00'
        );

INSERT INTO AS_SCHEDULE VALUES 
        ( 'F005'
        , 'J005'
        , 'BQM30'
        , 'Beijing'
        , '2021-07-02 2:27:27'
        , '2021-07-02 6:36:36'
        );

--
INSERT INTO AS_DEPARTMENTS VALUES(10,'FLIGHT CREW',100);
INSERT INTO AS_DEPARTMENTS VALUES(20,'PASSENGER HANDLING',200);
INSERT INTO AS_DEPARTMENTS VALUES(30,'BOOKING',300);
INSERT INTO AS_DEPARTMENTS VALUES(40,'CATERING',400);
INSERT INTO AS_DEPARTMENTS VALUES(50,'TECHNICAL',500);
--

INSERT INTO AS_EMPLOYEES VALUES
        ( 100  
        , 10
        , 'Steven'    
        , 'King'    
        , 1       
        , '1997-06-17'  
        , '0912-1234567'    
        , 'stevenking01@gmail.com'  
        , 'CAPTAIN'   
        , '2021-06-17'    
        , 3000
        , NULL
        );

INSERT INTO AS_EMPLOYEES VALUES
        ( 101  
        , 10
        , 'Neena'    
        , 'Kochhar'     
        , 0       
        , '2002-09-21'  
        , '0913-1234567'    
        , 'NeenaKochhar@gmail.work.com'  
        , 'FIGHT ATTENDANT'   
        , '2022-09-21'    
        , 850
        , 100
        );

INSERT INTO AS_EMPLOYEES VALUES
        ( 102  
        , 40
        , 'Alexander'    
        , 'Hunold'    
        , 1       
        , '2000-01-03'  
        , '0914-1234567'    
        , 'AlecHunold123@gmail.work.com'  
        , 'CABIN CREW'   
        , '2022-01-03'    
        , 1000
        , 200
        );

INSERT INTO AS_EMPLOYEES VALUES
        ( 103  
        , 30
        , 'Diana'    
        , 'Lorentz'      
        , 0       
        , '1997-02-07'  
        , '0845-1234567'    
        , 'Diana123@gmail.com'  
        , 'TICKET SALES'   
        , '2020-02-07'    
        , 1000
        , 150
        );
        
INSERT INTO AS_EMPLOYEES VALUES
        ( 104  
        , 30
        , 'Nancy'    
        , 'Greenberg'    
        , 0       
        , '2002-08-17' 
        , '0845-5556667'    
        , 'NancyGreen@gmail.com'  
        , 'TICKET SALES'   
        , '2022-08-17'    
        , 1500
        , 250
        );
        

INSERT INTO AS_EMPLOYEES VALUES
        ( 105  
        , 50
        , 'John'    
        , 'Chen'    
        , 1       
        , '1995-09-28'
        , '0845-0101010'    
        , 'JohnChen@gmail.com'  
        , 'SUPPORT'   
        , '2019-09-28'   
        , 2100
        , NULL
        );
--
INSERT INTO AS_TRIP VALUES (1,'F001',100);
INSERT INTO AS_TRIP VALUES (2,'F001',101);
INSERT INTO AS_TRIP VALUES (3,'F002',100);
INSERT INTO AS_TRIP VALUES (4,'F003',102);
INSERT INTO AS_TRIP VALUES (5,'F003',105);
--
INSERT INTO AS_PASSENGERS VALUES(91234567,NULL,'Taylor Swift','0125-5551251','United Kingdom');
INSERT INTO AS_PASSENGERS VALUES(81234567,012345,'Lana Del Rey','0126-5551251','United States');
INSERT INTO AS_PASSENGERS VALUES(71234567,NULL,'Xiao Yang','0127-5551251','China');
INSERT INTO AS_PASSENGERS VALUES(61234567,222445,'Nakamura Kimura','0128-5551251','Japan');
INSERT INTO AS_PASSENGERS VALUES(51234567,NULL,'Nguyen Van A','0129-5551251','Vietnam');
--
INSERT INTO AS_TICKET VALUES('10','F001',500);
INSERT INTO AS_TICKET VALUES('11','F002',550);
INSERT INTO AS_TICKET VALUES('12','F003',670);
INSERT INTO AS_TICKET VALUES('13','F004',250);
INSERT INTO AS_TICKET VALUES('14','F005',1000);
--
INSERT INTO AS_BILL VALUES(1000,103,091234567,'10','A-001','G-A',10,'A','2022-07-19 9:35:40');
INSERT INTO AS_BILL VALUES(1001,104,091234567,'10','B-003','G-A',NULL,'C','2022-07-19 9:36:40');
INSERT INTO AS_BILL VALUES(1002,103,081234567,'11','Z-271','G-B',15,'A','2017-12-01 21:52:16');
INSERT INTO AS_BILL VALUES(1003,104,071234567,'12','C-004','G-C',12,'B','2023-06-11 11:24:23');
INSERT INTO AS_BILL VALUES(1004,103,051234567,'13','D-005','G-F',NULL,'A','2020-10-20 7:45:19');
--
/*---------------------------------------------------------------------------------------------*/
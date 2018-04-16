
-- CREATE DATABASE ARROWSTREET;

USE ARROWSTREET;

CREATE TABLE Positions(
            load_id     int   NOT NULL, 
            acct_cd        varchar (20)   NOT NULL,
            acct_num      varchar(255)             NULL,
            sec_id        varchar(50)   NOT NULL,
            long_sht_cd   varchar(3)     NOT NULL,
            sedol        varchar(15)   NULL,
            isin               varchar(15)   NULL,
            cusip              varchar(9)     NULL,
            sec_type       varchar(8)     NULL,
            sec_name     varchar(100) NULL,
            currency_cd varchar(3)     NULL,
            total_holding decimal(18, 4) NULL,
            mkt_price      float               NULL,
            datetime_stamp datetime  NULL,
CONSTRAINT pk_Positions PRIMARY KEY CLUSTERED (       
 load_id  ASC, 
 acct_cd ASC, 
 sec_id ASC,
 long_sht_cd ASC )
);



CREATE TABLE PositionsTEST(
            load_id     int   NOT NULL, 
            acct_cd        varchar (20)   NOT NULL,
            acct_num      varchar(255)             NULL,
            sec_id        varchar(50)   NOT NULL,
            long_sht_cd   varchar(3)     NOT NULL,
            mkt_price      float               NULL,
            datetime_stamp datetime  NULL,
CONSTRAINT pk_Positions PRIMARY KEY CLUSTERED (       
 load_id  ASC, 
 acct_cd ASC, 
 sec_id ASC,
 long_sht_cd ASC )
);

INSERT INTO PositionsTEST values 
(1, 'A', '10Pet', '11Pet', '100', 2000, '2018-04-15 08:00:00'),
(1, 'B', '10Loi', '11PLoi', '200', 3000, '2018-04-15 08:01:00'),
(10, 'B', '10Loi', '11PLoi', '200', 3000, '2018-04-15 08:02:00');


INSERT INTO PositionsTEST values 
(2, 'C', '10Nei', '11Pet', '100', 2000, '2018-04-13 13:00:00'),
(2, 'C', '10Nei', '11PLoi', '400', 3000, '2018-04-13 13:01:00'), 
(2, 'C', '10Sti', '11PLoi', '300', 3000, '2018-04-13 13:10:00');


INSERT INTO PositionsTEST values 
(3, 'D', '10vor', '11Pet', '800', 2000, '2018-04-12 20:00:00'),
(3, 'D', '10DIS', '11PLoi', '200', 3000, '2018-04-12 20:05:00'),
(3, 'D', '10LA', '11PLoi', '600', 3000, '2018-04-12 20:10:00'),
(3, 'D', '10NYC', '11PLoi', '900', 3000, '2018-04-16 07:15:00');


select * from PositionsTEST;

truncate table PositionsTEST;


SELECT * from PositionsTest where load_id = ( SELECT load_id from PositionsTest where DATE (datetime_stamp) = DATE(NOW()) 
order by datetime_stamp asc
limit 1);


-- Another less efficient query : 

SELECT * from PositionsTEST where load_id =  ( select load_id from PositionsTEST where datetime_stamp  = 
 ( select MIN(datetime_stamp) from PositionsTEST where DATE(datetime_stamp) = DATE(NOW())));



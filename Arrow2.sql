
USE ARROWSTREET;

DROP TABLE tSWIFT_History_Trades;

CREATE TABLE tSWIFT_History_Trades(
	Id 		int  NOT NULL,
	BatchId	varchar (25) NOT NULL,
	TradeId	varchar (25) NOT NULL,
	Account	varchar(25) NULL,
	TranType	varchar (50) NULL,
	TradeDate	int NULL,
	SettleDate  int NULL,
	Exch	varchar (50) NULL,
	DateSent 	datetime NOT NULL DEFAULT NOW(),
	Status 	varchar (20) NOT NULL,
	AckNak	varchar (7) DEFAULT 'ABC',
	MachineIdReceived varchar (50) NULL,
	FileNameReceived varchar (100) NULL,
	DateReceived datetime NULL,
	DirectoryArchivedReceived varchar (300) NULL,
	Error		varchar (500) NULL,
	Price		float NULL  DEFAULT 0 ,
	CONSTRAINT PK_tSWIFT_History_Trades PRIMARY KEY  ( Id ));


insert into tSWIFT_History_Trades values(100, 'Batch1', 'Trade1','Account1','Tran1',123,456,'Exc1', Now(),'Status1','None', 
'Machine1', 'FIle1',Now(),'directory1','Erroe1',100.98);

SELECT * FROM tSWIFT_History_Trades;

UPDATE tSWIFT_History_Trades SET MachineIdReceived = 'RUTIKARANJOLKAR', FileNameReceived = 'rectestFile1', DirectoryArchivedReceived = 'archrecDir1', DateReceived = Now(), AckNak = 'ACK' WHERE (BatchId = 'Batch1' AND TradeId = 'Trade1');

CREATE TABLE Vuelos (
	codigo VARCHAR(6) PRIMARY KEY,
	origen VARCHAR(30),
	destino VARCHAR(30));

INSERT INTO Vuelos VALUES
	('TJ3028', 'BsAs', 'París'),
	('CJ2924', 'París', 'Londres'),
	('AB6180', 'Londres', 'BsAs'),
	('RS5628', 'Londres', 'Moscú'),
	('AJ5581', 'Roma', 'Londres'),
	('AJ7222', 'Londres', 'Dublín'),
	('SJ9956', 'Río', 'Dublín'),
	('NG3577', 'Moscú', 'Beijing'),
	('AF3312', 'Tokio', 'Beijing'),
	('SA3536', 'Tokio', 'Roma'),
	('VJ8092', 'Oslo', 'Dublín');

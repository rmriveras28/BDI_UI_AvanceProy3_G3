CREATE DATABASE PROYECTOSQL
USE PROYECTOSQL

CREATE TABLE DEPARTAMENTO(
	ID_DEPARTAMENTO		INT IDENTITY(1,1),
	NOMBRE				VARCHAR(50) NOT NULL,
	CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (ID_DEPARTAMENTO)
)

CREATE TABLE SUCURSAL(
	ID_SUCURSAL			INT IDENTITY(1,1),
	NOMBRE				VARCHAR(50) NOT NULL,
	DIRECCION			VARCHAR(50) NOT NULL,
	ID_DEPARTAMENTO		INT NOT NULL,
	CONSTRAINT PK_SUCURSAL PRIMARY KEY (ID_SUCURSAL),
	CONSTRAINT FK_SUCURSAL_DEPARTAMENTO FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTO (ID_DEPARTAMENTO)
)

CREATE TABLE SEGURO(
	ID_SEGURO		INT IDENTITY(1,1),
	NOMBRE			VARCHAR(50) NOT NULL,
	TIPO_SEGURO		VARCHAR(50) NOT NULL,
	FECHA_INICIAL	DATE NOT NULL,
	FECHA_FINAL		DATE NOT NULL,
	CONSTRAINT PK_SEGURO PRIMARY KEY (ID_SEGURO)
)

CREATE TABLE PROVEEDOR(
	ID_PROVEEDOR		INT IDENTITY(1,1),
	NOMBRE				VARCHAR(50) NOT NULL,
	EMAIL				VARCHAR(50) NOT NULL,
	TELEFONO			VARCHAR(50) NOT NULL,
	CONSTRAINT PK_PROVEEDOR PRIMARY KEY (ID_PROVEEDOR)
)

CREATE TABLE BODEGA(
	ID_BODEGA			INT IDENTITY(1,1),
	NOMBRE				VARCHAR(50),
	CAPACIDAD			INT NOT NULL,
	ID_SUCURSAL			INT NOT NULL,
	CONSTRAINT PK_BODEGA PRIMARY KEY (ID_BODEGA),
	CONSTRAINT FK_BODEGA_SUCURSAL FOREIGN KEY (ID_SUCURSAL) REFERENCES SUCURSAL (ID_SUCURSAL)
)

CREATE TABLE EMPLEADO (
	ID_EMPLEADO	INT IDENTITY(1,1),
	IDENTIDAD	VARCHAR(50) NOT NULL,
	NOMBRE1		VARCHAR(50) NOT NULL,
	NOMBRE2		VARCHAR(50) NOT NULL,
	APELLIDO1	VARCHAR(50) NOT NULL,
	APELLIDO2	VARCHAR(50) NOT NULL,
	SEXO		CHAR(1) CHECK(SEXO IN ('F','M'))NOT NULL,
	DIRECCION	VARCHAR(50) NOT NULL,
	EMAIL		VARCHAR(50) NOT NULL,
	TELEFONO	VARCHAR(50) NOT NULL,
	ROL			VARCHAR(50) NOT NULL,
	USUARIO		VARCHAR(50) UNIQUE NOT NULL,
	CONTRASEŅA	VARCHAR(50),
	ID_SUCURSAL	INT NOT NULL,
	CONSTRAINT PK_EMPLEADO PRIMARY KEY (ID_EMPLEADO),
	CONSTRAINT FK_EMPLEADO_SUCURSAL FOREIGN KEY (ID_SUCURSAL) REFERENCES SUCURSAL (ID_SUCURSAL)
)

CREATE TABLE GERENTE(
	ID_GERENTE	INT IDENTITY(1,1),
	ID_EMPLEADO	INT NOT NULL,
	CONSTRAINT PK_GERENTE PRIMARY KEY (ID_GERENTE),
	CONSTRAINT FK_GERENTE_EMPLEADO FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO(ID_EMPLEADO)
)

CREATE TABLE OPERADOR_DE_BODEGA(
	ID_OPERADOR_DE_BODEGA	INT IDENTITY(1,1),
	ID_EMPLEADO				INT NOT NULL,
	ID_GERENTE				INT NOT NULL,
	ID_BODEGA				INT NOT NULL,
	CONSTRAINT PK_OPERADOR_DE_BODEGA PRIMARY KEY (ID_OPERADOR_DE_BODEGA),
	CONSTRAINT FK_OPERADOR_DE_BODEGA_EMPLEADO FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO (ID_EMPLEADO),
	CONSTRAINT FK_OPERADOR_DE_BODEGA_GERENTE FOREIGN KEY (ID_GERENTE) REFERENCES GERENTE (ID_GERENTE),
	CONSTRAINT FK_OPERADOR_DE_BODEGA_BODEGA FOREIGN KEY (ID_BODEGA) REFERENCES BODEGA (ID_BODEGA)
)

CREATE TABLE AGENTE_DE_ALQUILER(
	ID_AGENTE_DE_ALQUILER	INT IDENTITY(1,1),
	ID_EMPLEADO				INT NOT NULL,
	ID_GERENTE				INT NOT NULL,
	CONSTRAINT PK_AGENTE_DE_ALQUILER PRIMARY KEY (ID_AGENTE_DE_ALQUILER),
	CONSTRAINT FK_AGENTE_DE_ALQUILER_EMPLEADO FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO (ID_EMPLEADO),
	CONSTRAINT FK_AGENTE_DE_ALQUILER_GERENTE FOREIGN KEY (ID_GERENTE) REFERENCES GERENTE (ID_GERENTE)
)

CREATE TABLE ADMINISTRADOR(
	ID_ADMINISTRADOR	INT IDENTITY(1,1),
	ID_EMPLEADO			INT NOT NULL,
	ID_GERENTE			INT NOT NULL,
	CONSTRAINT PK_ADMINISTRADOR PRIMARY KEY (ID_ADMINISTRADOR),
	CONSTRAINT FK_ADMINISTRADOR_EMPLEADO FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO (ID_EMPLEADO),
	CONSTRAINT FK_ADMINISTRADOR_GERENTE FOREIGN KEY (ID_GERENTE) REFERENCES GERENTE(ID_GERENTE)
)

CREATE TABLE AUTOMOVIL(
	ID_AUTOMOVIL			INT IDENTITY(1,1),
	MARCA					VARCHAR(50) NOT NULL,
	MODELO					VARCHAR(50) NOT NULL,
	CLASE					VARCHAR(50) NOT NULL,--CLASE SOCIAL
	AŅO						VARCHAR(50) NOT NULL,
	PASAJEROS				INT NOT NULL,
	FECHA_ADQUISICION		DATE NOT NULL,
	DISPONIBILIDAD			CHAR(1) CHECK (DISPONIBILIDAD IN ('V', 'F')) NOT NULL,
	PRECIO					INT NOT NULL,
	ID_SEGURO				INT NOT NULL,
	ID_PROVEEDOR			INT NOT NULL,
	ID_BODEGA				INT NOT NULL,
	ID_OPERADOR_DE_BODEGA	INT NOT NULL,
	CONSTRAINT PK_AUTOMOVIL PRIMARY KEY (ID_AUTOMOVIL),
	CONSTRAINT FK_AUTOMOVIL_SEGURO FOREIGN KEY (ID_SEGURO) REFERENCES SEGURO (ID_SEGURO),
	CONSTRAINT FK_AUTOMOVIL_PROVEEDOR FOREIGN KEY (ID_PROVEEDOR) REFERENCES PROVEEDOR (ID_PROVEEDOR),
	CONSTRAINT FK_AUTOMOVIL_BODEGA FOREIGN KEY (ID_BODEGA) REFERENCES BODEGA (ID_BODEGA),
	CONSTRAINT FK_AUTOMOVIL_OPERADOR_DE_BODEGA FOREIGN KEY (ID_OPERADOR_DE_BODEGA) REFERENCES OPERADOR_DE_BODEGA (ID_OPERADOR_DE_BODEGA)
)

CREATE TABLE CLIENTE (
	ID_CLIENTE				INT IDENTITY(1,1),
	IDENTIDAD				VARCHAR(50) NOT NULL,
	NOMBRE1					VARCHAR(50) NOT NULL,
	NOMBRE2					VARCHAR(50) NOT NULL,
	APELLIDO1				VARCHAR(50) NOT NULL,
	APELLIDO2				VARCHAR(50) NOT NULL,
	SEXO					CHAR(1) CHECK(SEXO IN ('F','M'))NOT NULL,
	DIRECCION				VARCHAR(50) NOT NULL,
	EMAIL					VARCHAR(50),
	TELEFONO				VARCHAR(50) NOT NULL,
	FECHA_ENTREGA_VEHICULO	DATE NOT NULL,
	ID_SUCURSAL				INT NOT NULL,	
	ID_AUTOMOVIL			INT NOT NULL,
	ID_AGENTE_DE_ALQUILER	INT NOT NULL,	
	CONSTRAINT PK_CLIENTE PRIMARY KEY (ID_CLIENTE),
	CONSTRAINT FK_CLIENTE_AUTOMOVIL FOREIGN KEY (ID_AUTOMOVIL) REFERENCES AUTOMOVIL (ID_AUTOMOVIL),
	CONSTRAINT FK_CLIENTE_AGENTE_DE_ALQUILER FOREIGN KEY (ID_AGENTE_DE_ALQUILER) REFERENCES AGENTE_DE_ALQUILER(ID_AGENTE_DE_ALQUILER),
	CONSTRAINT FK_CLIENTE_SUCURSAL FOREIGN KEY (ID_SUCURSAL) REFERENCES SUCURSAL (ID_SUCURSAL)
)

CREATE TABLE TRANSACCION(
	ID_TRANSACCION		INT IDENTITY(1,1),
	NUMERO_VOUCHER		VARCHAR(50) NOT NULL,
	MONTO				INT NOT NULL,
	FECHA_EMISION		DATE NOT NULL,
	ID_AUTOMOVIL		INT NOT NULL,
	ID_CLIENTE			INT NOT NULL,
	CONSTRAINT PK_TRANSACCION PRIMARY KEY (ID_TRANSACCION),
	CONSTRAINT FK_TRANSACCION_AUTOMOVIL FOREIGN KEY (ID_AUTOMOVIL) REFERENCES AUTOMOVIL (ID_AUTOMOVIL),
	CONSTRAINT FK_TRANSACCION_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE)
)

CREATE TABLE FACTURA(
	ID_FACTURA					INT IDENTITY(1,1),
	ID_SUCURSAL					INT NOT NULL,
	ID_AGENTE_DE_ALQUILER		INT NOT NULL,
	ID_TRANSACCION				INT NOT NULL,
	ID_CLIENTE					INT NOT NULL,
	ID_AUTOMOVIL				INT NOT NULL,
	CONSTRAINT PK_FACTURA PRIMARY KEY (ID_FACTURA),
	CONSTRAINT FK_FACTURA_SUCURSAL FOREIGN KEY (ID_SUCURSAL) REFERENCES SUCURSAL(ID_SUCURSAL),
	CONSTRAINT FK_FACTURA_AGENTE_DE_ALQUILER FOREIGN KEY (ID_AGENTE_DE_ALQUILER) REFERENCES AGENTE_DE_ALQUILER (ID_AGENTE_DE_ALQUILER),
	CONSTRAINT FK_FACTURA_TRANSACCION FOREIGN KEY (ID_TRANSACCION) REFERENCES TRANSACCION (ID_TRANSACCION),
	CONSTRAINT FK_FACTURA_CLIENTE	FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE),
	CONSTRAINT FK_AUTOMOVIL FOREIGN KEY (ID_AUTOMOVIL) REFERENCES AUTOMOVIL (ID_AUTOMOVIL)
)

--1 DEPARTAMENTO
INSERT INTO DEPARTAMENTO VALUES ('FRANCISCO MORAZAN')
INSERT INTO DEPARTAMENTO VALUES ('CORTES')
INSERT INTO DEPARTAMENTO VALUES ('COPAN')
SELECT * FROM DEPARTAMENTO

--2 SUCURSAL
INSERT INTO SUCURSAL VALUES ('CARMAX','COL LAS TORRES', 1)
INSERT INTO SUCURSAL VALUES ('AUTONATION INC','COL LA ROSA', 2)
INSERT INTO SUCURSAL VALUES ('GRUPO HENDRICK','SANTA ROSA DE COPAN', 3)
SELECT * FROM SUCURSAL

--3 SEGURO
INSERT INTO SEGURO VALUES ('SEGUROS ATLANTIDA','SEGURO CONTRA CHOQUES','20210514','20220514')
INSERT INTO SEGURO VALUES ('SEGUROS LAFISE','SEGURO CONTRA DAŅOS DE TERCEROS','20210207','20220207')
INSERT INTO SEGURO VALUES ('SEGUROS BAC','SEGURO CONTRA DAŅOS Y PERJUICIOS','20210315','20220315')
INSERT INTO SEGURO VALUES ('SEGUROS FICOHSA','SEGURO POR COLISION','20210430','20220430')
INSERT INTO SEGURO VALUES ('SEGUROS DE OCCIDENTE','COBERTURA DE PROTECCION CONTRA DAŅOS PERSONALES','20210101','20220101')
INSERT INTO SEGURO VALUES ('SEGUROS BAC','SEGURO INTEGRAL','2021-01-01','2022-01-01')
SELECT * FROM SEGURO

--4 PROVEEDOR
INSERT INTO PROVEEDOR VALUES ('EMPRESA HYUNDAI','HYNDAI@YAHOO.COM','98798654')
INSERT INTO PROVEEDOR VALUES ('EMPRESA TOYOTA','TOYOTA@GMAIL.COM','98792654')
INSERT INTO PROVEEDOR VALUES ('EMPRESA BMW','BMW@OUTLOOK.ES','97301763')
SELECT * FROM PROVEEDOR

--5 BODEGA
INSERT INTO BODEGA VALUES ('BODEGANGA',500,1)
SELECT * FROM BODEGA

--6 EMPLEADO
INSERT INTO EMPLEADO VALUES ('1401-1986-00009', 'MARIA', 'SARAHI', 'JIMENEZ', 'OSORIO', 'F', 'LAS LOMAS', 'MARIA@GMAIL.COM', '9999-9999','GERENTE','ABATELLA','123456',1)
INSERT INTO EMPLEADO VALUES ('0801-1977-06838', 'ALEX', 'MANUEL', 'DIAZ', 'ACOSTA', 'M', 'EL CENTRO', 'MANUEL@HOTMAIL.COM', '8888-9999','AGENTE DE ALQUILER','FINCRA','123456789',1)
INSERT INTO EMPLEADO VALUES ('1804-1929-02627', 'ANGEL', 'DANIEL', 'PEREZ', 'GARCIA', 'M', 'OLANCHITO', 'ANGEL@GMAIL.COM', '7777-8888','AGENTE DE ALQUILER','DALOMO','PICTURE1',1)
INSERT INTO EMPLEADO VALUES ('1521-1962-00039', 'KARLA', 'MARIANA', 'GONZALES', 'DIAZ', 'F', 'SPS', 'KARLA@HOTMAIL.COM', '9090-1111','OPERADOR DE BODEGA','IDOLCENT','PASSWORD',1)
INSERT INTO EMPLEADO VALUES ('0501-1966-06479', 'ORVIN', 'JAVIER', 'RIVERA', 'ACOSTA', 'M', 'SPS', 'JAVI@GMAIL.COM', '8899-9999','OPERADOR DE BODEGA','MAXUPFOR','123123',1)
INSERT INTO EMPLEADO VALUES ('1501-1953-00402', 'ALEJANDRO', 'JOSE', 'FLORES', 'GARCIA', 'M', 'EL HATO', 'ALE@GMAIL.COM', '7777-6538','ADMINISTRADOR','SENSTER','SENHA',1)
SELECT * FROM EMPLEADO

--7 GERENTE
INSERT INTO GERENTE VALUES (1)
SELECT * FROM GERENTE


--8 OPERADOR DE BODEGA
INSERT INTO OPERADOR_DE_BODEGA VALUES (4,1,1)
INSERT INTO OPERADOR_DE_BODEGA VALUES (5,1,1)
SELECT * FROM OPERADOR_DE_BODEGA

--9 AGENTE DE ALQUILER
INSERT INTO AGENTE_DE_ALQUILER VALUES (2,1)
INSERT INTO AGENTE_DE_ALQUILER VALUES (3,1)
SELECT * FROM AGENTE_DE_ALQUILER

--10 ADMINISTRADOR
INSERT INTO ADMINISTRADOR VALUES (6,1)
SELECT * FROM ADMINISTRADOR

--11 AUTOMOVIL
INSERT INTO AUTOMOVIL VALUES ('HYUNDAI','ACCENT','LUJO','2010',5,'2019-01-01','V',1500, 1, 1, 1, 1)
INSERT INTO AUTOMOVIL VALUES ('TOYOTA','AGYA','HUMILDE','2015',5,'2019-01-01','V',2000, 2, 2, 1, 2)
INSERT INTO AUTOMOVIL VALUES ('TOYOYA','AGYA','MEDIO','2018',5,'2019-01-01','V',3000, 3, 2, 1, 2)
INSERT INTO AUTOMOVIL VALUES ('HYUNDAI','H1','LUJO','2016',8,'2019-01-01','V',10000, 4, 1, 1, 1)
INSERT INTO AUTOMOVIL VALUES ('HYUNDAI','SANTA FE','BAJA','2016',7,'2019-01-01','V',5000, 5, 1, 1, 1)
INSERT INTO AUTOMOVIL VALUES ('BMW','X5','BAJA','2015',5,'2019-01-01','V',3000, 6, 1, 1, 2)
SELECT * FROM AUTOMOVIL 

--12 CLIENTE
INSERT INTO CLIENTE VALUES ('0107-1939-00315','IVETH', 'MARIELA', 'LOPEZ', 'PEREZ', 'F', 'EL PROGRESO', 'MARIELA@HOTMAIL.COM', '8899-3333','2020-01-01',1,1,1)
INSERT INTO CLIENTE VALUES ('0804-1970-01928','ANDRES', 'FERNANDO', 'CUELLO', 'FLORES', 'M', 'VILLA NUEVA CORTES', 'ANDY@GMAIL.COM', '2222-9999','2020-01-01',1,2,2)
INSERT INTO CLIENTE VALUES ('0801-1969-04035', 'KATHERINE', 'GISELL', 'RODRIGUEZ', 'FERNANDEZ', 'F', 'LA CEIBA', 'KATHGI@GMAIL.COM', '9825-8865','2020-01-01',1,3,2)
INSERT INTO CLIENTE VALUES ('1301-1930-00126', 'MARIO', 'JAVIER', 'AMADOR', 'FERNANDEZ', 'M', 'SPS', 'MARIFERN@GMAIL.COM', '5363-7362','2020-01-01',1,4,1)
INSERT INTO CLIENTE VALUES ('1501-1963-01096', 'MELISA', 'VALERIA', 'GUITIERRES', 'OSORIO', 'F', 'BARRIO CONCEPCION', 'VALE@GMAIL.COM', '9825-7453','2020-01-01',1,5,1)
INSERT INTO CLIENTE VALUES ('0601-1985-01511','JAVIER', 'ALEJANDRO', 'ACEBEDO', 'ZELAYA', 'M', 'LA KENEDY', 'ALEJAVI@HOTMAIL.COM', '8575-0826','2020-01-01',1,6,2)
SELECT * FROM CLIENTE

--13 TRANSACCION
INSERT INTO TRANSACCION VALUES (10000000001, 1500, '2019-12-15',1,1)
INSERT INTO TRANSACCION VALUES (10000000090, 2000, '2019-11-15',2,2)
INSERT INTO TRANSACCION VALUES (98756546898, 3000, '2019-12-17',3,3)
INSERT INTO TRANSACCION VALUES (23135468798, 10000,'2019-10-26',4,4)
INSERT INTO TRANSACCION VALUES (98745631254, 5000, '2019-12-10',5,5)
INSERT INTO TRANSACCION VALUES (32146549879, 3000, '2019-11-25',6,6)
SELECT * FROM TRANSACCION

--14 FACTURA
INSERT INTO FACTURA VALUES (1, 1, 1, 1 ,1 )
INSERT INTO FACTURA VALUES (1, 2, 2, 2 ,2 )
INSERT INTO FACTURA VALUES (1, 1, 3, 3 ,3 )
INSERT INTO FACTURA VALUES (1, 2, 4, 4 ,4 )
INSERT INTO FACTURA VALUES (1, 2, 5, 5 ,5 )
INSERT INTO FACTURA VALUES (1, 1, 6, 6 ,6 )
SELECT *FROM FACTURA		

SELECT	A.ID_OPERADOR_DE_BODEGA,
		E.NOMBRE1,
		E.APELLIDO1,
		S.NOMBRE,
		B.NOMBRE,
		EE.NOMBRE1
	FROM OPERADOR_DE_BODEGA A
INNER JOIN EMPLEADO E ON A.ID_EMPLEADO = E.ID_EMPLEADO
INNER JOIN SUCURSAL S ON E.ID_SUCURSAL = S.ID_SUCURSAL
INNER JOIN GERENTE G ON A.ID_GERENTE = G.ID_GERENTE
INNER JOIN EMPLEADO EE ON G.ID_EMPLEADO = EE.ID_EMPLEADO
INNER JOIN BODEGA B ON A.ID_BODEGA = B.ID_BODEGA

----------------------------------------------------------------------------------------------
--								REPORTES
----------------------------------------------------------------------------------------------
--REPORTE DE ADMINISTRADOR--------------------------------------------------------------------------------------
--1.
SELECT	E.NOMBRE1,
		E.APELLIDO1,
		A.MARCA,
		A.MODELO,
		CL.NOMBRE1,
		CL.APELLIDO1,
		COUNT (F.ID_FACTURA)
FROM EMPLEADO E
INNER JOIN AGENTE_DE_ALQUILER AG ON E.ID_EMPLEADO = AG.ID_EMPLEADO
INNER JOIN CLIENTE CL ON AG.ID_AGENTE_DE_ALQUILER = CL.ID_AGENTE_DE_ALQUILER
INNER JOIN AUTOMOVIL A ON CL.ID_AUTOMOVIL = A.ID_AUTOMOVIL
INNER JOIN FACTURA F ON AG.ID_AGENTE_DE_ALQUILER = F.ID_FACTURA
GROUP BY E.NOMBRE1,
		E.APELLIDO1,
		A.MARCA,
		A.MODELO,
		CL.NOMBRE1,
		CL.APELLIDO1

--RENTAS REALIZADAS POR EMPLEADO
SELECT	E.NOMBRE1,
		COUNT(F.ID_FACTURA) RENTAS_POR_EMPLEADO,
		MONTH(T.FECHA_EMISION) MES
		FROM EMPLEADO E
INNER JOIN AGENTE_DE_ALQUILER AG ON E.ID_EMPLEADO = AG.ID_EMPLEADO
INNER JOIN FACTURA F ON AG.ID_AGENTE_DE_ALQUILER = F.ID_AGENTE_DE_ALQUILER
INNER JOIN TRANSACCION T ON F.ID_TRANSACCION = T.ID_TRANSACCION
GROUP BY E.NOMBRE1,
		 T.FECHA_EMISION

--REPORTE DE SEGUROS Y PROVEEDORES
--2.
SELECT	S.NOMBRE,
		S.TIPO_SEGURO,
		P.NOMBRE,
		A.MARCA,
		A.MODELO
FROM SEGURO S
INNER JOIN AUTOMOVIL A ON S.ID_SEGURO = A.ID_SEGURO
INNER JOIN PROVEEDOR P ON A.ID_PROVEEDOR = P.ID_PROVEEDOR
-------------------------------------------------------------------------------------------
--REPORTES DE AGENTE DE ALQUILER
--1.
SELECT	CL.NOMBRE1,
		CL.APELLIDO1,
		A.MARCA,
		A.MODELO,
		CL.FECHA_ENTREGA_VEHICULO,
		E.NOMBRE1,
		E.APELLIDO1
FROM	CLIENTE CL
INNER JOIN AUTOMOVIL A ON CL.ID_AUTOMOVIL = A.ID_AUTOMOVIL
INNER JOIN AGENTE_DE_ALQUILER AG ON CL.ID_AGENTE_DE_ALQUILER = AG.ID_AGENTE_DE_ALQUILER
INNER JOIN EMPLEADO E ON AG.ID_EMPLEADO = E.ID_EMPLEADO

-------------------------------------------------------------------------------------------
--REPORTE DE OPERADOR DE BODEGA
--1.
SELECT	A.MARCA,
		COUNT(A.MODELO) MODELO_VEHICULO,
		P.NOMBRE,
		E.NOMBRE1,
		E.APELLIDO1,
		A.FECHA_ADQUISICION
FROM	AUTOMOVIL A
INNER JOIN PROVEEDOR P ON A.ID_PROVEEDOR = P.ID_PROVEEDOR
INNER JOIN OPERADOR_DE_BODEGA OP ON A.ID_OPERADOR_DE_BODEGA = OP.ID_OPERADOR_DE_BODEGA
INNER JOIN EMPLEADO E ON E.ID_EMPLEADO = OP.ID_EMPLEADO
GROUP BY A.MARCA,
		P.NOMBRE,
		E.NOMBRE1,
		E.APELLIDO1,
		A.FECHA_ADQUISICION

--2.
SELECT	A.MARCA,
		A.MODELO,
		CL.IDENTIDAD,
		CL.NOMBRE1,
		CL.APELLIDO1,
		CL.FECHA_ENTREGA_VEHICULO FECHA_DEVOLVER_VEHICULO,
		T.FECHA_EMISION FECHA_ENTREGA_VEHICULO
FROM AUTOMOVIL A
INNER JOIN CLIENTE CL ON A.ID_AUTOMOVIL = CL.ID_AUTOMOVIL
INNER JOIN TRANSACCION T ON A.ID_AUTOMOVIL = T.ID_AUTOMOVIL

--3.
SELECT	A.MARCA,
		A.MODELO,
		COUNT(A.DISPONIBILIDAD) DISPONIBLES
FROM AUTOMOVIL A
WHERE A.DISPONIBILIDAD = 'V'
GROUP BY	A.MARCA,
			A.MODELO
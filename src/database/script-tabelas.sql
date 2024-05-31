-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/


CREATE DATABASE tfruit;
USE tfruit;


-- ---------------------- --
-- Empresa
-- ---------------------- --
CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(45),
    telFixo VARCHAR(30),
    cnpj CHAR(14),
    cep CHAR(9),
    numEnd VARCHAR(45),
    complemento VARCHAR(45),
    dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO empresa(nome, email, telFixo, cnpj, cep, numEnd, complemento)  VALUES 
('SPTech Transportes', 'contato@transporte.com', '(11) 1234-5678', '12345678901234', '12345-678', '123', 'Andar 101'),
('Brandãos Hortifruti', 'contato@hortifrutibrandao.com', '(22) 9876-5432', '98765432109876', '98765-432', '456', 'Sala 202'),
('Digital Bulding Frutas Tropical', 'contato@digitalfrutas.com', '(33) 5678-1234', '56789012345678', '56789-012', '789', 'Bloco B');

SELECT * FROM empresa;



-- ---------------------- --
-- Usuário
-- ---------------------- --
CREATE TABLE usuario (
	idUsuario INT AUTO_INCREMENT,
    fkEmpresa INT,
		CONSTRAINT pkComposta PRIMARY KEY (idUsuario,fkEmpresa),
        CONSTRAINT fkEmpresa_usuario FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
	nome VARCHAR(50),
    senha VARCHAR (30),
    email VARCHAR(45),
    isAdm TINYINT
);

INSERT INTO usuario(fkEmpresa, nome, senha, email, isAdm) VALUES 
(1, 'Frizza', 'senhaF', 'frizza@sptech.transportes', 1),
(1, 'Pedro', 'senhaP', 'pedro@sptech.transportes', 0),
(2, 'Brandão', 'senhaB', 'brandao@hortifruti.brandao', 1),
(2, 'Julia', 'senhaJ', 'julia@hortifruti.brandao', 0),
(3, 'Pettry', 'senhaP', 'pettry@digital.frutas', 1),
(3, 'Clara', 'senhaC', 'clara@digital.frutas', 0);

SELECT
empresa.nome as 'Empresa',
empresa.email as 'Email da Empresa',
usuario.isAdm as 'Tipo Usuário',
usuario.nome as 'Usuário',
usuario.email as 'Email do Usuário'
FROM usuario JOIN empresa
ON fkEmpresa = idEmpresa;




-- ---------------------- --
-- Temperatura Ideal
-- ---------------------- --
CREATE TABLE temperaturaIdeal (
	idTemperaturaIdeal INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(5,2)
);


INSERT INTO temperaturaIdeal(valor)  VALUES 
(12.00);

SELECT * FROM temperaturaIdeal;



-- ---------------------- --
-- Dispositivo
-- ---------------------- --
CREATE TABLE dispositivo (
	idDispositivo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    fkEmpresa INT,
		CONSTRAINT fkEmpresa_dispositivo FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa),
	fkTemperaturaIdeal INT,
		CONSTRAINT fkTempIdeal_dispositivo FOREIGN KEY (fkTemperaturaIdeal) REFERENCES temperaturaIdeal(idTemperaturaIdeal)
);

INSERT INTO dispositivo(nome, fkEmpresa, fkTemperaturaIdeal) VALUES 
('Sensor 22', 1, 1),
('Sensor 57', 1, 1),
('Sensor 01', 2, 1),
('Sensor 09', 2, 1),
('Sensor 7', 3, 1),
('Sensor 11', 3, 1);

SELECT idEmpresa as 'ID Empresa' , 
empresa.nome as 'Empresa', 
dispositivo.nome as 'Dispositivo', 
temperaturaIdeal.valor as 'Temperatura Ideal'
FROM dispositivo JOIN empresa
	ON fkEmpresa = idEmpresa
JOIN temperaturaIdeal
	ON fkTemperaturaIdeal = idTemperaturaIdeal;




-- ---------------------- --
-- TemperaturaMedida
-- ---------------------- --
CREATE TABLE temperaturaMedida (
	idTemperaturaMedida INT AUTO_INCREMENT,
    fkDispositivo INT,
		CONSTRAINT pkcomposta2 PRIMARY KEY (idTemperaturaMedida, fkDispositivo),
        CONSTRAINT fkDispositivo_temp_medida FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo),
	valor DECIMAL(5,2),
    horaMedida DATETIME DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO temperaturaMedida(fkDispositivo, valor) VALUES 
(1, 11.50),
(2, 12.20),
(3, 12.80),
(4, 12.50),
(5, 13.50),
(6, 14.00);

SELECT empresa.nome as 'Empresa',
dispositivo.nome as 'Dispositivo', 
horaMedida as 'Hora Medida',
temperaturaMedida.valor as 'Temperatura Medida', 
temperaturaIdeal.valor as 'Temperatura Ideal'   
FROM temperaturaMedida JOIN dispositivo
	ON fkDispositivo = idDispositivo
JOIN empresa 
	ON fkEmpresa = idEmpresa
JOIN temperaturaIdeal
	ON fktemperaturaIdeal = idTemperaturaIdeal;

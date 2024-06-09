-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/


CREATE DATABASE tfruit;
USE tfruit;

-- DROP DATABASE tfruit;

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
('Digital Bulding Frutas Tropicais', 'contato@digitalfrutas.com', '(33) 5678-1234', '56789012345678', '56789-012', '789', 'Bloco B');

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
(2, 'Frizza', 'senhaF', 'frizza@brandaos.hortifruti', 1),
(2, 'Pedro', 'senhaP', 'pedro@brandaos.hortifruti', 0),
(1, 'Brandão', 'senhaB', 'brandao@sptech.transportes', 1),
(1, 'Julia', 'senhaJ', 'julia@sptech.transportes', 0),
(3, 'Petry', 'senhaP', 'petry@digital.frutas', 1),
(3, 'Clara', 'senhaC', 'clara@digital.frutas', 0);

SELECT
empresa.nome as 'Empresa',
empresa.email as 'Email da Empresa',
usuario.isAdm as 'Tipo Usuário',
usuario.nome as 'Usuário',
usuario.email as 'Email do Usuário'
FROM usuario JOIN empresa
ON fkEmpresa = idEmpresa;

SELECT idUsuario, nome, email, isAdm FROM usuario WHERE email = 'brandao@hortifruti.brandao' AND senha = 'senhaB';




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
('Caixa 1', 1, 1),
('Caixa 2', 1, 1),
('Caixa 3', 2, 1),
('Caixa 4', 2, 1),
('Caixa 5', 3, 1),
('Caixa 6', 3, 1);

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

-- Dia 1: Temperaturas normais
INSERT INTO temperaturaMedida (fkDispositivo, valor, horaMedida)
VALUES 
    (1, 11.50, '2023-06-01 00:00:00'), (1, 11.60, '2023-06-01 00:10:00'), (1, 11.70, '2023-06-01 00:20:00'),
    (1, 11.80, '2023-06-01 00:30:00'), (1, 11.90, '2023-06-01 00:40:00'), (1, 12.00, '2023-06-01 00:50:00'),
    (1, 12.10, '2023-06-01 01:00:00'), (1, 12.20, '2023-06-01 01:10:00'), (1, 12.30, '2023-06-01 01:20:00'),
    (1, 12.40, '2023-06-01 01:30:00'), (1, 12.50, '2023-06-01 01:40:00'), (1, 12.60, '2023-06-01 01:50:00'),
    (1, 12.70, '2023-06-01 02:00:00'), (1, 12.80, '2023-06-01 02:10:00'), (1, 12.90, '2023-06-01 02:20:00'),
    (1, 13.00, '2023-06-01 02:30:00'), (1, 13.10, '2023-06-01 02:40:00'), (1, 13.20, '2023-06-01 02:50:00'),
    (1, 13.30, '2023-06-01 03:00:00'), (1, 13.40, '2023-06-01 03:10:00'), (1, 13.50, '2023-06-01 03:20:00'),
    (1, 13.60, '2023-06-01 03:30:00'), (1, 13.70, '2023-06-01 03:40:00'), (1, 13.80, '2023-06-01 03:50:00'),
    (1, 13.90, '2023-06-01 04:00:00'), (1, 14.00, '2023-06-01 04:10:00'), (1, 14.10, '2023-06-01 04:20:00'),
    (1, 14.20, '2023-06-01 04:30:00'), (1, 14.30, '2023-06-01 04:40:00'), (1, 14.40, '2023-06-01 04:50:00'),
    (1, 14.50, '2023-06-01 05:00:00'), (1, 14.60, '2023-06-01 05:10:00'), (1, 14.70, '2023-06-01 05:20:00'),
    (1, 14.80, '2023-06-01 05:30:00'), (1, 14.90, '2023-06-01 05:40:00'), (1, 15.00, '2023-06-01 05:50:00');
    
-- Dia 2: Temperaturas normais
INSERT INTO temperaturaMedida (fkDispositivo, valor, horaMedida)
VALUES 
    (1, 11.50, '2023-06-02 00:00:00'), (1, 11.60, '2023-06-02 00:10:00'), (1, 11.70, '2023-06-02 00:20:00'),
    (1, 11.80, '2023-06-02 00:30:00'), (1, 11.90, '2023-06-02 00:40:00'), (1, 12.00, '2023-06-02 00:50:00'),
    (1, 12.10, '2023-06-02 01:00:00'), (1, 12.20, '2023-06-02 01:10:00'), (1, 12.30, '2023-06-02 01:20:00'),
    (1, 12.40, '2023-06-02 01:30:00'), (1, 12.50, '2023-06-02 01:40:00'), (1, 12.60, '2023-06-02 01:50:00'),
    (1, 12.70, '2023-06-02 02:00:00'), (1, 12.80, '2023-06-02 02:10:00'), (1, 12.90, '2023-06-02 02:20:00'),
    (1, 13.00, '2023-06-02 02:30:00'), (1, 13.10, '2023-06-02 02:40:00'), (1, 13.20, '2023-06-02 02:50:00'),
    (1, 13.30, '2023-06-02 03:00:00'), (1, 13.40, '2023-06-02 03:10:00'), (1, 13.50, '2023-06-02 03:20:00'),
    (1, 13.60, '2023-06-02 03:30:00'), (1, 13.70, '2023-06-02 03:40:00'), (1, 13.80, '2023-06-02 03:50:00'),
    (1, 13.90, '2023-06-02 04:00:00'), (1, 14.00, '2023-06-02 04:10:00'), (1, 14.10, '2023-06-02 04:20:00'),
    (1, 14.20, '2023-06-02 04:30:00'), (1, 14.30, '2023-06-02 04:40:00'), (1, 14.40, '2023-06-02 04:50:00'),
	(1, 14.50, '2023-06-02 05:00:00'), (1, 14.60, '2023-06-02 05:10:00'), (1, 14.70, '2023-06-02 05:20:00'),
	(1, 14.80, '2023-06-02 05:30:00'), (1, 14.90, '2023-06-02 05:40:00'), (1, 15.00, '2023-06-02 05:50:00');

-- Dia 3: Temperaturas altas
INSERT INTO temperaturaMedida (fkDispositivo, valor, horaMedida)
VALUES
(1, 17.00, '2023-06-03 00:00:00'), (1, 17.10, '2023-06-03 00:10:00'), (1, 17.20, '2023-06-03 00:20:00'),
(1, 17.30, '2023-06-03 00:30:00'), (1, 17.40, '2023-06-03 00:40:00'), (1, 17.50, '2023-06-03 00:50:00'),
(1, 17.60, '2023-06-03 01:00:00'), (1, 17.70, '2023-06-03 01:10:00'), (1, 17.80, '2023-06-03 01:20:00'),
(1, 17.90, '2023-06-03 01:30:00'), (1, 18.00, '2023-06-03 01:40:00'), (1, 18.10, '2023-06-03 01:50:00'),
(1, 18.20, '2023-06-03 02:00:00'), (1, 18.30, '2023-06-03 02:10:00'), (1, 18.40, '2023-06-03 02:20:00'),
(1, 18.50, '2023-06-03 02:30:00'), (1, 18.60, '2023-06-03 02:40:00'), (1, 18.70, '2023-06-03 02:50:00'),
(1, 18.80, '2023-06-03 03:00:00'), (1, 18.90, '2023-06-03 03:10:00'), (1, 19.00, '2023-06-03 03:20:00'),
(1, 19.10, '2023-06-03 03:30:00'), (1, 19.20, '2023-06-03 03:40:00'), (1, 19.30, '2023-06-03 03:50:00'),
(1, 19.40, '2023-06-03 04:00:00'), (1, 19.50, '2023-06-03 04:10:00'), (1, 19.60, '2023-06-03 04:20:00'),
(1, 19.70, '2023-06-03 04:30:00'), (1, 19.80, '2023-06-03 04:40:00'), (1, 19.90, '2023-06-03 04:50:00'),
(1, 20.00, '2023-06-03 05:00:00'), (1, 20.00, '2023-06-03 05:10:00'), (1, 20.00, '2023-06-03 05:20:00'),
(1, 20.00, '2023-06-03 05:30:00'), (1, 20.00, '2023-06-03 05:40:00'), (1, 20.00, '2023-06-03 05:50:00');

-- Dia 4: Temperaturas normais
INSERT INTO temperaturaMedida (fkDispositivo, valor, horaMedida)
VALUES
(1, 11.50, '2023-06-04 00:00:00'), (1, 11.60, '2023-06-04 00:10:00'), (1, 11.70, '2023-06-04 00:20:00'),
(1, 11.80, '2023-06-04 00:30:00'), (1, 11.90, '2023-06-04 00:40:00'), (1, 12.00, '2023-06-04 00:50:00'),
(1, 12.10, '2023-06-04 01:00:00'), (1, 12.20, '2023-06-04 01:10:00'), (1, 12.30, '2023-06-04 01:20:00'),
(1, 12.40, '2023-06-04 01:30:00'), (1, 12.50, '2023-06-04 01:40:00'), (1, 12.60, '2023-06-04 01:50:00'),
(1, 12.70, '2023-06-04 02:00:00'), (1, 12.80, '2023-06-04 02:10:00'), (1, 12.90, '2023-06-04 02:20:00'),
(1, 13.00, '2023-06-04 02:30:00'), (1, 13.10, '2023-06-04 02:40:00'), (1, 13.20, '2023-06-04 02:50:00'),
(1, 13.30, '2023-06-04 03:00:00'), (1, 13.40, '2023-06-04 03:10:00'), (1, 13.50, '2023-06-04 03:20:00'),
(1, 13.60, '2023-06-04 03:30:00'), (1, 13.70, '2023-06-04 03:40:00'), (1, 13.80, '2023-06-04 03:50:00'), 
(1, 13.90, '2023-06-04 04:00:00'), (1, 14.00, '2023-06-04 04:10:00'), (1, 14.10, '2023-06-04 04:20:00'), 
(1, 14.20, '2023-06-04 04:30:00'), (1, 14.30, '2023-06-04 04:40:00'), (1, 14.40, '2023-06-04 04:50:00'), 
(1, 14.50, '2023-06-04 05:00:00'), (1, 14.60, '2023-06-04 05:10:00'), (1, 14.70, '2023-06-04 05:20:00'), 
(1, 14.80, '2023-06-04 05:30:00'), (1, 14.90, '2023-06-04 05:40:00'), (1, 15.00, '2023-06-04 05:50:00');

-- Dia 5: Temperaturas baixas
INSERT INTO temperaturaMedida (fkDispositivo, valor, horaMedida)
VALUES
(1, 5.00, '2023-06-05 00:00:00'), (1, 5.10, '2023-06-05 00:10:00'), (1, 5.20, '2023-06-05 00:20:00'),
(1, 5.30, '2023-06-05 00:30:00'), (1, 5.40, '2023-06-05 00:40:00'), (1, 5.50, '2023-06-05 00:50:00'),
(1, 5.60, '2023-06-05 01:00:00'), (1, 5.70, '2023-06-05 01:10:00'), (1, 5.80, '2023-06-05 01:20:00'),
(1, 5.90, '2023-06-05 01:30:00'), (1, 6.00, '2023-06-05 01:40:00'), (1, 6.10, '2023-06-05 01:50:00'),
(1, 6.20, '2023-06-05 02:00:00'), (1, 6.30, '2023-06-05 02:10:00'), (1, 6.40, '2023-06-05 02:20:00'),
(1, 6.50, '2023-06-05 02:30:00'), (1, 6.60, '2023-06-05 02:40:00'), (1, 6.70, '2023-06-05 02:50:00'),
(1, 6.80, '2023-06-05 03:00:00'), (1, 6.90, '2023-06-05 03:10:00'), (1, 7.00, '2023-06-05 03:20:00'),
(1, 7.10, '2023-06-05 03:30:00'), (1, 7.20, '2023-06-05 03:40:00'), (1, 7.30, '2023-06-05 03:50:00'),
(1, 7.40, '2023-06-05 04:00:00'), (1, 7.50, '2023-06-05 04:10:00'), (1, 7.60, '2023-06-05 04:20:00'),
(1, 7.70, '2023-06-05 04:30:00'), (1, 7.80, '2023-06-05 04:40:00'), (1, 7.90, '2023-06-05 04:50:00'),
(1, 8.00, '2023-06-05 05:00:00'), (1, 8.00, '2023-06-05 05:10:00'), (1, 8.00, '2023-06-05 05:20:00'),
(1, 8.00, '2023-06-05 05:30:00'), (1, 8.00, '2023-06-05 05:40:00'), (1, 8.00, '2023-06-05 05:50:00');

-- Dia 6: Temperaturas normais
INSERT INTO temperaturaMedida (fkDispositivo, valor, horaMedida)
VALUES 
    (1, 11.50, '2023-06-06 00:00:00'), (1, 11.60, '2023-06-06 00:10:00'), (1, 11.70, '2023-06-06 00:20:00'),
    (1, 11.80, '2023-06-06 00:30:00'), (1, 11.90, '2023-06-06 00:40:00'), (1, 12.00, '2023-06-06 00:50:00'),
    (1, 12.10, '2023-06-06 01:00:00'), (1, 12.20, '2023-06-06 01:10:00'), (1, 12.30, '2023-06-06 01:20:00'),
    (1, 12.40, '2023-06-06 01:30:00'), (1, 12.50, '2023-06-06 01:40:00'), (1, 12.60, '2023-06-06 01:50:00'),
    (1, 12.70, '2023-06-06 02:00:00'), (1, 12.80, '2023-06-06 02:10:00'), (1, 12.90, '2023-06-06 02:20:00'),
    (1, 13.00, '2023-06-06 02:30:00'), (1, 13.10, '2023-06-06 02:40:00'), (1, 13.20, '2023-06-06 02:50:00'),
    (1, 13.30, '2023-06-06 03:00:00'), (1, 13.40, '2023-06-06 03:10:00'), (1, 13.50, '2023-06-06 03:20:00'),
    (1, 13.60, '2023-06-06 03:30:00'), (1, 13.70, '2023-06-06 03:40:00'), (1, 13.80, '2023-06-06 03:50:00'),
    (1, 13.90, '2023-06-06 04:00:00'), (1, 14.00, '2023-06-06 04:10:00'), (1, 14.10, '2023-06-06 04:20:00'),
    (1, 14.20, '2023-06-06 04:30:00'), (1, 14.30, '2023-06-06 04:40:00'), (1, 14.40, '2023-06-06 04:50:00'),
    (1, 14.50, '2023-06-06 05:00:00'), (1, 14.60, '2023-06-06 05:10:00'), (1, 14.70, '2023-06-06 05:20:00'),
    (1, 14.80, '2023-06-06 05:30:00'), (1, 14.90, '2023-06-06 05:40:00'), (1, 15.00, '2023-06-06 05:50:00');

-- Dia 7: Temperaturas normais
INSERT INTO temperaturaMedida (fkDispositivo, valor, horaMedida)
VALUES 
    (1, 12.00, '2023-06-07 00:00:00'), (1, 12.00, '2023-06-07 00:10:00'), (1, 12.00, '2023-06-07 00:20:00'),
    (1, 12.00, '2023-06-07 00:30:00'), (1, 12.00, '2023-06-07 00:40:00'), (1, 12.00, '2023-06-07 00:50:00'),
    (1, 12.00, '2023-06-07 01:00:00'), (1, 12.00, '2023-06-07 01:10:00'), (1, 12.00, '2023-06-07 01:20:00'),
    (1, 12.00, '2023-06-07 01:30:00'), (1, 12.00, '2023-06-07 01:40:00'), (1, 12.00, '2023-06-07 01:50:00'),
    (1, 12.00, '2023-06-07 02:00:00'), (1, 12.00, '2023-06-07 02:10:00'), (1, 12.00, '2023-06-07 02:20:00'),
    (1, 12.00, '2023-06-07 02:30:00'), (1, 12.00, '2023-06-07 02:40:00'), (1, 12.00, '2023-06-07 02:50:00'),
    (1, 12.00, '2023-06-07 03:00:00'), (1, 12.00, '2023-06-07 03:10:00'), (1, 12.00, '2023-06-07 03:20:00'),
    (1, 12.00, '2023-06-07 03:30:00'), (1, 12.00, '2023-06-07 03:40:00'), (1, 12.00, '2023-06-07 03:50:00'),
    (1, 12.00, '2023-06-07 04:00:00'), (1, 12.00, '2023-06-07 04:10:00'), (1, 12.00, '2023-06-07 04:20:00'),
    (1, 12.00, '2023-06-07 04:30:00'), (1, 12.00, '2023-06-07 04:40:00'), (1, 12.00, '2023-06-07 04:50:00'),
    (1, 12.00, '2023-06-07 05:00:00'), (1, 12.00, '2023-06-07 05:10:00'), (1, 12.00, '2023-06-07 05:20:00'),
    (1, 12.00, '2023-06-07 05:30:00'), (1, 12.00, '2023-06-07 05:40:00'), (1, 12.00, '2023-06-07 05:50:00');


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

        SELECT e.nome AS nomeE, u.fkEmpresa AS fkEmpresa, u.idUsuario as idUsuario, u.nome as nomeU, u.email AS emailU, u.isAdm AS isAdm 
        FROM usuario u
	    JOIN empresa e
        ON u.fkEmpresa = e.idEmpresa
	    WHERE u.email = 'brandao@hortifruti.brandao' AND u.senha = 'senhaB';
        
SELECT
	(SELECT COUNT(valor) FROM temperaturaMedida WHERE valor > 11 AND valor < 13) AS 'OK',
    (SELECT COUNT(valor) FROM temperaturaMedida WHERE valor >= 13 OR valor <= 11) AS 'ALERTA';
    
    
SELECT
    (SELECT COUNT(valor) 
     FROM temperaturaMedida 
     WHERE (valor > 11 AND valor < 13) 
       AND (DATE(horaMedida) = '2024-05-05') AND (fkDispositivo = 1)) AS 'OK',
    (SELECT COUNT(valor) 
     FROM temperaturaMedida 
     WHERE (valor >= 13 OR valor <= 11) 
       AND (DATE(horaMedida) = '2024-05-05') AND (fkDispositivo = 1)) AS 'ALERTA';
       
SELECT
       
    (SELECT COUNT(tm.valor) 
     FROM temperaturaMedida tm
     JOIN dispositivo d ON tm.fkDispositivo = d.idDispositivo
     JOIN usuario u ON d.fkEmpresa = u.fkEmpresa
     WHERE (tm.valor > 11 AND tm.valor < 13)
       AND (DATE(tm.horaMedida) = '2024-05-05')
       AND (u.idUsuario = 1)) AS 'OK',
       
    (SELECT COUNT(tm.valor) 
     FROM temperaturaMedida tm
     JOIN dispositivo d ON tm.fkDispositivo = d.idDispositivo
     JOIN usuario u ON d.fkEmpresa = u.fkEmpresa
     WHERE (tm.valor >= 13 OR tm.valor <= 11)
       AND (DATE(tm.horaMedida) = '2024-05-05')
       AND (u.idUsuario = 1)) AS 'ALERTA';
       
SELECT * FROM dispositivo WHERE fkEmpresa = 1;
SELECT * FROM usuario;
SELECT * FROM temperaturaMedida;

SELECT valor AS temperatura, TIME(horaMedida) AS hora FROM temperaturaMedida WHERE DATE(horaMedida) = '2024-05-05';

SELECT DISTINCT DATE(tm.horaMedida) AS dataMedida
FROM temperaturaMedida tm
JOIN dispositivo d ON tm.fkDispositivo = d.idDispositivo
JOIN usuario u ON d.fkEmpresa = u.fkEmpresa
WHERE u.idUsuario = 1
ORDER BY dataMedida;

SELECT DISTINCT DATE_FORMAT(tm.horaMedida, '%d/%m/%Y') AS dataMedida
FROM temperaturaMedida tm
JOIN dispositivo d ON tm.fkDispositivo = d.idDispositivo
JOIN usuario u ON d.fkEmpresa = u.fkEmpresa
WHERE u.idUsuario = 1
ORDER BY dataMedida;


SELECT 
    d.idDispositivo,
    d.fkEmpresa,
    d.nome AS nomeDispositivo
FROM 
    usuario u
JOIN 
    empresa e ON u.fkEmpresa = e.idEmpresa
JOIN 
    dispositivo d ON e.idEmpresa = d.fkEmpresa
WHERE 
    u.idUsuario = 1;

    SELECT DISTINCT DATE_FORMAT(tm.horaMedida, '%d/%m/%Y') AS dataMedida
    FROM temperaturaMedida tm
    JOIN dispositivo d ON tm.fkDispositivo = d.idDispositivo
    JOIN usuario u ON d.fkEmpresa = u.fkEmpresa
    WHERE u.idUsuario = 1 AND d.idDispositivo = 1
    ORDER BY dataMedida;

    SELECT valor AS temperatura, date_format(horaMedida, '%H:%i') as hora FROM temperaturaMedida WHERE DATE(horaMedida) = '2024-05-05';

-- select feito pela profa vivian
    SELECT ROUND(AVG(valor), 2) AS temperatura, date_format(horaMedida, '%H') as hora FROM temperaturaMedida 
    WHERE DATE(horaMedida) = '2024-06-04' GROUP BY date_format(horaMedida, '%H')
    union all
     SELECT ROUND(AVG(valor), 2) AS temperatura, date_format(horaMedida, '%H:%i') as horaMinuto FROM temperaturaMedida 
    WHERE DATE(horaMedida) = '2024-06-04' GROUP BY date_format(horaMedida, '%H:%i');

SELECT ROUND(AVG(valor), 2) AS temperatura, HOUR(horaMedida) AS hora
FROM temperaturaMedida
WHERE DATE(horaMedida) = '2024-06-04'
GROUP BY HOUR(horaMedida);
    
    INSERT INTO temperaturaMedida (fkDispositivo, valor, horaMedida) VALUES 
		(1, 14.7, DEFAULT);
        
            SELECT ROUND(AVG(valor), 2) AS temperatura, date_format(horaMedida, '%H') as hora FROM temperaturaMedida 
    WHERE DATE(horaMedida) = '2024-06-04' GROUP BY date_format(horaMedida, '%H');
    
SELECT valor, date_format(horaMedida, '%H:%i:%s') as hora FROM temperaturaMedida LIMIT 5;
    
    DESC temperaturaMedida;
    
    DESC empresa;
    
    desc dispositivo;
    
     SELECT valor FROM temperaturaMedida WHERE fkDispositivo = (SELECT idDispositivo FROM dispositivo where fkEmpresa = 1 LIMIT 1) ORDER BY horaMedida DESC LIMIT 1;
     
     SELECT idDispositivo FROM dispositivo where fkEmpresa = 1 LIMIT 1;
     
     SELECT nome, email FROM usuario WHERE fkEmpresa = 1 AND isAdm = 0;
     
     SELECT ROUND(AVG(valor),2) FROM temperaturaMedida WHERE fkDispositivo = 1 AND DATE(horaMedida) = '2024-06-04';
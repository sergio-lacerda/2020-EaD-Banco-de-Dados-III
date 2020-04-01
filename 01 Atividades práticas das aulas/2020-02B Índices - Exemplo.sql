/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Scripts das atividades práticas em aula - Índices.
 ----------------------------------------------------------------------*/

/* ----------------------- Criando o banco de dados --------------------------*/
CREATE SCHEMA `dbindices` ;
use dbindices;

/* ----------------------- Criando table para testes -------------------------*/
CREATE TABLE Clientes (
	CPF INT NOT NULL PRIMARY KEY,
    Nome VARCHAR(80) NOT NULL,
    Email VARCHAR(80) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    DataNascimento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* ----------------------- Inserindo valores de testes -----------------------*/
INSERT INTO Clientes (CPF, Nome, Email, Telefone, DataNascimento) 
VALUES (111, 'Epaminondas da Silva', 'epa@mail.com', '14966885547', '1980-03-18');

INSERT INTO Clientes (CPF, Nome, Email, Telefone, DataNascimento) 
VALUES (222, 'Zuleika Machado', 'zuzu@mail.com', '14988885674', '1980-05-13');

INSERT INTO Clientes (CPF, Nome, Email, Telefone, DataNascimento) 
VALUES (333, 'Pafúncio Rocha', 'paf@mail.com', '14977778542', '1990-01-03');

/* ----------------------- Criando índices de exemplo -----------------------*/
CREATE INDEX IX_CPF
ON Clientes (CPF);

CREATE INDEX IX_Nome
ON Clientes (Nome);

CREATE INDEX IX_DataNasc
ON Clientes (DataNascimento);

/* ------------------ Mostrando todos os índices de exemplo ------------------*/
SHOW INDEX FROM Clientes;

/* -------------------------- Apagando um índice -----------------------------*/
DROP INDEX IX_CPF ON Clientes;




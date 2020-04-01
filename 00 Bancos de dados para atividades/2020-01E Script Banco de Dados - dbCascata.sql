/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script para banco de dados - dbCascata - Exemplo utilizado em aula.
 ----------------------------------------------------------------------*/
CREATE SCHEMA dbcascata;
USE dbcascata;

/*---------------------------------------------------------------
  Vamos criar duas tabelas e estabelecer um relacionamento entre
  elas com cardinalidade (1:N). 
----------------------------------------------------------------*/  
/*----- criando a tabela Master ------*/
CREATE TABLE tbLojas(
	IdLoja INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    NomeLoja VARCHAR(30) NOT NULL
);

/*----- criando a tabela Detail -----*/
CREATE TABLE tbUnidades(
	IdUnidade INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    NomeUnidade VARCHAR(50) NOT NULL,
    IdLoja INT NOT NULL,
	FOREIGN KEY (IdLoja)
		REFERENCES tbLojas (IdLoja)
        ON DELETE CASCADE
);

/*----- cadastrando lojas -----------*/
INSERT INTO tbLojas(NomeLoja) VALUES ('Trufas do Pafúncio');
INSERT INTO tbLojas(NomeLoja) VALUES ('Zuleika Boleira');

/*----- cadastrando unidades --------*/
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Barra Bonita', 1);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Jau', 1);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Pederneiras', 1);

INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Barra Bonita', 2);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Botucatu', 2);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Piracicaba', 2);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade São Paulo', 2);

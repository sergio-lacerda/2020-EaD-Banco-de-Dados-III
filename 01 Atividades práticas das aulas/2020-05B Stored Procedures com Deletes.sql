/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script das atividades práticas em aula - Stored Procedures com Deletes.
 ----------------------------------------------------------------------*/
use dblojagames;

/*---------- Cadastrando alguns novos jogos para testes -------*/
CALL spCadastraProduto(9, 'Fortnite', 'Epic Games', 2017); 
CALL spCadastraProduto(10, 'FIFA 20', 'Eletronics Arts (EA)', 2019); 
CALL spCadastraProduto(11, 'Gears 5', 'Rod Fergusson', 2019); 
CALL spCadastraProdCategoria(11, 1, @Qtd);
CALL spCadastraProdCategoria(9, 1, @Qtd);
CALL spCadastraProdCategoria(9, 2, @Qtd); 

/*---------------------------------------------------------------
  Implemente uma stored procedure que receba como parâmetro um
  IdProduto e apague o respectivo registro.
----------------------------------------------------------------*/    
DELIMITER $$
CREATE PROCEDURE spApagaProduto(
	IN IdProd INT
)
BEGIN
	DELETE FROM Produtos WHERE IdProduto = IdProd;
END $$
DELIMITER ;

CALL spApagaProduto(10);

/*---------------------------------------------------------------
  Modifique a procedure anterior e crie uma nova Stored Procedure
  para apagar um determinado game, mesmo que ele tenha referências
  nas tabelas de CategoriasProdutos e PlataformasProdutos.
----------------------------------------------------------------*/  
DELIMITER $$
CREATE PROCEDURE spApagaProdutoDependencias(
	IN IdProd INT
)
BEGIN
	/*-- Apagando as dependências em CategoriasProdutos --*/
	DELETE FROM CategoriasProdutos WHERE IdProduto = IdProd;
	/*-- Apagando as dependências em PlataformasProdutos --*/
    DELETE FROM PlataformasProdutos WHERE IdProduto = IdProd;
	/*-- Apagando o produto na tabela master da relação --*/
	DELETE FROM Produtos WHERE IdProduto = IdProd;
END $$
DELIMITER ;

CALL spApagaProdutoDependencias(11);

/*****************************************************************
***************** Novo Banco de Dados de Exemplo *****************
*****************       para DELETE CASCADE      *****************
*****************************************************************/
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
SELECT * FROM tbLojas;

/*----- cadastrando unidades --------*/
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Barra Bonita', 1);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Jau', 1);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Pederneiras', 1);

INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Barra Bonita', 2);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Botucatu', 2);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade Piracicaba', 2);
INSERT INTO tbUnidades(NomeUnidade, IdLoja) VALUES ('Unidade São Paulo', 2);

SELECT * FROM tbUnidades;

/*---------------------------------------------------------------
  Criando uma Stored Procedures com um Delete simples. 
----------------------------------------------------------------*/
DELIMITER $$
CREATE PROCEDURE spApagaLoja(
	IN pLoja INT
)
BEGIN
	DELETE FROM tbLojas WHERE IdLoja = pLoja;
END $$
DELIMITER ;

CALL spApagaLoja(1);

SELECT * FROM tbLojas;
SELECT * FROM tbUnidades;






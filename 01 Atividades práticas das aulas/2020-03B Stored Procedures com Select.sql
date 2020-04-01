/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script das atividades práticas em aula - Stored Procedures com Selects.
 ----------------------------------------------------------------------*/

use dblojagames;

/*---------------------------------------------------------------
  Implemente uma stored procedure que retorne todos os registros 
  da tabela de produtos
----------------------------------------------------------------*/    
DELIMITER $$
CREATE PROCEDURE spListaProdutos()
BEGIN
	SELECT 	*
    FROM	produtos;
END $$
DELIMITER ;

CALL spListaProdutos();

/*---------------------------------------------------------------
  Implemente uma stored procedure que retorne todos os registros 
  da tabela de produtos, ordenada por ordem alfabética ascendente 
  de nome do game
----------------------------------------------------------------*/    
DELIMITER $$
CREATE PROCEDURE spListaProdutosOrdemProd()
BEGIN
	SELECT 	*
    FROM	produtos
    ORDER BY Produto ASC;
END $$
DELIMITER ;

CALL spListaProdutosOrdemProd();

/*-------------------------------------------------------------
  Implemente uma stored procedure que receba uma determinada 
  frase como parâmetro execute e retorne esssa frase como 
  resultado de uma consulta. Nomeie a coluna de resultado como 
  'Minha frase'
--------------------------------------------------------------*/  
DELIMITER $$
CREATE PROCEDURE spPapagaio(
	IN frase VARCHAR(50)
)
BEGIN
	SELECT 	frase AS 'Minha frase';
END $$
DELIMITER ;

CALL spPapagaio('Olá mundo...');

/*---------------------------------------------------------------
  Implemente uma stored procedure que receba como parâmetro o 
  código de um produto e retorne os dados do respectivo game
----------------------------------------------------------------*/  
DELIMITER $$
CREATE PROCEDURE spBuscaGamePorId(
	IN IdGame INT
)
BEGIN
	SELECT 	*
    FROM	produtos
    WHERE  	IdProduto = IdGame;
END $$
DELIMITER ;

CALL spBuscaGamePorId(3);

/*----------------------------------------------------------------
  Implemente uma stored procedure que receba como parâmetro o nome 
  de um produto e retorne os dados dos respectivos games
------------------------------------------------------------------*/  
DELIMITER $$
CREATE PROCEDURE spBuscaGamePorNome(
	IN Nome VARCHAR(50)
)
BEGIN
	SELECT 	*
    FROM	produtos
    WHERE  	Produto LIKE concat('%', Nome , '%');
END $$
DELIMITER ;

CALL spBuscaGamePorNome('of');

/*-----------------------------------------------------------------
  Implemente uma stored procedure que receba como parâmetro o 
  código de uma categoria e retorne todos os games dessa categoria
-----------------------------------------------------------------*/  
DELIMITER $$
CREATE PROCEDURE spBuscaGamePorCategoria(
	IN IdCateg INT
)
BEGIN
	SELECT 	C.IdCategoria, C.IdProduto, P.Produto
    FROM	categoriasprodutos C
			INNER JOIN produtos P ON P.IdProduto = C.IdProduto
    WHERE  	C.IdCategoria = IdCateg;
END $$
DELIMITER ;

CALL spBuscaGamePorCategoria(6);

/*---------------------------------------------------------------
  Implemente uma stored procedure que receba um código de plata-
  forma e retorne a quantidade de games compatíveis com a mesma.
----------------------------------------------------------------*/
DELIMITER $$
CREATE PROCEDURE spQtdGamesPlataforma(
	IN IdPlat INT
)
BEGIN
	DECLARE auxQtd INT DEFAULT 0;
    
    SET auxQtd = (    
					SELECT 	COUNT(P.IdProduto) AS Quantidade
					FROM	plataformasprodutos P
					WHERE  	P.IdPlataforma = IdPlat
				);
                
	SELECT CONCAT('Existem ', auxQtd, ' games compatíveis!') AS 'Quantidade de games';
END $$
DELIMITER ;

CALL spQtdGamesPlataforma(2);

/*---------------------------------------------------------------
  Implemente uma stored procedure que calcule a idade de algo 
  a partir da sua data de nascimento/lançamento/fabricação
----------------------------------------------------------------*/
DELIMITER $$
CREATE PROCEDURE spCalculaIdade(
	IN DataIni TIMESTAMP
)
BEGIN		
	SELECT TIMESTAMPDIFF(YEAR, DataIni, CURDATE()) AS Idade;
END $$
DELIMITER ;

CALL spCalculaIdade('1990-05-12');

/*---------------------------------------------------------------
  Implemente uma stored procedure que receba uma determinada 
  data e retorne a mesma formatada em português.
----------------------------------------------------------------*/
DELIMITER $$
CREATE PROCEDURE spFormataData(
	IN DataIni TIMESTAMP
)
BEGIN		
	SELECT DATE_FORMAT(DataIni,'%d/%m/%Y') AS DataFormatada;
END $$
DELIMITER ;

CALL spFormataData('1990-05-12');

/*---------------------------------------------------------------
  Implemente uma stored procedure que receba um determinado 
  valor (monetário) e retorne o mesmo formatado em R$.
----------------------------------------------------------------*/
DELIMITER $$
CREATE PROCEDURE spFormataDinheiro(
	IN Valor DECIMAL(8,2)
)
BEGIN		
	SELECT CONCAT(
		'R$ ',
		FORMAT(Valor, 2, 'de_DE') 
	) AS Valor;
END $$
DELIMITER ;

CALL spFormataDinheiro(1268.87);

/*---------------------------------------------------------------
  Implemente uma stored procedure que exiba todos os games com
  preços normais e preços com 5% de desconto.
----------------------------------------------------------------*/
DELIMITER $$
CREATE PROCEDURE spListaPrecos()
BEGIN	
 SELECT	PP.IdProduto, P.Produto, PT.Plataforma, 
	CONCAT('R$ ', FORMAT(PP.Preco, 2, 'de_DE')) AS 'Preço',
	CONCAT('R$ ', FORMAT(PP.Preco*0.95, 2, 'de_DE')) AS 'Preço c/ desconto'
 FROM	PlataformasProdutos PP
	INNER JOIN Produtos P ON P.IdProduto = PP.IdProduto
	INNER JOIN Plataformas PT ON PT.IdPlataforma = PP.IdPlataforma
 ORDER BY P.Produto, PT.Plataforma;
END $$
DELIMITER ;

CALL spListaPrecos();




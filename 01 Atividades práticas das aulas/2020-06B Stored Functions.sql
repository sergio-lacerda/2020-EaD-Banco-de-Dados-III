/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script das atividades práticas em aula - Stored Functions.
 ----------------------------------------------------------------------*/
use dblojagames;

/*---------------------------------------------------------------
  Implemente uma função que receba como parâmetro uma data e re-
  torne a mesma formatada.
----------------------------------------------------------------*/    
DELIMITER $$ 
CREATE FUNCTION udfFormataData(
	pData TIMESTAMP
)
RETURNS VARCHAR(12)
DETERMINISTIC
BEGIN
	RETURN date_format(pData, '%d/%m/%Y');
END $$ 
DELIMITER ;

SELECT udfFormataData( curdate() ) AS 'Data de hoje';
SELECT udfFormataData( '1980-12-03' ) AS 'Data formatada';

/*---------------------------------------------------------------
  Implemente uma função que receba como parâmetro um valor em 
  dinheiro e retorne o mesmo formatado (R$ 0.000,00)
----------------------------------------------------------------*/   
DELIMITER $$ 
CREATE FUNCTION udfFormataMoeda(
	pValor DECIMAL(15, 2)
)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	RETURN CONCAT( 'R$ ', FORMAT(pValor, 2, 'de_DE') );
END $$ 
DELIMITER ;

SELECT 	P.Produto, PT.Plataforma, 
		PP.Preco AS 'Preço sem formatação', 
        udfFormataMoeda(PP.Preco) AS 'Preço Formatado'
FROM	PlataformasProdutos PP
			INNER JOIN Produtos P ON P.IdProduto = PP.IdProduto
            INNER JOIN Plataformas PT ON PT.IdPlataforma = PP.IdPlataforma
ORDER BY P.Produto, 
		 PT.Plataforma;

/*---------------------------------------------------------------
  Implemente uma função que receba como parâmetro um Id de Plata-
  forma e retorne a quantidade de games compatíveis com a mesma.
----------------------------------------------------------------*/    
DELIMITER $$ 
CREATE FUNCTION udfQtdGamesPlataforma(
	PlatId INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE auxQtd INT DEFAULT 0;
    
	SELECT	COUNT(IdProduto)
    INTO	auxQtd
    FROM	PlataformasProdutos
    WHERE	IdPlataforma = PlatId;

	RETURN auxQtd;
END $$ 
DELIMITER ;

SELECT	Plataforma,
		udfQtdGamesPlataforma(IdPlataforma) AS 'Quantidade de games'
FROM	Plataformas
ORDER BY Plataforma;

/*---------------------------------------------------------------
  Implemente uma função que receba como parâmetros os Ids de 
  Produto e Plataforma, e retorne o preço do respectivo game na
  plataforma.
----------------------------------------------------------------*/    
DELIMITER $$ 
CREATE FUNCTION udfPrecoGamesPlataforma(
	ProdId INT,
    PlatId INT
)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	DECLARE auxPreco DECIMAL(15,2) DEFAULT 0;
    
	SELECT	Preco
    INTO	auxPreco
    FROM	PlataformasProdutos
    WHERE	IdProduto = ProdId AND
			IdPlataforma = PlatId;
            
	RETURN CONCAT( 'R$ ', FORMAT(auxPreco, 2, 'de_DE') );	
END $$ 
DELIMITER ;

SELECT 	udfPrecoGamesPlataforma(1, 3) AS 'Preço';
SELECT 	* FROM PlataformasProdutos WHERE IdProduto = 1 AND IdPlataforma = 3;

/*---------------------------------------------------------------
  Implemente uma variação da função anterior, que retorne um tex-
  to do tipo: [Nome Produto] - [Nome Plataforma] - [Preço]
----------------------------------------------------------------*/    
DELIMITER $$ 
CREATE FUNCTION udfPrecoGamesPlataformaLinha(
	ProdId INT,
    PlatId INT
)
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
	DECLARE auxProd VARCHAR(80) DEFAULT '';
    DECLARE auxPlat VARCHAR(80) DEFAULT '';
    
    SET auxProd = ( SELECT Produto FROM Produtos WHERE IdProduto = ProdId );
    SET auxPlat = ( SELECT Plataforma FROM Plataformas WHERE IdPlataforma = PlatId );

	RETURN CONCAT( auxProd, ' - ', auxPlat, ' - ', udfPrecoGamesPlataforma(ProdId, PlatId) );
END $$ 
DELIMITER ;

SELECT 	IdProduto, 
		IdPlataforma, 
        udfPrecoGamesPlataformaLinha(IdProduto, IdPlataforma) AS ProdInfo
FROM	PlataformasProdutos
ORDER BY ProdInfo;
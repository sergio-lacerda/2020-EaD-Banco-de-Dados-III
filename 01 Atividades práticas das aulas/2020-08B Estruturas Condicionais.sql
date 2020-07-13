/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script das atividades práticas em aula - Estruturas condicionais em 
	Stored Procedures, Functions e Triggers.
 ----------------------------------------------------------------------*/
use dblojagames;

/*---------------------------------------------------------------
  Implemente uma Função que receba como parâmetros os IDs de um
  game e de uma plataforma e retorne se o game é compatível com a
  plataforma.
----------------------------------------------------------------*/ 
DELIMITER $$ 
CREATE FUNCTION udfCompativel(
	ProdId INT,
	PlatId INT
)
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
	DECLARE auxQtd INT DEFAULT 0;
	DECLARE auxFrase VARCHAR(15) DEFAULT '';
	
	SELECT	COUNT(IdProduto)
	INTO	auxQtd
	FROM	PlataformasProdutos
	WHERE	IdProduto = ProdId AND
			IdPlataforma = PlatId;
			
	IF (auxQtd = 0) THEN 
		SET auxFrase = 'Não compatível';
	ELSE
		SET auxFrase = 'Compatível';
	END IF;

	RETURN auxFrase;
END $$ 
DELIMITER ;

SELECT udfCompativel(1, 2);


/*---------------------------------------------------------------
  Implemente uma Função que receba como parâmetro o ID de uma 
  plataforma e retorne o fabricante da mesma.
----------------------------------------------------------------*/ 
DELIMITER $$ 
CREATE FUNCTION udfFabricante(
	PlatId INT
)
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN	
	DECLARE auxFrase VARCHAR(15) DEFAULT '';
			
	CASE PlatId
		WHEN 1 THEN SET auxFrase = 'Microsoft';
		WHEN 2 THEN SET auxFrase = 'Sony';
		WHEN 3 THEN SET auxFrase = 'Sony';
		WHEN 4 THEN SET auxFrase = 'Nintendo';
		ELSE SET auxFrase = 'Desconhecido';
	END CASE;

	RETURN auxFrase;
END $$ 
DELIMITER ;

SELECT	PP.IdProduto, 
		P.Produto, 
		PP.IdPlataforma,
		PT.Plataforma,
		udfFabricante(IdPlataforma) AS 'Fabricante'
FROM	PlataformasProdutos PP
			INNER JOIN Produtos P ON P.IdProduto = PP.IdProduto
			INNER JOIN Plataformas PT ON PT.IdPlataforma = PP.IdPlataforma

/*---------------------------------------------------------------
  Implemente uma Stored Procedure que retorne uma listagem de 
  todos os games cadastrados, ordenados alfabeticamente (nome do
  game) com base em um parâmetro de entrada: "Ordem":
	1 - Ordem crescente
	2 - Ordem decrescente
----------------------------------------------------------------*/ 
DELIMITER $$ 
CREATE PROCEDURE spListaProdOrdem(
	IN Ordem INT
)
BEGIN	
	IF (Ordem = 1) THEN
		SELECT * FROM Produtos ORDER BY Produto ASC;
	ELSEIF (Ordem = 2) THEN
		SELECT * FROM Produtos ORDER BY Produto DESC;
	ELSE
		SELECT 'Valor inválido para o parâmetro ORDEM!' AS 'Erro';	
	END IF;
END $$ 
DELIMITER ;

CALL spListaProdOrdem(1);
CALL spListaProdOrdem(2);
CALL spListaProdOrdem(3);

/*---------------------------------------------------------------
  Implemente uma Stored Procedure que receba os dados de um game
  e cadastre o mesmo (se ainda não for cadastrado) ou atualize os
  dados (se já estiver cadastrado).
----------------------------------------------------------------*/ 
DELIMITER $$ 
CREATE PROCEDURE spRegistraGame(
	IN ProdId INT,
	IN ProdNome VARCHAR(80),
	IN ProdStd VARCHAR(50),
	IN ProdLanc SMALLINT
)
BEGIN	
	DECLARE auxQtd INT DEFAULT 0;
	
	SELECT	COUNT(IdProdudo)
	INTO	auxQtd
	FROM	Produtos
	WHERE	IdProduto = ProdId;
	
	IF (auxQtd != 0) THEN
		CALL spAlteraProduto(ProdId, ProdNome, ProdStd, ProdLanc);
	ELSE
		CALL spCadastraProduto(ProdId, ProdNome, ProdStd, ProdLanc); 
	END IF;
END $$ 
DELIMITER ;

CALL spRegistraGame(18, 'Game Teste', 'Studio Teste', 2000);
CALL spRegistraGame(18, 'Minecraft', 'Mojang', 2011);

/*---------------------------------------------------------------
  Implemente uma Trigger que, quando um novo Produto for cadastra-
  do, inclua esse produto na automaticamente na categoria 6 (aven-
  tura) e na plataforma 2 (PS 4).
----------------------------------------------------------------*/
DELIMITER $$ 
CREATE TRIGGER trCadastraProdBeforeInsert 
BEFORE INSERT
ON Produtos FOR EACH ROW
BEGIN
	DECLARE auxQtd INT DEFAULT 0;
	
	SELECT	COUNT(IdProdudo)
	INTO	auxQtd
	FROM	Produtos
	WHERE	IdProduto = NEW.IdProduto;
	
	IF (auxQtd != 0) THEN
		SELECT CONCAT(
			'Erro: Não é possível inserir o registro! ', 
			'Já existe um game com Id: ', 
			NEW.IdProduto
		) AS 'Erro';
	END IF;	
END $$ 
DELIMITER ;

CALL spCadastraProduto(18, 'Game Teste', 'Studio Teste', 2000);
DELETE FROM Produtos WHERE IdProduto = 18;
CALL spCadastraProduto(18, 'Game Teste', 'Studio Teste', 2000);


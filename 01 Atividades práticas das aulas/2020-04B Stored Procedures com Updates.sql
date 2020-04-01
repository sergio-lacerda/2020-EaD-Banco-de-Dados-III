/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script das atividades práticas em aula - Stored Procedures com Updates.
 ----------------------------------------------------------------------*/
use dblojagames;

/*---------------------------------------------------------------
  Implemente uma stored procedure que receba como parâmetros as 
  informações: IdProduto, Nome do game, studio e ano de lançamento, 
  e cadastre esses dados na tabela de produtos.
----------------------------------------------------------------*/    
DELIMITER $$
CREATE PROCEDURE spCadastraProduto(
	IN IdProd INT,
	IN NomProd VARCHAR(80),
	IN StudioProd VARCHAR(50),
	IN LancProd SMALLINT
)
BEGIN
	INSERT INTO Produtos (IdProduto, Produto, Studio, AnoLancamento)
	VALUES (IdProd, NomProd, StudioProd, LancProd);
END $$
DELIMITER ;

CALL spCadastraProduto(5, 'The Witcher', 'CD Projekt Red???', 2010);  

/*---------------------------------------------------------------
  Implemente uma stored procedure que receba como parâmetros as 
  informações: IdProduto, Nome do game, studio e ano de lançamento, 
  e atualize os dados do registro na tabela de produtos.
----------------------------------------------------------------*/    
DELIMITER $$
CREATE PROCEDURE spAlteraProduto(
	IN IdProd INT,
	IN NomProd VARCHAR(80),
	IN StudioProd VARCHAR(50),
	IN LancProd SMALLINT
)
BEGIN
	UPDATE	produtos
	SET		Produto = NomProd,
			Studio = StudioProd,
			AnoLancamento = LancProd
	WHERE	IdProduto = IdProd;
END $$
DELIMITER ;

CALL spAlteraProduto(5, 'The Witcher 3', 'CD Projekt Red', 2015);

/*---------------------------------------------------------------
  Altere a stored procedure spCadastraProduto para que, após 
  cadastrar um novo produto, ela retorne como parâmetro de saída
  a frase "Procedure spCadastraProdutoFrase executada".
----------------------------------------------------------------*/ 
DELIMITER $$
CREATE PROCEDURE spCadastraProdutoFrase(
	IN IdProd INT,
	IN NomProd VARCHAR(80),
	IN StudioProd VARCHAR(50),
	IN LancProd SMALLINT,
    OUT frase VARCHAR(50)
)
BEGIN
	/*---- Cadastrando o novo produto ----*/
    INSERT INTO Produtos (IdProduto, Produto, Studio, AnoLancamento)
	VALUES (IdProd, NomProd, StudioProd, LancProd);
    
    /*---- Atribuindo a frase ao parâmetro de saída  ----*/
    SET frase = 'Procedure spCadastraProdutoId executada';
END $$
DELIMITER ;

SET @AuxFrase = '';
CALL spCadastraProdutoFrase(6, 'God of War 4', 'SIE Santa Monica Studio', 2018, @AuxFrase);
SELECT @AuxFrase;

/*---------------------------------------------------------------
  Implemente uma stored procedure para cadastrar um jogo em uma
  determinada categoria. Como parâmetro de saída, retorne e quan-
  tidade de games existentes na referida categoria.
----------------------------------------------------------------*/ 
DELIMITER $$
CREATE PROCEDURE spCadastraProdCategoria(
	IN IdProd INT,
    IN IdCateg INT,
    OUT Qtd INT
)
BEGIN
	/*--- Inserindo o game na categoria ---*/
    INSERT INTO CategoriasProdutos (IdProduto, IdCategoria)
    VALUES (IdProd, IdCateg);
    
    /*--- Obter a quantidade de games na categoria ---*/
    SET Qtd = (
			SELECT 	COUNT(IdProduto)
			FROM	CategoriasProdutos
			WHERE	IdCategoria = IdCateg
		);
END $$
DELIMITER ;

SET @Qtd = 0;
CALL spCadastraProdCategoria(6, 4, @Qtd);
SELECT @Qtd;

/*---------------------------------------------------------------
  Implemente uma stored procedure para cadastrar um jogo em uma
  determinada plataforma. Como parâmetro de saída, retorne e quan-
  tidade de games existentes na referida plataforma.
----------------------------------------------------------------*/ 
DELIMITER $$
CREATE PROCEDURE spCadastraProdPlataforma(
	IN IdProd INT,
    IN IdPlat INT,
    IN PrecoProd DECIMAL(8, 2),
    OUT Qtd INT
)
BEGIN
	/*--- Inserindo o game na plataforma ---*/
    INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco)
    VALUES (IdProd, IdPlat, PrecoProd);
    
    /*--- Obter a quantidade de games na plataforma ---*/
    SELECT 	COUNT(IdProduto)
    INTO	Qtd
	FROM	PlataformasProdutos
	WHERE	IdPlataforma = IdPlat;
END $$
DELIMITER ;

SET @Qtd = 0;
CALL spCadastraProdPlataforma(6, 2, 50, @Qtd);
SELECT @Qtd;

/*---------------------------------------------------------------
  Implemente uma stored procedure trocar um game de categoria.
----------------------------------------------------------------*/ 
DELIMITER $$
CREATE PROCEDURE spTrocaCategoria(
	IN IdProd INT,
    IN IdCatOld INT,
    IN IdCatNew INT
)
BEGIN
	UPDATE 	CategoriasProdutos
    SET		IdCategoria = IdCatNew
    WHERE 	IdProduto = IdProd AND
			IdCategoria = IdCatOld;
END $$
DELIMITER ;

/* cadastrando o game em uma categoria errada */
CALL spCadastraProdCategoria(6, 2, @Qtd);

/* Corrigindo a categoria: de 2 (simulação) para 6 (aventura) */
CALL spTrocaCategoria(6, 2, 6);

/*---------------------------------------------------------------
  Implemente uma stored procedure que, ao mesmo tempo, cadastre 
  um novo game e já o inclua em uma determinada categoria.
----------------------------------------------------------------*/ 
DELIMITER $$
CREATE PROCEDURE spCadGameCategoria(
	IN ProdId INT,
    IN Prod VARCHAR(80),
    IN ProdStd VARCHAR(50),
    IN ProdLanc SMALLINT,
    IN CategId INT
)
BEGIN
	SET @Qtd = 0;
	CALL spCadastraProduto(ProdId, Prod, ProdStd, ProdLanc); 
    CALL spCadastraProdCategoria(ProdId, CategId, @Qtd);	
END $$
DELIMITER ;

CALL spCadGameCategoria(7, 'Death Stranding', 'Sony', 2019, 6); 

/*---------------------------------------------------------------
  Implemente uma variação da procedure spCadastraProduto que trate
  a exceção de uma tentativa de incluir um registro duplicado na
  tabela de produtos
----------------------------------------------------------------*/    
DELIMITER $$
CREATE PROCEDURE spCadastraProdutoException(
	IN IdProd INT,
	IN NomProd VARCHAR(80),
	IN StudioProd VARCHAR(50),
	IN LancProd SMALLINT
)
BEGIN
	/*-- Declarando um manipulador de exception --*/
	DECLARE EXIT HANDLER FOR sqlexception
    BEGIN
		SHOW errors;
    END;
	
    /*-- Fazendo a inserção do novo registro --*/
	INSERT INTO Produtos (IdProduto, Produto, Studio, AnoLancamento)
	VALUES (IdProd, NomProd, StudioProd, LancProd);
END $$
DELIMITER ;

/* Tentando inserir registro duplicado - vai gerar exception */
CALL spCadastraProdutoException(5, 'The Witcher', 'CD Projekt Red???', 2010); 
/* Inserindo registro não duplicado - NÃO vai gerar exception */
CALL spCadastraProdutoException(8, 'Call of Duty: Modern Warfare', 'Activision', 2019); 

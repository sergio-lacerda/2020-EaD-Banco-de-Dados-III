/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script das atividades práticas em aula - Views.
 ----------------------------------------------------------------------*/
use dblojagames;

/*---------------------------------------------------------------
  Implemente uma View contendo as informações das tabelas de Pro-
  dutos e Plataformas.
----------------------------------------------------------------*/ 
CREATE VIEW vwProdutosPlataformas
AS
SELECT	PP.IdProduto, 
		P.Produto, 
		PP.IdPlataforma,
		PT.Plataforma,
		PP.Preco
FROM	PlataformasProdutos PP
			INNER JOIN Produtos P ON P.IdProduto = PP.IdProduto
			INNER JOIN Plataformas PT ON PT.IdPlataforma = PP.IdPlataforma			

/*----------- Testando select simples na View ------------------*/
SELECT 	*
FROM	vwProdutosPlataformas
ORDER BY Plataforma, Produto

/*----------- Testando select com restrições na View -----------*/
SELECT 	*
FROM	vwProdutosPlataformas
WHERE 	IdPlataforma = 2;

/*----------- Testando select com inner join na View -----------*/
SELECT 	PP.*,
		CP.IdCategoria,
		C.Categoria
FROM	vwProdutosPlataformas PP
			INNER JOIN CategoriasProdutos CP ON CP.IdProduto = PP.IdProduto
			INNER JOIN Categorias C ON C.IdCategoria = CP.IdCategoria
					
/*---------------------------------------------------------------
  Implemente uma View que contenha uma listagem única com os dados
  de Plataformas e Categorias.
----------------------------------------------------------------*/ 
CREATE VIEW vwPlataformasCategorias
AS
  (
	SELECT	P.IdPlataforma AS 'ID',
			P.Plataforma AS 'Descrição',
			'Plataforma' AS 'Tipo'
	FROM 	Plataformas
  )
  UNION
  (
	SELECT	C.IdCategoria AS 'ID',
			C.Categoria AS 'Descrição',
			'Categoria' AS 'Tipo'
	FROM 	Categorias
  )
 ORDER BY Tipo, ID;
  
 /*----------- Testando select simples na View ------------------*/
 SELECT *
 FROM	vwPlataformasCategorias;
  
  /*---------------------------------------------------------------
  Implemente uma View contendo as informações da tabela de Produtos
  com Id menor ou igual a 5. Utilize CHECK OPTION para bloquear 
  inserts com Ids acima de 5.
----------------------------------------------------------------*/ 
CREATE VIEW vwProdutosMenorCinco
AS
SELECT	*
FROM	Produtos
WHERE	IdProduto <= 5
WITH CHECK OPTION;

/*----------- Testando restrição de insert na View --------------*/
INSERT INTO 
    vwProdutosMenorCinco (IdProduto, Produto, Studio, AnoLancamento)
VALUES 
	(20, 'Game Teste', 'Studio Teste', 2000);

	



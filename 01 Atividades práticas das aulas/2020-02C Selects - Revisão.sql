/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script das atividades práticas em aula - Revisão de selects.
 ----------------------------------------------------------------------*/

/*----------------------------------------------------------------------
	Obtenha os dados das tabelas Produtos, Categorias e Plataformas   
-----------------------------------------------------------------------*/
SELECT * FROM produtos;
SELECT * FROM categorias;
SELECT * FROM plataformas;

/*----------------------------------------------------------------------
	Obtenha os dados da tabela Produtos ordenados por:
    a) Nome do Produto
    b) Nome do Studio e Nome do Produto
-----------------------------------------------------------------------*/
SELECT * 
FROM produtos
ORDER BY Produto;

SELECT * 
FROM produtos
ORDER BY Studio, Produto;

/*----------------------------------------------------------------------
	Obtenha todos os jogos que contenham 'Of' no nome do produto
-----------------------------------------------------------------------*/
SELECT * 
FROM produtos
WHERE Produto LIKE '%Of%';

/*----------------------------------------------------------------------
	Obtenha todos os jogos por ordem descendente de IdProduto
-----------------------------------------------------------------------*/
SELECT * 
FROM produtos
ORDER BY IdProduto DESC;

/*----------------------------------------------------------------------
	Obtenha todos os jogos lançados em 2019 pela NaughtyDog
-----------------------------------------------------------------------*/
SELECT * 
FROM produtos
WHERE AnoLancamento = 2019 AND 
	  Studio = 'NaughtyDog';

/*----------------------------------------------------------------------
	Obtenha todos os jogos lançados pela NaughtyDog OU pela Sony
-----------------------------------------------------------------------*/
SELECT * 
FROM produtos
WHERE Studio = 'NaughtyDog' OR 
	  Studio = 'Sony';

/*----------------------------------------------------------------------
	Obtenha todos os jogos da categoria 'Tiro'
-----------------------------------------------------------------------*/
SELECT C.IdCategoria, P.IdProduto, P.Produto
FROM CategoriasProdutos C INNER JOIN Produtos P
	ON C.IdProduto = P.IdProduto
WHERE C.IdCategoria = 5;

/*----------------------------------------------------------------------
	Altere a pesquisa anteior para exibir o nome da categoria. Além da 
    categoria 'Tiro', exiba também os jogos da categoria 'Aventura'
-----------------------------------------------------------------------*/
SELECT C.IdCategoria, CT.Categoria, P.IdProduto, P.Produto
FROM CategoriasProdutos C 
	INNER JOIN Produtos P ON C.IdProduto = P.IdProduto
    INNER JOIN Categorias CT ON C.IdCategoria = CT.IdCategoria    
WHERE C.IdCategoria IN (5, 6);

/*----------------------------------------------------------------------
	Obtenha todos os jogos compatíveis com PS4
-----------------------------------------------------------------------*/
SELECT PP.IdPlataforma, P.IdProduto, P.Produto
FROM PlataformasProdutos PP 
	INNER JOIN Produtos P ON PP.IdProduto = P.IdProduto
WHERE PP.IdPlataforma = 2;

/*----------------------------------------------------------------------
	Altere a consulta anterior para exibir o nome da plataforma. Exiba
    todos os jogos compatíves com PS3 e PS4
-----------------------------------------------------------------------*/
SELECT PP.IdPlataforma, PT.Plataforma, P.IdProduto, P.Produto
FROM PlataformasProdutos PP 
	INNER JOIN Produtos P ON PP.IdProduto = P.IdProduto
    INNER JOIN Plataformas PT ON PP.IdPlataforma = PT.IdPlataforma
WHERE PP.IdPlataforma IN (2, 3);

/*----------------------------------------------------------------------
	Obtenha a quantidade de jogos compatíveis com XBox One
-----------------------------------------------------------------------*/
SELECT COUNT(IdProduto) AS Quantidade
FROM PlataformasProdutos
WHERE IdPlataforma = 1;

/*----------------------------------------------------------------------
	Obtenha a média dos preços dos jogos, independente da plataforma
-----------------------------------------------------------------------*/
SELECT AVG(Preco) AS MediaPreco
FROM PlataformasProdutos;

/*----------------------------------------------------------------------
	Obtenha a média dos preços dos jogos POR plataforma
-----------------------------------------------------------------------*/
SELECT P.Plataforma,
	   AVG(Preco) AS MediaPreco
FROM PlataformasProdutos PP
	INNER JOIN Plataformas P ON PP.IdPlataforma = P.IdPlataforma
GROUP BY PP.IdPlataforma;

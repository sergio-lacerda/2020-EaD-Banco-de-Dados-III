/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script para banco de dados dos exemplos práticos em aula.
 ----------------------------------------------------------------------*/

/*-----------------------------------------------------------------------
  Criação do banco de dados (Schemma)
-----------------------------------------------------------------------*/
CREATE SCHEMA dblojagames;
USE dblojagames;

/*-----------------------------------------------------------------------
  Criação das tabelas
-----------------------------------------------------------------------*/

/* Tabela de Categorias dos jogos */
CREATE TABLE Categorias (
	IdCategoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Categoria VARCHAR(50) NOT NULL    
);

/* Tabela de Plataformas dos jogos */
CREATE TABLE Plataformas (
	IdPlataforma INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Plataforma VARCHAR(50) NOT NULL    
);

/* Tabela de Produtos (jogos) */
CREATE TABLE Produtos (
	IdProduto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Produto VARCHAR(80) NOT NULL,
    Studio VARCHAR(50),
    AnoLancamento SMALLINT UNSIGNED
);

/* Tabela de relacionamento CategoriasProdutos */
CREATE TABLE CategoriasProdutos (
	IdProduto INT NOT NULL,
    IdCategoria INT NOT NULL,
    PRIMARY KEY (IdProduto, IdCategoria),
    FOREIGN KEY (IdProduto) REFERENCES Produtos(IdProduto),
    FOREIGN KEY (IdCategoria) REFERENCES Categorias(IdCategoria)
);

/* Tabela de relacionamento PlataformasProdutos */
CREATE TABLE PlataformasProdutos (
	IdProduto INT NOT NULL,
    IdPlataforma INT NOT NULL,
    Preco DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (IdProduto, IdPlataforma),
    FOREIGN KEY (IdProduto) REFERENCES Produtos(IdProduto),
    FOREIGN KEY (IdPlataforma) REFERENCES Plataformas(IdPlataforma)
);

/*-----------------------------------------------------------------------
  Populando tabelas base com dados para simulação
-----------------------------------------------------------------------*/

INSERT INTO Categorias (Categoria) 
VALUES ("RPG");

INSERT INTO Categorias (Categoria) 
VALUES ("Simulação");

INSERT INTO Categorias (Categoria) 
VALUES ("Esportes");

INSERT INTO Categorias (Categoria) 
VALUES ("Luta");

INSERT INTO Categorias (Categoria) 
VALUES ("Tiro");

INSERT INTO Categorias (Categoria) 
VALUES ("Aventura");

INSERT INTO Plataformas (Plataforma) 
VALUES ("Xbox One");

INSERT INTO Plataformas (Plataforma) 
VALUES ("Playstation 4");

INSERT INTO Plataformas (Plataforma) 
VALUES ("Playstation 3");

INSERT INTO Plataformas (Plataforma) 
VALUES ("Nintendo Wii");

INSERT INTO Produtos (Produto, Studio, AnoLancamento) 
VALUES ("Mortal Kombat 11", "Warner Bros", 2019);

INSERT INTO Produtos (Produto, Studio, AnoLancamento) 
VALUES ("FIFA 19", "Eletronics Arts (EA)", 2018);

INSERT INTO Produtos (Produto, Studio, AnoLancamento) 
VALUES ("The Last Of Us", "NaughtyDog", 2013);

INSERT INTO Produtos (Produto, Studio, AnoLancamento) 
VALUES ("Rise Of The Tomb Raider", "Sony", 2015);

INSERT INTO CategoriasProdutos (IdProduto, IdCategoria) VALUES (1, 4);
INSERT INTO CategoriasProdutos (IdProduto, IdCategoria) VALUES (1, 6);
INSERT INTO CategoriasProdutos (IdProduto, IdCategoria) VALUES (2, 3);
INSERT INTO CategoriasProdutos (IdProduto, IdCategoria) VALUES (3, 5);
INSERT INTO CategoriasProdutos (IdProduto, IdCategoria) VALUES (3, 6);
INSERT INTO CategoriasProdutos (IdProduto, IdCategoria) VALUES (4, 5);
INSERT INTO CategoriasProdutos (IdProduto, IdCategoria) VALUES (4, 6);

INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (1, 1, 230);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (1, 2, 250);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (1, 3, 190);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (2, 1, 195);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (2, 2, 210);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (3, 2, 195);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (3, 3, 95);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (4, 1, 200);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (4, 2, 230);
INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco) VALUES (4, 3, 195);


/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script das atividades práticas em aula - Triggers.
 ----------------------------------------------------------------------*/
use dblojagames;

/*-------- Cadastrando mais alguns jogos para teste ------------*/
CALL spCadastraProduto(12, 'FarCry New Dawn', 'Ubisoft', 2019); 
CALL spCadastraProduto(13, 'Days Gone', 'Bend Studio', 2019); 
CALL spCadastraProduto(14, 'Resident Evil 3', 'CAPCOM', 2020);
CALL spCadastraProduto(15, 'Red Dead Redemption 2', 'Rockstar Games', 2018);
CALL spCadastraProduto(16, 'Uncharted 4 A Thief`s End', 'Naughty Dog', 2018);
CALL spCadastraProduto(17, 'Horizon Zero Dawn', 'Guerrilla Games', 2017);

/*---------------------------------------------------------------
  Implemente uma Trigger que armazene a informação do usuário que
  apagar registros na tabela de Produtos.
----------------------------------------------------------------*/ 

/*---------- Criando a tabela de logs --------------------------*/
CREATE TABLE tbDedoDuro(
	IdLog INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    DataLog TIMESTAMP DEFAULT current_timestamp,
    UserLog VARCHAR(30),
    AcaoLog VARCHAR(100)
);

/*---------- Criando a trigger de logs -------------------------*/
DELIMITER $$ 
CREATE TRIGGER trDedoDuroBeforeDelete
BEFORE DELETE
ON Produtos FOR EACH ROW
BEGIN
	/*---- Criando variáveis auxiliares --------*/    
	DECLARE usuario VARCHAR(30) DEFAULT '';
    DECLARE acao VARCHAR(100) DEFAULT '';
        
    /*---- Obtendo o usuário logado no banco ---*/
    SET usuario = user();
    
    /*---- Dedurando a ação do usuário ---------*/
    SET acao = CONCAT(
		'Apagou registro da tabela de Produtos: ID: ', 
        OLD.IdProduto, 
        ' - Produto: ',
        OLD.Produto
	);
    
    /*---- Gravando a ação do usuário ----------*/
    INSERT INTO tbDedoDuro (UserLog, AcaoLog)
    VALUES (usuario, acao);    
END $$ 
DELIMITER ;

/*---------- Testando exclusão de um único game ----------------*/
DELETE FROM Produtos 
WHERE IdProduto = 15;

SELECT * FROM tbDedoduro;

/*---------- Testando exclusão de mais de um game --------------*/
DELETE FROM Produtos 
WHERE IdProduto BETWEEN 12 AND 17;

SELECT * FROM tbDedoduro;

/*---------------------------------------------------------------
  Implemente uma Trigger que, quando um novo Produto for cadastra-
  do, inclua esse produto na automaticamente na categoria 6 (aven-
  tura) e na plataforma 2 (PS 4).
----------------------------------------------------------------*/
DELIMITER $$ 
CREATE TRIGGER trComplementaProdAfterInsert 
AFTER INSERT
ON Produtos FOR EACH ROW
BEGIN
	/*---- Inserindo o game na categoria 6 --------*/  
    INSERT INTO CategoriasProdutos (IdProduto, IdCategoria)
    VALUES (NEW.IdProduto, 6);
    
    /*---- Inserindo o game na plataforma 2 -------*/
	INSERT INTO PlataformasProdutos (IdProduto, IdPlataforma, Preco)
    VALUES (NEW.IdProduto, 2, 0);
END $$ 
DELIMITER ;

/*---------- Incluindo um único game ---------------------------*/
CALL spCadastraProduto(12, 'FarCry New Dawn', 'Ubisoft', 2019); 

/*---------- Verificando Categoria e Plataforma ----------------*/
SELECT * FROM CategoriasProdutos WHERE IdProduto = 12;
SELECT * FROM PlataformasProdutos WHERE IdProduto = 12;

/*---------- Incluindo vários games ----------------------------*/
CALL spCadastraProduto(13, 'Days Gone', 'Bend Studio', 2019); 
CALL spCadastraProduto(14, 'Resident Evil 3', 'CAPCOM', 2020);
CALL spCadastraProduto(15, 'Red Dead Redemption 2', 'Rockstar Games', 2018);
CALL spCadastraProduto(16, 'Uncharted 4 A Thief`s End', 'Naughty Dog', 2018);
CALL spCadastraProduto(17, 'Horizon Zero Dawn', 'Guerrilla Games', 2017);

/*---------- Verificando Categoria e Plataforma ----------------*/
SELECT * FROM CategoriasProdutos WHERE IdProduto BETWEEN 13 AND 17;
SELECT * FROM PlataformasProdutos WHERE IdProduto BETWEEN 13 AND 17;


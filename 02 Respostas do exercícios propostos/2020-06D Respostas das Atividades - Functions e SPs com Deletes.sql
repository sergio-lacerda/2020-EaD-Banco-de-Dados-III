/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Respostas das Atividades - Functions e Stored Procedures com Deletes
 ----------------------------------------------------------------------*/
USE dbcursos;
 
/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  1. Programe uma Stored Procedure para excluir os dados de um determinado 
     aluno do banco de dados. Teste sua procedure excluindo o aluno ID 11.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spApagaAluno(
	IN pAlunoId INT
)
BEGIN
	DELETE FROM tbMatricula WHERE IdAluno = pAlunoId;
	DELETE FROM tbAlunos WHERE IdAluno = pAlunoId;
END $$
DELIMITER ;

CALL spApagaAluno(11);

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  2. Programe uma Function que retorne a quantidade de alunos matriculadas 
     em um determinado curso.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$ 
CREATE FUNCTION udfQtdAlunos(
	pCursoId INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE auxQtd INT DEFAULT 0;
    
    SELECT	COUNT(IdAluno)
    INTO	auxQtd
    FROM	tbMatricula
    WHERE	IdCurso = pCursoId;
    
    RETURN auxQtd;
END $$ 
DELIMITER ;
 
 /*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  3. Programe uma Function que retorne a quantidade de cursos nos quais um 
     determinado aluno está matriculado.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$ 
CREATE FUNCTION udfQtdCursos(
	pAlunoId INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE auxQtd INT DEFAULT 0;
    
	SELECT	COUNT(IdCurso)
	INTO 	auxQtd 
    FROM	tbMatricula
	WHERE	IdAluno = pAlunoId;
    
    RETURN auxQtd;
END $$ 
DELIMITER ;

 /*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  4. Escreva uma pesquisa SQL utilizando a Função desenvolvida na questão 2 
     para mostrar os seguintes dados: 
	Código do curso | Nome do Curso | Qtd. Matriculados.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
SELECT	IdCurso AS 'Código do Curso',
		Curso AS 'Nome do Curso',
        udfQtdAlunos(IdCurso) AS 'Qtd. Matriculados'
FROM	tbCursos;
 
 /*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  5. Escreva uma pesquisa SQL utilizando a Função desenvolvida na questão 3 
     para mostrar os seguintes dados: RM | Nome do Aluno | Qtd. Cursos.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
SELECT	RM,
		Aluno AS 'Nome do Aluno',
        udfQtdCursos(IdAluno) AS 'Qtd. Cursos'
FROM	tbAlunos;

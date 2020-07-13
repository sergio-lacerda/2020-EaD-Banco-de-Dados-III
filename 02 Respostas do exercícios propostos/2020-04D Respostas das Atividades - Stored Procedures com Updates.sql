/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Respostas das Atividades - Stored Procedures com Inserts e Updates
 ----------------------------------------------------------------------*/
USE dbcursos;
 
/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  1. Programe uma Stored Procedure para cadastrar novos alunos no banco de 
     dados. Utilize essa procedure para cadastrar 5 (cinco) novos alunos.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spCadastraAluno(
	IN aId INT,
    IN aNome VARCHAR(80),
    IN aRM VARCHAR(10),
    IN aNasc TIMESTAMP
)
BEGIN
	INSERT INTO tbAlunos (IdAluno, Aluno, RM, DataNascimento)
    VALUES (aId, aNome, aRM, aNasc);
END $$
DELIMITER ;

CALL spCadastraAluno(12, 'Dolores Noronha', '12012', '1993-11-15');
CALL spCadastraAluno(13, 'Jacinto Nogueira', '12013', '1990-10-06');
CALL spCadastraAluno(14, 'Eleutério Arruda', '12014', '1992-08-01');
CALL spCadastraAluno(15, 'Francisneide Lorena', '12015', '1985-07-29');
CALL spCadastraAluno(16, 'Juvenal Torres', '12016', '1993-05-12');

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  2. Programe uma Stored Procedure que matricule um aluno em um curso. 
     Utilize essa procedure para matricular 3 (três) dos alunos cadastra-
	 dos na questão anterior em cursos quaisquer.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */ 
DELIMITER $$
CREATE PROCEDURE spMatricula(
	IN mCurso INT,
    IN mAluno INT,    
    IN mData TIMESTAMP
)
BEGIN
	INSERT INTO tbMatricula (IdCurso, IdAluno, DataMatricula)
    VALUES (mCurso, mAluno, mData);
END $$
DELIMITER ; 

CALL spMatricula(3, 12, '2020-03-26');
CALL spMatricula(3, 13, '2020-03-20');
CALL spMatricula(3, 14, '2020-03-12');

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  3. Programe uma StoredProcedure que atualize os dados cadastrais de um 
     determinado aluno. Utilize essa procedure para alterar os dados de 2 
	 (dois) alunos cadastrados na questão 1.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spAlteraAluno(
	IN aId INT,
    IN aNome VARCHAR(80),
    IN aRM VARCHAR(10),
    IN aNasc TIMESTAMP
)
BEGIN
	UPDATE	tbAlunos
    SET		Aluno = aNome, 
			RM = aRM, 
            DataNascimento = aNasc
	WHERE	IdAluno = aId;
END $$
DELIMITER ;

CALL spAlteraAluno(15, 'Francisneide Lorena da Silva', '12015', '1985-07-28');
CALL spAlteraAluno(16, 'Juvenal Torres Lopes', '12016', '1993-05-11');

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  4. Crie uma variação da Stored Procedures desenvolvida na questão 2, de 
     tal modo que, após matricular um aluno em um determinado curso, a 
	 procedure retorne a quantidade de alunos matriculados nesse curso.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spMatriculaQtd(
	IN mCurso INT,
    IN mAluno INT,    
    IN mData TIMESTAMP,
    OUT mQtd INT
)
BEGIN   
    INSERT INTO tbMatricula (IdCurso, IdAluno, DataMatricula)
    VALUES (mCurso, mAluno, mData);
	
	/* Ou simplesmente CALL spMatricula(mCurso, mAluno, mData) - Exercício 2*/
    
	SELECT COUNT(IdAluno)
    INTO	mQtd
    FROM	tbMatricula
    WHERE	IdCurso = mCurso;    
END $$
DELIMITER ; 

SET @qtd = 0;
CALL spMatriculaQtd(10, 12, '2020-03-26', @qtd);
SELECT @qtd;

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  5. Programe uma Stored Procedure para corrigir matrícula incorreta de um 
  aluno (alterar o curso no qual foi matriculado). Utilize essa procedure 
  para alterar uma das matrículas realizadas na questão 2.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spCorrigeMatricula(
	IN mCursoOld INT,
    IN mCursoNew INT,
    IN mAluno INT,    
    IN mData TIMESTAMP
)
BEGIN
	UPDATE 	tbMatricula 
    SET		IdCurso = mCursoNew,
			DataMatricula = mData
	WHERE	IdAluno = mAluno AND
			IdCurso = mCursoOld;
END $$
DELIMITER ;

CALL spCorrigeMatricula(3, 5, 14, '2020-03-11');

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  6. Programe uma Stored Procedure que cadastre um aluno no banco de dados 
     e já faça sua matrícula em um determinado curso. Utilize essa proce-
	 dure para cadastrar um novo aluno e matriculá-lo em um curso qualquer.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spCadastraAlunoMatricula(
	IN aId INT,
    IN aNome VARCHAR(80),
    IN aRM VARCHAR(10),
    IN aNasc TIMESTAMP,
    IN aCurso INT,
    IN aDtMatr TIMESTAMP
)
BEGIN
	CALL spCadastraAluno(aId, aNome, aRM, aNasc);
    CALL spMatricula(aCurso, aId, aDtMatr);
END $$
DELIMITER ;

CALL spCadastraAlunoMatricula(17, 'Ubirajara Santos Neto', '12017', '1980-03-14', 5, '2020-03-26');


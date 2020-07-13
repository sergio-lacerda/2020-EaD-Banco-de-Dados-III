/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Respostas das Atividades - Stored Procedures com Selects
 ----------------------------------------------------------------------*/
USE dbcursos;
 
/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  1. Programe uma Stored Procedure que receba como parâmetro um 
     determinado id de aluno e, com base no mesmo, retorne todas as 
     informações cadastrais do respectivo aluno.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spConsultaAluno(
	IN CodAluno INT
)
BEGIN
	SELECT	*
    FROM	tbAlunos
    WHERE	IdAluno = CodAluno;
END $$
DELIMITER ;

CALL spConsultaAluno(10);

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  2. Programe uma Stored Procedure que receba como parâmetro um determina-
     do id de curso e, com base no mesmo, retorne todas as informações 
     cadastrais do respectivo curso.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spConsultaCurso(
	IN CodCurso INT
)
BEGIN
	SELECT	*
    FROM	tbCursos
    WHERE	IdCurso = CodCurso;
END $$
DELIMITER ;

CALL spConsultaCurso(5);

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  3. Programe uma Stored Procedure que receba como parâmetro um determi-
     nado id de curso e, com base no mesmo, retorne uma listagem de 
     todos os alunos matriculados no respectivo curso.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spConsultaAlunosMatriculados(
	IN CodCurso INT
)
BEGIN
	SELECT	A.*
    FROM	tbMatricula M
			INNER JOIN tbAlunos A ON A.IdAluno = M.IdAluno
    WHERE	M.IdCurso = CodCurso;
END $$
DELIMITER ;

CALL spConsultaAlunosMatriculados(10);

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  4. Programe uma Stored Procedure com as seguintes características: 
		* Retorne uma listagem de todas as matrículas realizadas em um certo 
          intervalo de datas (utilizar como parâmetros data_inicial e data_final);
		* Exibir as seguintes informações:
			- Data da matrícula;
			- Id e nome do curso;
			- RM e nome do aluno;
		* Ordenar o resultado por data da matrícula, começando pela mais recente até a mais antiga.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$
CREATE PROCEDURE spConsultaMatriculaEntreDatas(
	IN data_inicial TIMESTAMP,
    IN data_final TIMESTAMP
)
BEGIN
	SELECT	M. DataMatricula,
			M.IdCurso,
            C.Curso,
			A.RM,
            A.Aluno
    FROM	tbMatricula M
			INNER JOIN tbCursos C ON C.IdCurso = M.IdCurso
            INNER JOIN tbAlunos A ON A.IdAluno = M.IdAluno
    WHERE	M.DataMatricula BETWEEN data_inicial AND data_final
    ORDER BY M.DataMatricula DESC;
END $$
DELIMITER ;

CALL spConsultaMatriculaEntreDatas('2019-03-01', '2019-03-31');

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  5. Programe uma Stored Procedure que receba como parâmetro um determinado 
     id de curso e, com base no mesmo, retorne o percentual de alunos matri-
     culados no respectivo curso: 
		* Considere, para efeitos de cálculo: 
			percentual = [quantidade de alunos matriculado no curso] / [quantidade total de matrículas]);
		* Formate o resultado obtido para que seja exibido em formato de porcentagem (X,XX%)
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
DELIMITER $$  
CREATE PROCEDURE spPercentualAlunosMatriculados(
	IN CodCurso INT
)
BEGIN
	/*-- Declarando variáveis para o cálculo --*/
    DECLARE TotalMatriculas INT DEFAULT 0;
    DECLARE TotalCurso INT DEFAULT 0;
    DECLARE Percentual DECIMAL(10,2) DEFAULT 0;
    
    /*-- Obtendo o total de matrículas      --*/
    SET TotalMatriculas = (
				SELECT 	COUNT(IdAluno)
                FROM	tbMatricula                
			);
	
    /*-- Obtendo o total de matrículas no curso --*/
    SET TotalCurso = (
				SELECT 	COUNT(IdAluno)
                FROM	tbMatricula   
                WHERE	IdCurso = CodCurso
			);
    
    /*-- Calculando o percentual            --*/
    SET Percentual = (TotalCurso / TotalMatriculas)*100;
    
    /*-- Retornando o percentual de matrículas --*/
    SELECT CONCAT(
				'Percentual de matrículas no curso: ',
                FORMAT(Percentual, 2, 'de_DE'),
                '%'
		   ) AS Resultado;
END $$
DELIMITER ;

CALL spPercentualAlunosMatriculados(2);
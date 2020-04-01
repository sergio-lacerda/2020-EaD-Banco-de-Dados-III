/*-----------------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Respostas das Atividades - Revisão dos conteúdos presenciais
 ----------------------------------------------------------------------*/
USE dbcursos;
 
/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  1. Escreva uma pesquisa em SQL que retorne todos os cursos cadastrados, 
	 ordenados de forma descendente por carga horária.   
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
SELECT	*
FROM	tbCursos
ORDER BY CargaHoraria DESC;

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  2. Escreva uma pesquisa em SQL que retorne os RMs e Nomes dos alunos 
	 matriculados no curso “Informática - Banco de Dados Oracle”.   
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */ 
SELECT	A.RM, A.Aluno
FROM	tbMatricula M
		INNER JOIN tbAlunos A ON A.IdAluno = M.IdAluno
WHERE	M.IdCurso = 2;

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  3. Escreva uma pesquisa em SQL com as seguintes características:
		* Retornar as seguintes informações: 
			- IdCurso (renomear como ‘Código do curso’);
			- Curso;
			- RM;
			- Aluno;
		* Ordenar os resultados por:
			- Nome do curso – Ordem alfabética descendente (de Z a A);
			- Nome do aluno – Ordem alfabética ascendente (de A a Z).   
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
SELECT	C.IdCurso AS 'Código do Curso', 
		C.Curso, 
        A.RM, 
        A.Aluno
FROM	tbMatricula M
			INNER JOIN tbAlunos A ON A.IdAluno = M.IdAluno
            INNER JOIN tbCursos C ON C.IdCurso = M.IdCurso
ORDER BY C.Curso DESC,
		 A.Aluno ASC;
         
/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  4. Escreva uma pesquisa em SQL que retorne o nome e a idade (em anos) 
     de todos os alunos cadastrados.   
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */ 
SELECT	Aluno,
		TIMESTAMPDIFF(YEAR, DataNascimento, CURDATE()) AS Idade
FROM	tbAlunos
ORDER BY Aluno;

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  5. Escreva uma pesquisa em SQL que retorne uma listagem de todos os 
     cursos e a quantidade de alunos matriculados em cada um deles.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
SELECT	C.Curso,
		COUNT(M.IdAluno) AS 'Qtd. Alunos'
FROM	tbMatricula M			
            INNER JOIN tbCursos C ON C.IdCurso = M.IdCurso
GROUP BY C.Curso;

/*  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
  6. Escreva o comando necessário para criar um índice para o campo 
     “Aluno” da tabela “tbAlunos”.
 -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   - */
CREATE INDEX IX_Aluno
ON tbAlunos (Aluno);








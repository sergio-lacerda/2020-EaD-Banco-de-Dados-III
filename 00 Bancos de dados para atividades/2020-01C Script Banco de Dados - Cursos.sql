/*--------------------------------------------------------------
  Curso Técnico em Desenvolvimento de Sistemas
  Banco de Dados III - Prof. Sérgio Lacerda
  Script para banco de dados das listas de exercícios
 -------------------------------------------------------------*/

/*--------------------------------------------------------------
  Criando o banco de dados.
 -------------------------------------------------------------*/
CREATE SCHEMA dbCursos;
USE dbCursos;

/*--------------------------------------------------------------
  Criando a tabela de Alunos
 -------------------------------------------------------------*/
CREATE TABLE tbAlunos(
	IdAluno INT NOT NULL PRIMARY KEY,
	Aluno VARCHAR(80) NOT NULL,
	RM VARCHAR(10) NOT NULL,
	DataNascimento TIMESTAMP NOT NULL
);

/*--------------------------------------------------------------
  Criando a tabela de Cursos
 -------------------------------------------------------------*/
CREATE TABLE tbCursos(
	IdCurso INT NOT NULL PRIMARY KEY,
	Sigla  VARCHAR(10) NOT NULL,
	Curso VARCHAR(80) NOT NULL,
	CargaHoraria SMALLINT UNSIGNED NOT NULL
);

/*--------------------------------------------------------------
  Criando a tabela de Matrícula de Alunos em Cursos
 -------------------------------------------------------------*/
CREATE TABLE tbMatricula(
	IdCurso INT NOT NULL,
	IdAluno INT NOT NULL,
	DataMatricula TIMESTAMP NOT NULL,
	PRIMARY KEY (IdCurso, IdAluno),
    FOREIGN KEY (IdCurso) REFERENCES tbCursos(IdCurso),
    FOREIGN KEY (IdAluno) REFERENCES tbAlunos(IdAluno)
);

/*--------------------------------------------------------------
  Inserindo registros de exemplo na tabela de Alunos
 -------------------------------------------------------------*/
INSERT INTO tbAlunos VALUES (1, 'Joana da Silva', '12001', '2010-05-15');
INSERT INTO tbAlunos VALUES (2, 'Pedro Paulo de Souza', '12002', '2012-03-01');
INSERT INTO tbAlunos VALUES (3, 'João Rabino', '12003', '2011-06-10');
INSERT INTO tbAlunos VALUES (4, 'Lucas Fernandes Costa', '12004', '2012-02-05');
INSERT INTO tbAlunos VALUES (5, 'Cintia Machado', '12005', '2011-06-02');
INSERT INTO tbAlunos VALUES (6, 'Milena Costa e Silva', '12006', '2010-12-17');
INSERT INTO tbAlunos VALUES (7, 'Carlos Eduardo Meireles', '12007', '2009-07-10');
INSERT INTO tbAlunos VALUES (8, 'Luciana Navarra Obregon', '12008', '2011-01-03');
INSERT INTO tbAlunos VALUES (9, 'José Luiz Castanho', '12009', '2005-07-01');
INSERT INTO tbAlunos VALUES (10, 'Carla Helena das Dores', '12010', '2010-06-15');
INSERT INTO tbAlunos VALUES (11, 'Letícia Lesner', '12011', '2010-03-03');

/*--------------------------------------------------------------
  Inserindo registros de exemplo na tabela de Cursos
 -------------------------------------------------------------*/
INSERT INTO tbCursos VALUES (1, 'INF-001', 'Informática - Manutenção de computadores', 80 );
INSERT INTO tbCursos VALUES (2, 'INF-002', 'Informática - Banco de Dados Oracle', 120);
INSERT INTO tbCursos VALUES (3, 'INF-003', 'Informática - Análise de sistemas com UML', 80);
INSERT INTO tbCursos VALUES (4, 'CONT-001', 'Contabilidade - Contabilidade Básica', 65);
INSERT INTO tbCursos VALUES (5, 'CONT-002', 'Contabilidade - Contabilidade Intermediária', 70);
INSERT INTO tbCursos VALUES (6, 'CONT-003', 'Contabilidade - Contabilidade Avançada', 80);
INSERT INTO tbCursos VALUES (7, 'SAU-001', 'Saúde - Saúde e bem estar', 25);
INSERT INTO tbCursos VALUES (8, 'SAU-002', 'Saúde - Programas de saúde na família', 45);
INSERT INTO tbCursos VALUES (9, 'FIS-001', 'Física - Física Quântica', 60);
INSERT INTO tbCursos VALUES (10, 'AST-001', 'Astronomia - Introdução à evolução estelar', 65);

/*--------------------------------------------------------------
  Inserindo registros de exemplo na tabela de Matrículas
 -------------------------------------------------------------*/
INSERT INTO tbMatricula VALUES (1, 1, '2019-02-01');
INSERT INTO tbMatricula VALUES (1, 2, '2019-02-01');
INSERT INTO tbMatricula VALUES (1, 7, '2019-02-03');
INSERT INTO tbMatricula VALUES (1, 9, '2019-03-01');

INSERT INTO tbMatricula VALUES (2, 2, '2019-04-15');
INSERT INTO tbMatricula VALUES (2, 3, '2019-04-10');
INSERT INTO tbMatricula VALUES (2, 4, '2019-04-07');
INSERT INTO tbMatricula VALUES (2, 7, '2019-04-21');
INSERT INTO tbMatricula VALUES (2, 10, '2019-04-11');

INSERT INTO tbMatricula VALUES (4, 10, '2019-04-15');
INSERT INTO tbMatricula VALUES (4, 11, '2019-04-15');

INSERT INTO tbMatricula VALUES (6, 5, '2019-03-30');
INSERT INTO tbMatricula VALUES (6, 6, '2019-04-08');
INSERT INTO tbMatricula VALUES (6, 7, '2019-04-12');
INSERT INTO tbMatricula VALUES (6, 8, '2019-04-03');

INSERT INTO tbMatricula VALUES (10, 3, '2019-03-28');
INSERT INTO tbMatricula VALUES (10, 5, '2019-04-10');
INSERT INTO tbMatricula VALUES (10, 11, '2019-04-11');















use analise_campanhas;

CREATE TABLE campanhas (
id_campanha INT AUTO_INCREMENT PRIMARY KEY,
nome_campanha VARCHAR (50) NOT NULL,
ferramenta VARCHAR (50),
inicio_campanha DATE,
fim_campanha DATE,
orcamento_campanha DECIMAL (6,2),
objetivo_campanha VARCHAR (50)
);

CREATE TABLE Leads (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR (100) NOT NULL,
email VARCHAR (100),
telefone VARCHAR (15),
Cidade VARCHAR (50),
idade INT,
cadastrado_em DATE
);

CREATE TABLE Interacoes (
id_interacao INT AUTO_INCREMENT PRIMARY KEY,
id_campanha INT NOT NULL,
id_cliente INT NOT NULL,
tipo VARCHAR (50),
interacao_em DATE,
FOREIGN KEY (id_campanha) REFERENCES campanhas (id_campanha),
FOREIGN KEY (id_cliente) REFERENCES Leads (id_cliente)
);

CREATE TABLE conversoes (
id_conversao INT AUTO_INCREMENT PRIMARY KEY,
id_interacao INT NOT NULL,
receita DECIMAL (10,2),
tipo VARCHAR (50),
data_conversao DATE,
FOREIGN KEY (id_interacao) REFERENCES Interacoes (id_interacao));

INSERT INTO campanhas (nome_campanha, ferramenta, inicio_campanha, fim_campanha, orcamento_campanha, objetivo_campanha) 
VALUES ('Lançamento Jd Nova Europa', 'Meta Ads', '2026-03-15', '2026-03-30', 250.00, 'vendas'),
       ('Institucional', 'Meta Ads', '2026-04-01', '2026-04-15', 200.00, 'engajamento com a empresa'),
	   ('Feirão Loteamento Jardim Riverside', 'Meta Ads', '2026-04-16', '2026-04-30', 300.00, 'vendas');
       
       
       INSERT INTO Leads (nome, email, telefone, Cidade, idade, cadastrado_em)
VALUES ('Jose Roberto', 'joserober.16@gmail.com', '(14) 97777-8888', 'Jau', 33, '2026-04-15'),
       ('Ana Vitoria', 'vitoria.ana15@hotmail.com', '(16) 99777-5555', 'Araraquara', 29, '2026-03-20'),
	   ('Julio Cesar', 'itsjulio_c@gmail.com', '(14) 99777-4447', 'Ibitinga', 37, '2026-04-20'),
	   ('Lucas Verissimo', 'lucas_verissimo25@gmail.com', '(15) 99877-4447', 'Sorocaba', 43, '2026-03-25'),
	   ('Carlos Italo', 'italo_c18@yahoo.com.br', '(14) 99999-2888', 'Bauru', 28, '2026-04-18'),
       ('Anthony', 'antony_mateus177@gmail.com', '(14) 99977-5577', 'Sao Carlos', 37, '2026-03-18');
       
       INSERT INTO Interacoes (id_campanha, id_cliente, tipo, interacao_em)
VALUES (1, 2, 'formulario', '2026-03-20'),
       (1, 4, 'formulario', '2026-03-25'),
	   (2, 1, 'clique', '2026-04-15'),
	   (3, 5 , 'formulario', '2026-04-18'),
	   (3, 3, 'formulario', '2026-04-20'),
       (1, 6, 'formulario', '2026-03-18');
       
       INSERT INTO conversoes (id_interacao, receita, tipo, data_conversao)
VALUES (4, 2500, 'Contrato Assinado', '2026-04-28'),
       (2, 0.00, 'Contato via Whatsapp', '2026-03-25'),
	   (1, 10000.00, 'Entrada Financiamento','2026-03-28'),
       (6, 7000, 'Contrato Assinado e entrada', '2026-03-26');
       
/* ANÁLISE DAS CAMPANHAS */

/* Primeiro vamos análisar quais tipos de campanhas estão ativas, o investimento total delas e o orçamento médio para cada tipo de campanha */
  
  SELECT
  objetivo_campanha,
  COUNT(*) AS quantidade_campanhas,
  SUM(orcamento_campanha) AS investimento_total,
  AVG(orcamento_campanha) AS orcamento_medio
  FROM campanhas
  GROUP BY objetivo_campanha
  ORDER BY investimento_total DESC;
  
 /* Agora, o propósito da próxima análise é descobrir o perfil demográfico dos Leads. Essa análise é importante para segmentar as próximas campanhas.
 Ela vai nos gerar a média de idade dos Leads, indicar qual menor e maior idade e indicar de quantas cidades esses Leads são*/
 
 SELECT
 COUNT(*) AS total_leads,
 ROUND(AVG(idade), 1) AS idade_media,
 MIN(idade) AS mais_novo,
 MAX(idade) AS mais_velho,
 COUNT(DISTINCT Cidade) AS cidades_distintas
 FROM Leads;
 
 /* Na próxima análise, vamos analisar quando as pessoas interagiram com a campanha a partir do seu início.
 Através desta análise, é possível verificar o tempo médio de interação de cada campanha*/
 
 SELECT 
 c.nome_campanha,
 ROUND(AVG(DATEDIFF(i.interacao_em, c.inicio_campanha)), 1) AS
 dias_ate_interacao
 FROM interacoes i
 JOIN campanhas c ON i.id_campanha = c.id_campanha
 GROUP BY c.nome_campanha
 ORDER BY dias_ate_interacao;
 
 /* E por último faremos uma análise do tipo de interação mais comum por campanha */
 
 SELECT
 c.nome_campanha,
 i.tipo,
 count(*) AS quantidade
 FROM campanhas c
 JOIN Interacoes i ON c.id_campanha = i.id_campanha
 GROUP BY c.nome_campanha, i.tipo
 ORDER BY quantidade DESC;
 
 

       
       


INSERT INTO funcao (nome_funcao) VALUES ('Chef'), ('Estoquista'), ('Gerente')
ON DUPLICATE KEY UPDATE nome_funcao=VALUES(nome_funcao);

INSERT INTO usuario (funcao_id, nome, login, senha_hash) VALUES
(1,'Carlos Chef','chef01','hash'),
(2,'Marina Estoquista','estoq01','hash'),
(3,'João Gerente','ger01','hash')
ON DUPLICATE KEY UPDATE nome=VALUES(nome);

INSERT INTO fornecedor (nome, contato) VALUES
('HortiFácil','(65) 9 9999-0001'),
('Laticínios Cuiabá','(65) 9 9999-0002')
ON DUPLICATE KEY UPDATE contato=VALUES(contato);

INSERT INTO ingrediente (nome, categoria, unidade_medida, quantidade_atual, quantidade_minima)
VALUES
('Tomate','Hortifruti','kg', 5.000, 2.000),
('Queijo Mussarela','Laticínios','kg', 3.000, 1.000),
('Farinha de Trigo','Secos','kg', 10.000, 5.000)
ON DUPLICATE KEY UPDATE categoria=VALUES(categoria);

INSERT INTO prato (nome, preco) VALUES
('Pizza Margherita', 39.90),
('Bruschetta', 19.90)
ON DUPLICATE KEY UPDATE preco=VALUES(preco);

INSERT INTO ingredientes_utilizados (prato_id, ingrediente_id, quantidade_por_porcao) VALUES
(1, 1, 0.200),
(1, 2, 0.150),
(1, 3, 0.100),
(2, 1, 0.080),
(2, 3, 0.050)
ON DUPLICATE KEY UPDATE quantidade_por_porcao=VALUES(quantidade_por_porcao);

-- Vendas de um dia específico
SELECT *
FROM venda
WHERE data_hora >= '2025-10-14 00:00:00'
  AND data_hora <  '2025-10-15 00:00:00'
ORDER BY data_hora DESC;

-- Entradas de ingredientes em um dia
SELECT *
FROM entrada_ingrediente
WHERE DATE(data_entrada) = '2025-10-14'
ORDER BY data_entrada DESC;

-- Faturamento por dia
SELECT DATE(v.data_hora) AS dia,
       COUNT(*) AS qtd_vendas,
       SUM(v.total) AS faturamento
FROM venda v
WHERE v.data_hora >= '2025-10-01'
  AND v.data_hora <  '2025-11-01'
GROUP BY DATE(v.data_hora)
ORDER BY dia;

-- Estoque abaixo do mínimo
SELECT i.*,
       CASE WHEN i.quantidade_atual < i.quantidade_minima THEN 'BAIXO ESTOQUE' ELSE 'OK' END AS status
FROM ingrediente i
ORDER BY status DESC, nome;

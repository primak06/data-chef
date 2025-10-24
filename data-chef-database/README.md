# DataChef – Banco de Dados (MySQL)

Sistema exemplo de **gestão de estoque e vendas para restaurante**.

ALUNOS: Enzo Natali, Bruno Primak, Marcos Ribeiro, Jose Henrique

## Estrutura
- `schema.sql` – criação do banco `data_chef` (tabelas, PKs/FKs).
- `sample_data.sql` – dados mínimos para testes.
- `queries.sql` – consultas úteis (filtros e relatórios).
- `erd.png` – diagrama entidade-relacionamento.
- `LICENSE` – MIT.
- `.gitignore` – itens comuns a projetos SQL.

## Como usar (DBeaver / MySQL Workbench)
1. Execute (isolados):
   ```sql
   CREATE DATABASE IF NOT EXISTS data_chef;
   USE data_chef;
   SET FOREIGN_KEY_CHECKS = 0;
   ```
2. Rode `schema.sql` por completo.
3. (Opcional) Rode `sample_data.sql`.
4. Reative FKs:
   ```sql
   SET FOREIGN_KEY_CHECKS = 1;
   ```
5. Use `queries.sql` para consultas.

Compatível com **MySQL 5.6 / 5.7 / 8.0**.

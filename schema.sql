-- Criação das tabelas principais (MySQL 5.6/5.7/8.0)

CREATE TABLE IF NOT EXISTS funcao (
  funcao_id INT AUTO_INCREMENT PRIMARY KEY,
  nome_funcao VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS usuario (
  usuario_id INT AUTO_INCREMENT PRIMARY KEY,
  funcao_id INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  login VARCHAR(50) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) NOT NULL,
  ativo TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_usuario_funcao
    FOREIGN KEY (funcao_id) REFERENCES funcao(funcao_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fornecedor (
  fornecedor_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  contato VARCHAR(120),
  UNIQUE KEY uq_fornecedor_nome (nome)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ingrediente (
  ingrediente_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  categoria VARCHAR(60),
  unidade_medida VARCHAR(20) NOT NULL,
  quantidade_atual DECIMAL(12,3) NOT NULL DEFAULT 0,
  quantidade_minima DECIMAL(12,3) NOT NULL DEFAULT 0,
  data_validade_padrao DATE NULL,
  UNIQUE KEY uq_ingrediente_nome (nome)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS entrada_ingrediente (
  entrada_id INT AUTO_INCREMENT PRIMARY KEY,
  ingrediente_id INT NOT NULL,
  fornecedor_id INT,
  data_entrada DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  quantidade_recebida DECIMAL(12,3) NOT NULL,
  preco_unitario DECIMAL(12,4) NOT NULL,
  validade_lote DATE NULL,
  criado_por INT NULL,
  CONSTRAINT fk_ent_ingrediente
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(ingrediente_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_ent_fornecedor
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(fornecedor_id)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_ent_usuario
    FOREIGN KEY (criado_por) REFERENCES usuario(usuario_id)
    ON UPDATE CASCADE ON DELETE SET NULL,
  KEY ix_ent_data (data_entrada)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS prato (
  prato_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,
  preco DECIMAL(12,2) NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ingredientes_utilizados (
  prato_id INT NOT NULL,
  ingrediente_id INT NOT NULL,
  quantidade_por_porcao DECIMAL(12,3) NOT NULL,
  PRIMARY KEY (prato_id, ingrediente_id),
  CONSTRAINT fk_bom_prato
    FOREIGN KEY (prato_id) REFERENCES prato(prato_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_bom_ingrediente
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(ingrediente_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS venda (
  venda_id INT AUTO_INCREMENT PRIMARY KEY,
  data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  cliente VARCHAR(120),
  criado_por INT NULL,
  total DECIMAL(12,2) NOT NULL DEFAULT 0,
  CONSTRAINT fk_venda_usuario
    FOREIGN KEY (criado_por) REFERENCES usuario(usuario_id)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS item_venda (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  venda_id INT NOT NULL,
  prato_id INT NOT NULL,
  quantidade INT NOT NULL,
  valor_unit DECIMAL(12,2) NOT NULL,
  CONSTRAINT fk_item_venda
    FOREIGN KEY (venda_id) REFERENCES venda(venda_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_item_prato
    FOREIGN KEY (prato_id) REFERENCES prato(prato_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS consumo (
  consumo_id INT AUTO_INCREMENT PRIMARY KEY,
  ingrediente_id INT NOT NULL,
  data_consumo DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  quantidade_consumida DECIMAL(12,3) NOT NULL,
  origem ENUM('AJUSTE','DESCARTE','PRODUCAO') NOT NULL DEFAULT 'PRODUCAO',
  observacao VARCHAR(255),
  CONSTRAINT fk_consumo_ingrediente
    FOREIGN KEY (ingrediente_id) REFERENCES ingrediente(ingrediente_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS notificacao (
  notificacao_id INT AUTO_INCREMENT PRIMARY KEY,
  tipo VARCHAR(50) NOT NULL,
  mensagem VARCHAR(255) NOT NULL,
  data_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lida TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB;

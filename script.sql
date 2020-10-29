CREATE DATABASE IF NOT EXISTS leilaocombustivel;
USE leilaocombustivel;

-- DROP TABLE IF EXISTS perfil;
CREATE TABLE perfil (
  id int NOT NULL AUTO_INCREMENT,
  nome varchar(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY nome_UN (nome)
);

INSERT INTO perfil (nome) VALUES ('ADMINISTRADOR'), ('COMUM');

-- DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
  id int NOT NULL AUTO_INCREMENT,
  login varchar(100) NOT NULL,
  nome varchar(100) NOT NULL,
  idperfil int NOT NULL,
  senha varchar(100) NOT NULL,
  token char(32) DEFAULT NULL,
  criacao datetime NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY login_UN (login),
  KEY idperfil_FK_idx (idperfil),
  CONSTRAINT idperfil_FK FOREIGN KEY (idperfil) REFERENCES perfil (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

INSERT INTO usuario (login, nome, idperfil, senha, token, criacao) VALUES ('ADMIN', 'ADMINISTRADOR', 1, 'peTcC99vkvvLqGQL7mdhGuJZIvL2iMEqvCNvZw3475PJ:JVyo1Pg2HyDyw9aSOd3gNPT30KdEyiUYCjs7RUzSoYGN', NULL, NOW());


CREATE TABLE IF NOT EXISTS pedido (
  id_pedido INT NOT NULL AUTO_INCREMENT,
  id_anu INT NOT NULL,
  data_pedido DATE NOT NULL,
  valortotal_pedido DOUBLE NOT NULL,
  id_posto INT NOT NULL,
  PRIMARY KEY (`id_pedido`))



-- -----------------------------------------------------
-- Table `mydb`.`posto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS posto (
  id_posto INT NOT NULL,
  nome_posto VARCHAR(50) NOT NULL,
  cep_posto VARCHAR(45) NOT NULL,
  tel_posto VARCHAR(45) NOT NULL,
  end_posto VARCHAR(45) NOT NULL,
  cidade_posto VARCHAR(45) NOT NULL,
  num_pedidos INT NOT NULL,
  num_compras INT NOT NULL,
  id_cad VARCHAR(45) NOT NULL,
  pedido_id_pedido INT NOT NULL,
  PRIMARY KEY (id_posto),
  INDEX fk_posto_pedido1_idx (pedido_id_pedido ASC) VISIBLE,
  CONSTRAINT fk_posto_pedido1
    FOREIGN KEY (pedido_id_pedido)
    REFERENCES pedido (id_pedido)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table `mydb`.`combustivel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS combustivel (
  id_comb INT NOT NULL,
  tipo_comb INT NOT NULL,
  desc_comb VARCHAR(45) NOT NULL,
  origem_comb VARCHAR(45) NULL,
  PRIMARY KEY (`id_comb`))



-- -----------------------------------------------------
-- Table `mydb`.`anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS anuncio (
  id_anu INT NOT NULL,
  prazo_anu VARCHAR(45) NOT NULL,
  transporte_anu VARCHAR(45) NOT NULL,
  qtd_anu DOUBLE NOT NULL,
  id_dist VARCHAR(45) NOT NULL,
  data_anu DATE NULL,
  valor_anu DOUBLE NOT NULL,
  id_transp INT NOT NULL,
  id_comb INT NOT NULL,
  pedido_id_pedido INT NOT NULL,
  combustivel_id_comb INT NOT NULL,
  PRIMARY KEY (`id_anu`),
  INDEX fk_anuncio_pedido1_idx (`pedido_id_pedido` ASC) VISIBLE,
  INDEX fk_anuncio_combustivel1_idx (`combustivel_id_comb` ASC) VISIBLE,
  CONSTRAINT fk_anuncio_pedido1
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES pedido (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_anuncio_combustivel1
    FOREIGN KEY (`combustivel_id_comb`)
    REFERENCES combustivel (`id_comb`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table `mydb`.`distribuidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS distribuidor (
  id_dist INT NOT NULL AUTO_INCREMENT,
  anuncios_dist INT NULL,
  vestas_dist INT NULL,
  cnpj_dist VARCHAR(45) NOT NULL,
  id_cad INT NOT NULL,
  id_anu INT NULL,
  end_dist VARCHAR(45) NOT NULL,
  nome_dist VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_dist`),
  INDEX fk_distribuidor_anuncio1_idx (`id_anu` ASC) VISIBLE,
  CONSTRAINT fk_distribuidor_anuncio1
    FOREIGN KEY (`id_anu`)
    REFERENCES anuncio (`id_anu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table `mydb`.`transportadora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS transportadora (
  id_transp INT NOT NULL AUTO_INCREMENT,
  nome_tansp VARCHAR(45) NOT NULL,
  anuncio_id_anu INT NOT NULL,
  PRIMARY KEY (`id_transp`),
  INDEX fk_transportadora_anuncio1_idx (`anuncio_id_anu` ASC) VISIBLE,
  CONSTRAINT fk_transportadora_anuncio1
    FOREIGN KEY (`anuncio_id_anu`)
    REFERENCES anuncio (`id_anu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS usuarioregular (
  id_cad INT NOT NULL,
  email_cad VARCHAR(45) NOT NULL,
  senha_cad VARCHAR(100) NOT NULL,
  cel_cad VARCHAR(45) NOT NULL,
  tipo_cad INT NOT NULL,
  posto_id_posto INT NOT NULL,
  distribuidor_id_dist INT NOT NULL,
  criacao DATE NOT NULL,
  token CHAR(32) NOT NULL,
  PRIMARY KEY (`id_cad`),
  INDEX fk_usuario_posto_idx (`posto_id_posto` ASC) VISIBLE,
  INDEX fk_usuario_distribuidor1_idx (`distribuidor_id_dist` ASC) VISIBLE,
  CONSTRAINT fk_usuario_posto
    FOREIGN KEY (`posto_id_posto`)
    REFERENCES posto (`id_posto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_usuario_distribuidor1
    FOREIGN KEY (`distribuidor_id_dist`)
    REFERENCES distribuidor (`id_dist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table `mydb`.`mediapreco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mediapreco (
  id_mediap INT NOT NULL AUTO_INCREMENT,
  id_comb INT NOT NULL,
  precoa_mediap DOUBLE NOT NULL,
  semanal_mediap DOUBLE NOT NULL,
  mensal_mediap DOUBLE NOT NULL,
  anual_mediap DOUBLE NOT NULL,
  PRIMARY KEY (`id_mediap`))



-- -----------------------------------------------------
-- Table `mydb`.`notaf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notaf (
  id_nota INT NOT NULL,
  id_pedido INT NOT NULL,
  datah_nota DATE NOT NULL,
  numboleto_nota TEXT NOT NULL,
  pedido_id_pedido INT NOT NULL,
  PRIMARY KEY (`id_nota`),
  INDEX `fk_notaf_pedido1_idx` (`pedido_id_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_notaf_pedido1`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES pedido (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



-- -----------------------------------------------------
-- Table `mydb`.`docdistribuidora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS docdistribuidora (
  id_doc INT NOT NULL,
  pathdoc VARCHAR(255) NOT NULL,
  distribuidor_id_dist INT NOT NULL,
  PRIMARY KEY (`id_doc`),
  INDEX `fk_docdistribuidora_distribuidor1_idx` (`distribuidor_id_dist` ASC) VISIBLE,
  CONSTRAINT `fk_docdistribuidora_distribuidor1`
    FOREIGN KEY (`distribuidor_id_dist`)
    REFERENCES distribuidor (`id_dist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)



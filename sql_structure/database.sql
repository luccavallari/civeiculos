/*
Navicat MySQL Data Transfer

Source Server         : LocalMysql
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : appcars

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-08-20 16:02:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for categorias
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_titulo` varchar(40) NOT NULL,
  PRIMARY KEY (`cat_id`,`cat_titulo`),
  KEY `cat_id` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for combustiveis
-- ----------------------------
DROP TABLE IF EXISTS `combustiveis`;
CREATE TABLE `combustiveis` (
  `comb_id` int(11) NOT NULL AUTO_INCREMENT,
  `comb_titulo` varchar(50) NOT NULL,
  `comb_id_categoria` int(11) DEFAULT NULL,
  PRIMARY KEY (`comb_id`),
  KEY `comb_id` (`comb_id`),
  KEY `fkcomb_id_categoria` (`comb_id_categoria`),
  CONSTRAINT `fkcomb_id_categoria` FOREIGN KEY (`comb_id_categoria`) REFERENCES `categorias` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for imagens
-- ----------------------------
DROP TABLE IF EXISTS `imagens`;
CREATE TABLE `imagens` (
  `imag_id` int(11) NOT NULL AUTO_INCREMENT,
  `imag_titulo` varchar(150) NOT NULL,
  `imag_id_veiculo` int(11) DEFAULT NULL,
  PRIMARY KEY (`imag_id`,`imag_titulo`),
  KEY `fkimag_id_veiculo` (`imag_id_veiculo`),
  CONSTRAINT `fkimag_id_veiculo` FOREIGN KEY (`imag_id_veiculo`) REFERENCES `veiculos` (`vei_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for marcas
-- ----------------------------
DROP TABLE IF EXISTS `marcas`;
CREATE TABLE `marcas` (
  `mar_id` int(11) NOT NULL AUTO_INCREMENT,
  `mar_titulo` varchar(40) NOT NULL,
  `mar_id_categoria` int(11) NOT NULL,
  `mar_url` varchar(255) NOT NULL,
  PRIMARY KEY (`mar_id`,`mar_titulo`),
  KEY `fkmar_id_categoria` (`mar_id_categoria`),
  CONSTRAINT `fkmar_id_categoria` FOREIGN KEY (`mar_id_categoria`) REFERENCES `categorias` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for modelos
-- ----------------------------
DROP TABLE IF EXISTS `modelos`;
CREATE TABLE `modelos` (
  `mod_id` int(11) NOT NULL AUTO_INCREMENT,
  `mod_titulo` varchar(100) NOT NULL,
  `mod_id_marca` int(11) NOT NULL,
  PRIMARY KEY (`mod_id`),
  UNIQUE KEY `idxmod_titulo` (`mod_titulo`,`mod_id_marca`),
  KEY `mod_id` (`mod_id`),
  KEY `fkmod_id_marca` (`mod_id_marca`),
  CONSTRAINT `fkmod_id_marca` FOREIGN KEY (`mod_id_marca`) REFERENCES `marcas` (`mar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=550 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for opcionais
-- ----------------------------
DROP TABLE IF EXISTS `opcionais`;
CREATE TABLE `opcionais` (
  `opc_id` int(11) NOT NULL AUTO_INCREMENT,
  `opc_titulo` varchar(50) NOT NULL,
  `opc_id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`opc_id`,`opc_titulo`),
  KEY `opc_id` (`opc_id`),
  KEY `fkopc_id_categoria` (`opc_id_categoria`),
  CONSTRAINT `fkopc_id_categoria` FOREIGN KEY (`opc_id_categoria`) REFERENCES `categorias` (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for opcionais_veiculo
-- ----------------------------
DROP TABLE IF EXISTS `opcionais_veiculo`;
CREATE TABLE `opcionais_veiculo` (
  `opc_vei_id` int(11) NOT NULL AUTO_INCREMENT,
  `opc_vei_id_opcional` int(11) NOT NULL,
  `opc_vei_id_veiculo` int(11) NOT NULL,
  PRIMARY KEY (`opc_vei_id`),
  KEY `fkopc_vei_id_opcional` (`opc_vei_id_opcional`),
  KEY `fkopc_vei_id_veiculo` (`opc_vei_id_veiculo`),
  CONSTRAINT `fkopc_vei_id_opcional` FOREIGN KEY (`opc_vei_id_opcional`) REFERENCES `opcionais` (`opc_id`),
  CONSTRAINT `fkopc_vei_id_veiculo` FOREIGN KEY (`opc_vei_id_veiculo`) REFERENCES `veiculos` (`vei_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for orcamentos
-- ----------------------------
DROP TABLE IF EXISTS `orcamentos`;
CREATE TABLE `orcamentos` (
  `orc_id` int(11) NOT NULL AUTO_INCREMENT,
  `orc_data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orc_data_validade` timestamp NULL DEFAULT NULL,
  `orc_nome_cliente` varchar(100) NOT NULL,
  `orc_telefone` varchar(20) DEFAULT NULL,
  `orc_celular` varchar(20) DEFAULT NULL,
  `orc_email` varchar(255) DEFAULT NULL,
  `orc_veiculo_id` int(11) DEFAULT NULL,
  `orc_veiculo_ano` int(4) DEFAULT NULL,
  `orc_veiculo_categoria` varchar(100) DEFAULT NULL,
  `orc_veiculo_marca` varchar(100) DEFAULT NULL,
  `orc_veiculo_modelo` varchar(150) DEFAULT NULL,
  `orc_veiculo_tipo_venda` varchar(100) DEFAULT NULL,
  `orc_veiculo_combustivel` varchar(100) DEFAULT NULL,
  `orc_veiculo_imagem` longblob,
  `orc_observacoes` text,
  `orc_status` tinyint(1) NOT NULL,
  `orc_proposta` decimal(24,2) NOT NULL,
  PRIMARY KEY (`orc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for permissoes
-- ----------------------------
DROP TABLE IF EXISTS `permissoes`;
CREATE TABLE `permissoes` (
  `perm_id` int(11) NOT NULL AUTO_INCREMENT,
  `perm_id_usuario` int(11) NOT NULL,
  `perm_categorias` tinyblob NOT NULL,
  `perm_combustiveis` tinyblob NOT NULL,
  `perm_imagens` tinyblob NOT NULL,
  `perm_marcas` tinyblob NOT NULL,
  `perm_modelos` tinyblob NOT NULL,
  `perm_opcionais` tinyblob NOT NULL,
  `perm_tipo_venda` tinyblob NOT NULL,
  `perm_usuarios` tinyblob NOT NULL,
  `perm_veiculos` tinyblob NOT NULL,
  `perm_permissoes` tinyblob NOT NULL,
  PRIMARY KEY (`perm_id`,`perm_id_usuario`),
  KEY `fkperm_id_usuario` (`perm_id_usuario`),
  CONSTRAINT `fkperm_id_usuario` FOREIGN KEY (`perm_id_usuario`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for tipo_venda
-- ----------------------------
DROP TABLE IF EXISTS `tipo_venda`;
CREATE TABLE `tipo_venda` (
  `tip_ven_id` int(11) NOT NULL AUTO_INCREMENT,
  `tip_ven_titulo` varchar(50) NOT NULL,
  PRIMARY KEY (`tip_ven_id`,`tip_ven_titulo`),
  KEY `tip_ven_id` (`tip_ven_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `usu_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_nome` varchar(100) NOT NULL,
  `usu_email` varchar(150) NOT NULL,
  `usu_senha` varchar(100) NOT NULL,
  `usu_telefone` varchar(20) DEFAULT NULL,
  `usu_celular` varchar(20) DEFAULT NULL,
  `usu_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usu_id`,`usu_email`),
  KEY `usu_id` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for veiculos
-- ----------------------------
DROP TABLE IF EXISTS `veiculos`;
CREATE TABLE `veiculos` (
  `vei_id` int(11) NOT NULL AUTO_INCREMENT,
  `vei_id_categoria` int(11) NOT NULL,
  `vei_id_marca` int(11) NOT NULL,
  `vei_id_modelo` int(11) NOT NULL,
  `vei_id_combustivel` int(11) NOT NULL,
  `vei_id_tipo_venda` int(11) NOT NULL,
  `vei_ano` int(4) NOT NULL,
  `vei_valor` decimal(24,2) DEFAULT NULL,
  `vei_valor_promocional` decimal(24,2) DEFAULT NULL,
  `vei_status` tinyint(1) NOT NULL DEFAULT '0',
  `vei_data` date NOT NULL,
  `vei_titulo` varchar(100) DEFAULT NULL,
  `vei_descricao` text,
  `vei_visualizacoes` int(11) NOT NULL DEFAULT '0',
  `vei_comparar_fipe` tinyint(1) NOT NULL,
  `vei_valor_fipe` decimal(24,2) DEFAULT NULL,
  `vei_keywords` varchar(255) DEFAULT NULL,
  `vei_url` varchar(255) NOT NULL,
  PRIMARY KEY (`vei_id`),
  KEY `fkvei_id_modelo` (`vei_id_modelo`),
  KEY `fkvei_id_tipo_venda` (`vei_id_tipo_venda`),
  KEY `fkvei_id_categoria` (`vei_id_categoria`),
  KEY `fkvei_id_marca` (`vei_id_marca`),
  KEY `fkvei_id_combustivel` (`vei_id_combustivel`),
  CONSTRAINT `fkvei_id_categoria` FOREIGN KEY (`vei_id_categoria`) REFERENCES `categorias` (`cat_id`),
  CONSTRAINT `fkvei_id_combustivel` FOREIGN KEY (`vei_id_combustivel`) REFERENCES `combustiveis` (`comb_id`),
  CONSTRAINT `fkvei_id_marca` FOREIGN KEY (`vei_id_marca`) REFERENCES `marcas` (`mar_id`),
  CONSTRAINT `fkvei_id_modelo` FOREIGN KEY (`vei_id_modelo`) REFERENCES `modelos` (`mod_id`),
  CONSTRAINT `fkvei_id_tipo_venda` FOREIGN KEY (`vei_id_tipo_venda`) REFERENCES `tipo_venda` (`tip_ven_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
DROP TRIGGER IF EXISTS `tr_deletar_opcionais_veiculos`;

CREATE TRIGGER `tr_deletar_opcionais_veiculos` BEFORE DELETE ON `opcionais` FOR EACH ROW DELETE FROM opcionais_veiculo WHERE opcionais_veiculo.opc_vei_id_opcional = old.opc_id;


DROP TRIGGER IF EXISTS `tr_insert_usuario`;

CREATE TRIGGER `tr_insert_usuario` AFTER INSERT ON `usuarios` FOR EACH ROW INSERT INTO permissoes (
	permissoes.perm_id_usuario, permissoes.perm_categorias, permissoes.perm_combustiveis,
	permissoes.perm_imagens, permissoes.perm_marcas, permissoes.perm_modelos, permissoes.perm_opcionais,
	permissoes.perm_tipo_venda, permissoes.perm_usuarios, permissoes.perm_veiculos, permissoes.perm_permissoes
) VALUES (
	NEW.usu_id,
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
	COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
                  	COLUMN_CREATE('editar',FALSE,'visualizar',TRUE)
);

DROP TRIGGER IF EXISTS `tr_delete_usuario`;

CREATE TRIGGER `tr_delete_usuario` BEFORE DELETE ON `usuarios` FOR EACH ROW DELETE FROM permissoes WHERE permissoes.perm_id_usuario = old.usu_id;

DROP TRIGGER IF EXISTS `tr_delete_veiculo_imagens`;

CREATE TRIGGER `tr_delete_veiculo_imagens` BEFORE DELETE ON `veiculos` FOR EACH ROW DELETE FROM imagens WHERE imagens.imag_id_veiculo = old.vei_id;


-- Crear la base de datos Locuras_mias
CREATE DATABASE Locuras_mias;
USE Locuras_mias;

-- Crear la tabla 'tipo_documento' para tipos de documento
CREATE TABLE `tipo_documento` (
  `tdoc` varchar(10) NOT NULL,
  `desc_tdoc` varchar(30) NOT NULL,
  `estado_tdoc` tinyint(1) NOT NULL,
  PRIMARY KEY (`tdoc`)
);

-- Insertar datos en la tabla 'tipo_documento'
INSERT INTO `tipo_documento` (`tdoc`, `desc_tdoc`, `estado_tdoc`) VALUES
('1', 'Cedula de Ciudadania', 1),
('2', 'Cedula de Extranjeria', 1);

-- Crear la tabla 'usuarios' para usuarios
CREATE TABLE `usuarios` (
  `pk_fk_tdoc` varchar(10) NOT NULL,
  `id_usuario` varchar(11) NOT NULL,
  `nom_persona` varchar(25) NOT NULL,
  `nom2_persona` varchar(25) DEFAULT NULL,
  `apell_persona` varchar(25) NOT NULL,
  `apell2_persona` varchar(25) DEFAULT NULL,
  `direccion_persona` varchar(35) NOT NULL,
  `telefono` bigint(12) NOT NULL,
  `email` varchar(35) NOT NULL,
  `contrasena` varchar(15) NOT NULL,
  PRIMARY KEY (`pk_fk_tdoc`, `id_usuario`),
  FOREIGN KEY (`pk_fk_tdoc`) REFERENCES `tipo_documento` (`tdoc`)
);

-- Insertar datos en la tabla 'usuarios'
INSERT INTO `usuarios` (`pk_fk_tdoc`, `id_usuario`, `nom_persona`, `nom2_persona`, `apell_persona`, `apell2_persona`, `direccion_persona`, `telefono`, `email`, `contrasena`) VALUES
('1', '1003928266', 'jhoan', 'Guillermo', 'mena', 'heredia', 'calle 65 g sur', 7785709, 'j@a.com', '12345'),
('1', '100096', 'sergio', 'andrey', 'paez', 'lopez', 'calle 200', 3852546546, 'a@a.com', '12345'),
('1', '10666677', 'tati', '', 'perez', 'uzamov', 'cra 89 # 89-101', 7745444, 'us@correo.com', '12345');

-- Crear la tabla 'administrador' para administradores
CREATE TABLE `administrador` (
  `tdoc_admin` varchar(10) NOT NULL,
  `id_admin` varchar(11) NOT NULL,
  PRIMARY KEY (`tdoc_admin`, `id_admin`),
  FOREIGN KEY (`tdoc_admin`, `id_admin`) REFERENCES `usuarios` (`pk_fk_tdoc`, `id_usuario`)
);

-- Insertar datos en la tabla 'administrador'
INSERT INTO `administrador` (`tdoc_admin`, `id_admin`) VALUES
('1', '1003928266'),
('1', '100096');

-- Crear la tabla 'vendedor' para vendedores
CREATE TABLE `vendedor` (
  `tdoc_vendedor` varchar(10) NOT NULL,
  `id_vendedor` varchar(11) NOT NULL,
  PRIMARY KEY (`tdoc_vendedor`, `id_vendedor`),
  FOREIGN KEY (`tdoc_vendedor`, `id_vendedor`) REFERENCES `usuarios` (`pk_fk_tdoc`, `id_usuario`)
);

-- Insertar datos en la tabla 'vendedor'
INSERT INTO `vendedor` (`tdoc_vendedor`, `id_vendedor`) VALUES
('1', '100096'),
('1', '10666677');

-- Crear la tabla 'categorias' para categorías de productos
CREATE TABLE `categorias` (
  `cod_categoria` varchar(10) NOT NULL,
  `nom_categoria` varchar(25) NOT NULL,
  `estado_tprod` tinyint(1) NOT NULL,
  PRIMARY KEY (`cod_categoria`)
);

-- Insertar datos en la tabla 'categorias'
INSERT INTO `categorias` (`cod_categoria`, `nom_categoria`, `estado_tprod`) VALUES
('cerveza', 'cervezas', 1),
('aguardiente', 'aguardientes', 1),
('rones', 'rones', 1),
('comida', 'comidas', 1),
('wisky', 'wiskys', 1),
('gaseosa', 'gaseosas', 1),
('vino', 'vinos', 1);

-- Crear la tabla 'productos' para productos
CREATE TABLE `productos` (
  `cod_producto` varchar(10) NOT NULL,
  `desc_producto` varchar(45) NOT NULL,
  `valor_prod` double NOT NULL,
  `fk_tipo_prod` varchar(10) NOT NULL,
  PRIMARY KEY (`cod_producto`),
  FOREIGN KEY (`fk_tipo_prod`) REFERENCES `categorias` (`cod_categoria`)
);

-- Insertar datos en la tabla 'productos'
INSERT INTO `productos` (`cod_producto`, `desc_producto`, `valor_prod`, `fk_tipo_prod`) VALUES
('pk', 'Poker', 4000, 'cerveza'),
('ag', 'Agila', 4000, 'cerveza'),
('and', 'Andina', 4000, 'cerveza'),
('nect', 'nectar', 4000, 'cerveza'),
('antio', 'aguardiente antioqueño', 4000, 'aguardiente'),
('cald', 'ron caldas', 4000, 'rones'),
('med', 'ron medellin', 4000, 'rones'),
('blanc', 'ron blanco', 4000, 'rones'),
('papas', 'Todo rico', 4000, 'cerveza'),
('vino1', 'vino rojo', 4000, 'rones'),
('vino2', 'vino blanco', 4000, 'rones'),
('wisky_jt', 'jhon thomas', 4000, 'rones'),
('wisky_bw', 'black and withe', 4000, 'rones');

-- Crear la tabla 'roles' para roles de usuarios
CREATE TABLE `roles` (
  `cod_rol` int(11) NOT NULL,
  `desc_rol` varchar(30) NOT NULL,
  PRIMARY KEY (`cod_rol`)
);

-- Insertar datos en la tabla 'roles'
INSERT INTO `roles` (`cod_rol`, `desc_rol`) VALUES
(91001102, 'Vendedor'),
(91001101, 'Administrador');

-- Crear la tabla 'usuario_has_roles' para relaciones entre usuarios y roles
CREATE TABLE `usuario_has_roles` (
  `usuario_tdoc` varchar(10) NOT NULL,
  `usuario_id` varchar(11) NOT NULL,
  `usuario_rol` int(11) NOT NULL,
  PRIMARY KEY (`usuario_tdoc`, `usuario_id`, `usuario_rol`),
  FOREIGN KEY (`usuario_tdoc`, `usuario_id`) REFERENCES `usuarios` (`pk_fk_tdoc`, `id_usuario`),
  FOREIGN KEY (`usuario_rol`) REFERENCES `roles` (`cod_rol`)
);

-- Insertar datos en la tabla 'usuario_has_roles'
INSERT INTO `usuario_has_roles` (`usuario_tdoc`, `usuario_id`, `usuario_rol`) VALUES
('1', '1003928266', 91001101),
('1', '10666677', 91001102),
('1', '10666677', 91001101),
('1', '100096', 91001102);

-- Crear la tabla 'hoja_calculo' para registros de ventas
CREATE TABLE `hoja_calculo` (
  `n_factura` int(11) NOT NULL,
  `fecha_factura` date NOT NULL,
  `fk_nombre_prod` varchar(45) NOT NULL,
  `fk_cantidad_prod` int(11) NOT NULL,
  `fk_precio_prod` int(11) NOT NULL,
  `gastos` int(11) NOT NULL,
  `total_ganancia` double NOT NULL,
  PRIMARY KEY (`n_factura`)
  FOREIGN KEY (`fecha_factura`) REFERENCES `
);
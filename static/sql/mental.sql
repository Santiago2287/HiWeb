-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-11-2023 a las 20:02:27
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mental`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `idfav` int(11) NOT NULL,
  `idweb` int(11) NOT NULL,
  `iduser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombreu` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `correou` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `claveu` varchar(105) COLLATE utf8mb4_spanish_ci NOT NULL,
  `perfilu` char(1) COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'C',
  `edadu` int(11) NOT NULL,
  `profesionu` varchar(1) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombreu`, `correou`, `claveu`, `perfilu`, `edadu`, `profesionu`) VALUES
(3, 'Adrian Martinez', 'adrianmartsal@gmail.com', 'pbkdf2:sha256:600000$MqxSBARPz4GsyqMU$d00afc94a0f627c8a0d34821e0078dbb2214d467b8048a3a9f86e57f5cb0852c', 'A', 15, 'M'),
(4, 'Adriano', 'adrian.martinez1621@alumnos.udg.mx', 'pbkdf2:sha256:600000$Yng3PrOLtbqwTV6V$6e92bcf353e96d2b5eb7b97e8e72c2cf8f496949751432b27c69a7283146b5ff', 'A', 15, 'M'),
(7, 'Johann Ruelas', 'osiris.sanchez1670@alumnos.udg.mx', 'pbkdf2:sha256:600000$11mAR4MUF23iubf2$5214b8d76243fb65046165295a201110448cf2dceefd2ecc2e3061ab56f844be', 'C', 123, 'D'),
(8, 'Johann Ruelas', 'jaime.avalos1696@alumnos.udg.mx', 'pbkdf2:sha256:600000$uaNxHoyYEbDTmMil$abbb0ff20d26ed74ea0acb19d9952b4d94b58dba79b85a5f32d390f9e79653db', 'C', 0, 'C');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valorar`
--

CREATE TABLE `valorar` (
  `idvalor` int(11) NOT NULL,
  `idweb` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `valor` float NOT NULL,
  `megusta` varchar(1) NOT NULL,
  `comentario` varchar(50) NOT NULL,
  `fechapublicado` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `web`
--

CREATE TABLE `web` (
  `idweb` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `categoria` varchar(20) NOT NULL,
  `calificacion` float NOT NULL,
  `favorito` varchar(1) NOT NULL,
  `url` text NOT NULL,
  `fechareg` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `web`
--

INSERT INTO `web` (`idweb`, `nombre`, `descripcion`, `categoria`, `calificacion`, `favorito`, `url`, `fechareg`) VALUES
(1, 'AMAZON - QUE ES', 'Libros para saber es JavaScript?', 'VENTA', 4.25, 'N', 'https://www.bing.com/ck/a?!&&p=2f2d8a2c77a4dac8JmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTI2Mg&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript+amazon&u=a1aHR0cHM6Ly93d3cuYW1hem9uLmNvbS5teC9iP25vZGU9OTU3MDIwMzAxMQ&ntb=1', '2023-10-08 09:46:00'),
(2, 'ARIMETRICS  - Q', 'Definicion, ejemplos y significados', 'INFORMATIVO', 5, 'F', 'https://www.bing.com/ck/a?!&&p=c4b688fe5d9382d6JmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTE5MQ&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript+arimetrics&u=a1aHR0cHM6Ly93d3cuYXJpbWV0cmljcy5jb20vZ2xvc2FyaW8tZGlnaXRhbC9qYXZhc2NyaXB0&ntb=1', '2023-10-03 09:46:00'),
(3, 'BLOG HUBSPOT - ', 'Que es javascript , para que sirve javascript y como funcion', 'INFORMATIVO', 1.5, 'F', 'https://www.bing.com/ck/a?!&&p=6a8fffb89beb8bc2JmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTIxNA&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript+blog&u=a1aHR0cHM6Ly9ibG9nLmh1YnNwb3QuZXMvd2Vic2l0ZS9xdWUtZXMtamF2YXNjcmlwdA&ntb=1', '2023-10-07 09:46:00'),
(4, 'DESARROLLO WEB ', 'JavaScript', 'INFORMATIVO', 4, 'N', 'https://www.bing.com/ck/a?!&&p=a5724e66e1d03f5eJmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTIxOQ&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript+desarrollo+web&u=a1aHR0cHM6Ly9kZXNhcnJvbGxvd2ViLmNvbS9ob21lL2phdmFzY3JpcHQ&ntb=1', '2023-10-10 09:46:00'),
(5, 'DEVELOPER MOZZI', 'Primeros pasos de JS, funsdamentos y guia.', 'INFORMATIVO', 5, 'N', 'https://www.bing.com/ck/a?!&&p=c3bc2d8e39159f38JmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTIxOQ&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript&u=a1aHR0cHM6Ly9kZXZlbG9wZXIubW96aWxsYS5vcmcvZXMvZG9jcy9MZWFybi9KYXZhU2NyaXB0L0ZpcnN0X3N0ZXBzL1doYXRfaXNfSmF2YVNjcmlwdA&ntb=1', '2023-10-03 09:46:00'),
(6, 'LENGUAJE JAVASC', 'JavaScript y su documentacion', 'INFORMATIVO', 1, 'F', 'https://www.bing.com/ck/a?!&&p=7379e2558ab26e7aJmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTIwNQ&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript+lenguaje+js&u=a1aHR0cHM6Ly9sZW5ndWFqZWpzLmNvbS8&ntb=1', '2023-10-03 09:46:00'),
(7, 'PLATZY - JAVASC', 'Curso de platzy', 'CURSO', 5, 'N', 'https://platzi.com/cursos/basico-javascript/?msclkid=78c4f4d4242e17e3e02891cac4eede23', '2023-10-10 09:46:00'),
(8, 'SOY RAFRAMAS - ', 'Que es y para quÃ© sirve', 'INFORMATIVO', 3.9, 'N', 'https://www.bing.com/ck/a?!&&p=0adcce1cfe81af8eJmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTIxMw&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript+soy+rafa&u=a1aHR0cHM6Ly9zb3lyYWZhcmFtb3MuY29tL3F1ZS1lcy1qYXZhc2NyaXB0Lw&ntb=1', '2023-10-08 09:46:00'),
(9, 'UDEMY - CURSO G', 'Curso Js - Java Script desde cero', 'CURSO', 4.3, 'N', 'https://www.bing.com/ck/a?!&&p=a5724e66e1d03f5eJmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTIxOQ&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript+desarrollo+web&u=a1aHR0cHM6Ly9kZXNhcnJvbGxvd2ViLmNvbS9ob21lL2phdmFzY3JpcHQ&ntb=1', '2023-10-10 09:46:00'),
(10, 'WIKIPEDIA - JS', 'Historia, desarrollo y herramientas de javascript', 'INFORMATIVO', 3, 'F', 'https://www.bing.com/ck/a?!&&p=2bd97260873bd565JmltdHM9MTY5NjQ2NDAwMCZpZ3VpZD0wZTUyYWQxMi0yODY5LTY1OTktMWE3My1iZTNkMjlhZTY0NzcmaW5zaWQ9NTE3NQ&ptn=3&hsh=3&fclid=0e52ad12-2869-6599-1a73-be3d29ae6477&psq=javascript&u=a1aHR0cHM6Ly9lcy53aWtpcGVkaWEub3JnL3dpa2kvSmF2YVNjcmlwdA&ntb=1', '2023-10-03 09:46:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`idfav`),
  ADD KEY `idweb` (`idweb`),
  ADD KEY `iduser` (`iduser`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correou` (`correou`);

--
-- Indices de la tabla `valorar`
--
ALTER TABLE `valorar`
  ADD PRIMARY KEY (`idvalor`),
  ADD KEY `idweb` (`idweb`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `web`
--
ALTER TABLE `web`
  ADD PRIMARY KEY (`idweb`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `idfav` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `web`
--
ALTER TABLE `web`
  MODIFY `idweb` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`idweb`) REFERENCES `web` (`idweb`),
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`iduser`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `valorar`
--
ALTER TABLE `valorar`
  ADD CONSTRAINT `valorar_ibfk_1` FOREIGN KEY (`id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `valorar_ibfk_2` FOREIGN KEY (`idweb`) REFERENCES `web` (`idweb`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

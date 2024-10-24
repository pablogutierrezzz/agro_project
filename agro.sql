-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 24-10-2024 a las 19:31:54
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `agro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ambiente`
--

CREATE TABLE `ambiente` (
  `id_ambiente` int NOT NULL,
  `ambiente_temperatura` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ambiente_luzSolar` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ambiente_humedad` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ambiente_fechayhora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ambiente`
--

INSERT INTO `ambiente` (`id_ambiente`, `ambiente_temperatura`, `ambiente_luzSolar`, `ambiente_humedad`, `ambiente_fechayhora`) VALUES
(1, '30.70', '136', '46.00', '2024-10-24 16:10:32'),
(2, '30.70', '136', '47.00', '2024-10-24 16:10:42'),
(3, '30.80', '136', '47.00', '2024-10-24 16:10:53'),
(4, '30.80', '134', '47.00', '2024-10-24 16:11:03'),
(5, '30.80', '138', '46.00', '2024-10-24 16:11:14'),
(6, '30.80', '152', '46.00', '2024-10-24 16:11:25'),
(7, '30.90', '142', '46.00', '2024-10-24 16:11:35'),
(8, '31.00', '160', '46.00', '2024-10-24 16:11:46'),
(9, '31.00', '159', '46.00', '2024-10-24 16:11:57'),
(10, '31.00', '154', '46.00', '2024-10-24 16:12:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clima`
--

CREATE TABLE `clima` (
  `clima_id` int NOT NULL,
  `clima_estado` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `clima_ProbPrecipitaciones` varchar(250) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clima`
--

INSERT INTO `clima` (`clima_id`, `clima_estado`, `clima_ProbPrecipitaciones`) VALUES
(1, 'cielo claro', ''),
(2, 'cielo claro', ''),
(3, 'cielo claro', ''),
(4, 'cielo claro', ''),
(5, 'cielo claro', ''),
(6, 'cielo claro', ''),
(7, 'cielo claro', ''),
(8, 'cielo claro', ''),
(9, 'cielo claro', ''),
(10, 'cielo claro', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `siembra`
--

CREATE TABLE `siembra` (
  `siembra_id` int NOT NULL,
  `siembra_fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `datos_suelo` int NOT NULL,
  `datos_ambiente` int NOT NULL,
  `datos_clima` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suelo`
--

CREATE TABLE `suelo` (
  `suelo_id` int NOT NULL,
  `suelo_ph` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `suelo_humedad` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `suelo_temperatura` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `suelo_fechayhora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `suelo`
--

INSERT INTO `suelo` (`suelo_id`, `suelo_ph`, `suelo_humedad`, `suelo_temperatura`, `suelo_fechayhora`) VALUES
(1, '', '1', '', '2024-10-24 16:10:31'),
(2, '', '1', '', '2024-10-24 16:10:42'),
(3, '', '1', '', '2024-10-24 16:10:53'),
(4, '', '1', '', '2024-10-24 16:11:03'),
(5, '', '1', '', '2024-10-24 16:11:14'),
(6, '', '1', '', '2024-10-24 16:11:25'),
(7, '', '1', '', '2024-10-24 16:11:35'),
(8, '', '1', '', '2024-10-24 16:11:46'),
(9, '', '1', '', '2024-10-24 16:11:57'),
(10, '', '1', '', '2024-10-24 16:12:07');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ambiente`
--
ALTER TABLE `ambiente`
  ADD PRIMARY KEY (`id_ambiente`);

--
-- Indices de la tabla `clima`
--
ALTER TABLE `clima`
  ADD PRIMARY KEY (`clima_id`);

--
-- Indices de la tabla `siembra`
--
ALTER TABLE `siembra`
  ADD PRIMARY KEY (`siembra_id`),
  ADD KEY `datos_suelo` (`datos_suelo`),
  ADD KEY `datos_ambiente` (`datos_ambiente`),
  ADD KEY `datos_clima` (`datos_clima`);

--
-- Indices de la tabla `suelo`
--
ALTER TABLE `suelo`
  ADD PRIMARY KEY (`suelo_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ambiente`
--
ALTER TABLE `ambiente`
  MODIFY `id_ambiente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `clima`
--
ALTER TABLE `clima`
  MODIFY `clima_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `siembra`
--
ALTER TABLE `siembra`
  MODIFY `siembra_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `suelo`
--
ALTER TABLE `suelo`
  MODIFY `suelo_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `siembra`
--
ALTER TABLE `siembra`
  ADD CONSTRAINT `siembra_ibfk_1` FOREIGN KEY (`datos_ambiente`) REFERENCES `ambiente` (`id_ambiente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `siembra_ibfk_2` FOREIGN KEY (`datos_clima`) REFERENCES `clima` (`clima_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `siembra_ibfk_3` FOREIGN KEY (`datos_suelo`) REFERENCES `suelo` (`suelo_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

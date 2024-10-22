-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Oct 22, 2024 at 07:18 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kapitansisig`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `firstname` varchar(191) NOT NULL,
  `lastname` varchar(191) NOT NULL,
  `username` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `is_banned` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=not_banned,1=banned',
  `created_at` date NOT NULL DEFAULT current_timestamp(),
  `position` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `firstname`, `lastname`, `username`, `password`, `is_banned`, `created_at`, `position`) VALUES
(1, 'Kristyle Marie', 'Modin', 'kmgmodin', '$2y$10$Aj1WGyrfovmy5VQA3wXKleP0nrV42X5knV.jfYJI1AStwXaV3kzDK', 0, '2024-10-16', 0);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `status`) VALUES
(1, 'Sisig Meal', 0),
(2, 'Barkada Meals', 0),
(5, 'Shawarma Meals', 0),
(6, 'Meryenda Meals', 0),
(7, 'Extra', 0);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(566) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`) VALUES
(1, 'khim'),
(2, 'Dawn');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `category` varchar(191) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`id`, `name`, `unit_id`, `category`, `price`, `quantity`) VALUES
(12, 'PORK SISIG ING', 9, 'Meat & Poultry', 0.00, 98.00),
(13, 'TUNA SISIG ING', 9, 'Meat & Poultry', 0.00, 100.00),
(14, 'Test', 9, 'Meat & Poultry', 0.00, 3.00);

-- --------------------------------------------------------

--
-- Table structure for table `ingredients_items`
--

CREATE TABLE `ingredients_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `tracking_no` varchar(100) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `total_amount` varchar(100) NOT NULL,
  `order_date` datetime DEFAULT NULL,
  `order_status` enum('Placed','Preparing','Completed','Cancelled') NOT NULL DEFAULT 'Placed' COMMENT 'placed, preparing, completed, cancelled',
  `payment_mode` varchar(100) NOT NULL COMMENT 'cash,online',
  `order_placed_by_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `tracking_no`, `invoice_no`, `total_amount`, `order_date`, `order_status`, `payment_mode`, `order_placed_by_id`) VALUES
(1, 1, '134987', 'INV-509868', '450', '2024-10-22 03:28:53', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(2, 1, '669714', 'INV-961238', '1000', '2024-10-22 03:38:47', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(3, 1, '617803', 'INV-155826', '1000', '2024-10-22 03:46:16', 'Placed', 'Online Payment', 'Kristyle Marie'),
(4, 1, '274477', 'INV-817835', '1000', '2024-10-22 03:47:11', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(5, 1, '356657', 'INV-959967', '1000', '2024-10-22 03:54:00', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(6, 1, '741172', 'INV-648550', '2000', '2024-10-22 03:55:44', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(7, 1, '809435', 'INV-479150', '1000', '2024-10-22 04:04:21', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(8, 1, '405048', 'INV-400021', '10000', '2024-10-22 04:05:28', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(9, 1, '795473', 'INV-393448', '1000', '2024-10-22 04:06:16', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(10, 1, '146588', 'INV-973139', '1000', '2024-10-22 04:06:43', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(11, 1, '980728', 'INV-416090', '19', '2024-10-22 04:08:47', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(12, 1, '131177', 'INV-287679', '19', '2024-10-22 04:09:04', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(13, 1, '854744', 'INV-973791', '19', '2024-10-22 04:13:47', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(14, 1, '958317', '', '0', '2024-10-22 04:13:48', 'Placed', '', 'Kristyle Marie'),
(15, 1, '484644', '', '0', '2024-10-22 04:13:49', 'Placed', '', 'Kristyle Marie'),
(16, 1, '980843', '', '0', '2024-10-22 04:13:51', 'Placed', '', 'Kristyle Marie'),
(17, 1, '681875', 'INV-115575', '19', '2024-10-22 04:14:05', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(18, 1, '539918', '', '0', '2024-10-22 04:14:06', 'Placed', '', 'Kristyle Marie'),
(19, 1, '663835', 'INV-724291', '19', '2024-10-22 04:14:30', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(20, 1, '318695', '', '0', '2024-10-22 04:14:31', 'Placed', '', 'Kristyle Marie'),
(21, 1, '922439', '', '0', '2024-10-22 04:14:31', 'Placed', '', 'Kristyle Marie'),
(22, 1, '585236', '', '0', '2024-10-22 04:14:31', 'Placed', '', 'Kristyle Marie'),
(23, 1, '842392', '', '0', '2024-10-22 04:14:31', 'Placed', '', 'Kristyle Marie'),
(24, 1, '597617', '', '0', '2024-10-22 04:14:40', 'Placed', '', 'Kristyle Marie'),
(25, 1, '580858', '', '0', '2024-10-22 04:14:53', 'Placed', '', 'Kristyle Marie'),
(26, 1, '389946', '', '0', '2024-10-22 04:14:53', 'Placed', '', 'Kristyle Marie'),
(27, 1, '899957', '', '0', '2024-10-22 04:14:54', 'Placed', '', 'Kristyle Marie'),
(28, 1, '468733', 'INV-358973', '19', '2024-10-22 04:19:48', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(29, 1, '870503', '', '0', '2024-10-22 04:19:50', 'Placed', '', 'Kristyle Marie'),
(30, 1, '762735', 'INV-970219', '19', '2024-10-22 04:21:16', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(31, 1, '712966', '', '0', '2024-10-22 04:21:17', 'Placed', '', 'Kristyle Marie'),
(32, 1, '603756', '', '0', '2024-10-22 04:23:21', 'Placed', '', 'Kristyle Marie'),
(33, 1, '637625', '', '0', '2024-10-22 04:23:22', 'Placed', '', 'Kristyle Marie'),
(34, 1, '477577', 'INV-859789', '19', '2024-10-22 04:23:35', 'Placed', 'Online Payment', 'Kristyle Marie'),
(35, 1, '545958', 'INV-910278', '19', '2024-10-22 04:24:59', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(36, 1, '769728', 'INV-524558', '19', '2024-10-22 04:26:32', 'Placed', 'Online Payment', 'Kristyle Marie'),
(37, 1, '930347', 'INV-629434', '38', '2024-10-22 04:31:32', 'Placed', 'Online Payment', 'Kristyle Marie'),
(38, 1, '396151', 'INV-849513', '19', '2024-10-22 09:29:27', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(39, 1, '125680', 'INV-723103', '19', '2024-10-22 09:32:12', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(40, 1, '168014', 'INV-769081', '19', '2024-10-22 09:33:52', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(41, 1, '625853', 'INV-803347', '1000', '2024-10-22 09:54:53', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(42, 1, '865952', 'INV-803347', '1000', '2024-10-22 09:54:54', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(43, 1, '339706', 'INV-803347', '1000', '2024-10-22 09:54:55', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(44, 1, '720977', 'INV-803347', '1000', '2024-10-22 09:54:55', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(45, 1, '179887', 'INV-803347', '1000', '2024-10-22 09:54:55', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(46, 1, '389825', 'INV-408239', '19', '2024-10-22 09:55:11', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(47, 1, '746036', 'INV-408239', '19', '2024-10-22 09:55:12', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(48, 1, '698164', 'INV-408239', '19', '2024-10-22 09:55:17', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(49, 1, '749599', 'INV-408239', '19', '2024-10-22 09:55:17', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(50, 1, '581858', 'INV-408239', '19', '2024-10-22 09:55:17', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(51, 1, '333561', 'INV-408239', '19', '2024-10-22 09:55:40', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(52, 1, '824026', 'INV-408239', '19', '2024-10-22 09:55:40', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(53, 1, '258097', 'INV-408239', '19', '2024-10-22 09:55:41', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(54, 1, '425991', 'INV-408239', '19', '2024-10-22 09:55:46', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(55, 1, '247379', 'INV-408239', '19', '2024-10-22 09:55:47', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(56, 1, '459867', 'INV-408239', '19', '2024-10-22 09:55:56', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(57, 1, '123780', 'INV-408239', '19', '2024-10-22 09:58:16', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(58, 1, '479661', 'INV-461697', '19', '2024-10-22 09:58:25', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(59, 1, '859049', 'INV-461697', '19', '2024-10-22 09:58:36', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(60, 1, '562247', 'INV-760794', '1000', '2024-10-22 09:59:09', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(61, 1, '619271', 'INV-375344', '1000', '2024-10-22 10:02:21', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(62, 1, '963443', 'INV-300522', '190', '2024-10-22 10:02:42', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(63, 2, '740113', 'INV-953925', '19', '2024-10-22 10:07:25', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(64, 1, '788240', 'INV-357242', '190', '2024-10-22 10:20:52', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(65, 1, '275816', 'INV-747949', '190', '2024-10-22 10:21:24', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(66, 1, '353794', 'INV-557294', '190', '2024-10-22 10:22:00', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(67, 1, '898543', 'INV-842874', '190', '2024-10-22 10:22:47', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(68, 1, '278287', 'INV-621716', '190', '2024-10-22 10:23:22', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(69, 1, '275247', 'INV-613093', '1', '2024-10-22 10:38:40', 'Placed', 'Cash Payment', 'Kristyle Marie'),
(70, 1, '904894', 'INV-858938', '190', '2024-10-22 13:12:21', 'Placed', 'Cash Payment', 'Kristyle Marie');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` varchar(100) NOT NULL,
  `quantity` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `price`, `quantity`) VALUES
(1, 1, 1, '90.00', '5'),
(2, 2, 3, '1000.00', '1'),
(3, 3, 3, '1000.00', '1'),
(4, 4, 3, '1000.00', '1'),
(5, 5, 3, '1000.00', '1'),
(6, 6, 3, '1000.00', '2'),
(7, 7, 3, '1000.00', '1'),
(8, 8, 3, '1000.00', '10'),
(9, 9, 3, '1000.00', '1'),
(10, 10, 3, '1000.00', '1'),
(11, 11, 4, '19.00', '1'),
(12, 12, 4, '19.00', '1'),
(13, 13, 4, '19.00', '1'),
(14, 17, 4, '19.00', '1'),
(15, 19, 4, '19.00', '1'),
(16, 28, 4, '19.00', '1'),
(17, 30, 4, '19.00', '1'),
(18, 34, 4, '19.00', '1'),
(19, 35, 4, '19.00', '1'),
(20, 36, 4, '19.00', '1'),
(21, 37, 4, '19.00', '2'),
(22, 38, 4, '19.00', '1'),
(23, 39, 4, '19.00', '1'),
(24, 40, 4, '19.00', '1'),
(25, 41, 3, '1000.00', '1'),
(26, 42, 3, '1000.00', '1'),
(27, 43, 3, '1000.00', '1'),
(28, 44, 3, '1000.00', '1'),
(29, 45, 3, '1000.00', '1'),
(30, 46, 4, '19.00', '1'),
(31, 47, 4, '19.00', '1'),
(32, 48, 4, '19.00', '1'),
(33, 49, 4, '19.00', '1'),
(34, 50, 4, '19.00', '1'),
(35, 51, 4, '19.00', '1'),
(36, 52, 4, '19.00', '1'),
(37, 53, 4, '19.00', '1'),
(38, 54, 4, '19.00', '1'),
(39, 55, 4, '19.00', '1'),
(40, 56, 4, '19.00', '1'),
(41, 57, 4, '19.00', '1'),
(42, 58, 4, '19.00', '1'),
(43, 59, 4, '19.00', '1'),
(44, 60, 3, '1000.00', '1'),
(45, 61, 3, '1000.00', '1'),
(46, 62, 4, '19.00', '10'),
(47, 63, 4, '19.00', '1'),
(48, 64, 6, '190.00', '1'),
(49, 65, 6, '190.00', '1'),
(50, 66, 6, '190.00', '1'),
(51, 67, 6, '190.00', '1'),
(52, 68, 6, '190.00', '1'),
(53, 69, 7, '1.00', '1'),
(54, 70, 6, '190.00', '1');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `productname` varchar(191) NOT NULL,
  `description` varchar(191) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp(),
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `productname`, `description`, `price`, `image`, `created_at`, `quantity`) VALUES
(3, 1, 'Tuna', 'Yum', 1000.00, '', '2024-10-22', 226),
(4, 1, 'Pork', '', 19.00, '', '2024-10-22', 60),
(6, 1, 'TEST', '', 190.00, '', '2024-10-22', 94),
(7, 2, 'testtt', '', 1.00, '', '2024-10-22', 189);

-- --------------------------------------------------------

--
-- Table structure for table `purchaseorders`
--

CREATE TABLE `purchaseorders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `tracking_no` varchar(100) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `total_amount` varchar(100) NOT NULL,
  `order_date` datetime NOT NULL,
  `order_status` varchar(100) NOT NULL,
  `ingPayment_mode` varchar(100) NOT NULL,
  `order_placed_by_id` varchar(100) NOT NULL,
  `supplierName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchaseorders`
--

INSERT INTO `purchaseorders` (`id`, `customer_id`, `tracking_no`, `invoice_no`, `total_amount`, `order_date`, `order_status`, `ingPayment_mode`, `order_placed_by_id`, `supplierName`) VALUES
(1, 1, '856401', 'INV-816507', '190', '2024-10-16 16:43:15', 'Delivered', 'Cash Payment', 'Admin', '1'),
(2, 1, '506430', 'INV-886256', '190', '2024-10-16 16:59:43', 'Delivered', 'Cash Payment', 'Admin', '1');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `product_id`, `name`, `created_at`) VALUES
(1, 1, '', '2024-10-16 09:00:35'),
(2, 3, '', '2024-10-21 19:38:06'),
(3, 4, '', '2024-10-21 20:08:35'),
(4, 6, '', '2024-10-22 02:20:18'),
(5, 7, '', '2024-10-22 02:35:45');

-- --------------------------------------------------------

--
-- Table structure for table `recipe_ingredients`
--

CREATE TABLE `recipe_ingredients` (
  `id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipe_ingredients`
--

INSERT INTO `recipe_ingredients` (`id`, `recipe_id`, `ingredient_id`, `quantity`, `unit_id`) VALUES
(1, 1, 2, 5.00, 2),
(2, 2, 5, 1000.00, 9),
(3, 3, 7, 5.00, 10),
(4, 3, 8, 1.00, 11),
(5, 3, 9, 5.00, 12),
(6, 3, 10, 1.00, 12),
(7, 2, 11, 500.00, 10),
(8, 3, 11, 1.00, 9),
(9, 2, 13, 200.00, 10),
(10, 3, 12, 100.00, 10),
(11, 3, 12, 2.00, 9),
(12, 4, 14, 2.00, 6),
(13, 5, 14, 100.00, 10);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `firstname` varchar(191) NOT NULL,
  `lastname` varchar(191) NOT NULL,
  `phonenumber` varchar(191) NOT NULL,
  `address` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `firstname`, `lastname`, `phonenumber`, `address`) VALUES
(1, 'Gaisano', 'Mall', '1234567891', 'Downtown');

-- --------------------------------------------------------

--
-- Table structure for table `units_of_measure`
--

CREATE TABLE `units_of_measure` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `uom_name` varchar(255) DEFAULT NULL,
  `type` enum('reference','bigger','smaller') DEFAULT NULL,
  `ratio` decimal(10,5) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `rounding_precision` decimal(10,5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `units_of_measure`
--

INSERT INTO `units_of_measure` (`id`, `category_id`, `uom_name`, `type`, `ratio`, `active`, `rounding_precision`) VALUES
(6, 1, 'm', 'reference', 1.00000, 1, 0.01000),
(8, 1, 'km', 'bigger', 1000.00000, 1, 0.01000),
(9, 4, 'kg', 'reference', 1.00000, 1, 0.01000),
(10, 4, 'g', 'smaller', 1000.00000, 1, 0.01000),
(11, 3, 'L', 'reference', 1.00000, 1, 0.01000),
(12, 3, 'ml', 'smaller', 100.00000, 1, 0.01000);

-- --------------------------------------------------------

--
-- Table structure for table `unit_categories`
--

CREATE TABLE `unit_categories` (
  `id` int(11) NOT NULL,
  `category_unit_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unit_categories`
--

INSERT INTO `unit_categories` (`id`, `category_unit_name`) VALUES
(1, 'Length'),
(3, 'Volume'),
(4, 'Weight');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `ingredients_items`
--
ALTER TABLE `ingredients_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchaseorders`
--
ALTER TABLE `purchaseorders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recipe_id` (`recipe_id`),
  ADD KEY `ingredient_id` (`ingredient_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units_of_measure`
--
ALTER TABLE `units_of_measure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `unit_categories`
--
ALTER TABLE `unit_categories`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `ingredients_items`
--
ALTER TABLE `ingredients_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchaseorders`
--
ALTER TABLE `purchaseorders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `units_of_measure`
--
ALTER TABLE `units_of_measure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `unit_categories`
--
ALTER TABLE `unit_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `units_of_measure` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ingredients_items`
--
ALTER TABLE `ingredients_items`
  ADD CONSTRAINT `ingredients_items_ibfk_1` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `units_of_measure`
--
ALTER TABLE `units_of_measure`
  ADD CONSTRAINT `units_of_measure_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `unit_categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

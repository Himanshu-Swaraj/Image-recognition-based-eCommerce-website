-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2023 at 11:04 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `password`) VALUES
(1, 'admin', '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `pid` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `pid`, `name`, `price`, `quantity`, `image`) VALUES
(2, 1, 1, 'Laptop - Lenovo Series Ideapad', 34990, 1, 'laptop1.jpg'),
(3, 1, 2, 'Laptop - HP 255 G8 Notebook', 37188, 1, 'laptop4.jpg'),
(4, 1, 3, 'Laptop - APPLE MacBook', 110900, 1, 'laptop7.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `number` varchar(12) NOT NULL,
  `message` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `name`, `email`, `number`, `message`) VALUES
(1, 1, 'Himanshu', 'himanshuswaraj4@gmail.com', '4465464646', 'hello');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `number` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `address` varchar(500) NOT NULL,
  `total_products` varchar(1000) NOT NULL,
  `total_price` int(100) NOT NULL,
  `placed_on` date NOT NULL DEFAULT current_timestamp(),
  `payment_status` varchar(20) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `details` varchar(500) NOT NULL,
  `price` int(10) NOT NULL,
  `image_01` varchar(100) NOT NULL,
  `image_02` varchar(100) NOT NULL,
  `image_03` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `details`, `price`, `image_01`, `image_02`, `image_03`) VALUES
(1, 'Laptop - Lenovo Series Ideapad', 'Brand	Lenovo\r\nSeries	Ideapad Slim 3i\r\nScreen Size	15.6 Inches\r\nColour	Platinum Grey\r\nHard Disk Size	256 GB\r\nCPU Model	Celeron N4020\r\nRAM Memory Installed Size	4 GB\r\nOperating System	Windows 10 Home\r\nSpecial Feature	Anti reflective\r\nGraphics Card Description	Integrated', 34990, 'laptop1.jpg', 'laptop2.jpg', 'laptop3.jpg'),
(2, 'Laptop - HP 255 G8 Notebook', 'Brand	HP\r\nSeries	G8 255 -689T4PA\r\nScreen Size	39.6 Centimetres\r\nCPU Model	Ryzen 3 3250U\r\nRAM Memory Installed Size	8 GB\r\nOperating System	Windows 11 Home\r\nSpecial Feature	Full Size Keyboard\r\nGraphics Card Description	Integrated\r\nGraphics Coprocessor	Integrated AMD Graphics\r\nCPU Speed	2.6 GHz', 37188, 'laptop4.jpg', 'laptop5.jpg', 'laptop6.jpg'),
(3, 'Laptop - APPLE MacBook', 'Sales Package\r\nMacBook Air, 30 W USB-C Power Adapter, USB-C Charge Cable (2m), User Guide, Warranty Documents\r\nModel Number\r\nZ12A000D3\r\nPart Number\r\nZ12A000D3\r\nSeries\r\nMacBook Air\r\nColor\r\nGold\r\nType\r\nThin and Light Laptop\r\nSuitable For\r\nProcessing & Multitasking\r\n\r\n', 110900, 'laptop7.jpg', 'laptop8.jpg', 'laptop9.jpg'),
(4, 'Smartphone - REDMI 9A', '3MP rear camera with AI portrait, AI scene recognition, HDR, pro mode | 5MP front camera\r\n16.58 centimeters (6.53 inch) HD+ multi-touch capacitive touchscreen with 1600 x 720 pixels resolution, 268 ppi pixel density and 20:9 aspect ratio', 9499, 'P1.jpg', 'P3.jpg', 'P2.jpg'),
(5, 'Smartphone - Apple iPhone X', '5.8 inch Full HD Retina Screen\r\n12-megapixel wide-angle and telephoto cameras\r\niOS 11 Operating System', 50000, 'P4.jpg', 'P5.jpg', 'P6.jpg'),
(6, 'Smartphone - Galaxy S21FE', ' Measured diagonally, the screen size is 16.29cm (6.4&#34;) in the full rectangle and 15.89cm (6.3&#34;) accounting for the rounded corners. Actual viewable area is less due to the rounded corners and the camera hole.All dimensions are approximate and may slightly vary.', 30999, 'P7.JPG', 'P8.JPG', 'P9.JPG');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(1, 'Himanshu', 'himanshuswaraj4@gmail.com', '70ababe77fcc97ec300c225ae96a5810c188b0e5');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `pid` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(100) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

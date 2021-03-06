-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 15, 2021 at 02:49 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tu2hand`
--

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `idSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `nameSeller` text COLLATE utf8_unicode_ci NOT NULL,
  `namePd` text COLLATE utf8_unicode_ci NOT NULL,
  `pricePd` text COLLATE utf8_unicode_ci NOT NULL,
  `detailPd` text COLLATE utf8_unicode_ci NOT NULL,
  `imagesPd` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `idSeller`, `nameSeller`, `namePd`, `pricePd`, `detailPd`, `imagesPd`) VALUES
(13, '2', 'haiSu', 'Sofa', '20000', 'gagaga', '[/pdImg/pd_655735.jpg, /pdImg/pd_217984.jpg, /pdImg/pd_417374.jpg, /pdImg/pd_285068.jpg]'),
(14, '2', 'haiSu', 'TV', '12000', 'fafafa', '[/pdImg/pd_516516.jpg, /pdImg/pd_241818.jpg, /pdImg/pd_568909.jpg, /pdImg/pd_195491.jpg]'),
(15, '2', 'haiSu', 'golflook', '300', 'lalala', '[/pdImg/pd_516516.jpg, /pdImg/pd_241818.jpg, /pdImg/pd_568909.jpg, /pdImg/pd_195491.jpg]');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `type` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `user` text COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL,
  `img` text COLLATE utf8_unicode_ci NOT NULL,
  `lat` text COLLATE utf8_unicode_ci NOT NULL,
  `long` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `type`, `address`, `phone`, `user`, `password`, `img`, `lat`, `long`) VALUES
(1, 'suhai', 'buyer', '99/10 Rangsit Thammsat Pathum Thani 12120\n12120', '0987654321', 'suhaiBuyer', '123456', '', '37.4219983', '-122.084'),
(2, 'haiSu', 'seller', '54/45 Satun Huhin 94110', '0876543210', 'suhaiSeller', '123456', '', '37.4219983', '-122.084'),
(3, 'suhai', 'buyer', 'thammasat', '123', 'suhaiBuyer526', '123456', '/tu2hand/userImg/img23559.jpg', '37.4219983', '-122.084'),
(4, 'Nutty', 'seller', '145/12 Srabitu 19991', '0770021', 'nutSeller', '123456', '/tu2hand/userImg/profile_30737.jpg', '37.4219983', '-122.084');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2016-07-25 15:31:27
-- 服务器版本： 10.1.10-MariaDB
-- PHP Version: 7.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tour_helper`
--

-- --------------------------------------------------------

--
-- 表的结构 `about_us`
--

CREATE TABLE `about_us` (
  `about_us_content` varchar(64) NOT NULL COMMENT '关于我们'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `map_content_info`
--

CREATE TABLE `map_content_info` (
  `scenic_area_id` varchar(64) NOT NULL COMMENT '景区内码',
  `scenic_facility_id` varchar(64) NOT NULL COMMENT '设施内码',
  `scenic_facility_name` varchar(64) NOT NULL COMMENT '设施名称',
  `scenic_facility_explain` varchar(64) NOT NULL COMMENT '设施说明',
  `scenic_facility_latitude` double NOT NULL,
  `scenic_facility_longitude` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `opinion_info`
--

CREATE TABLE `opinion_info` (
  `opinion_id` varchar(64) NOT NULL COMMENT '意见内码',
  `opinion_content` varchar(64) NOT NULL COMMENT '意见内容'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `scenic_area_info`
--

CREATE TABLE `scenic_area_info` (
  `scenic_area_id` varchar(64) NOT NULL COMMENT '景区内码',
  `scenic_area_name` varchar(64) NOT NULL COMMENT '景区名称',
  `scenic_area_latitude` double NOT NULL,
  `scenic_area_longitude` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `scenic_area_info`
--

INSERT INTO `scenic_area_info` (`scenic_area_id`, `scenic_area_name`, `scenic_area_latitude`, `scenic_area_longitude`) VALUES
('000001', '九寨沟', 33.273342, 103.924245);

-- --------------------------------------------------------

--
-- 表的结构 `scenic_spot_info`
--

CREATE TABLE `scenic_spot_info` (
  `scenic_area_id` varchar(64) NOT NULL COMMENT '景区内码',
  `scenic_spot_id` varchar(64) NOT NULL COMMENT '景点内码',
  `scenic_spot_name` varchar(64) NOT NULL COMMENT '景点名称',
  `scenic_spot_introduction` varchar(400) NOT NULL COMMENT '景点介绍',
  `scenic_spot_voice` varchar(400) NOT NULL COMMENT '景点语音',
  `scenic_spot_picture` varchar(200) NOT NULL,
  `scenic_spot_longitude` double NOT NULL,
  `scenic_spot_latitude` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `scenic_spot_info`
--

INSERT INTO `scenic_spot_info` (`scenic_area_id`, `scenic_spot_id`, `scenic_spot_name`, `scenic_spot_introduction`, `scenic_spot_voice`, `scenic_spot_picture`, `scenic_spot_longitude`, `scenic_spot_latitude`) VALUES
('000001', '000001', '卧龙海', '卧龙海海拔2215米，深22米。小巧玲珑的卧龙海是蓝色湖泊典型的代表，极浓重的蓝色醉人心田。湖面水波不兴，宁静祥和，像一块光滑平整、晶莹剔透的蓝宝石。透过波平如镜的水面，一条乳白色钙华长堤横卧湖心，宛若一条蛟龙潜游海底。', '卧龙海海拔2215米，深22米。小巧玲珑的卧龙海是蓝色湖泊典型的代表，极浓重的蓝色醉人心田。湖面水波不兴，宁静祥和，像一块光滑平整、晶莹剔透的蓝宝石。透过波平如镜的水面，一条乳白色钙华长堤横卧湖心，宛若一条蛟龙潜游海底。', '卧龙海.jpeg', 103.907089, 33.206952),
('000001', '000002', '箭竹海', '箭竹(Arrow Bamboo)是大熊猫喜食的食物，箭竹海(Arrow Bamboo Lake)湖岸四周广有生长，是箭竹海最大的特点，因而得名。箭竹海湖面开阔而绵长，水色碧蓝。倒影历历，直叫人分不清究竟是山入水中还是水浸山上。', '箭竹(Arrow Bamboo)是大熊猫喜食的食物，箭竹海(Arrow Bamboo Lake)湖岸四周广有生长，是箭竹海最大的特点，因而得名。箭竹海湖面开阔而绵长，水色碧蓝。倒影历历，直叫人分不清究竟是山入水中还是水浸山上。', '箭竹海.jpg', 103.879475, 33.144499),
('000001', '000003', '芦苇海', '“芦苇海”海拔2140米，全长2.2公里，是一个半沼泽湖泊。海中芦苇丛生，水鸟飞翔，清溪碧流，漾绿摇翠，蜿蜒空行，好一派泽国风光。“芦苇海”中，荡荡芦苇，一片青葱，微风徐来，绿浪起伏。飒飒之声，委婉抒情，使人心旷神怡。', '“芦苇海”海拔2140米，全长2.2公里，是一个半沼泽湖泊。海中芦苇丛生，水鸟飞翔，清溪碧流，漾绿摇翠，蜿蜒空行，好一派泽国风光。“芦苇海”中，荡荡芦苇，一片青葱，微风徐来，绿浪起伏。飒飒之声，委婉抒情，使人心旷神怡。', '芦苇海.jpg', 103.879475, 33.144499),
('000001', '000004', '双龙海', '“双龙海”在火花海瀑布下的树丛中。海中有两条带状的生物钙华礁堤隐隐潜伏于海底，活像两条蛟龙藏于海中，蠕蠕欲动。还有一个黑龙与白龙打斗的传说。那条白龙本是双龙海的守护神，黑龙是天将，黑龙因触犯天条，被玉帝贬下界，在双龙海与白龙夺龙王大权……', '“双龙海”在火花海瀑布下的树丛中。海中有两条带状的生物钙华礁堤隐隐潜伏于海底，活像两条蛟龙藏于海中，蠕蠕欲动。还有一个黑龙与白龙打斗的传说。那条白龙本是双龙海的守护神，黑龙是天将，黑龙因触犯天条，被玉帝贬下界，在双龙海与白龙夺龙王大权……', '双龙海.jpg', 103.879475, 33.144499);

-- --------------------------------------------------------

--
-- 表的结构 `scenic_spot_piclist`
--

CREATE TABLE `scenic_spot_piclist` (
  `scenic_spot_id` varchar(64) NOT NULL,
  `scenic_picture_id` varchar(64) NOT NULL,
  `scenic_spot_picture` varchar(64) NOT NULL,
  `scenic_area_id` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `scenic_spot_piclist`
--

INSERT INTO `scenic_spot_piclist` (`scenic_spot_id`, `scenic_picture_id`, `scenic_spot_picture`, `scenic_area_id`) VALUES
('000001', '000001', '卧龙海.jpeg', '000001'),
('000001', '000002', '卧龙海2.jpeg', '000001'),
('000001', '000003', '卧龙海3.jpeg', '000001'),
('000001', '000004', '卧龙海4.jpeg', '000001'),
('000002', '000001', '箭竹海.jpg', '000001'),
('000002', '000002', '箭竹海2.jpeg', '000001'),
('000002', '000003', '箭竹海3.jpeg', '000001'),
('000002', '000004', '箭竹海4.jpeg', '000001'),
('000003', '000001', '芦苇海.jpg', '000001'),
('000003', '000002', '芦苇海2.jpeg', '000001'),
('000003', '000003', '芦苇海3.jpeg', '000001'),
('000004', '000001', '双龙海.jpg', '000001'),
('000004', '000002', '双龙海2.jpeg', '000001'),
('000004', '000003', '双龙海3.jpeg', '000001'),
('000004', '000004', '双龙海4.jpeg', '000001');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_us`
--
ALTER TABLE `about_us`
  ADD PRIMARY KEY (`about_us_content`);

--
-- Indexes for table `map_content_info`
--
ALTER TABLE `map_content_info`
  ADD PRIMARY KEY (`scenic_area_id`,`scenic_facility_id`);

--
-- Indexes for table `opinion_info`
--
ALTER TABLE `opinion_info`
  ADD PRIMARY KEY (`opinion_id`);

--
-- Indexes for table `scenic_area_info`
--
ALTER TABLE `scenic_area_info`
  ADD PRIMARY KEY (`scenic_area_id`);

--
-- Indexes for table `scenic_spot_info`
--
ALTER TABLE `scenic_spot_info`
  ADD PRIMARY KEY (`scenic_area_id`,`scenic_spot_id`);

--
-- Indexes for table `scenic_spot_piclist`
--
ALTER TABLE `scenic_spot_piclist`
  ADD PRIMARY KEY (`scenic_spot_id`,`scenic_picture_id`,`scenic_area_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

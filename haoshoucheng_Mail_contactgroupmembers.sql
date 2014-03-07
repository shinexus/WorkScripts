-- phpMyAdmin SQL Dump
-- version 3.3.4
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 03 月 13 日 11:56
-- 服务器版本: 5.5.12
-- PHP 版本: 5.3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `fomax_roundcubedb`
--

-- --------------------------------------------------------

--
-- 表的结构 `contactgroupmembers`
--

CREATE TABLE IF NOT EXISTS `contactgroupmembers` (
  `contactgroup_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`contactgroup_id`,`contact_id`),
  KEY `contact_id_fk_contacts` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `contactgroupmembers`
--

INSERT INTO `contactgroupmembers` (`contactgroup_id`, `contact_id`, `created`) VALUES
-- wenqian@haoshoucheng.com
(14, 44, '2012-02-28 11:45:50'),
(14, 45, '2012-02-28 11:46:17'),
(14, 46, '2012-02-28 11:46:51'),
(14, 47, '2012-03-12 09:55:50'),
(14, 48, '2012-03-12 09:56:34'),
(14, 49, '2012-03-12 09:57:36'),
(14, 50, '2012-03-12 09:58:20'),
(14, 51, '2012-03-12 09:59:05'),
(14, 52, '2012-03-12 09:59:48'),
(14, 53, '2012-03-12 10:00:54'),
(14, 54, '2012-03-12 10:01:38'),
(14, 55, '2012-03-12 10:02:16'),
(14, 56, '2012-03-12 10:02:49');
-- muao@haoshoucheng.com
(13, 57, '2012-02-28 11:45:50'),
(13, 58, '2012-02-28 11:46:17'),
(13, 59, '2012-02-28 11:46:51'),
(13, 60, '2012-03-12 09:55:50'),
(13, 61, '2012-03-12 09:56:34'),
(13, 62, '2012-03-12 09:57:36'),
(13, 63, '2012-03-12 09:58:20'),
(13, 64, '2012-03-12 09:59:05'),
(13, 65, '2012-03-12 09:59:48'),
(13, 66, '2012-03-12 10:00:54'),
(13, 67, '2012-03-12 10:01:38'),
(13, 68, '2012-03-12 10:02:16'),
(13, 69, '2012-03-12 10:02:49');

--
-- 限制导出的表
--

--
-- 限制表 `contactgroupmembers`
--
ALTER TABLE `contactgroupmembers`
  ADD CONSTRAINT `contactgroup_id_fk_contactgroups` FOREIGN KEY (`contactgroup_id`) REFERENCES `contactgroups` (`contactgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contact_id_fk_contacts` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE;

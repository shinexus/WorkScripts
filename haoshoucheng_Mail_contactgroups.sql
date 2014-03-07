-- phpMyAdmin SQL Dump
-- version 3.3.4
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2012 年 03 月 13 日 10:49
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
-- 表的结构 `contactgroups`
--

CREATE TABLE IF NOT EXISTS `contactgroups` (
  `contactgroup_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`contactgroup_id`),
  KEY `contactgroups_user_index` (`user_id`,`del`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `contactgroups`
--

INSERT INTO `contactgroups` (`contactgroup_id`, `user_id`, `changed`, `del`, `name`) VALUES
(13, 14, '2012-02-28 11:45:24', 0, '店长'),
(14, 16, '2012-02-28 11:45:24', 0, '店长'),
(15, 18, '2012-02-28 11:45:24', 0, '店长'),
(16, 19, '2012-02-28 11:45:24', 0, '店长'),
(17, 20, '2012-02-28 11:45:24', 0, '店长'),
(18, 21, '2012-02-28 11:45:24', 0, '店长'),
(19, 22, '2012-02-28 11:45:24', 0, '店长'),
(20, 23, '2012-02-28 11:45:24', 0, '店长'),

(22, 25, '2012-02-28 11:45:24', 0, '店长'),
(23, 26, '2012-02-28 11:45:24', 0, '店长'),

(25, 28, '2012-02-28 11:45:24', 0, '店长'),
(26, 29, '2012-02-28 11:45:24', 0, '店长'),
(27, 30, '2012-02-28 11:45:24', 0, '店长'),

(30, 33, '2012-02-28 11:45:24', 0, '店长'),
(31, 34, '2012-02-28 11:45:24', 0, '店长'),
(32, 35, '2012-02-28 11:45:24', 0, '店长'),
(33, 36, '2012-02-28 11:45:24', 0, '店长'),
(34, 37, '2012-02-28 11:45:24', 0, '店长'),
(35, 38, '2012-02-28 11:45:24', 0, '店长'),
(36, 39, '2012-02-28 11:45:24', 0, '店长'),
(37, 40, '2012-02-28 11:45:24', 0, '店长'),
(38, 41, '2012-02-28 11:45:24', 0, '店长'),
(39, 42, '2012-02-28 11:45:24', 0, '店长'),
(40, 43, '2012-02-28 11:45:24', 0, '店长'),
(41, 44, '2012-02-28 11:45:24', 0, '店长'),
(42, 45, '2012-02-28 11:45:24', 0, '店长'),
(43, 46, '2012-02-28 11:45:24', 0, '店长'),
(44, 47, '2012-02-28 11:45:24', 0, '店长'),
(45, 48, '2012-02-28 11:45:24', 0, '店长'),
(46, 49, '2012-02-28 11:45:24', 0, '店长'),
(47, 50, '2012-02-28 11:45:24', 0, '店长'),
(48, 51, '2012-02-28 11:45:24', 0, '店长');

--
-- 限制导出的表
--

--
-- 限制表 `contactgroups`
--
ALTER TABLE `contactgroups`
  ADD CONSTRAINT `user_id_fk_contactgroups` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

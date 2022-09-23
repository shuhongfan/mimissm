/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.120.20_3307
 Source Server Type    : MySQL
 Source Server Version : 50738
 Source Host           : 192.168.120.20:3307
 Source Schema         : xiaomissm

 Target Server Type    : MySQL
 Target Server Version : 50738
 File Encoding         : 65001

 Date: 23/09/2022 09:25:07
*/
create database xiaomissm;
use xiaomissm;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `addressId` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `cnee` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`addressId`) USING BTREE,
  INDEX `FK_Reference_1`(`uid`) USING BTREE,
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 1, 'zar', '15266676667', '北京海淀甲骨文');
INSERT INTO `address` VALUES (2, 1, 'oracle', '15266678888', '北京朝阳科技文化一条街');
INSERT INTO `address` VALUES (3, 2, '张三', '15290888162', '北京大兴西红门');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `a_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `a_pass` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'c984aed014aec7623a54f0591da07a85fd4b762d');

-- ----------------------------
-- Table structure for carshop
-- ----------------------------
DROP TABLE IF EXISTS `carshop`;
CREATE TABLE `carshop`  (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `pid` int(11) NULL DEFAULT NULL,
  `numbers` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE,
  INDEX `FK_Reference_3`(`uid`) USING BTREE,
  INDEX `FK_Reference_4`(`pid`) USING BTREE,
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`pid`) REFERENCES `product_info` (`p_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carshop
-- ----------------------------
INSERT INTO `carshop` VALUES (1, 1, 1, 2);

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail`  (
  `odid` int(11) NOT NULL AUTO_INCREMENT,
  `oid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` int(11) NULL DEFAULT NULL,
  `pnumber` int(11) NULL DEFAULT NULL,
  `ptotal` double(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`odid`) USING BTREE,
  INDEX `FK_Reference_7`(`oid`) USING BTREE,
  INDEX `FK_Reference_8`(`pid`) USING BTREE,
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`pid`) REFERENCES `product_info` (`p_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`oid`) REFERENCES `xmorder` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES (1, 'abcd111222333444777888999000wwww', 1, 2, 9996.00);

-- ----------------------------
-- Table structure for product_info
-- ----------------------------
DROP TABLE IF EXISTS `product_info`;
CREATE TABLE `product_info`  (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_content` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_price` int(11) NULL DEFAULT NULL,
  `p_image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_number` int(11) NULL DEFAULT NULL,
  `type_id` int(11) NULL DEFAULT NULL,
  `p_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`p_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  CONSTRAINT `product_info_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `product_type` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_info
-- ----------------------------
INSERT INTO `product_info` VALUES (1, '小米Note2', '双曲面 黑色 6GB内存 64GB闪存', 2899, 'b80cd1991f2d4c229ad1e6fd8000c23d.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (2, '红米Note5A', '5.5英寸 粉色 2GB内存 16GB闪存', 699, '48fdbc0a4540459e81d568e196423442.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (3, '红米Note4X', '5.5英寸 绿色 4GB内存 64GB闪存', 1299, '2cc6be2362ee4d5fa3db6d50668cec66.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (4, '红米4', '5英寸 金色 3GB内存 32GB闪存', 999, 'd97a4b22267b478da3dd17ad885f65d6.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (5, '红米4X', '5英寸 黑色 3GB内存 32GB闪存', 899, '37449522e36e46b3bb472d43b98286bb.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (6, '小米平板3', '7.9英寸 金色 4GB内存 64GB闪存', 1499, '04b3af4fb721404487a50fd50d9138d5.jpg', 500, 2, NULL);
INSERT INTO `product_info` VALUES (7, '小米Air12', '12.5英寸 银色 4GB内存 128GB闪存', 3599, '70ec6a3303894c11b44809632991da26.jpg', 500, 2, NULL);
INSERT INTO `product_info` VALUES (8, '小米Air13', '13.3英寸 银色 8GB内存 256GB闪存', 4999, '420711fd0f2c42a6a6e1b5904eb6f77a.jpg', 500, 2, NULL);
INSERT INTO `product_info` VALUES (9, '小米Pro', '15.6英寸 灰色 16GB内存 256GB闪存', 6999, '12ba27419be64d7980030b20664beacc.jpg', 500, 2, NULL);
INSERT INTO `product_info` VALUES (10, '小米电视4', '49英寸 原装LG屏 3840×2160 真4K', 3299, 'aa75dc6dbbac4e88a937113b9105d4d3.jpg', 500, 3, NULL);
INSERT INTO `product_info` VALUES (11, '小米电视4', '55英寸 原装三星屏 3840×2160 真4K', 3999, '4aeb55d7ead642b8824554691f10439e.jpg', 500, 3, NULL);
INSERT INTO `product_info` VALUES (12, '小米电视4', '65英寸 原装三星屏 3840×2160 真4K', 8999, '0432bfc5eda74ef7966aa74947cebbed.jpg', 500, 3, NULL);
INSERT INTO `product_info` VALUES (13, '小米电视4A', '43英寸 FHD全高清屏 1920*1080', 1999, '4de2326a59f5467ea35fc96ad6125bfe.jpg', 500, 3, NULL);
INSERT INTO `product_info` VALUES (14, '小米电视4A', '49英寸 FHD全高清屏 1920*1080', 2299, '03cd9b905d7943fc95ca81089494b56a.jpg', 500, 3, NULL);
INSERT INTO `product_info` VALUES (15, '小米MIX2', '全陶瓷 黑色 8GB内存 128GB闪存', 4699, 'b22bab31c1ed482d92d4378995adcab9.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (16, '小米Note3', '全网通 蓝色 6GB内存 64GB闪存', 2499, '6eff5b9651ca4f2980e7707de51e3b5f.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (17, '小米6', '玻璃金属 白色 6GB内存 128GB闪存', 2899, '88c9c35c338c4243aca039112b5f7732.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (18, '小米MAX2', '全金属 金色 4GB内存 64GB闪存', 1599, '94b7275303244862bbfa9dff70997407.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (19, '小米5X', '全金属 金色 4GB内存 64GB闪存', 1499, '66d2fbf4dbae46088e20236463b1ecbc.jpg', 500, 1, NULL);
INSERT INTO `product_info` VALUES (21, '我是凡凡凡', '我是凡凡凡', 999, 'de582e4dbd694f548e3c5cf4bc56f245.png', 100, 1, '2022-09-23');

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS `product_type`;
CREATE TABLE `product_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_type
-- ----------------------------
INSERT INTO `product_type` VALUES (1, '手机');
INSERT INTO `product_type` VALUES (2, '电脑');
INSERT INTO `product_type` VALUES (3, '电视');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `upass` varbinary(50) NULL DEFAULT NULL,
  `ustatus` int(11) NULL DEFAULT NULL,
  `ulevel` int(11) NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'zar', 0x313233343536, 0, 0, 0);
INSERT INTO `users` VALUES (2, 'zhangsan', 0x313233343536, 1, 0, 0);

-- ----------------------------
-- Table structure for xmorder
-- ----------------------------
DROP TABLE IF EXISTS `xmorder`;
CREATE TABLE `xmorder`  (
  `oid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `addressId` int(11) NULL DEFAULT NULL,
  `totalprice` double(10, 2) NULL DEFAULT NULL,
  `remarks` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `odate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`oid`) USING BTREE,
  INDEX `FK_Reference_5`(`uid`) USING BTREE,
  INDEX `FK_Reference_6`(`addressId`) USING BTREE,
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`addressId`) REFERENCES `address` (`addressId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xmorder
-- ----------------------------
INSERT INTO `xmorder` VALUES ('abcd111222333444777888999000wwww', 1, 1, 9996.00, '尽快送到', '待发货', '2022-09-23 08:38:51');

SET FOREIGN_KEY_CHECKS = 1;

-- MySQL dump 10.13  Distrib 5.5.32, for Linux (x86_64)
--
-- Host: 192.168.1.230    Database: draco
-- ------------------------------------------------------
-- Server version	5.5.32-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `draco_donate_role`
--

DROP TABLE IF EXISTS `draco_donate_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_donate_role` (
  `rankId` int(11) NOT NULL DEFAULT '0' COMMENT '排行榜活动ID',
  `roleId` varchar(15) NOT NULL DEFAULT '0' COMMENT '色角ID',
  `curCount` int(11) NOT NULL DEFAULT '0' COMMENT '活动计数',
  `reward` int(1) NOT NULL DEFAULT '0',
  `worldReward` int(6) NOT NULL DEFAULT '0' COMMENT '全民领奖标识',
  PRIMARY KEY (`rankId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_donate_world`
--

DROP TABLE IF EXISTS `draco_donate_world`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_donate_world` (
  `activeId` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `curCount` int(11) NOT NULL DEFAULT '0' COMMENT '活动计数',
  PRIMARY KEY (`activeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_qualify_rank`
--

DROP TABLE IF EXISTS `draco_qualify_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_qualify_rank` (
  `rank` int(11) NOT NULL,
  `roleId` varchar(15) NOT NULL DEFAULT '0',
  `robot` int(2) NOT NULL DEFAULT '0' COMMENT '0.玩家 1.机器人',
  PRIMARY KEY (`rank`),
  UNIQUE KEY `qualiftRank` (`rank`) USING BTREE,
  UNIQUE KEY `qualiftRoleId` (`roleId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_qualify_robot`
--

DROP TABLE IF EXISTS `draco_qualify_robot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_qualify_robot` (
  `roleId` varchar(15) NOT NULL,
  `roleName` varchar(20) NOT NULL,
  `heroId1` int(11) NOT NULL,
  `heroId2` int(11) NOT NULL,
  `heroId3` int(11) NOT NULL,
  `level` int(4) NOT NULL,
  `battleScore` int(11) NOT NULL,
  PRIMARY KEY (`roleId`),
  UNIQUE KEY `Robot` (`roleId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_async_arena`
--

DROP TABLE IF EXISTS `draco_role_async_arena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_async_arena` (
  `roleId` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `successNum` tinyint(4) DEFAULT '0' COMMENT '连胜次数',
  `refNum` tinyint(11) DEFAULT '0' COMMENT '刷新次数',
  `challengeNum` tinyint(11) DEFAULT '0' COMMENT '挑战次数',
  `targetData` blob COMMENT '对手数据',
  `nowHonor` int(11) DEFAULT '0' COMMENT '当前荣誉',
  `historyHonor` int(11) DEFAULT '0' COMMENT '历史荣誉',
  `refTime` bigint(20) DEFAULT '0' COMMENT '刷新时间',
  `isReward` tinyint(4) DEFAULT NULL,
  `historyRanking` int(11) DEFAULT '0' COMMENT '历史排行',
  PRIMARY KEY (`roleId`),
  KEY `roleId` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_charge`
--

DROP TABLE IF EXISTS `draco_role_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_charge` (
  `channelId` int(11) NOT NULL DEFAULT '0' COMMENT '渠道ID',
  `channelOrderId` varchar(50) NOT NULL COMMENT '渠道订单号',
  `orderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `recordTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录时间',
  `userId` varchar(36) DEFAULT '' COMMENT '发请求userID',
  `roleId` varchar(20) DEFAULT '' COMMENT '角色ID',
  `feeValue` int(11) NOT NULL DEFAULT '0' COMMENT '充值金额(单位分)',
  `state` int(11) NOT NULL DEFAULT '-1' COMMENT '与计费中心通讯码',
  `errCode` int(11) NOT NULL DEFAULT '-1' COMMENT '充值失败错误码',
  `payGold` int(11) NOT NULL DEFAULT '0' COMMENT '充值真实获得的金条数',
  `gameMoney` int(11) DEFAULT '0' COMMENT '游戏虚拟币（大于0表示以此充值）',
  PRIMARY KEY (`channelId`,`channelOrderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_choice_card`
--

DROP TABLE IF EXISTS `draco_role_choice_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_choice_card` (
  `roleId` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '-1' COMMENT '金币抽卡 钻石抽卡 活动抽卡',
  `specificType` tinyint(4) NOT NULL DEFAULT '-1' COMMENT '细节分类 （免费、花钱、十连抽）',
  `num` int(11) DEFAULT '0' COMMENT '花费次数',
  `freeNum` int(11) DEFAULT '0' COMMENT '免费次数',
  `cdTime` bigint(20) DEFAULT '0' COMMENT 'cd时间',
  PRIMARY KEY (`roleId`,`type`,`specificType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_choice_card_luck`
--

DROP TABLE IF EXISTS `draco_role_choice_card_luck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_choice_card_luck` (
  `roleId` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '-1' COMMENT '金币抽卡 钻石抽卡 活动抽卡',
  `luck` int(11) DEFAULT '0' COMMENT '幸运值',
  `freeNum` int(11) DEFAULT '0' COMMENT '首次',
  `goldFirstNum` int(11) DEFAULT '0' COMMENT '金币首次抽',
  PRIMARY KEY (`roleId`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_copy`
--

DROP TABLE IF EXISTS `draco_role_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_copy` (
  `roleId` varchar(15) NOT NULL,
  `copyId` int(11) NOT NULL,
  `enterNum` int(11) DEFAULT NULL,
  `buyNum` int(11) DEFAULT NULL,
  `copyPass` int(4) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`roleId`,`copyId`),
  UNIQUE KEY `roleCopy` (`roleId`,`copyId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_copy_line_reward`
--

DROP TABLE IF EXISTS `draco_role_copy_line_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_copy_line_reward` (
  `roleId` varchar(15) NOT NULL,
  `chapterId` int(4) NOT NULL DEFAULT '0',
  `takeStarNum` int(11) DEFAULT '0',
  PRIMARY KEY (`roleId`,`chapterId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_copy_line_score`
--

DROP TABLE IF EXISTS `draco_role_copy_line_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_copy_line_score` (
  `roleId` varchar(15) NOT NULL,
  `chapterId` int(4) NOT NULL,
  `copyIndex` int(4) NOT NULL,
  `maxStar` int(4) DEFAULT '0',
  PRIMARY KEY (`roleId`,`chapterId`,`copyIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_dailyplay`
--

DROP TABLE IF EXISTS `draco_role_dailyplay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_dailyplay` (
  `roleId` varchar(15) NOT NULL,
  `updateOn` datetime NOT NULL,
  `data` blob,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_discount`
--

DROP TABLE IF EXISTS `draco_role_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_discount` (
  `activeId` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `roleId` int(11) NOT NULL DEFAULT '0',
  `totalValue` int(11) NOT NULL DEFAULT '0' COMMENT '累计总值',
  `operateDate` datetime NOT NULL COMMENT '操作时间',
  `meetCond1Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件1次数',
  `meetCond2Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件2次数',
  `meetCond3Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件3次数',
  `meetCond4Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件4次数',
  `meetCond5Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件5次数',
  `meetCond6Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件6次数',
  `meetCond7Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件7次数',
  `meetCond8Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件8次数',
  `meetCond9Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件9次数',
  `meetCond10Count` int(5) NOT NULL DEFAULT '0' COMMENT '满足条件10次数',
  `reward1Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励1次数',
  `reward2Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励2次数',
  `reward3Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励3次数',
  `reward4Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励4次数',
  `reward5Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励5次数',
  `reward6Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励6次数',
  `reward7Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励7次数',
  `reward8Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励8次数',
  `reward9Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励9次数',
  `reward10Count` int(5) NOT NULL DEFAULT '0' COMMENT '领取奖励10次数',
  `curDayTotal` int(11) DEFAULT '0' COMMENT '当日总额',
  `extraInfo` varchar(30) DEFAULT '',
  PRIMARY KEY (`activeId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_exchange`
--

DROP TABLE IF EXISTS `draco_role_exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_exchange` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '兑换id',
  `roleId` varchar(15) NOT NULL COMMENT '角色ID',
  `times` int(3) DEFAULT '0' COMMENT '已兑换次数',
  `lastExTime` datetime DEFAULT NULL COMMENT '上一次兑换时间',
  `expiredTime` datetime DEFAULT NULL COMMENT '兑换过期时间',
  PRIMARY KEY (`id`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_hero`
--

DROP TABLE IF EXISTS `draco_role_hero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_hero` (
  `roleId` varchar(15) NOT NULL,
  `heroId` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `exp` int(11) NOT NULL DEFAULT '0',
  `skills` varchar(100) NOT NULL DEFAULT '',
  `quality` int(4) NOT NULL DEFAULT '0',
  `star` int(4) NOT NULL DEFAULT '0',
  `qualityProgress` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `hpRate` smallint(2) NOT NULL DEFAULT '-1' COMMENT '血量百分比',
  PRIMARY KEY (`roleId`,`heroId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_hero_status`
--

DROP TABLE IF EXISTS `draco_role_hero_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_hero_status` (
  `roleId` varchar(15) NOT NULL,
  `battleHeroId` varchar(15) DEFAULT '',
  `switchHeros` varchar(50) DEFAULT '',
  `helpHeros` varchar(50) DEFAULT '',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_horse`
--

DROP TABLE IF EXISTS `draco_role_horse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_horse` (
  `roleId` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `horseId` int(11) NOT NULL DEFAULT '0' COMMENT '坐骑ID',
  `quality` tinyint(4) NOT NULL DEFAULT '0' COMMENT '品质',
  `star` tinyint(4) NOT NULL DEFAULT '0' COMMENT '星级',
  `state` tinyint(4) DEFAULT '0' COMMENT '状态 0未骑乘 1骑乘',
  `starNum` int(11) NOT NULL DEFAULT '0' COMMENT '坐骑升星消耗数量',
  `battleScore` int(11) NOT NULL DEFAULT '0' COMMENT '坐骑战力',
  PRIMARY KEY (`roleId`,`horseId`),
  KEY `horseId` (`horseId`),
  KEY `roleId` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_horse_skill`
--

DROP TABLE IF EXISTS `draco_role_horse_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_horse_skill` (
  `roleId` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `horseId` int(11) NOT NULL DEFAULT '0' COMMENT '坐骑ID',
  `skillId` smallint(11) NOT NULL DEFAULT '0' COMMENT '技能ID',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT '等级',
  `luck` int(11) NOT NULL DEFAULT '0' COMMENT '幸运值',
  PRIMARY KEY (`roleId`,`horseId`),
  KEY `horseId` (`horseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='坐骑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_mail`
--

DROP TABLE IF EXISTS `draco_role_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_mail` (
  `mailId` varchar(15) NOT NULL,
  `roleId` varchar(15) DEFAULT NULL,
  `gold` int(11) DEFAULT NULL,
  `bindGold` int(11) DEFAULT NULL,
  `silverMoney` int(11) DEFAULT NULL,
  `exp` int(11) DEFAULT NULL,
  `dkp` int(11) DEFAULT '0' COMMENT 'DKP',
  `potential` int(11) NOT NULL DEFAULT '0',
  `honor` int(11) DEFAULT '0',
  `look` int(1) NOT NULL DEFAULT '0',
  `sendTime` datetime DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `sendRole` varchar(15) DEFAULT NULL,
  `existGoods` int(1) DEFAULT NULL,
  `sendSource` int(11) NOT NULL DEFAULT '0',
  `contentId` int(11) NOT NULL DEFAULT '0',
  `payGold` int(11) DEFAULT '0' COMMENT '付费金条数',
  `freeze` int(4) DEFAULT '0' COMMENT '冻结状态 0=非冻结 1=冻结',
  PRIMARY KEY (`mailId`),
  KEY `NewIndex1` (`roleId`),
  KEY `NewIndex2` (`sendTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_mail_accessory`
--

DROP TABLE IF EXISTS `draco_role_mail_accessory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_mail_accessory` (
  `mailId` varchar(15) NOT NULL,
  `roleId` varchar(15) DEFAULT NULL,
  `templateId` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `bind` int(1) DEFAULT NULL,
  `instanceId` varchar(15) DEFAULT NULL,
  `sendTime` datetime DEFAULT NULL,
  KEY `NewIndex1` (`mailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_mail_goods`
--

DROP TABLE IF EXISTS `draco_role_mail_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_mail_goods` (
  `id` varchar(15) NOT NULL,
  `roleId` varchar(15) NOT NULL DEFAULT '' COMMENT '角色id',
  `storageType` int(1) NOT NULL DEFAULT '0' COMMENT 'storageType：1:背包 2:仓库 3:装备上4.邮件',
  `goodsId` int(11) NOT NULL DEFAULT '0' COMMENT '物品id',
  `mosaic` varchar(200) NOT NULL DEFAULT '' COMMENT '镶嵌[孔的ID1:宝石ID1,孔的ID2: 宝石ID2]',
  `currOverlapCount` int(11) NOT NULL DEFAULT '0' COMMENT '当前叠放数量',
  `bind` int(1) NOT NULL DEFAULT '0' COMMENT '是否绑定 0:没有绑定 1:已经绑定',
  `attrVar` varchar(200) NOT NULL DEFAULT '' COMMENT '随机装备属性类型[类型1:值1,类型2：值2](只是用于随机装备)',
  `strengthenLevel` int(11) NOT NULL DEFAULT '0',
  `otherParm` varchar(80) NOT NULL DEFAULT '' COMMENT '特殊公用参数，不同类型的物品代表意义不同',
  `mailId` varchar(15) NOT NULL DEFAULT '',
  `sendTime` datetime DEFAULT NULL,
  `deadline` int(11) NOT NULL DEFAULT '0' COMMENT '限时物品有效时间(小时)',
  `star` int(4) NOT NULL DEFAULT '0',
  `quality` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `roleId_index` (`roleId`),
  KEY `NewIndex1` (`mailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='邮件物品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_nostrum`
--

DROP TABLE IF EXISTS `draco_role_nostrum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_nostrum` (
  `roleId` varchar(15) NOT NULL,
  `goodsId` int(11) NOT NULL,
  `goodsNum` int(11) DEFAULT '0',
  PRIMARY KEY (`roleId`,`goodsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_operate`
--

DROP TABLE IF EXISTS `draco_role_operate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_operate` (
  `roleId` varchar(15) NOT NULL,
  `activeId` int(11) NOT NULL,
  `activeType` int(4) NOT NULL,
  `data` blob,
  PRIMARY KEY (`roleId`,`activeId`),
  UNIQUE KEY `operate_active` (`roleId`,`activeId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_pay`
--

DROP TABLE IF EXISTS `draco_role_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_pay` (
  `roleId` varchar(20) NOT NULL DEFAULT '',
  `currMoney` int(11) NOT NULL DEFAULT '0',
  `totalMoney` int(11) NOT NULL DEFAULT '0',
  `consumeMoney` int(11) NOT NULL DEFAULT '0' COMMENT '总消耗的金条',
  `lastUpTime` datetime DEFAULT NULL,
  `payGold` int(11) NOT NULL DEFAULT '0' COMMENT '充值真实获得的金条数',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_pet`
--

DROP TABLE IF EXISTS `draco_role_pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_pet` (
  `masterId` varchar(15) NOT NULL,
  `petId` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  `exp` int(11) NOT NULL DEFAULT '0',
  `star` int(4) NOT NULL DEFAULT '0',
  `starProgress` int(11) NOT NULL DEFAULT '0',
  `mosaic` varchar(200) DEFAULT NULL COMMENT '镶嵌[孔的ID1:宝石ID1,孔的ID2: 宝石ID2]',
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`masterId`,`petId`),
  UNIQUE KEY `pet` (`masterId`,`petId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_quest`
--

DROP TABLE IF EXISTS `draco_role_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_quest` (
  `roleId` varchar(15) NOT NULL COMMENT '角色Id',
  `questId` int(11) NOT NULL DEFAULT '0' COMMENT '任务Id',
  `phase` int(11) NOT NULL DEFAULT '0' COMMENT '阶段Id',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '任务状态',
  `data1` int(11) NOT NULL DEFAULT '0' COMMENT '数据1',
  `data2` int(11) NOT NULL DEFAULT '0' COMMENT '数据2',
  `data3` int(11) NOT NULL DEFAULT '0' COMMENT '数据3',
  `awardId` int(11) NOT NULL DEFAULT '0' COMMENT '奖励ID',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`roleId`,`questId`),
  KEY `questId` (`questId`),
  KEY `roleId` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='玩家任务记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_quest_daily_finished`
--

DROP TABLE IF EXISTS `draco_role_quest_daily_finished`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_quest_daily_finished` (
  `roleId` varchar(15) NOT NULL DEFAULT '' COMMENT '角色ID',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `edata0` bigint(20) NOT NULL DEFAULT '0',
  `edata1` bigint(20) NOT NULL DEFAULT '0',
  `edata2` bigint(20) NOT NULL DEFAULT '0',
  `edata3` bigint(20) NOT NULL DEFAULT '0',
  `edata4` bigint(20) NOT NULL DEFAULT '0',
  `edata5` bigint(20) NOT NULL DEFAULT '0',
  `edata6` bigint(20) NOT NULL DEFAULT '0',
  `edata7` bigint(20) NOT NULL DEFAULT '0',
  `edata8` bigint(20) NOT NULL DEFAULT '0',
  `edata9` bigint(20) NOT NULL DEFAULT '0',
  `edata10` bigint(20) NOT NULL DEFAULT '0',
  `edata11` bigint(20) NOT NULL DEFAULT '0',
  `edata12` bigint(20) NOT NULL DEFAULT '0',
  `edata13` bigint(20) NOT NULL DEFAULT '0',
  `edata14` bigint(20) NOT NULL DEFAULT '0',
  `edata15` bigint(20) NOT NULL DEFAULT '0',
  `edata16` bigint(20) NOT NULL DEFAULT '0',
  `edata17` bigint(20) NOT NULL DEFAULT '0',
  `edata18` bigint(20) NOT NULL DEFAULT '0',
  `edata19` bigint(20) NOT NULL DEFAULT '0',
  `edata20` bigint(20) NOT NULL DEFAULT '0',
  `edata21` bigint(20) NOT NULL DEFAULT '0',
  `edata22` bigint(20) NOT NULL DEFAULT '0',
  `edata23` bigint(20) NOT NULL DEFAULT '0',
  `edata24` bigint(20) NOT NULL DEFAULT '0',
  `edata25` bigint(20) NOT NULL DEFAULT '0',
  `edata26` bigint(20) NOT NULL DEFAULT '0',
  `edata27` bigint(20) NOT NULL DEFAULT '0',
  `edata28` bigint(20) NOT NULL DEFAULT '0',
  `edata29` bigint(20) NOT NULL DEFAULT '0',
  `edata30` bigint(20) NOT NULL DEFAULT '0',
  `edata31` bigint(20) NOT NULL DEFAULT '0',
  `edata32` bigint(20) NOT NULL DEFAULT '0',
  `edata33` bigint(20) NOT NULL DEFAULT '0',
  `edata34` bigint(20) NOT NULL DEFAULT '0',
  `edata35` bigint(20) NOT NULL DEFAULT '0',
  `edata36` bigint(20) NOT NULL DEFAULT '0',
  `edata37` bigint(20) NOT NULL DEFAULT '0',
  `edata38` bigint(20) NOT NULL DEFAULT '0',
  `edata39` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_quest_finished`
--

DROP TABLE IF EXISTS `draco_role_quest_finished`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_quest_finished` (
  `roleId` varchar(15) NOT NULL DEFAULT '' COMMENT '角色ID',
  `data0` bigint(20) NOT NULL DEFAULT '0',
  `data1` bigint(20) NOT NULL DEFAULT '0',
  `data2` bigint(20) NOT NULL DEFAULT '0',
  `data3` bigint(20) NOT NULL DEFAULT '0',
  `data4` bigint(20) NOT NULL DEFAULT '0',
  `data5` bigint(20) NOT NULL DEFAULT '0',
  `data6` bigint(20) NOT NULL DEFAULT '0',
  `data7` bigint(20) NOT NULL DEFAULT '0',
  `data8` bigint(20) NOT NULL DEFAULT '0',
  `data9` bigint(20) NOT NULL DEFAULT '0',
  `data10` bigint(20) NOT NULL DEFAULT '0',
  `data11` bigint(20) NOT NULL DEFAULT '0',
  `data12` bigint(20) NOT NULL DEFAULT '0',
  `data13` bigint(20) NOT NULL DEFAULT '0',
  `data14` bigint(20) NOT NULL DEFAULT '0',
  `data15` bigint(20) NOT NULL DEFAULT '0',
  `data16` bigint(20) NOT NULL DEFAULT '0',
  `data17` bigint(20) NOT NULL DEFAULT '0',
  `data18` bigint(20) NOT NULL DEFAULT '0',
  `data19` bigint(20) NOT NULL DEFAULT '0',
  `data20` bigint(20) NOT NULL DEFAULT '0',
  `data21` bigint(20) NOT NULL DEFAULT '0',
  `data22` bigint(20) NOT NULL DEFAULT '0',
  `data23` bigint(20) NOT NULL DEFAULT '0',
  `data24` bigint(20) NOT NULL DEFAULT '0',
  `data25` bigint(20) NOT NULL DEFAULT '0',
  `data26` bigint(20) NOT NULL DEFAULT '0',
  `data27` bigint(20) NOT NULL DEFAULT '0',
  `data28` bigint(20) NOT NULL DEFAULT '0',
  `data29` bigint(20) NOT NULL DEFAULT '0',
  `data30` bigint(20) NOT NULL DEFAULT '0',
  `data31` bigint(20) NOT NULL DEFAULT '0',
  `data32` bigint(20) NOT NULL DEFAULT '0',
  `data33` bigint(20) NOT NULL DEFAULT '0',
  `data34` bigint(20) NOT NULL DEFAULT '0',
  `data35` bigint(20) NOT NULL DEFAULT '0',
  `data36` bigint(20) NOT NULL DEFAULT '0',
  `data37` bigint(20) NOT NULL DEFAULT '0',
  `data38` bigint(20) NOT NULL DEFAULT '0',
  `data39` bigint(20) NOT NULL DEFAULT '0',
  `data40` bigint(20) NOT NULL DEFAULT '0',
  `data41` bigint(20) NOT NULL DEFAULT '0',
  `data42` bigint(20) NOT NULL DEFAULT '0',
  `data43` bigint(20) NOT NULL DEFAULT '0',
  `data44` bigint(20) NOT NULL DEFAULT '0',
  `data45` bigint(20) NOT NULL DEFAULT '0',
  `data46` bigint(20) NOT NULL DEFAULT '0',
  `data47` bigint(20) NOT NULL DEFAULT '0',
  `data48` bigint(20) NOT NULL DEFAULT '0',
  `data49` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_quest_poker`
--

DROP TABLE IF EXISTS `draco_role_quest_poker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_quest_poker` (
  `roleId` varchar(15) NOT NULL DEFAULT '' COMMENT '角色ID',
  `count` int(11) DEFAULT '0' COMMENT '接取次数',
  `poker1` int(11) DEFAULT '-1',
  `poker2` int(11) DEFAULT '-1',
  `poker3` int(11) DEFAULT '-1',
  `status` int(4) DEFAULT '0',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `tempQuestId` int(11) DEFAULT '0',
  `tempAwardId` int(11) DEFAULT '0',
  `tempPoker` int(11) DEFAULT '-1',
  `buyNum` int(11) DEFAULT '0' COMMENT '购买次数（轮次的购买次数）',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_rank`
--

DROP TABLE IF EXISTS `draco_role_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_rank` (
  `rankId` int(11) NOT NULL DEFAULT '0' COMMENT '排行榜活动ID',
  `roleId` varchar(15) NOT NULL DEFAULT '0' COMMENT '色角ID',
  `reward` int(1) NOT NULL DEFAULT '0',
  `count0` int(11) NOT NULL DEFAULT '0' COMMENT '页签0计数',
  `count1` int(11) NOT NULL DEFAULT '0' COMMENT '页签1计数',
  `count2` int(11) NOT NULL DEFAULT '0' COMMENT '页签2计数',
  PRIMARY KEY (`rankId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_recovery`
--

DROP TABLE IF EXISTS `draco_role_recovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_recovery` (
  `roleId` varchar(15) NOT NULL COMMENT '角色ID',
  `recoveryId` varchar(11) NOT NULL COMMENT '一键追回的ID',
  `roleLevel` int(11) DEFAULT NULL COMMENT '角色等级',
  `num` int(11) DEFAULT '0' COMMENT '一键追回的数目',
  `maxNum` int(11) DEFAULT '0' COMMENT '一键追回总次数',
  `data` varchar(22) DEFAULT '0' COMMENT '离线经验的昨日可获取经验',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_richman`
--

DROP TABLE IF EXISTS `draco_role_richman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_richman` (
  `roleId` int(11) NOT NULL,
  `curJoinNum` int(3) DEFAULT NULL,
  `diceNormalNum` int(11) DEFAULT NULL,
  `diceRemoteNum` int(3) DEFAULT NULL,
  `diceDoubleNum` int(3) DEFAULT NULL,
  `todayCoupon` int(11) DEFAULT NULL,
  `operateDate` datetime DEFAULT NULL,
  `totalCoupon` int(11) DEFAULT NULL,
  `randomEventInfo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_shop`
--

DROP TABLE IF EXISTS `draco_role_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_shop` (
  `roleId` varchar(15) NOT NULL COMMENT '角色ID',
  `refreshTime` datetime DEFAULT NULL COMMENT '刷新时间',
  `data` blob COMMENT '购买记录',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_shop_secret`
--

DROP TABLE IF EXISTS `draco_role_shop_secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_shop_secret` (
  `roleId` varchar(15) NOT NULL COMMENT '角色ID',
  `shopId` varchar(15) NOT NULL COMMENT '商店Id',
  `refreshTime` datetime DEFAULT NULL COMMENT '刷新时间',
  `currentDayRefreshTimes` int(11) NOT NULL DEFAULT '0' COMMENT '当时刷新的次数',
  `data` blob COMMENT '商店信息',
  PRIMARY KEY (`roleId`,`shopId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_talent`
--

DROP TABLE IF EXISTS `draco_role_talent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_talent` (
  `roleId` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `talent` int(11) DEFAULT '0' COMMENT '天赋值',
  `talent1` int(11) DEFAULT NULL,
  `talent2` int(11) DEFAULT NULL,
  `talent3` int(11) DEFAULT NULL,
  `talent4` int(11) DEFAULT NULL,
  `talent5` int(11) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_target`
--

DROP TABLE IF EXISTS `draco_role_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_target` (
  `roleId` int(11) NOT NULL,
  `line1Id` int(5) DEFAULT '0',
  `line1Status` int(1) DEFAULT '0',
  `line2Id` int(5) DEFAULT NULL,
  `line2Status` int(1) DEFAULT NULL,
  `line3Id` int(5) DEFAULT NULL,
  `line3Status` int(1) DEFAULT NULL,
  `line4Id` int(5) DEFAULT '0',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_role_vip`
--

DROP TABLE IF EXISTS `draco_role_vip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_role_vip` (
  `roleId` int(11) NOT NULL,
  `vipLevel` int(11) NOT NULL DEFAULT '0' COMMENT 'vip等级。0级为不是VIP',
  `vipExp` int(11) NOT NULL DEFAULT '0' COMMENT 'vip经验',
  `lastReceiveAwardTime` datetime DEFAULT '2012-07-17 15:30:50' COMMENT '《要删掉》',
  `vipLevelUpAward` int(11) NOT NULL DEFAULT '0' COMMENT 'vip奖励列表',
  `vipLevelFunction` int(11) NOT NULL DEFAULT '0' COMMENT 'VIP功能列表',
  `vipLevelGift` int(11) DEFAULT '0' COMMENT 'vip商城礼包',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_social_relation`
--

DROP TABLE IF EXISTS `draco_social_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_social_relation` (
  `roleId` varchar(15) NOT NULL,
  `friendId` varchar(15) NOT NULL,
  `friendHeadId` int(11) NOT NULL DEFAULT '0',
  `intimate` int(11) NOT NULL DEFAULT '0',
  `socialType` int(4) NOT NULL DEFAULT '0',
  `praiseTime` datetime DEFAULT NULL,
  PRIMARY KEY (`roleId`,`friendId`,`socialType`),
  UNIQUE KEY `friend` (`roleId`,`friendId`,`socialType`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union`
--

DROP TABLE IF EXISTS `draco_union`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union` (
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `unionName` varchar(20) NOT NULL DEFAULT '' COMMENT '公会名称',
  `unionLevel` int(5) DEFAULT '0' COMMENT '公会等级',
  `leaderId` varchar(15) NOT NULL DEFAULT '' COMMENT '会长id',
  `leaderName` varchar(20) NOT NULL DEFAULT '' COMMENT '会长名称',
  `unionDesc` varchar(100) DEFAULT '' COMMENT '公会简介',
  `popularity` int(11) DEFAULT '0' COMMENT '公会人气',
  `unionCamp` tinyint(4) DEFAULT '0' COMMENT '阵营',
  `createTime` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`unionId`),
  UNIQUE KEY `NewIndex1` (`unionName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_activity`
--

DROP TABLE IF EXISTS `draco_union_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_activity` (
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `activityId` tinyint(4) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `num` tinyint(4) DEFAULT '0' COMMENT '次数',
  `state` tinyint(4) DEFAULT '0' COMMENT '状态 0未开启 1开启',
  PRIMARY KEY (`unionId`,`activityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_activity_boss_record`
--

DROP TABLE IF EXISTS `draco_union_activity_boss_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_activity_boss_record` (
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `activityId` tinyint(4) NOT NULL DEFAULT '0' COMMENT '公会活动ID',
  `groupId` varchar(20) NOT NULL COMMENT 'bossId',
  `bossHp` bigint(20) DEFAULT '0' COMMENT '血量',
  `state` tinyint(4) DEFAULT '0' COMMENT '状态 0未杀  1已击杀',
  `lastTime` bigint(20) DEFAULT '0' COMMENT '最后操作时间',
  PRIMARY KEY (`unionId`,`groupId`,`activityId`),
  KEY `factionId` (`unionId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_auction`
--

DROP TABLE IF EXISTS `draco_union_auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_auction` (
  `id` varchar(15) NOT NULL,
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `data` blob NOT NULL COMMENT '数据',
  PRIMARY KEY (`id`),
  KEY `factionId` (`unionId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_battle`
--

DROP TABLE IF EXISTS `draco_union_battle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_battle` (
  `battleId` int(11) NOT NULL COMMENT '公会战ID',
  `roleId` int(11) DEFAULT '0' COMMENT '杀死BOSS的角色ID',
  `unionId` varchar(15) DEFAULT '' COMMENT '目前防守的公会ID',
  `killTime` datetime DEFAULT NULL COMMENT '杀死BOSS的时间',
  PRIMARY KEY (`battleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_dkp`
--

DROP TABLE IF EXISTS `draco_union_dkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_dkp` (
  `roleId` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `dkp` int(11) DEFAULT '0' COMMENT 'DPK',
  `exitTime` bigint(20) DEFAULT '0' COMMENT '退出时间',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_kill_boss_record`
--

DROP TABLE IF EXISTS `draco_union_kill_boss_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_kill_boss_record` (
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `data` blob NOT NULL COMMENT '数据',
  PRIMARY KEY (`unionId`),
  KEY `factionId` (`unionId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_member`
--

DROP TABLE IF EXISTS `draco_union_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_member` (
  `roleId` varchar(15) NOT NULL COMMENT '公会成员角色ID',
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `roleName` varchar(20) NOT NULL DEFAULT '' COMMENT '公会成员角色名称',
  `level` int(11) DEFAULT '0' COMMENT '公会成员等级',
  `occupation` tinyint(4) DEFAULT '0' COMMENT '职业',
  `position` tinyint(4) DEFAULT '0' COMMENT '职位',
  `createTime` bigint(20) DEFAULT '0' COMMENT '创建时间',
  `offlineTime` bigint(20) DEFAULT '0' COMMENT '离线时间',
  `dkp` int(11) DEFAULT '0' COMMENT 'DPK',
  `userId` varchar(11) DEFAULT '' COMMENT '帐号ID',
  PRIMARY KEY (`roleId`),
  KEY `NewIndex1` (`unionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会与角色关系信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_member_donate`
--

DROP TABLE IF EXISTS `draco_union_member_donate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_member_donate` (
  `roleId` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '捐献次数',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_record`
--

DROP TABLE IF EXISTS `draco_union_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '帮会ID',
  `type` int(4) NOT NULL COMMENT '类型',
  `data1` int(11) NOT NULL COMMENT '数据1',
  `data2` varchar(15) DEFAULT '' COMMENT '数据2',
  `data3` varchar(15) DEFAULT '' COMMENT '数据3',
  `createTime` bigint(20) DEFAULT '0' COMMENT '记录时间',
  PRIMARY KEY (`id`),
  KEY `factionId` (`unionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_role_auction`
--

DROP TABLE IF EXISTS `draco_union_role_auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_role_auction` (
  `unionId` varchar(20) NOT NULL COMMENT '公会ID',
  `uuid` varchar(200) NOT NULL DEFAULT '' COMMENT '物品唯一ID',
  `roleId` int(20) NOT NULL COMMENT '角色ID',
  `price` int(20) DEFAULT '0' COMMENT '出价',
  PRIMARY KEY (`unionId`,`uuid`,`roleId`),
  KEY `factionId` (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_role_boss`
--

DROP TABLE IF EXISTS `draco_union_role_boss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_role_boss` (
  `roleId` int(15) NOT NULL COMMENT '角色ID',
  `data` blob COMMENT '击杀BOSS数据',
  `num` tinyint(4) DEFAULT '0' COMMENT '次数',
  PRIMARY KEY (`roleId`),
  KEY `factionId` (`roleId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `draco_union_role_dps_record`
--

DROP TABLE IF EXISTS `draco_union_role_dps_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draco_union_role_dps_record` (
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `activityId` tinyint(4) NOT NULL DEFAULT '0' COMMENT '公会活动ID',
  `groupId` varchar(20) NOT NULL COMMENT 'bossId',
  `data` blob COMMENT '数据',
  `lastTime` bigint(20) DEFAULT '0' COMMENT '最后操作时间',
  PRIMARY KEY (`unionId`,`activityId`,`groupId`),
  KEY `factionId` (`unionId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_camp_boom`
--

DROP TABLE IF EXISTS `easter_camp_boom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_camp_boom` (
  `campId` int(1) NOT NULL DEFAULT '0' COMMENT '阵营ID',
  `boom` int(11) NOT NULL DEFAULT '0' COMMENT '阵营繁荣度',
  PRIMARY KEY (`campId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction`
--

DROP TABLE IF EXISTS `easter_faction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction` (
  `factionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `factionName` varchar(20) NOT NULL DEFAULT '' COMMENT '公会名称',
  `factionLevel` int(5) DEFAULT '0' COMMENT '公会等级',
  `status` int(3) DEFAULT '0' COMMENT '公会状态',
  `leaderId` varchar(15) NOT NULL DEFAULT '' COMMENT '会长id',
  `leaderName` varchar(20) NOT NULL DEFAULT '' COMMENT '会长名称',
  `createDate` datetime NOT NULL COMMENT '创建时间',
  `factionDesc` varchar(100) DEFAULT NULL COMMENT '公会简介',
  `memberNum` int(5) DEFAULT '0' COMMENT '公会当前人数',
  `contribution` int(11) DEFAULT '0' COMMENT '帮会总贡献',
  `integral` int(11) DEFAULT '0' COMMENT '帮会积分',
  `resource` int(11) DEFAULT '0' COMMENT '帮会资源',
  `factionMoney` int(11) DEFAULT '0' COMMENT '门派金钱',
  `factionCamp` int(2) NOT NULL DEFAULT '0' COMMENT '门派阵营',
  `donateCount` int(4) DEFAULT '0' COMMENT '捐献总次数',
  `donateTime` datetime DEFAULT NULL COMMENT '捐献时间',
  PRIMARY KEY (`factionId`),
  UNIQUE KEY `NewIndex1` (`factionName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction_build`
--

DROP TABLE IF EXISTS `easter_faction_build`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction_build` (
  `factionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `buildId` varchar(15) NOT NULL DEFAULT '' COMMENT '建筑ID',
  `level` int(4) DEFAULT NULL COMMENT '建筑等级',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  KEY `NewIndex1` (`factionId`,`buildId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction_contribute`
--

DROP TABLE IF EXISTS `easter_faction_contribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction_contribute` (
  `roleId` varchar(15) NOT NULL COMMENT '角色ID',
  `factionId` varchar(15) NOT NULL COMMENT '公会ID',
  `contribute` int(11) DEFAULT NULL COMMENT '贡献值',
  `totalContribute` int(11) DEFAULT NULL COMMENT '角色获得的贡献度',
  PRIMARY KEY (`roleId`,`factionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction_integral_log`
--

DROP TABLE IF EXISTS `easter_faction_integral_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction_integral_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `factionId` varchar(15) NOT NULL DEFAULT '' COMMENT '帮会ID',
  `roleId` int(11) NOT NULL COMMENT '角色ID',
  `roleName` varchar(15) DEFAULT '' COMMENT '角色名称',
  `operateType` int(4) DEFAULT '0' COMMENT '操作类型',
  `integral` int(11) DEFAULT '0' COMMENT '积分变化值',
  `remainIntegral` int(11) DEFAULT '0' COMMENT '剩余积分值',
  `operateTime` datetime DEFAULT NULL COMMENT '创建时间',
  `info` varchar(100) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction_record`
--

DROP TABLE IF EXISTS `easter_faction_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `factionId` varchar(15) NOT NULL DEFAULT '' COMMENT '帮会ID',
  `type` int(4) NOT NULL COMMENT '类型',
  `data1` int(11) NOT NULL COMMENT '数据1',
  `data2` varchar(15) DEFAULT '' COMMENT '数据2',
  `data3` varchar(15) DEFAULT '' COMMENT '数据3',
  `createTime` datetime DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`),
  KEY `factionId` (`factionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction_role`
--

DROP TABLE IF EXISTS `easter_faction_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction_role` (
  `roleId` varchar(15) NOT NULL COMMENT '公会成员角色ID',
  `factionId` varchar(15) NOT NULL COMMENT '公会ID',
  `roleName` varchar(20) NOT NULL DEFAULT '' COMMENT '公会成员角色名称',
  `roleLevel` int(4) DEFAULT NULL COMMENT '公会成员等级',
  `nickName` varchar(36) DEFAULT '' COMMENT '公会成员昵称',
  `sex` int(2) DEFAULT '0' COMMENT '公会成员性别',
  `career` int(1) DEFAULT NULL COMMENT '公会成员职业',
  `position` int(1) DEFAULT NULL COMMENT '公会成员的职务',
  `createDate` datetime DEFAULT NULL COMMENT '加入公会时间',
  `signature` varchar(60) DEFAULT '' COMMENT '成员签名',
  `offlineTime` datetime DEFAULT NULL COMMENT '下线时间',
  `prestige` int(11) DEFAULT '0' COMMENT '声望',
  `contribution` int(11) DEFAULT '0' COMMENT '贡献度',
  `donateCount` int(2) DEFAULT '0' COMMENT '捐献次数',
  `donateTime` datetime DEFAULT NULL COMMENT '捐献时间',
  `salaryTime` datetime DEFAULT NULL COMMENT '工资领取时间',
  `totalContribution` int(11) DEFAULT '0' COMMENT '总贡献度',
  PRIMARY KEY (`roleId`),
  KEY `NewIndex1` (`factionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会与角色关系信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction_soul`
--

DROP TABLE IF EXISTS `easter_faction_soul`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction_soul` (
  `factionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `soulId` int(4) DEFAULT NULL COMMENT '公会神兽ID',
  `level` int(4) DEFAULT NULL COMMENT '公会神兽等级',
  `flyNum` int(4) DEFAULT NULL COMMENT '公会神兽飞升次数',
  `growValue` int(4) DEFAULT NULL COMMENT '公会神兽成长值',
  KEY `NewIndex1` (`factionId`,`soulId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction_war`
--

DROP TABLE IF EXISTS `easter_faction_war`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction_war` (
  `factionWarIndex` int(11) NOT NULL DEFAULT '0' COMMENT 'index',
  `factionId` varchar(15) NOT NULL DEFAULT '' COMMENT '门派ID',
  `factionName` varchar(15) NOT NULL DEFAULT '' COMMENT '门派名',
  `rounds` int(4) NOT NULL DEFAULT '0' COMMENT '轮次',
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`factionWarIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_faction_war_gamble`
--

DROP TABLE IF EXISTS `easter_faction_war_gamble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_faction_war_gamble` (
  `roleId` varchar(15) NOT NULL DEFAULT '' COMMENT '角色ID',
  `factionId` varchar(15) NOT NULL DEFAULT '' COMMENT '门派ID',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '押注的钱数',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_public_announce`
--

DROP TABLE IF EXISTS `easter_public_announce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_public_announce` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '公告内容',
  `startTime` datetime DEFAULT NULL COMMENT '起始时间',
  `endTime` datetime DEFAULT NULL COMMENT '截止时间',
  `timeGap` int(11) DEFAULT NULL COMMENT '时间间隔',
  `state` int(11) DEFAULT NULL COMMENT '状态 3：关闭 2：开启',
  `announceType` int(1) NOT NULL DEFAULT '0' COMMENT '类型 0：GM添加 1：系统添加',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_public_notice`
--

DROP TABLE IF EXISTS `easter_public_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_public_notice` (
  `noticeType` int(4) DEFAULT NULL COMMENT '公告类型',
  `content` text COMMENT '内容',
  `updateTime` datetime DEFAULT NULL COMMENT '修改时间',
  `color` varchar(20) DEFAULT '',
  `title` varchar(30) DEFAULT '' COMMENT '公告标题'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_random_quest`
--

DROP TABLE IF EXISTS `easter_random_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_random_quest` (
  `roleId` varchar(15) NOT NULL DEFAULT '' COMMENT '角色ID',
  `type` int(11) NOT NULL COMMENT '随机任务类型',
  `count` int(11) DEFAULT NULL COMMENT '接取次数',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`roleId`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_rate`
--

DROP TABLE IF EXISTS `easter_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_rate` (
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `type` int(8) NOT NULL DEFAULT '0' COMMENT '倍率类型',
  `rate` int(8) NOT NULL DEFAULT '0',
  `rate1` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='倍率表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_recoup`
--

DROP TABLE IF EXISTS `easter_recoup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_recoup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `senderName` varchar(20) NOT NULL DEFAULT '' COMMENT '补偿邮件者名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '补偿邮件标题',
  `context` varchar(150) NOT NULL DEFAULT '' COMMENT '补偿邮件内容',
  `bindMoney` int(11) NOT NULL DEFAULT '0' COMMENT '补偿绑金',
  `gameMoney` int(11) NOT NULL DEFAULT '0' COMMENT '补偿游戏币',
  `goodsInfo` varchar(200) DEFAULT '' COMMENT '补偿物品(goods1:num:bind;goods2:num:bind)',
  `startTime` datetime NOT NULL COMMENT '开始时间',
  `endTime` datetime NOT NULL COMMENT '结束时间',
  `channelId` int(11) DEFAULT '0' COMMENT '渠道ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role`
--

DROP TABLE IF EXISTS `easter_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role` (
  `roleid` varchar(15) NOT NULL COMMENT '角色ID',
  `userid` varchar(15) NOT NULL COMMENT '账号名',
  `username` varchar(20) NOT NULL DEFAULT '',
  `channelId` int(11) NOT NULL DEFAULT '0' COMMENT '渠道id',
  `rolename` varchar(20) NOT NULL COMMENT '角色名 创建角色的时候，系统判断此角色有同名则不允许创建，但不在数据库中强制限制。当合服时，系统判断到同名者在一个月内有登陆，则强制要求改名。',
  `sex` int(1) NOT NULL DEFAULT '0' COMMENT '性别',
  `level` int(3) NOT NULL DEFAULT '1' COMMENT '等级',
  `exp` int(11) NOT NULL DEFAULT '0' COMMENT '经验',
  `bindingGoldMoney` int(11) NOT NULL DEFAULT '0' COMMENT '绑金',
  `consumeBindMoney` int(11) NOT NULL DEFAULT '0',
  `silverMoney` int(11) NOT NULL DEFAULT '0' COMMENT '银币',
  `mapid` varchar(30) DEFAULT NULL COMMENT '所在地图',
  `mapx` int(8) DEFAULT NULL COMMENT '所在地图坐标X',
  `mapy` int(8) DEFAULT NULL COMMENT '所在地图坐标Y',
  `dayOnlineTime` int(11) DEFAULT '0' COMMENT '当天的在线时长',
  `historyOnlineTime` int(10) DEFAULT '0' COMMENT '总在线时长',
  `lastlogintime` datetime DEFAULT NULL COMMENT '上次进入时间',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `backpackCapacity` int(5) NOT NULL,
  `lastOffTime` datetime DEFAULT NULL COMMENT '上次退出下线时间',
  `curHP` int(8) NOT NULL DEFAULT '0',
  `frozenBeginTime` datetime DEFAULT NULL,
  `frozenEndTime` datetime DEFAULT NULL COMMENT '角色隔离截止时间',
  `frozenMemo` varchar(255) DEFAULT NULL,
  `forbidType` int(1) NOT NULL DEFAULT '0' COMMENT '禁言类型 1：全部禁言 2：世界私聊之外禁言',
  `forbidBeginTime` datetime DEFAULT NULL,
  `forbidEndTime` datetime DEFAULT NULL COMMENT '角色禁言截止时间',
  `forbidMemo` varchar(255) DEFAULT NULL,
  `totalExp` bigint(20) NOT NULL DEFAULT '0',
  `campId` int(1) NOT NULL DEFAULT '0' COMMENT '阵营ID',
  `levelUpTime` int(11) NOT NULL DEFAULT '0' COMMENT '玩家升级所用时间(秒)',
  `rolePayGold` int(11) NOT NULL DEFAULT '0' COMMENT '总充值金条数',
  `roleConsumeGold` int(11) NOT NULL DEFAULT '0' COMMENT '色角消耗的金条数',
  `offlineTime` int(11) NOT NULL DEFAULT '0',
  `receiveRecoup` varchar(50) NOT NULL DEFAULT '' COMMENT '已经领取的补偿id(用,分隔)',
  `potential` int(11) NOT NULL DEFAULT '0',
  `factionSalaryCount` int(4) DEFAULT '0' COMMENT '门派领取工资次数',
  `factionActiveTime` datetime DEFAULT NULL COMMENT '门派活动时间',
  `battleScore` int(11) NOT NULL DEFAULT '0' COMMENT '战斗力(用于排行榜初始化)',
  `honor` int(11) NOT NULL DEFAULT '0' COMMENT '荣誉',
  `wingResId` int(11) NOT NULL DEFAULT '0' COMMENT '翅膀资源ID',
  `clothesResId` int(11) NOT NULL DEFAULT '0' COMMENT '衣服资源ID',
  `copyLostReLoginInfo` varchar(60) DEFAULT NULL COMMENT '副本掉线的标记信息',
  `factionDonate` varchar(20) DEFAULT NULL COMMENT '捐献记录',
  `channelUserId` varchar(50) DEFAULT NULL,
  `pkStatus` int(1) NOT NULL DEFAULT '0' COMMENT 'PK状态',
  `lastFinishQuestId` int(11) DEFAULT '0' COMMENT '最后完成任务ID',
  `campPrestige` int(11) NOT NULL DEFAULT '0',
  `createServerId` int(11) NOT NULL DEFAULT '0',
  `wildBlood` int(11) NOT NULL DEFAULT '0' COMMENT '狂野之血',
  `braveSoul` int(11) NOT NULL DEFAULT '0' COMMENT '勇者之血',
  `arena3v3Score` int(11) NOT NULL DEFAULT '0' COMMENT '竞技场积分',
  `heroCoin` int(11) DEFAULT '0' COMMENT '试炼点',
  PRIMARY KEY (`roleid`),
  UNIQUE KEY `NewIndex1` (`rolename`),
  KEY `NewIndex2` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_active`
--

DROP TABLE IF EXISTS `easter_role_active`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_active` (
  `roleId` varchar(15) NOT NULL DEFAULT '',
  `activeId` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `resetTime` datetime DEFAULT NULL COMMENT '重置时间',
  `commonTimes` int(11) NOT NULL DEFAULT '0' COMMENT '常规次数',
  `extraTimes` int(11) NOT NULL DEFAULT '0' COMMENT '额外次数',
  `data1` int(11) NOT NULL DEFAULT '0',
  `data2` int(11) NOT NULL DEFAULT '0',
  `data3` int(11) NOT NULL DEFAULT '0',
  `data4` int(11) NOT NULL DEFAULT '0',
  `data5` int(11) NOT NULL DEFAULT '0',
  `data6` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleId`,`activeId`),
  KEY `roleId` (`roleId`),
  KEY `activeId` (`activeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_arena`
--

DROP TABLE IF EXISTS `easter_role_arena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_arena` (
  `roleId` varchar(15) NOT NULL,
  `win1v1` int(11) NOT NULL DEFAULT '0',
  `fail1v1` int(11) NOT NULL DEFAULT '0',
  `cycleWin1v1` int(11) NOT NULL DEFAULT '0',
  `cycleFail1v1` int(11) NOT NULL DEFAULT '0',
  `cycleDate` datetime NOT NULL,
  `join1v1` int(11) NOT NULL DEFAULT '0',
  `cycleJoin1v1` int(11) NOT NULL DEFAULT '0',
  `cycle1v1Score` int(11) NOT NULL DEFAULT '0',
  `topScore` int(11) NOT NULL DEFAULT '0' COMMENT '本赛季大师赛积分',
  `topDate` datetime DEFAULT NULL COMMENT '本赛季大师赛最后记录时间',
  `cycle3v3Score` int(11) NOT NULL DEFAULT '0' COMMENT '33竞技场积分',
  `cycleWin3v3` int(11) NOT NULL DEFAULT '0' COMMENT '33竞技场胜利次数',
  `arenaLevel3v3` float(13,2) DEFAULT '0.00' COMMENT '33竞技场等级',
  `lastArenaLevel3v3` float(13,2) DEFAULT '0.00' COMMENT '上周33竞技场等级',
  `cycleWinDark3v3` int(11) DEFAULT '0' COMMENT '跨服33竞技场胜利次数',
  `darkKillNum` int(11) DEFAULT '0' COMMENT '跨服33竞技场杀人数',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_buff`
--

DROP TABLE IF EXISTS `easter_role_buff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_buff` (
  `roleid` varchar(15) NOT NULL DEFAULT '' COMMENT '角色ID',
  `buffid` int(3) NOT NULL COMMENT 'buffid',
  `casterid` varchar(15) DEFAULT NULL COMMENT '产生buff的角色id',
  `remaintime` int(5) DEFAULT NULL COMMENT '剩余时间',
  `buffLevel` int(11) DEFAULT '1' COMMENT 'buff级别',
  `intervalTime` int(11) DEFAULT '1000' COMMENT '间隔时间',
  `extroInfo` varchar(100) DEFAULT NULL COMMENT '额外信息',
  `buffSeries` int(3) NOT NULL DEFAULT '0',
  `lastexecutetime` datetime DEFAULT NULL COMMENT '上次执行时间',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  KEY `NewIndex1` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色buff表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_carnival`
--

DROP TABLE IF EXISTS `easter_role_carnival`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_carnival` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activeId` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `targetId` varchar(15) NOT NULL DEFAULT '' COMMENT '目标ID',
  `name` varchar(15) NOT NULL DEFAULT '' COMMENT '目标名字',
  `campId` int(4) NOT NULL DEFAULT '0' COMMENT '阵营ID',
  `career` int(4) NOT NULL DEFAULT '0' COMMENT '职业ID',
  `targetValue` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `subTargetValue` int(11) NOT NULL DEFAULT '0' COMMENT '子数值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_carnival_rank`
--

DROP TABLE IF EXISTS `easter_role_carnival_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_carnival_rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activeId` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `targetId` varchar(15) NOT NULL DEFAULT '' COMMENT '目标ID',
  `name` varchar(15) NOT NULL DEFAULT '' COMMENT '目标名字',
  `campId` int(4) NOT NULL DEFAULT '0' COMMENT '阵营ID',
  `career` int(4) NOT NULL DEFAULT '0' COMMENT '职业ID',
  `targetValue` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `rank` int(4) NOT NULL DEFAULT '0' COMMENT '值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_count`
--

DROP TABLE IF EXISTS `easter_role_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_count` (
  `roleId` varchar(15) NOT NULL COMMENT '角色ID',
  `dayTime` datetime DEFAULT NULL,
  `data` blob,
  `flowerNum` int(4) NOT NULL DEFAULT '0',
  `todayFlowerNum` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleId`),
  UNIQUE KEY `index_roleId` (`roleId`) USING BTREE,
  KEY `index_flower_num` (`flowerNum`),
  KEY `index_flower_today_num` (`todayFlowerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_drama`
--

DROP TABLE IF EXISTS `easter_role_drama`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_drama` (
  `roleId` int(11) NOT NULL DEFAULT '0',
  `dramaId` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleId`,`dramaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_goods`
--

DROP TABLE IF EXISTS `easter_role_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_goods` (
  `id` varchar(15) NOT NULL,
  `roleId` varchar(15) NOT NULL DEFAULT '' COMMENT '角色id',
  `storageType` int(1) NOT NULL DEFAULT '0' COMMENT 'storageType：1:背包 2:仓库 3:装备上4.邮件',
  `goodsId` int(11) NOT NULL DEFAULT '0' COMMENT '物品id',
  `mosaic` varchar(200) DEFAULT NULL COMMENT '镶嵌[孔的ID1:宝石ID1,孔的ID2: 宝石ID2]',
  `currOverlapCount` int(11) NOT NULL DEFAULT '0' COMMENT '当前叠放数量',
  `bind` int(1) NOT NULL DEFAULT '0' COMMENT '是否绑定 0:没有绑定 1:已经绑定',
  `attrVar` varchar(200) DEFAULT NULL COMMENT '随机装备属性类型[类型1:值1,类型2：值2](只是用于随机装备)',
  `strengthenLevel` int(11) NOT NULL DEFAULT '0',
  `otherParm` varchar(80) DEFAULT NULL COMMENT '特殊公用参数，不同类型的物品代表意义不同',
  `deadline` int(11) NOT NULL DEFAULT '0' COMMENT '限时物品有效时间(小时)',
  `expiredTime` datetime DEFAULT NULL COMMENT '限时物品过期时间',
  `quality` int(4) NOT NULL DEFAULT '0',
  `star` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `roleId_index` (`roleId`),
  KEY `NewIndex1` (`storageType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='角色物品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_rank`
--

DROP TABLE IF EXISTS `easter_role_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_rank` (
  `rankId` int(11) NOT NULL DEFAULT '0' COMMENT '排行榜活动ID',
  `roleId` varchar(15) NOT NULL DEFAULT '0' COMMENT '色角ID',
  `reward` int(1) NOT NULL DEFAULT '0',
  `count0` int(11) NOT NULL DEFAULT '0' COMMENT '页签0计数',
  `count1` int(11) NOT NULL DEFAULT '0' COMMENT '页签1计数',
  `count2` int(11) NOT NULL DEFAULT '0' COMMENT '页签2计数',
  PRIMARY KEY (`rankId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_setting`
--

DROP TABLE IF EXISTS `easter_role_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_setting` (
  `roleId` varchar(15) NOT NULL COMMENT '角色ID',
  `synthesize` int(4) NOT NULL DEFAULT '1' COMMENT '综合设置',
  `sound` int(4) NOT NULL DEFAULT '3' COMMENT '音效',
  `chat` int(8) NOT NULL DEFAULT '0' COMMENT '聊天设置',
  `chatVoice` int(11) DEFAULT '0' COMMENT '语音聊天设置',
  `percentHP` int(11) NOT NULL DEFAULT '80' COMMENT '挂机生命百分比',
  `percentHero` int(11) NOT NULL DEFAULT '80' COMMENT '挂机蓝量百分比',
  `guide` int(11) NOT NULL DEFAULT '0' COMMENT '新手引导',
  `teamInvite` int(4) NOT NULL DEFAULT '0' COMMENT '组队邀请设置',
  `teamApply` int(4) NOT NULL DEFAULT '0' COMMENT '入队申请设置',
  `trade` int(4) NOT NULL DEFAULT '0' COMMENT '交易设置',
  `guide2` int(11) NOT NULL DEFAULT '0' COMMENT '新手引导进度2',
  `fatigue` int(4) NOT NULL DEFAULT '0' COMMENT '疲劳度',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_skill`
--

DROP TABLE IF EXISTS `easter_role_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_skill` (
  `roleId` varchar(15) NOT NULL COMMENT '角色ID',
  `skillId` int(3) NOT NULL COMMENT '技能id',
  `skillLevel` int(3) DEFAULT NULL COMMENT '技能等级',
  PRIMARY KEY (`roleId`,`skillId`),
  KEY `roleid` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色技能表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_role_title`
--

DROP TABLE IF EXISTS `easter_role_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_role_title` (
  `titleId` varchar(15) NOT NULL DEFAULT '0' COMMENT '号称ID',
  `roleId` varchar(15) NOT NULL DEFAULT '0' COMMENT '色角ID',
  `activateState` int(1) NOT NULL DEFAULT '0' COMMENT '活激状态(1:激活,0:未激活)',
  `dueTime` datetime DEFAULT NULL COMMENT '到期时间',
  `useDate` datetime DEFAULT NULL COMMENT '用使日期',
  PRIMARY KEY (`titleId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `easter_summon`
--

DROP TABLE IF EXISTS `easter_summon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easter_summon` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '召唤id',
  `targetId` varchar(15) NOT NULL COMMENT '角色ID',
  `type` int(3) NOT NULL COMMENT '召唤类型',
  `times` int(3) DEFAULT '0' COMMENT '已兑换次数',
  `lastExTime` datetime DEFAULT NULL COMMENT '上一次召唤时间',
  `expiredTime` datetime DEFAULT NULL COMMENT '召唤过期时间',
  PRIMARY KEY (`id`,`targetId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_string_id`
--

DROP TABLE IF EXISTS `idgen_string_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_string_id` (
  `appId` int(11) NOT NULL DEFAULT '0' COMMENT 'appid',
  `serverId` int(11) NOT NULL DEFAULT '0' COMMENT '服务器id',
  `endId` bigint(50) DEFAULT '0' COMMENT '当前取到的id值',
  PRIMARY KEY (`appId`,`serverId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor`
--

DROP TABLE IF EXISTS `monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor` (
  `id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-21 19:28:03

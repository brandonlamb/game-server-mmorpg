alter table easter_role_arena add column `cycleFail3v3` int(11) NOT NULL DEFAULT '0' COMMENT '33竞技场失败次数' ;
CREATE TABLE `draco_role_tower_gate` (
  `roleId` varchar(15) NOT NULL,
  `gateId` int(11) NOT NULL DEFAULT '0',
  `star` int(11) NOT NULL DEFAULT '0',
  `starAwardState` int(11) NOT NULL DEFAULT '0',
  `resetStatus` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleId`,`gateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

CREATE TABLE `draco_union_integral_state` (
  `round` int(11) NOT NULL DEFAULT '0' COMMENT '轮数',
  `grid` int(11) NOT NULL DEFAULT '0' COMMENT '排位',
  `groupId` int(11) NOT NULL COMMENT '对战组',
  `unionId` varchar(20) NOT NULL COMMENT '公会ID',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态 1胜 0平 -1负 -2轮空'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会积分战状态表';

CREATE TABLE `draco_union_integral_rank` (
  `unionId` varchar(15) NOT NULL DEFAULT '' COMMENT '公会ID',
  `integral` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`unionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会积分战排行榜';




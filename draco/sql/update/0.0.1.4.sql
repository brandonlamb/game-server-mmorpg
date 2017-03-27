CREATE TABLE `draco_union_battle_rank` (
  `roleId` int(11) NOT NULL COMMENT '角色ID',
  `killNum` int(11) DEFAULT NULL COMMENT '击杀数',
  `killedNum` int(11) DEFAULT NULL COMMENT '被击杀数',
  `dkp` int(11) DEFAULT NULL COMMENT '此公会战中的DKP获得',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='公会战排行信息表'


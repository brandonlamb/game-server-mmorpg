DROP TABLE IF EXISTS `easter_public_notice`;
ALTER TABLE `easter_role`
ADD COLUMN `prestigePoints`  int(11) NULL DEFAULT 0 COMMENT '威望' AFTER `heroCoin`,
ADD COLUMN `totalPrestigePoints`  int(11) NULL DEFAULT 0 COMMENT '累计威望' AFTER `prestigePoints`;
alter table easter_role_count add column `todayTaitan` int(11) not null default 0 ;
alter table easter_role_count add column `todayJulong` int(11) not null default 0 ;
ALTER TABLE `draco_role_talent` DROP INDEX `roleId`,ADD INDEX `roleId` (`roleId`) USING BTREE ,ENGINE=InnoDB,DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;
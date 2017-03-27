ALTER TABLE `draco_union_activity_boss_record` ADD COLUMN `lastTime`  bigint(20) NOT NULL DEFAULT 0 COMMENT '最后操作时间' AFTER `state`;
ALTER TABLE `draco_union_role_dps_record` ADD COLUMN `lastTime`  bigint(20) NOT NULL DEFAULT 0 COMMENT '最后操作时间' AFTER `data`;

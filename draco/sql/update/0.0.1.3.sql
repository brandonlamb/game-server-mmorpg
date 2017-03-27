ALTER TABLE `draco_union_integral_rank`
ADD COLUMN `oldIntegral`  int(11) NOT NULL DEFAULT 0 COMMENT '历史积分' AFTER `integral`,
ADD COLUMN `resetTime`  bigint(20) NOT NULL DEFAULT 0 COMMENT '重置时间' AFTER `oldIntegral`;


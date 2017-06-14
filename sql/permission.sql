-- 员工表
CREATE TABLE `employee` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '员工id',
  `username` varchar(32) NOT NULL COMMENT '员工账号',
  `password` varchar(32) NOT NULL COMMENT '员工密码',
  `account_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '账号状态[启用；禁用]',
  `position_id` int(11) NOT NULL DEFAULT '0' COMMENT '岗位ID',
  `position_begin_date` char(14) NOT NULL DEFAULT '00000000000000' COMMENT '岗位生效日期',
  `position_end_date` char(14) NOT NULL DEFAULT '99999999999999' COMMENT '岗位失效日期',  

  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '员工姓名',
  `mobile` varchar(128) NOT NULL DEFAULT '' COMMENT '手机号',
  `telphone` varchar(128) NOT NULL DEFAULT '' COMMENT '座机',
  `email` varchar(128) NOT NULL DEFAULT '' COMMENT '员工邮箱',
  `sex` char(1) DEFAULT NULL COMMENT '员工性别',
  `entry_date` char(8) NOT NULL DEFAULT '00000000' COMMENT '入职日期',
  `leave_date` char(8) NOT NULL DEFAULT '00000000' COMMENT '离职日期',
  `certificate_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '证件类型',
  `certificate_card` varchar(18) NOT NULL DEFAULT '' COMMENT '证件号码',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '员工状态[试用；正式；离职]',
  `formal_date` char(8) NOT NULL DEFAULT '00000000' COMMENT '转正日期',
  `photo_fs_id` varchar(64) NOT NULL DEFAULT '' COMMENT '员工图像在文件系统中的唯一标识',

  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifytime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleteflag` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`)
) COMMENT='员工信息表'



-- 角色表
CREATE TABLE `role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类信息，角色分类表id',
  `name` varchar(32) NOT NULL COMMENT '角色名字',
  `memo` varchar(256) DEFAULT '' COMMENT '角色备注',

  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifytime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleteflag` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_NAME` (`name`)
) COMMENT='角色表'



-- 角色分类表
CREATE TABLE `role_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色分类id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `memo` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',

  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifytime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleteflag` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`)
) COMMENT='角色分类表'



-- 权限编码表，资源url跟权限编码的关系在项目的properties文件中配置，为保证code唯一，约定组成：项目名_文件名_模块功能
CREATE TABLE `permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(256) NOT NULL COMMENT '权限code',
  `memo` varchar(256) NOT NULL DEFAULT '' COMMENT '权限备注',
  `group` varchar(40) NOT NULL DEFAULT '' COMMENT '权限组',

  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifytime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleteflag` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`)
) COMMENT='权限编码表'



-- 角色与权限关系表
CREATE TABLE `role_permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) unsigned NOT NULL COMMENT '角色id',
  `permission_id` int(11) unsigned NOT NULL COMMENT '权限id',

  `level` tinyint(3) NOT NULL COMMENT '数据级权限控制依据：权限级别[系统级;部门及子部门;部门级;用户及下属级;用户级;自定义]',

  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifytime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleteflag` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`)
) COMMENT='角色权限关系表'



-- 人员与角色关系表
CREATE TABLE `employee_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '员工id',
  `role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',

  `effect_begin_date` char(8) NOT NULL DEFAULT '00000000' COMMENT '服务开始日期',
  `effect_end_date` char(8) NOT NULL DEFAULT '99999999' COMMENT '服务结束时间',

  `creator_id` int(11) NOT NULL DEFAULT '0' COMMENT '数据级权限控制依据：当前维护人员ID',
  `org_id` int(11) NOT NULL DEFAULT '0' COMMENT '数据级权限控制依据：当前维护人所在部门',

  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modifytime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleteflag` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`)
) COMMENT='用户角色分配表'
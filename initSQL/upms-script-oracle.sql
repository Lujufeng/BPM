-- ----------------------------
-- 请仅在下面的数据库链接中执行该脚本。
-- 主数据源 [47.100.197.208:1521/ORCL]
-- ----------------------------

SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE NONE

-- ----------------------------
-- 系统角色表
-- ----------------------------
DROP TABLE og_sys_role;
CREATE TABLE og_sys_role (
  role_id NUMBER(19) NOT NULL,
  role_name VARCHAR2(64) NOT NULL,
  create_user_id NUMBER(19) NOT NULL,
  create_time TIMESTAMP NOT NULL,
  update_user_id NUMBER(19) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  deleted_flag NUMBER(10) NOT NULL,
  CONSTRAINT PK_ROLE_ID PRIMARY KEY (role_id)
);

COMMENT ON COLUMN og_sys_role.role_id IS '主键Id';
COMMENT ON COLUMN og_sys_role.role_name IS '角色名称';
COMMENT ON COLUMN og_sys_role.create_user_id IS '创建者Id';
COMMENT ON COLUMN og_sys_role.create_time IS '创建时间';
COMMENT ON COLUMN og_sys_role.update_user_id IS '更新者Id';
COMMENT ON COLUMN og_sys_role.update_time IS '最后更新时间';
COMMENT ON COLUMN og_sys_role.deleted_flag IS '逻辑删除标记(0: 正常 1: 已删除)';
COMMENT ON TABLE og_sys_role IS '系统角色表';

-- ----------------------------
-- 用户与角色对应关系表
-- ----------------------------
DROP TABLE og_sys_user_role;
CREATE TABLE og_sys_user_role (
  user_id NUMBER(19) NOT NULL,
  role_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_USER_ID_ROLE_ID PRIMARY KEY (user_id, role_id)
);

COMMENT ON COLUMN og_sys_user_role.user_id IS '用户Id';
COMMENT ON COLUMN og_sys_user_role.role_id IS '角色Id';
COMMENT ON TABLE og_sys_user_role IS '用户与角色对应关系表';

CREATE INDEX idx_user_role_role_id
  ON og_sys_user_role (role_id);

-- ----------------------------
-- 菜单和操作权限管理表
-- ----------------------------
DROP TABLE og_sys_menu;
CREATE TABLE og_sys_menu (
  menu_id NUMBER(19) NOT NULL,
  parent_id NUMBER(19),
  menu_name VARCHAR2(50) NOT NULL,
  menu_type NUMBER(10) NOT NULL,
  form_router_name VARCHAR2(64),
  online_form_id NUMBER(19),
  online_menu_perm_type NUMBER(10),
  online_flow_entry_id NUMBER(19),
  show_order NUMBER(10) NOT NULL,
  icon VARCHAR2(50),
  create_user_id NUMBER(19) NOT NULL,
  create_time TIMESTAMP NOT NULL,
  update_user_id NUMBER(19) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  deleted_flag NUMBER(10) NOT NULL,
  CONSTRAINT PK_MENU_ID PRIMARY KEY (menu_id)
);

COMMENT ON COLUMN og_sys_menu.menu_id IS '主键Id';
COMMENT ON COLUMN og_sys_menu.parent_id IS '父菜单Id，目录菜单的父菜单为null';
COMMENT ON COLUMN og_sys_menu.menu_name IS '菜单显示名称';
COMMENT ON COLUMN og_sys_menu.menu_type IS '(0: 目录 1: 菜单 2: 按钮 3: UI片段)';
COMMENT ON COLUMN og_sys_menu.form_router_name IS '前端表单路由名称，仅用于menu_type为1的菜单类型';
COMMENT ON COLUMN og_sys_menu.online_form_id IS '在线表单主键Id';
COMMENT ON COLUMN og_sys_menu.online_menu_perm_type IS '在线表单菜单的权限控制类型';
COMMENT ON COLUMN og_sys_menu.online_flow_entry_id IS '仅用于在线表单的流程Id';
COMMENT ON COLUMN og_sys_menu.show_order IS '菜单显示顺序 (值越小，排序越靠前)';
COMMENT ON COLUMN og_sys_menu.icon IS '菜单图标';
COMMENT ON COLUMN og_sys_menu.create_user_id IS '创建者Id';
COMMENT ON COLUMN og_sys_menu.create_time IS '创建时间';
COMMENT ON COLUMN og_sys_menu.update_user_id IS '更新者Id';
COMMENT ON COLUMN og_sys_menu.update_time IS '最后更新时间';
COMMENT ON COLUMN og_sys_menu.deleted_flag IS '删除标记(0: 正常 1: 已删除)';
COMMENT ON TABLE og_sys_menu IS '菜单和操作权限管理表';

CREATE INDEX idx_menu_parent_id
  ON og_sys_menu (parent_id);

CREATE INDEX idx_menu_show_order
  ON og_sys_menu (show_order);

-- ----------------------------
-- 角色与菜单对应关系表
-- ----------------------------
DROP TABLE og_sys_role_menu;
CREATE TABLE og_sys_role_menu (
  role_id NUMBER(19) NOT NULL,
  menu_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_ROLE_ID_MENU_ID PRIMARY KEY (role_id, menu_id)
);

COMMENT ON COLUMN og_sys_role_menu.role_id IS '角色Id';
COMMENT ON COLUMN og_sys_role_menu.menu_id IS '菜单Id';
COMMENT ON TABLE og_sys_role_menu IS '角色与菜单对应关系表';

CREATE INDEX idx_role_menu_menu_id
  ON og_sys_role_menu (menu_id);

-- ----------------------------
-- Table structure for og_sys_perm_code
-- ----------------------------
DROP TABLE og_sys_perm_code;
CREATE TABLE og_sys_perm_code (
  perm_code_id NUMBER(19) NOT NULL,
  parent_id NUMBER(19),
  perm_code VARCHAR2(128) NOT NULL,
  perm_code_type NUMBER(10) NOT NULL,
  show_name VARCHAR2(128) NOT NULL,
  show_order NUMBER(10) NOT NULL,
  create_user_id NUMBER(19) NOT NULL,
  create_time TIMESTAMP NOT NULL,
  update_user_id NUMBER(19) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  deleted_flag NUMBER(10) NOT NULL,
  CONSTRAINT PK_PERM_CODE_PERM_CODE_ID PRIMARY KEY (perm_code_id)
);

COMMENT ON COLUMN og_sys_perm_code.perm_code_id IS '主键Id';
COMMENT ON COLUMN og_sys_perm_code.parent_id IS '上级权限字Id';
COMMENT ON COLUMN og_sys_perm_code.perm_code IS '权限字标识(一般为有含义的英文字符串)';
COMMENT ON COLUMN og_sys_perm_code.perm_code_type IS '类型(0: 表单 1: UI片段 2: 操作)';
COMMENT ON COLUMN og_sys_perm_code.show_name IS '显示名称';
COMMENT ON COLUMN og_sys_perm_code.show_order IS '显示顺序(数值越小，越靠前)';
COMMENT ON COLUMN og_sys_perm_code.create_user_id IS '创建者Id';
COMMENT ON COLUMN og_sys_perm_code.create_time IS '创建时间';
COMMENT ON COLUMN og_sys_perm_code.update_user_id IS '更新者Id';
COMMENT ON COLUMN og_sys_perm_code.update_time IS '最后更新时间';
COMMENT ON COLUMN og_sys_perm_code.deleted_flag IS '逻辑删除标记(0: 正常 1: 已删除)';
COMMENT ON TABLE og_sys_perm_code IS '系统权限资源表';

CREATE INDEX idx_perm_code_parent_id
  ON og_sys_perm_code (parent_id);

CREATE UNIQUE INDEX idx_perm_code_perm_code
  ON og_sys_perm_code (perm_code);

CREATE INDEX idx_perm_code_show_order
  ON og_sys_perm_code (show_order);

-- ----------------------------
-- 菜单和权限关系表
-- ----------------------------
DROP TABLE og_sys_menu_perm_code;
CREATE TABLE og_sys_menu_perm_code (
  menu_id NUMBER(19) NOT NULL,
  perm_code_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_MENU_ID_PERM_CODE_ID PRIMARY KEY (menu_id, perm_code_id)
);

COMMENT ON COLUMN og_sys_menu_perm_code.menu_id IS '关联菜单Id';
COMMENT ON COLUMN og_sys_menu_perm_code.perm_code_id IS '关联权限字Id';
COMMENT ON TABLE og_sys_menu_perm_code IS '菜单和权限关系表';

CREATE INDEX idx_mpc_perm_code_id
  ON og_sys_menu_perm_code (perm_code_id);

-- ----------------------------
-- 系统权限模块表
-- ----------------------------
DROP TABLE og_sys_perm_module;
CREATE TABLE og_sys_perm_module (
  module_id NUMBER(19) NOT NULL,
  parent_id NUMBER(19),
  module_name VARCHAR2(64) NOT NULL,
  module_type NUMBER(10) NOT NULL,
  show_order NUMBER(10) NOT NULL,
  create_user_id NUMBER(19) NOT NULL,
  create_time TIMESTAMP NOT NULL,
  update_user_id NUMBER(19) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  deleted_flag NUMBER(10) NOT NULL,
  CONSTRAINT PK_MODULE_ID PRIMARY KEY (module_id)
);

COMMENT ON COLUMN og_sys_perm_module.module_id IS '权限模块id';
COMMENT ON COLUMN og_sys_perm_module.parent_id IS '上级权限模块id';
COMMENT ON COLUMN og_sys_perm_module.module_name IS '权限模块名称';
COMMENT ON COLUMN og_sys_perm_module.module_type IS '模块类型(0: 普通模块 1: Controller模块)';
COMMENT ON COLUMN og_sys_perm_module.show_order IS '权限模块在当前层级下的顺序，由小到大';
COMMENT ON COLUMN og_sys_perm_module.create_user_id IS '创建者Id';
COMMENT ON COLUMN og_sys_perm_module.create_time IS '创建时间';
COMMENT ON COLUMN og_sys_perm_module.update_user_id IS '更新者Id';
COMMENT ON COLUMN og_sys_perm_module.update_time IS '最后更新时间';
COMMENT ON COLUMN og_sys_perm_module.deleted_flag IS '逻辑删除标记(0: 正常 1: 已删除)';
COMMENT ON TABLE og_sys_perm_module IS '系统权限模块表';

CREATE INDEX idx_perm_module_module_type
  ON og_sys_perm_module (module_type);

CREATE INDEX idx_perm_module_parent_id
  ON og_sys_perm_module (parent_id);

CREATE INDEX idx_perm_module_show_order
  ON og_sys_perm_module (show_order);

-- ----------------------------
-- 系统权限表
-- ----------------------------
DROP TABLE og_sys_perm;
CREATE TABLE og_sys_perm (
  perm_id NUMBER(19) NOT NULL,
  module_id NUMBER(19) NOT NULL,
  perm_name VARCHAR2(64) NOT NULL,
  url VARCHAR2(128) NOT NULL,
  show_order NUMBER(10) NOT NULL,
  create_user_id NUMBER(19) NOT NULL,
  create_time TIMESTAMP NOT NULL,
  update_user_id NUMBER(19) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  deleted_flag NUMBER(10) NOT NULL,
  CONSTRAINT PK_PERM_PERM_ID PRIMARY KEY (perm_id)
);

COMMENT ON COLUMN og_sys_perm.perm_id IS '权限id';
COMMENT ON COLUMN og_sys_perm.module_id IS '权限所在的权限模块id';
COMMENT ON COLUMN og_sys_perm.perm_name IS '权限名称';
COMMENT ON COLUMN og_sys_perm.url IS '关联的url';
COMMENT ON COLUMN og_sys_perm.show_order IS '权限在当前模块下的顺序，由小到大';
COMMENT ON COLUMN og_sys_perm.create_user_id IS '创建者Id';
COMMENT ON COLUMN og_sys_perm.create_time IS '创建时间';
COMMENT ON COLUMN og_sys_perm.update_user_id IS '更新者Id';
COMMENT ON COLUMN og_sys_perm.update_time IS '最后更新时间';
COMMENT ON COLUMN og_sys_perm.deleted_flag IS '逻辑删除标记(0: 正常 1: 已删除)';
COMMENT ON TABLE og_sys_perm IS '系统权限表';

CREATE INDEX idx_perm_module_id
  ON og_sys_perm (module_id);

CREATE INDEX idx_perm_show_order
  ON og_sys_perm (show_order);

-- ----------------------------
-- 系统权限字和权限资源关联表
-- ----------------------------
DROP TABLE og_sys_perm_code_perm;
CREATE TABLE og_sys_perm_code_perm (
  perm_code_id NUMBER(19) NOT NULL,
  perm_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_PERM_CODE_ID_PERM_ID PRIMARY KEY (perm_code_id, perm_id)
);

COMMENT ON COLUMN og_sys_perm_code_perm.perm_code_id IS '权限字Id';
COMMENT ON COLUMN og_sys_perm_code_perm.perm_id IS '权限id';
COMMENT ON TABLE og_sys_perm_code_perm IS '系统权限字和权限资源关联表';

CREATE INDEX idx_perm_code_perm_perm_id
  ON og_sys_perm_code_perm (perm_id);

-- ----------------------------
-- 权限资源白名单表
-- ----------------------------
DROP TABLE og_sys_perm_whitelist;
CREATE TABLE og_sys_perm_whitelist (
  perm_url VARCHAR2(512) NOT NULL,
  module_name VARCHAR2(64),
  perm_name VARCHAR2(64),
  CONSTRAINT PK_PERM_URL PRIMARY KEY (perm_url)
);

COMMENT ON COLUMN og_sys_perm_whitelist.perm_url IS '权限资源的url';
COMMENT ON COLUMN og_sys_perm_whitelist.module_name IS '权限资源所属模块名字(通常是Controller的名字)';
COMMENT ON COLUMN og_sys_perm_whitelist.perm_name IS '权限的名称';
COMMENT ON TABLE og_sys_perm_whitelist IS '权限资源白名单表(认证用户均可访问的url资源)';

-- ----------------------------
-- 数据权限表
-- ----------------------------
DROP TABLE og_sys_data_perm;
CREATE TABLE og_sys_data_perm (
  data_perm_id NUMBER(19) NOT NULL,
  data_perm_name VARCHAR2(64) NOT NULL,
  rule_type NUMBER(10) NOT NULL,
  create_user_id NUMBER(19) NOT NULL,
  create_time TIMESTAMP NOT NULL,
  update_user_id NUMBER(19) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  deleted_flag NUMBER(10) NOT NULL,
  CONSTRAINT PK_DATA_PERM_ID PRIMARY KEY (data_perm_id)
);

COMMENT ON COLUMN og_sys_data_perm.data_perm_id IS '主键';
COMMENT ON COLUMN og_sys_data_perm.data_perm_name IS '显示名称';
COMMENT ON COLUMN og_sys_data_perm.rule_type IS '数据权限规则类型';
COMMENT ON COLUMN og_sys_data_perm.create_user_id IS '创建者Id';
COMMENT ON COLUMN og_sys_data_perm.create_time IS '创建时间';
COMMENT ON COLUMN og_sys_data_perm.update_user_id IS '更新者Id';
COMMENT ON COLUMN og_sys_data_perm.update_time IS '最后更新时间';
COMMENT ON COLUMN og_sys_data_perm.deleted_flag IS '逻辑删除标记(0: 正常 1: 已删除)';
COMMENT ON TABLE og_sys_data_perm  IS '数据权限表';

CREATE INDEX idx_data_perm_create_time
  ON og_sys_data_perm (create_time);

-- ----------------------------
-- 数据权限和用户关联表
-- ----------------------------
DROP TABLE og_sys_data_perm_user;
CREATE TABLE og_sys_data_perm_user (
  data_perm_id NUMBER(19) NOT NULL,
  user_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_DATA_PERM_ID_USER_ID PRIMARY KEY (data_perm_id, user_id)
);

COMMENT ON COLUMN og_sys_data_perm_user.data_perm_id IS '数据权限Id';
COMMENT ON COLUMN og_sys_data_perm_user.user_id IS '用户Id';
COMMENT ON TABLE og_sys_data_perm_user IS '数据权限和用户关联表';

CREATE INDEX idx_data_perm_user_user_id
  ON og_sys_data_perm_user (user_id);

-- ----------------------------
-- 数据权限和部门关联表
-- ----------------------------
DROP TABLE og_sys_data_perm_dept;
CREATE TABLE og_sys_data_perm_dept (
  data_perm_id NUMBER(19) NOT NULL,
  dept_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_DATA_PERM_ID_DEPT_ID PRIMARY KEY (data_perm_id, dept_id)
);

COMMENT ON COLUMN og_sys_data_perm_dept.data_perm_id IS '数据权限Id';
COMMENT ON COLUMN og_sys_data_perm_dept.dept_id IS '部门Id';
COMMENT ON TABLE og_sys_data_perm_dept IS '数据权限和部门关联表';

CREATE INDEX idx_data_perm_dept_dept_id
  ON og_sys_data_perm_dept (dept_id);

-- ----------------------------
-- 所有微服务集中存储的系统操作日志表，请在专门的操作日志数据库中执行该脚本。
-- ----------------------------
DROP TABLE og_sys_operation_log;
CREATE TABLE og_sys_operation_log (
  log_id NUMBER(19) NOT NULL,
  description VARCHAR2(255),
  operation_type NUMBER(10),
  service_name VARCHAR2(128),
  api_class VARCHAR2(255),
  api_method VARCHAR2(255),
  session_id VARCHAR2(255),
  trace_id VARCHAR2(32),
  elapse NUMBER(10),
  request_method VARCHAR2(32),
  request_url VARCHAR2(255),
  request_arguments CLOB,
  response_result CLOB,
  request_ip VARCHAR2(32),
  success NUMBER(10) DEFAULT 0,
  error_msg CLOB,
  tenant_id NUMBER(19),
  operator_id NUMBER(19),
  operator_name VARCHAR2(255),
  operation_time TIMESTAMP,
  CONSTRAINT PK_OPERATION_LOG_LOG_ID PRIMARY KEY (log_id)
);

COMMENT ON COLUMN og_sys_operation_log.log_id IS '主键Id';
COMMENT ON COLUMN og_sys_operation_log.description IS '日志描述';
COMMENT ON COLUMN og_sys_operation_log.operation_type IS '操作类型';
COMMENT ON COLUMN og_sys_operation_log.service_name IS '接口所在服务名称';
COMMENT ON COLUMN og_sys_operation_log.api_class IS '调用的controller全类名';
COMMENT ON COLUMN og_sys_operation_log.api_method IS '调用的controller中的方法';
COMMENT ON COLUMN og_sys_operation_log.session_id IS '用户会话sessionId';
COMMENT ON COLUMN og_sys_operation_log.trace_id IS '每次请求的Id';
COMMENT ON COLUMN og_sys_operation_log.elapse IS '调用时长';
COMMENT ON COLUMN og_sys_operation_log.request_method IS 'HTTP 请求方法，如GET';
COMMENT ON COLUMN og_sys_operation_log.request_url IS 'HTTP 请求地址';
COMMENT ON COLUMN og_sys_operation_log.request_arguments IS 'controller接口参数';
COMMENT ON COLUMN og_sys_operation_log.response_result IS 'controller应答结果';
COMMENT ON COLUMN og_sys_operation_log.request_ip IS '请求IP';
COMMENT ON COLUMN og_sys_operation_log.success IS '应答状态';
COMMENT ON COLUMN og_sys_operation_log.error_msg IS '错误信息';
COMMENT ON COLUMN og_sys_operation_log.tenant_id IS '租户Id';
COMMENT ON COLUMN og_sys_operation_log.operator_id IS '操作员Id';
COMMENT ON COLUMN og_sys_operation_log.operator_name IS '操作员名称';
COMMENT ON COLUMN og_sys_operation_log.operation_time IS '操作时间';
COMMENT ON TABLE og_sys_operation_log IS '系统操作日志表';

CREATE INDEX idx_op_log_elapse
  ON og_sys_operation_log (elapse);

CREATE INDEX idx_op_log_operation_time
  ON og_sys_operation_log (operation_time);

CREATE INDEX idx_op_log_operation_type
  ON og_sys_operation_log (operation_type);

CREATE INDEX idx_op_log_success
  ON og_sys_operation_log (success);

CREATE INDEX idx_op_log_trace_id
  ON og_sys_operation_log (trace_id);

-- ----------------------------
-- 管理员账号数据
-- ----------------------------

create public database link FAB2USERADM    
 connect to "C##FAB2USERADM" identified by "123456"  
 using '(DESCRIPTION =(ADDRESS_LIST =(ADDRESS =(PROTOCOL = TCP)(HOST = 192.168.2.72)(PORT = 1521)))(CONNECT_DATA =(SERVICE_NAME = orcl)))';
 
CREATE VIEW "OG_SYS_USER" AS select * from OG_SYS_USER@FAB2USERADM;
CREATE VIEW "OG_SYS_DEPT" AS select * from OG_SYS_DEPT@FAB2USERADM;
CREATE VIEW "OG_SYS_DEPT_POST" AS select * from OG_SYS_DEPT_POST@FAB2USERADM;
CREATE VIEW "OG_SYS_DEPT_RELATION" AS select * from OG_SYS_DEPT_RELATION@FAB2USERADM;
CREATE VIEW "OG_SYS_POST" AS select * from OG_SYS_POST@FAB2USERADM;
CREATE VIEW "OG_SYS_USER_POST" AS select * from OG_SYS_USER_POST@FAB2USERADM;
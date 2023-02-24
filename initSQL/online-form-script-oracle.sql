-- ----------------------------
-- 一定要在与upms相同的数据库中执行该脚本。
-- ----------------------------

SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE NONE

-- ----------------------------
-- Table structure for og_online_column
-- ----------------------------
DROP TABLE og_online_column;
CREATE TABLE og_online_column (
  column_id NUMBER(19) NOT NULL,
  column_name VARCHAR2(64) NOT NULL,
  table_id NUMBER(19) NOT NULL,
  column_type VARCHAR2(32) NOT NULL,
  full_column_type VARCHAR2(32) NOT NULL,
  primary_key NUMBER(10) NOT NULL,
  auto_increment NUMBER(10) NOT NULL,
  nullable NUMBER(10) NOT NULL,
  column_default VARCHAR2(255),
  column_show_order NUMBER(10) NOT NULL,
  column_comment VARCHAR2(255),
  object_field_name VARCHAR2(255) NOT NULL,
  object_field_type VARCHAR2(32) NOT NULL,
  numeric_precision NUMBER(10),
  numeric_scale NUMBER(10),
  filter_type NUMBER(10) NOT NULL,
  parent_key NUMBER(10) NOT NULL,
  dept_filter NUMBER(10) NOT NULL,
  user_filter NUMBER(10) NOT NULL,
  field_kind NUMBER(10),
  max_file_count NUMBER(10),
  upload_file_system_type NUMBER(10) NOT NULL,
  encoded_rule VARCHAR2(4000),
  dict_id NUMBER(19),
  update_time TIMESTAMP NOT NULL,
  create_time TIMESTAMP NOT NULL,
  field_link_json CLOB, 
  CONSTRAINT PK_ONLINE_COLUMN_ID PRIMARY KEY (column_id)
);

COMMENT ON COLUMN og_online_column.column_id IS '主键Id';
COMMENT ON COLUMN og_online_column.column_name IS '字段名';
COMMENT ON COLUMN og_online_column.table_id IS '数据表Id';
COMMENT ON COLUMN og_online_column.column_type IS '数据表中的字段类型';
COMMENT ON COLUMN og_online_column.full_column_type IS '数据表中的完整字段类型(包括了精度和刻度)';
COMMENT ON COLUMN og_online_column.primary_key IS '是否为主键';
COMMENT ON COLUMN og_online_column.auto_increment IS '是否是自增主键(0: 不是 1: 是)';
COMMENT ON COLUMN og_online_column.nullable IS '是否可以为空 (0: 不可以为空 1: 可以为空)';
COMMENT ON COLUMN og_online_column.column_default IS '缺省值';
COMMENT ON COLUMN og_online_column.column_show_order IS '字段在数据表中的显示位置';
COMMENT ON COLUMN og_online_column.column_comment IS '数据表中的字段注释';
COMMENT ON COLUMN og_online_column.object_field_name IS '对象映射字段名称';
COMMENT ON COLUMN og_online_column.object_field_type IS '对象映射字段类型';
COMMENT ON COLUMN og_online_column.numeric_precision IS '数值型字段的精度';
COMMENT ON COLUMN og_online_column.numeric_scale IS '数值型字段的刻度';
COMMENT ON COLUMN og_online_column.filter_type IS '字段过滤类型';
COMMENT ON COLUMN og_online_column.parent_key IS '是否是主键的父Id';
COMMENT ON COLUMN og_online_column.dept_filter IS '是否部门过滤字段';
COMMENT ON COLUMN og_online_column.user_filter IS '是否用户过滤字段';
COMMENT ON COLUMN og_online_column.field_kind IS '字段类别';
COMMENT ON COLUMN og_online_column.max_file_count IS '包含的文件文件数量，0表示无限制';
COMMENT ON COLUMN og_online_column.upload_file_system_type IS '上传文件系统类型';
COMMENT ON COLUMN og_online_column.encoded_rule IS '编码规则的JSON格式数据';
COMMENT ON COLUMN og_online_column.dict_id IS '字典Id';
COMMENT ON COLUMN og_online_column.update_time IS '更新时间';
COMMENT ON COLUMN og_online_column.create_time IS '创建时间';

CREATE INDEX idx_online_column_dict_id
  ON og_online_column (dict_id);

CREATE INDEX idx_online_column_table_id
  ON og_online_column (table_id);

-- ----------------------------
-- Table structure for og_online_column_rule
-- ----------------------------
DROP TABLE og_online_column_rule;
CREATE TABLE og_online_column_rule (
  column_id NUMBER(19) NOT NULL,
  rule_id NUMBER(19) NOT NULL,
  prop_data_json CLOB,
  CONSTRAINT PK_ONLINE_COLUMN_ID_RULE_ID PRIMARY KEY (column_id, rule_id)
);

COMMENT ON COLUMN og_online_column_rule.column_id IS '字段Id';
COMMENT ON COLUMN og_online_column_rule.rule_id IS '规则Id';
COMMENT ON COLUMN og_online_column_rule.prop_data_json IS '规则属性数据';

CREATE INDEX idx_online_col_rule_rule_id
  ON og_online_column_rule (rule_id);

-- ----------------------------
-- Table structure for og_online_datasource
-- ----------------------------
DROP TABLE og_online_datasource;
CREATE TABLE og_online_datasource (
  datasource_id NUMBER(19) NOT NULL,
  datasource_name VARCHAR2(64) NOT NULL,
  variable_name VARCHAR2(64) NOT NULL,
  dblink_id NUMBER(19) NOT NULL,
  master_table_id NUMBER(19) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  create_time TIMESTAMP NOT NULL,
  CONSTRAINT PK_ONLINE_DATASOURCE_ID PRIMARY KEY (datasource_id)
);

COMMENT ON COLUMN og_online_datasource.datasource_id IS '主键Id';
COMMENT ON COLUMN og_online_datasource.datasource_name IS '数据源名称';
COMMENT ON COLUMN og_online_datasource.variable_name IS '数据源变量名';
COMMENT ON COLUMN og_online_datasource.dblink_id IS '数据库链接Id';
COMMENT ON COLUMN og_online_datasource.master_table_id IS '主表Id';
COMMENT ON COLUMN og_online_datasource.update_time IS '更新时间';
COMMENT ON COLUMN og_online_datasource.create_time IS '创建时间';

CREATE INDEX idx_online_ds_master_table_id
  ON og_online_datasource (master_table_id);

CREATE UNIQUE INDEX idx_online_ds_variable_name
  ON og_online_datasource (variable_name);

-- ----------------------------
-- Table structure for og_online_datasource_relation
-- ----------------------------
DROP TABLE og_online_datasource_relation;
CREATE TABLE og_online_datasource_relation (
  relation_id NUMBER(19) NOT NULL,
  relation_name VARCHAR2(64) NOT NULL,
  variable_name VARCHAR2(128) NOT NULL,
  datasource_id NUMBER(19) NOT NULL,
  relation_type NUMBER(10) NOT NULL,
  master_column_id NUMBER(19) NOT NULL,
  slave_table_id NUMBER(19) NOT NULL,
  slave_column_id NUMBER(19) NOT NULL,
  cascade_delete NUMBER(10) NOT NULL,
  left_join NUMBER(10) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  create_time TIMESTAMP NOT NULL,
  CONSTRAINT PK_ONLINE_RELATION_ID PRIMARY KEY (relation_id)
);

COMMENT ON COLUMN og_online_datasource_relation.relation_id IS '主键Id';
COMMENT ON COLUMN og_online_datasource_relation.relation_name IS '关联名称';
COMMENT ON COLUMN og_online_datasource_relation.variable_name IS '变量名';
COMMENT ON COLUMN og_online_datasource_relation.datasource_id IS '主数据源Id';
COMMENT ON COLUMN og_online_datasource_relation.relation_type IS '关联类型';
COMMENT ON COLUMN og_online_datasource_relation.master_column_id IS '主表关联字段Id';
COMMENT ON COLUMN og_online_datasource_relation.slave_table_id IS '从表Id';
COMMENT ON COLUMN og_online_datasource_relation.slave_column_id IS '从表关联字段Id';
COMMENT ON COLUMN og_online_datasource_relation.cascade_delete IS '删除主表的时候是否级联删除一对一和一对多的从表数据，多对多只是删除关联，不受到这个标记的影响。';
COMMENT ON COLUMN og_online_datasource_relation.left_join IS '是否左连接';
COMMENT ON COLUMN og_online_datasource_relation.update_time IS '更新时间';
COMMENT ON COLUMN og_online_datasource_relation.create_time IS '创建时间';

CREATE INDEX idx_online_ds_relation_ds_id
  ON og_online_datasource_relation (datasource_id);

-- ----------------------------
-- Table structure for og_online_datasource_table
-- ----------------------------
DROP TABLE og_online_datasource_table;
CREATE TABLE og_online_datasource_table (
  id NUMBER(19) NOT NULL,
  datasource_id NUMBER(19) NOT NULL,
  relation_id NUMBER(19),
  table_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_ONLINE_DATASOURCE_TABLE_ID PRIMARY KEY (id)
);

COMMENT ON COLUMN og_online_datasource_table.id IS '主键Id';
COMMENT ON COLUMN og_online_datasource_table.datasource_id IS '数据源Id';
COMMENT ON COLUMN og_online_datasource_table.relation_id IS '数据源关联Id';
COMMENT ON COLUMN og_online_datasource_table.table_id IS '数据表Id';

CREATE INDEX idx_online_ds_table_ds_id
  ON og_online_datasource_table (datasource_id);

CREATE INDEX idx_online_ds_table_rel_id
  ON og_online_datasource_table (relation_id);

CREATE INDEX idx_online_ds_table_table_id
  ON og_online_datasource_table (table_id);

-- ----------------------------
-- Table structure for og_online_dblink
-- ----------------------------
DROP TABLE og_online_dblink;
CREATE TABLE og_online_dblink (
  dblink_id NUMBER(19) NOT NULL,
  dblink_name VARCHAR2(64) NOT NULL,
  variable_name VARCHAR2(64) NOT NULL,
  dblink_desc VARCHAR2(512),
  dblink_config_constant NUMBER(10) NOT NULL,
  create_time TIMESTAMP NOT NULL,
  CONSTRAINT PK_ONLINE_DBLINK_ID PRIMARY KEY (dblink_id)
);

COMMENT ON COLUMN og_online_dblink.dblink_id IS '主键Id';
COMMENT ON COLUMN og_online_dblink.dblink_name IS '链接中文名称';
COMMENT ON COLUMN og_online_dblink.variable_name IS '链接英文名称';
COMMENT ON COLUMN og_online_dblink.dblink_desc IS '链接描述';
COMMENT ON COLUMN og_online_dblink.dblink_config_constant IS '数据源配置常量';
COMMENT ON COLUMN og_online_dblink.create_time IS '创建时间';

-- ----------------------------
-- 为 og_online_dblink 插入一条缺省数据。出于安全考虑，前端没有提供dblink的配置接口，因此，推荐手动维护。
-- 有关 dblink_config_constant 字段的数值，可参考在线文档。
-- ----------------------------

INSERT INTO og_online_dblink VALUES (1, 'first', 'first', '第一个链接', 0, sysdate);
COMMIT;

-- ----------------------------
-- Table structure for og_online_dict
-- ----------------------------
DROP TABLE og_online_dict;
CREATE TABLE og_online_dict (
  dict_id NUMBER(19) NOT NULL,
  dict_name VARCHAR2(64) NOT NULL,
  dict_type NUMBER(10) NOT NULL,
  dict_code VARCHAR2(50),
  dblink_id NUMBER(19),
  table_name VARCHAR2(64),
  key_column_name VARCHAR2(64),
  parent_key_column_name VARCHAR2(64),
  value_column_name VARCHAR2(64),
  deleted_column_name VARCHAR2(64),
  user_filter_column_name VARCHAR2(64),
  dept_filter_column_name VARCHAR2(64),
  tenant_filter_column_name VARCHAR2(64),
  tree_flag NUMBER(10) NOT NULL,
  dict_list_url VARCHAR2(512),
  dict_ids_url VARCHAR2(512),
  dict_data_json CLOB,
  update_time TIMESTAMP NOT NULL,
  create_time TIMESTAMP NOT NULL,
  CONSTRAINT PK_ONLINE_DICT_ID PRIMARY KEY (dict_id)
);

COMMENT ON COLUMN og_online_dict.dict_id IS '主键Id';
COMMENT ON COLUMN og_online_dict.dict_name IS '字典名称';
COMMENT ON COLUMN og_online_dict.dict_type IS '字典类型';
COMMENT ON COLUMN og_online_dict.dict_code IS '字典CODE';
COMMENT ON COLUMN og_online_dict.dblink_id IS '数据库链接Id';
COMMENT ON COLUMN og_online_dict.table_name IS '字典表名称';
COMMENT ON COLUMN og_online_dict.key_column_name IS '字典表键字段名称';
COMMENT ON COLUMN og_online_dict.parent_key_column_name IS '字典表父键字段名称';
COMMENT ON COLUMN og_online_dict.value_column_name IS '字典值字段名称';
COMMENT ON COLUMN og_online_dict.deleted_column_name IS '逻辑删除字段';
COMMENT ON COLUMN og_online_dict.user_filter_column_name IS '用户过滤滤字段名称';
COMMENT ON COLUMN og_online_dict.dept_filter_column_name IS 'dept_filter_column_name';
COMMENT ON COLUMN og_online_dict.tenant_filter_column_name IS '租户过滤字段名称';
COMMENT ON COLUMN og_online_dict.tree_flag IS '是否树形标记';
COMMENT ON COLUMN og_online_dict.dict_list_url IS '获取字典列表数据的url';
COMMENT ON COLUMN og_online_dict.dict_ids_url IS '根据主键id批量获取字典数据的url';
COMMENT ON COLUMN og_online_dict.dict_data_json IS '字典的JSON数据';
COMMENT ON COLUMN og_online_dict.update_time IS '更新时间';
COMMENT ON COLUMN og_online_dict.create_time IS '创建时间';


-- ----------------------------
-- Table structure for OG_ONLINE_DICT_COLUMN
-- ----------------------------
DROP TABLE "OG_ONLINE_DICT_COLUMN";
CREATE TABLE "OG_ONLINE_DICT_COLUMN" (
  "COLUMN_ID" NUMBER(19) NOT NULL ,
  "DICT_ID" NUMBER(19) NOT NULL ,
  "COLUMN_FIELD" VARCHAR2(255 BYTE) ,
  "COLUMN_NAME" VARCHAR2(255 BYTE) ,
  "ORDER_BY" NUMBER(10) ,
  CONSTRAINT PK_OG_ONLINE_DICT_COLUMN_ID PRIMARY KEY (COLUMN_ID)
);

COMMENT ON COLUMN "OG_ONLINE_DICT_COLUMN"."COLUMN_ID" IS '主键Id';
COMMENT ON COLUMN "OG_ONLINE_DICT_COLUMN"."DICT_ID" IS '字典ID';
COMMENT ON COLUMN "OG_ONLINE_DICT_COLUMN"."COLUMN_FIELD" IS '列字段名称';
COMMENT ON COLUMN "OG_ONLINE_DICT_COLUMN"."COLUMN_NAME" IS '列显示名称';
COMMENT ON COLUMN "OG_ONLINE_DICT_COLUMN"."ORDER_BY" IS '顺序';

-- ----------------------------
-- Table structure for og_online_form
-- ----------------------------
DROP TABLE og_online_form;
CREATE TABLE og_online_form (
  form_id NUMBER(19) NOT NULL,
  page_id NUMBER(19) NOT NULL,
  form_code VARCHAR2(32),
  form_name VARCHAR2(64) NOT NULL,
  form_kind NUMBER(10) NOT NULL,
  form_type NUMBER(10) NOT NULL,
  master_table_id NUMBER(19) NOT NULL,
  widget_json CLOB,
  params_json CLOB,
  update_time TIMESTAMP NOT NULL,
  create_time TIMESTAMP NOT NULL,
  CONSTRAINT PK_ONLINE_FORM_ID PRIMARY KEY (form_id)
);

COMMENT ON COLUMN og_online_form.form_id IS '主键Id';
COMMENT ON COLUMN og_online_form.page_id IS '页面id';
COMMENT ON COLUMN og_online_form.form_code IS '表单编码';
COMMENT ON COLUMN og_online_form.form_name IS '表单名称';
COMMENT ON COLUMN og_online_form.form_kind IS '表单类别';
COMMENT ON COLUMN og_online_form.form_type IS '表单类型';
COMMENT ON COLUMN og_online_form.master_table_id IS '表单主表id';
COMMENT ON COLUMN og_online_form.widget_json IS '表单组件JSON';
COMMENT ON COLUMN og_online_form.params_json IS '表单参数JSON';
COMMENT ON COLUMN og_online_form.update_time IS '更新时间';
COMMENT ON COLUMN og_online_form.create_time IS '创建时间';

CREATE UNIQUE INDEX uk_online_form_page_form_code
  ON og_online_form (form_code, page_id);

-- ----------------------------
-- Table structure for og_online_form_datasource
-- ----------------------------
DROP TABLE og_online_form_datasource;
CREATE TABLE og_online_form_datasource (
  id NUMBER(19) NOT NULL,
  form_id NUMBER(19) NOT NULL,
  datasource_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_ONLINE_FORM_DATASOURCE_ID PRIMARY KEY (id)
);

COMMENT ON COLUMN og_online_form_datasource.id IS '主键Id';
COMMENT ON COLUMN og_online_form_datasource.form_id IS '表单Id';
COMMENT ON COLUMN og_online_form_datasource.datasource_id IS '数据源Id';

CREATE INDEX idx_online_form_ds_ds_id
  ON og_online_form_datasource (datasource_id);

CREATE INDEX idx_online_form_ds_form_id
  ON og_online_form_datasource (form_id);

-- ----------------------------
-- Table structure for og_online_page
-- ----------------------------
DROP TABLE og_online_page;
CREATE TABLE og_online_page (
  page_id NUMBER(19) NOT NULL,
  page_code VARCHAR2(32),
  page_name VARCHAR2(64) NOT NULL,
  page_type NUMBER(10) NOT NULL,
  status NUMBER(10) NOT NULL,
  published NUMBER(10) DEFAULT 0 NOT NULL,
  update_time TIMESTAMP NOT NULL,
  create_time TIMESTAMP NOT NULL,
  CONSTRAINT PK_ONLINE_PAGE_ID PRIMARY KEY (page_id)
);

COMMENT ON COLUMN og_online_page.page_id IS '主键Id';
COMMENT ON COLUMN og_online_page.page_code IS '页面编码';
COMMENT ON COLUMN og_online_page.page_name IS '页面名称';
COMMENT ON COLUMN og_online_page.page_type IS '页面类型';
COMMENT ON COLUMN og_online_page.status IS '页面编辑状态';
COMMENT ON COLUMN og_online_page.published IS '是否发布';
COMMENT ON COLUMN og_online_page.update_time IS '更新时间';
COMMENT ON COLUMN og_online_page.create_time IS '创建时间';

-- ----------------------------
-- Table structure for og_online_page_datasource
-- ----------------------------
DROP TABLE og_online_page_datasource;
CREATE TABLE og_online_page_datasource (
  id NUMBER(19) NOT NULL,
  page_id NUMBER(19) NOT NULL,
  datasource_id NUMBER(19) NOT NULL,
  CONSTRAINT PK_ONLINE_PAGE_DATASOURCE_ID PRIMARY KEY (id)
);

COMMENT ON COLUMN og_online_page_datasource.id IS '主键Id';
COMMENT ON COLUMN og_online_page_datasource.page_id IS '页面主键Id';
COMMENT ON COLUMN og_online_page_datasource.datasource_id IS '数据源主键Id';

CREATE INDEX idx_online_page_ds_ds_id
  ON og_online_page_datasource (datasource_id);

CREATE INDEX idx_online_page_ds_page_id
  ON og_online_page_datasource (page_id);

-- ----------------------------
-- Table structure for og_online_rule
-- ----------------------------
DROP TABLE og_online_rule;
CREATE TABLE og_online_rule (
  rule_id NUMBER(19) NOT NULL,
  rule_name VARCHAR2(64) NOT NULL,
  rule_type NUMBER(10) NOT NULL,
  builtin NUMBER(10) NOT NULL,
  pattern VARCHAR2(512),
  update_time TIMESTAMP NOT NULL,
  create_time TIMESTAMP NOT NULL,
  deleted_flag NUMBER(10) NOT NULL,
  CONSTRAINT PK_ONLINE_RULE_ID PRIMARY KEY (rule_id)
);

COMMENT ON COLUMN og_online_rule.rule_id IS '主键Id';
COMMENT ON COLUMN og_online_rule.rule_name IS '规则名称';
COMMENT ON COLUMN og_online_rule.rule_type IS '规则类型';
COMMENT ON COLUMN og_online_rule.builtin IS '内置规则标记';
COMMENT ON COLUMN og_online_rule.pattern IS '自定义规则的正则表达式';
COMMENT ON COLUMN og_online_rule.update_time IS '更新时间';
COMMENT ON COLUMN og_online_rule.create_time IS '创建时间';
COMMENT ON COLUMN og_online_rule.deleted_flag IS '逻辑删除标记';

INSERT INTO og_online_rule VALUES (1, '只允许整数', 1, 1, NULL, sysdate, sysdate, 1);
INSERT INTO og_online_rule VALUES (2, '只允许数字', 2, 1, NULL, sysdate, sysdate, 1);
INSERT INTO og_online_rule VALUES (3, '只允许英文字符', 3, 1, NULL, sysdate, sysdate, 1);
INSERT INTO og_online_rule VALUES (4, '范围验证', 4, 1, NULL, sysdate, sysdate, 1);
INSERT INTO og_online_rule VALUES (5, '邮箱格式验证', 5, 1, NULL, sysdate, sysdate, 1);
INSERT INTO og_online_rule VALUES (6, '手机格式验证', 6, 1, NULL, sysdate, sysdate, 1);
COMMIT;

-- ----------------------------
-- Table structure for og_online_table
-- ----------------------------
DROP TABLE og_online_table;
CREATE TABLE og_online_table (
  table_id NUMBER(19) NOT NULL,
  table_name VARCHAR2(64) NOT NULL,
  model_name VARCHAR2(64) NOT NULL,
  dblink_id NUMBER(19) NOT NULL,
  update_time TIMESTAMP NOT NULL,
  create_time TIMESTAMP NOT NULL,
  CONSTRAINT PK_ONLINE_TABLE_ID PRIMARY KEY (table_id)
);

COMMENT ON COLUMN og_online_table.table_id IS '主键Id';
COMMENT ON COLUMN og_online_table.table_name IS '表名称';
COMMENT ON COLUMN og_online_table.model_name IS '实体名称';
COMMENT ON COLUMN og_online_table.dblink_id IS '数据库链接Id';
COMMENT ON COLUMN og_online_table.update_time IS '更新时间';
COMMENT ON COLUMN og_online_table.create_time IS '创建时间';

CREATE INDEX idx_online_table_dblink_id
  ON og_online_table (dblink_id);

-- ----------------------------
-- Table structure for og_online_virtual_column
-- ----------------------------
DROP TABLE og_online_virtual_column;
CREATE TABLE og_online_virtual_column (
  virtual_column_id NUMBER(19) NOT NULL,
  table_id NUMBER(19) NOT NULL,
  object_field_name VARCHAR2(64) NOT NULL,
  object_field_type VARCHAR2(32) NOT NULL,
  column_prompt VARCHAR2(64) NOT NULL,
  virtual_type NUMBER(10) NOT NULL,
  datasource_id NUMBER(19) NOT NULL,
  relation_id NUMBER(19),
  aggregation_table_id NUMBER(19),
  aggregation_column_id NUMBER(19),
  aggregation_type NUMBER(10),
  where_clause_json CLOB,
  CONSTRAINT PK_ONLINE_VIRTUAL_COLUMN_ID PRIMARY KEY (virtual_column_id)
);

COMMENT ON COLUMN og_online_virtual_column.virtual_column_id IS '主键Id';
COMMENT ON COLUMN og_online_virtual_column.table_id IS '所在表Id';
COMMENT ON COLUMN og_online_virtual_column.object_field_name IS '字段名称';
COMMENT ON COLUMN og_online_virtual_column.object_field_type IS '属性类型';
COMMENT ON COLUMN og_online_virtual_column.column_prompt IS '字段提示名';
COMMENT ON COLUMN og_online_virtual_column.virtual_type IS '虚拟字段类型(0: 聚合)';
COMMENT ON COLUMN og_online_virtual_column.datasource_id IS '关联数据源Id';
COMMENT ON COLUMN og_online_virtual_column.relation_id IS '关联Id';
COMMENT ON COLUMN og_online_virtual_column.aggregation_table_id IS '聚合字段所在关联表Id';
COMMENT ON COLUMN og_online_virtual_column.aggregation_column_id IS '关联表聚合字段Id';
COMMENT ON COLUMN og_online_virtual_column.aggregation_type IS '聚合类型(0: sum 1: count 2: avg 3: min 4: max)';
COMMENT ON COLUMN og_online_virtual_column.where_clause_json IS '存储过滤条件的json';

CREATE INDEX idx_online_virtual_col_agg_id
  ON og_online_virtual_column (aggregation_column_id);

CREATE INDEX idx_online_virtual_col_ds_id
  ON og_online_virtual_column (datasource_id);

CREATE INDEX idx_online_virtual_col_rel_id
  ON og_online_virtual_column (relation_id);

CREATE INDEX idx_online_virtual_col_tab_id
  ON og_online_virtual_column (table_id);

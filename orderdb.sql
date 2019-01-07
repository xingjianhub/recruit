/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/12/22 15:48:18                          */
/*==============================================================*/


drop table if exists T_AGENT;

drop table if exists T_CONSTANT_CONFIGURE;

drop table if exists T_CONTRACT_AGENT;

drop table if exists T_CONTRACT_CONTROL_INFO;

drop table if exists T_CONTRACT_EXECUTE_FAIL;

drop table if exists T_CONTRACT_EXECUTE_RECORD;

drop table if exists T_CONTRACT_PARTY_INFO;

drop table if exists T_CONTRACT_TERMINATE_AUDIT;

drop table if exists T_DELIVERY_INFO;

drop table if exists T_EXTERNAL_TRADE_LOG;

drop table if exists T_INVOICE_INFO;

drop table if exists T_ORDER;

drop table if exists T_ORDER_AUDIT;

drop table if exists T_ORDER_COUPON;

drop table if exists T_ORDER_ITEM;

drop table if exists T_ORG_CUSTOMER;

drop table if exists T_ORG_CUSTOMER_LOG;

drop table if exists T_PAYMENT_REFUND_LOG;

drop table if exists T_PURCHASE_LOG;

drop table if exists T_RISK_ASSESS_QUESTIONAIRE;

drop table if exists T_RISK_ASSESS_RESULT;

drop table if exists T_RISK_ASSESS_STANDARD;

drop table if exists T_SETTLEMENT;

drop table if exists T_TRADE_FAIL;

drop table if exists T_USER_CONTRACT;

/*==============================================================*/
/* Table: T_AGENT                                               */
/*==============================================================*/
create table T_AGENT
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '订单ID',
   AGENT_ID             bigint comment '代办人ID',
   NAME                 varchar(60) comment '代办人姓名',
   PHONE_NUM            varchar(20) comment '代办人电话',
   CREATE_TIME          timestamp comment '记录创建时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='订单代办人信息表';

/*==============================================================*/
/* Table: T_CONSTANT_CONFIGURE                                  */
/*==============================================================*/
create table T_CONSTANT_CONFIGURE
(
   ID                   bigint not null auto_increment comment 'ID',
   KEY_NAME             varchar(255) comment '键描述',
   KEY_CODE             varchar(255) comment '键',
   VALUE_NAME           varchar(255) comment '值描述',
   VALUE_CODE           varchar(255) comment '值',
   DEADLINE             int comment '缓存时间，以秒为单位',
   GROUP_NAME           varchar(255) comment '目录分组名称',
   GROUP_CODE           varchar(255) comment '分组编码',
   ORDER_BY             int comment '排序字段',
   REMARK               varchar(255) comment '备注',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


/*==============================================================*/
/* Table: T_CONTRACT_AGENT                                      */
/*==============================================================*/
create table T_CONTRACT_AGENT
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '客户合约编号',
   USER_CONTRACT_VERSION tinyint comment '客户合约版本号',
   AGENT_ID             bigint comment '若代办人为平台用户，则为用户ID',
   NAME                 varchar(60) comment '代办人姓名',
   PHONE_NUM            varchar(20) comment '代办人电话',
   PROCESS_TIME         timestamp comment '系统生成，同签约时间',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码 
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='代办人信息表';


/*==============================================================*/
/* Table: T_CONTRACT_CONTROL_INFO                               */
/*==============================================================*/
create table T_CONTRACT_CONTROL_INFO
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '客户合约编号',
   USER_CONTRACT_VERSION tinyint comment '客户合约版本号',
   CURRENT_PERIOD       int comment '当前期数',
   TYPE                 tinyint not null comment '1：基金定期定额投资
            2：信用卡代扣费：信用卡账单日进行自动缴费
            3：水费代缴费：水费账单日自动缴费
            4：电费代缴费：电费账单日自动缴费
            5：煤费代缴费：煤费账单日自动缴费
            ',
   INTO_ACCOUNT_NAME    varchar(60) comment '转入账户名称',
   INTO_ACCOUNT         varchar(32) comment '转入账户，如果是信用卡还款则必填，保存信用卡卡号而非账户编号',
   OUT_ACCOUNT_NAME     varchar(60) comment '转出账户名称',
   OUT_ACCOUNT          varchar(32) comment '转出账户',
   AMOUNT               decimal(18,4) comment '金额',
   START_TIME           timestamp comment '定投/代扣开始日期',
   PERIOD_TYPE          tinyint comment '1: 每个月 2:每个季度',
   FAIL_PERIOD_TIME     int comment '执行失败期数',
   FAIL_TIME            int comment '每期失败次数',
   PERIOD_FAIL_TIME     int comment '记录本期失败次数',
   NEXT_EXECUTE_TIME    timestamp comment '下次执行时间，根据job计算出来',
   EXECUTE_SIGN         tinyint comment '0:未执行 1:执行成功  2:执行失败 3:失败次数过多 4:不执行(适用于合约撤销\过期\调整失效时间等)',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='合约控制信息表';

/*==============================================================*/
/* Table: T_CONTRACT_EXECUTE_FAIL                               */
/*==============================================================*/
create table T_CONTRACT_EXECUTE_FAIL
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '客户合约编号',
   USER_CONTRACT_VERSION tinyint comment '客户合约版本号',
   PERIOD               int comment '期数',
   PERIOD_FAIL_TIME     int comment '每期失败次数',
   CREATE_TIME          timestamp comment '创建时间',
   UPDATE_TIME          timestamp comment '更新时间',
   IS_VALID             tinyint comment '是否当前有效 1:当前有效 2: 历史记录',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='合约执行失败统计表';

/*==============================================================*/
/* Table: T_CONTRACT_EXECUTE_RECORD                             */
/*==============================================================*/
create table T_CONTRACT_EXECUTE_RECORD
(
   ID                   bigint not null auto_increment comment 'ID',
   SERIAL_NO            varchar(21) not null comment '流水号 系统自动生成
            2：信用卡代缴费：信用卡账单日进行自动缴费
            3：水费代扣费：水费账单日自动缴费
            4：电费代扣费：电费账单日自动缴费',
   ORDER_NO             varchar(21) not null comment '订单编号',
   PERIOD               int comment '期数',
   USER_CONTRACT_NO     varchar(21) not null comment '客户合约编号',
   USER_CONTRACT_VERSION tinyint not null comment '客户合约版本号',
   EXECUTE_TIME         timestamp not null comment '执行时间',
   RESULT               tinyint not null comment '1: 成功 2: 失败',
   FAIL_REASON          varchar(255) comment '失败原因',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='合约执行记录表';


/*==============================================================*/
/* Table: T_CONTRACT_PARTY_INFO                                 */
/*==============================================================*/
create table T_CONTRACT_PARTY_INFO
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '客户合约编号',
   USER_CONTRACT_VERSION tinyint comment '客户合约版本号',
   FIRST_UNIT           varchar(100) comment '甲方缴费单位',
   FIRST_ACCOUNT        varchar(32) comment '甲方户号',
   FIRST_CENTER_ACCOUNT varchar(32) comment '甲方账户编号，代销基金：卡绑定账户；贵金属：卡绑定账户；三方存管：卡绑定账户；掌柜钱包：掌柜钱包账户编号；金生宝钱包：金生宝钱包账户编号；绑定卡：卡绑定编号',
   FIRST_GROUP          varchar(100) comment '甲方分组',
   FIRST_FINANCIAL_ACCOUNT varchar(32) comment '甲方理财账户',
   SECOND_AGENCY_NO     varchar(10) comment '乙方机构编号',
   SECOND_CENTER_ACCOUNT varchar(30) comment '乙方账户编号（资金账户编号）',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='签约方信息表';

/*==============================================================*/
/* Table: T_CONTRACT_TERMINATE_AUDIT                            */
/*==============================================================*/
create table T_CONTRACT_TERMINATE_AUDIT
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '客户合约编号',
   USER_CONTRACT_VERSION tinyint comment '客户合约版本号',
   STATUS               tinyint comment '默认为空 0: 待审核 1: 审核通过 2: 审核不通过',
   AUDIT_TIME           timestamp comment '审核时间',
   AUDIT_REMARK         varchar(255) comment '审核意见',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码 
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='解除合约审核信息表';


/*==============================================================*/
/* Table: T_DELIVERY_INFO                                       */
/*==============================================================*/
create table T_DELIVERY_INFO
(
   ID                   bigint not null auto_increment comment '主键',
   ORDER_ID             bigint not null comment '订单ID',
   PROVINCE_NO          varchar(10) comment '省份编码',
   CITY_NO              varchar(10) comment '城市编码',
   DISTRICT_NO          varchar(10) comment '区县编码',
   ADDRESS              varchar(255) comment '详细地址',
   POST_CODE            varchar(10) comment '邮政编码',
   RECEIVER_NAME        varchar(20) comment '收货人姓名',
   PHONE                varchar(20) comment '收货人电话1',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编号
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编号',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='收货地址信息';


/*==============================================================*/
/* Table: T_EXTERNAL_TRADE_LOG                                  */
/*==============================================================*/
create table T_EXTERNAL_TRADE_LOG
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_NO             varchar(21) not null comment '订单编号',
   TXN_STATUS           varchar(4) comment '产品/业务系统返回的交易状态',
   TXN_TIME             datetime not null comment '产品/业务系统中交易的创建时间',
   FAIL_REASON          varchar(255) comment '若返回交易失败，失败原因',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码 
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对接系统返回信息表';

/*==============================================================*/
/* Table: T_INVOICE_INFO                                        */
/*==============================================================*/
create table T_INVOICE_INFO
(
   ID                   bigint not null auto_increment comment '主键',
   ORDER_ID             bigint not null comment '订单ID',
   TYPE                 tinyint comment '1：普通发票 2：增值税发票， 默认为1',
   TITLE                varchar(255) comment '发票抬头 1：个人  2：公司',
   COMPANY_NAME         varchar(100) comment '发票公司名称',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编号
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编号',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='发票信息表';

/*==============================================================*/
/* Table: T_ORDER                                               */
/*==============================================================*/
create table T_ORDER
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_NO             varchar(21) not null comment '订单编号',
   CREATE_TYPE          tinyint not null comment '订单创建类型 1:平台订单 2:收单订单',
   TYPE                 tinyint not null comment '1:代缴水费订单 2:代缴电费订单  3:代缴煤费订单  4:电影票订单 5:虚拟商品订单 6:掌柜钱包转入订单 7:掌柜钱包转出订单 8:金生宝钱包转入订单 9:金生宝钱包转出订单 10:理财订单 11:理财赎回 12:代销基金订单 13:代销基金赎回 14:直销基金订单 15:直销基金赎回 16:贵金属订单 17:贵金属出金 18:三方存管银转正19:三方存管证转银 20:信用卡还款 21:通联交学费 22:退货 23:普通商品 24:不退货退款 ',
   CATEGORY             tinyint comment '1: 个人订单 2: 机构订单',
   STATUS               tinyint not null comment '0: 待支付，订单创建还未支付   1: 已支付，订单已支付  2:已发货（废除） 3: 交易成功，机构/商户已确认订单（预授权通过），或者已销账（缴费类） 4: 交易失败，订单取消、订单失效、预授权不通过 5:赎回申请中 6:赎回取消 7:赎回成功 8:赎回失败 9：退货申请中 10：拒绝  11：同意退款 12：已完成退款',
   DELIVERY_STATUS      tinyint comment '0:待发货 1:已发货 2:已收货 3:拒签',
   EXPRESS_NO           varchar(20) comment '运单号',
   CARRIAGE             decimal(8,2) comment '运费',
   DEADLINE_DELIVERY_TIME timestamp comment '截止收货时间',
   DELIVERY_TIME        timestamp comment '用户实际收货时间',
   DELAY_FLAG           tinyint comment '0未延长 1已延长 默认为0',
   DEADLINE_TIME        datetime comment '支付截止时间，超过此时间后订单置为交易失败',
   PAY_TYPE             tinyint comment '1.卡 2.钱包  3.券支付 4.卡+券组合支付',
   VALID_TIME           timestamp comment '保留字段',
   REQUEST_SERIAL_NO    varchar(21) comment '下订单请求时的流水号',
   REQUEST_TIME         datetime comment '下订单请求时间',
   CUST_NO              varchar(15) not null comment '客户编号',
   BUYER_NAME           varchar(20),
   USER_CONTRACT_NO     varchar(21) comment '若需签约，则不为空',
   USER_CONTRACT_VERSION tinyint comment '客户合约对应版本号',
   QUANTITY             decimal(18,2) comment '交易申请份额',
   AMOUNT               decimal(18,4) comment '交易申请金额',
   VALID_QUANTITY       decimal(18,2) comment '成交份额',
   VALID_AMOUNT         decimal(18,4) comment '成交总金额',
   ACTUAL_AMOUNT        decimal(18,4) comment '实际支付金额',
   COUPON_AMOUNT        decimal(18,4) comment '券抵扣金额',
   POINT_AMOUNT         decimal(18,4) comment '积分抵扣金额',
   ORIGINAL_ORDER_NO    varchar(25) comment '原订单号，用于关联退货时的原订单号',
   REFUND_FLAG          tinyint comment '0: 未申请退款（默认） 1:申请退款  2:部分退款 3:全部退款',
   IS_CANCEL_AUDIT      tinyint comment '取消订单时是否需要人工审核 0: 不需要  1: 需要   默认为0',
   REMARK               varchar(255) comment '订单摘要',
   RETURN_GOOD_CODE     varchar(20) comment '受理编号，即调用产品/业务系统需要返回的流水号',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码 
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=utf8 COMMENT='订单表';


/*==============================================================*/
/* Table: T_ORDER_AUDIT                                         */
/*==============================================================*/
create table T_ORDER_AUDIT
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '订单ID',
   TYPE                 tinyint comment '1:取消订单；  目前只有这一种审核，后续扩展',
   STATUS               tinyint comment '状态 0：待审核 1: 审核通过 2：审核拒绝',
   REMARK               varchar(255) comment '审核通过或拒绝的备注',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码',
   CREATE_TIME          timestamp comment '创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单审核表，一些需要审核的操作记录在此表中，支持同一业务场景的多级审核操作';


/*==============================================================*/
/* Table: T_ORDER_COUPON                                        */
/*==============================================================*/
create table T_ORDER_COUPON
(
   ID                   bigint not null auto_increment comment '主键',
   ORDER_ID             bigint not null comment '订单ID',
   COUPON_NO            varchar(20) comment '券号',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编号
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编号',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='订单用券信息';

/*==============================================================*/
/* Table: T_ORDER_ITEM                                          */
/*==============================================================*/
create table T_ORDER_ITEM
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '订单ID',
   ORDER_ITEM_NO        varchar(18) comment '订单子项编号',
   SALE_ORG_NO          varchar(32) not null comment '销售机构编号',
   MDSE_NO              varchar(10) comment '商品代码',
   EX_PRODUCT_NO        varchar(8) comment '产品代码',
   SKU_ID               bigint comment 'SKUID库存单位',
   TA_NO                varchar(20) comment 'TA代码',
   MDSE_VERSION         tinyint comment '商品版本号',
   MDSE_NAME            varchar(100) comment '商品名称',
   QUANTITY             decimal(18,2) comment '商品数量',
   PRICE                decimal(18,4) comment '商品销售单价/商品净值',
   PAY_PRICE            decimal(18,4) comment '对于财富类商品，保存申请的金额',
   PROD_CAT_NO          varchar(10),
   SALE_CAT_CODE        varchar(10),
   SETTLE_PRICE         decimal(18,4) comment '与商家结算用的价格',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码
            ',
   CREATE_TIME          timestamp comment '创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人id',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COMMENT='订单子项表';


/*==============================================================*/
/* Table: T_ORG_CUSTOMER                                        */
/*==============================================================*/
create table T_ORG_CUSTOMER
(
   ID                   bigint not null auto_increment comment 'ID',
   CUST_NO              varchar(15) not null comment '客户编号',
   LEVEL                tinyint comment '授权级别',
   CREATE_BY            varchar(15) character set utf8 comment '订单创建人id 
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人id',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构客户授权设置表';

/*==============================================================*/
/* Table: T_ORG_CUSTOMER_LOG                                    */
/*==============================================================*/
create table T_ORG_CUSTOMER_LOG
(
   ID                   bigint not null auto_increment comment 'ID',
   CUST_NO              varchar(15) not null comment '客户编号',
   OPT_ROLE             varchar(20) comment '操作角色',
   OPT_TYPE             tinyint comment '1: 一级授权 2:: 二级授权  3: 三级授权',
   CREATE_BY            varchar(15) character set utf8 comment '订单创建人id 
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人id',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构客户授权日志表';


/*==============================================================*/
/* Table: T_PAYMENT_REFUND_LOG                                  */
/*==============================================================*/
create table T_PAYMENT_REFUND_LOG
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '订单ID',
   ORDER_ITEM_ID        bigint comment '订单子项ID 用于支持订单项退款，若此字段为空则为全部订单退款',
   TYPE                 tinyint comment '1:支付记录 2：退款记录 3：转账记录',
   PAYMENT_NO           varchar(21) not null comment '支付流水号',
   CURRENCY             char(3) comment '币种',
   AMOUNT               decimal(18,4) not null,
   STATUS               tinyint not null comment '0: 待支付  1: 支付成功  2: 支付失败  3: 待退款  4: 退款成功  5: 退款失败 6：运营驳回 7:超时',
   PAYMENT_TIME         timestamp not null comment '支付时间',
   REMARK               varchar(255) comment '记录失败原因或者驳回备注等信息',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码',
   CREATE_TIME          timestamp comment '创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付退款记录表';



/*==============================================================*/
/* Table: T_PURCHASE_LOG                                        */
/*==============================================================*/
create table T_PURCHASE_LOG
(
   ID                   bigint not null auto_increment comment 'ID',
   PURCHASE_TYPE        varchar(20),
   PURCHASE_CONTENT     blob,
   PURCHASE_DATA        timestamp,
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订购/赎回清单表';

/*==============================================================*/
/* Table: T_RISK_ASSESS_QUESTIONAIRE                            */
/*==============================================================*/
create table T_RISK_ASSESS_QUESTIONAIRE
(
   ID                   bigint not null auto_increment comment 'ID',
   TYPE                 tinyint not null comment '0:风险等级卷子 1:风险适合度卷子  默认为0',
   PAPER_NO             varchar(32) not null,
   PAPER_NAME           varchar(60) not null comment '试卷名称',
   QUESTION_NO          varchar(10) not null comment '问题编号',
   BUSINESS_TYPE        char(2) comment '业务种类，保留字段',
   QUESTION_TYPE        tinyint comment '0 单选题目 1 复选题目 默认为0',
   OPTION_TIP           varchar(20) comment '标题为null 其他为A、B、C、D',
   CONTENT              varchar(255) comment '提示内容',
   SCORE                decimal(4,2) comment '当为答案时才有值',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码 
            ',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风险评估问卷表';


/*==============================================================*/
/* Table: T_RISK_ASSESS_RESULT                                  */
/*==============================================================*/
create table T_RISK_ASSESS_RESULT
(
   ID                   bigint not null auto_increment comment 'ID',
   CUST_NO              varchar(15) not null comment '客户编号',
   CUST_NAME            varchar(60) comment '会员名称',
   CERT_TYPE            varchar(2) not null comment '证件类型 1：身份证 2：护照 具体以会员中心定义为准',
   CERT_NO              varchar(20) not null comment '证件号码',
   PROD_CAT_NO          varchar(10) not null comment '对应产品分类，比如理财、基金、贵金属，对应产品中心中的编码',
   RISK_LEVEL           tinyint not null comment '客户提交问卷后，根据风险评估标准得出客户的风险等级',
   ANSWER               varchar(30),
   SCORE                char(3),
   CHANNEL              char(3) comment '渠道种类 204:网银 208:app 101:柜面',
   START_TIME           timestamp comment '默认存当前风评时间',
   END_TIME             timestamp comment '默认为生效日期后一年',
   IS_FACE_SIGN         tinyint comment '0: 不是 1: 是   当为合作行柜面风评时，为是',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码',
   CREATE_TIME          timestamp comment '创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户风评结果表';

/*==============================================================*/
/* Table: T_RISK_ASSESS_STANDARD                                */
/*==============================================================*/
create table T_RISK_ASSESS_STANDARD
(
   ID                   bigint not null auto_increment comment 'ID',
   CUSTOMER_TYPE        tinyint comment '1：个人客户 2：机构客户    默认为个人客户',
   CUSTOMER_LEVEL       tinyint comment '客户层级，暂未使用，赋值为0',
   TYPE                 tinyint not null comment '问卷类型',
   PROD_CAT_NO          varchar(10) not null comment '对应产品分类，比如理财、基金、贵金属，对应产品中心中的编码',
   PAPER_NO             varchar(32) not null comment '每套问卷的唯一编号',
   MIN_SCORE            decimal(4,2) not null,
   MAX_SCORE            decimal(4,2) not null,
   RISK_LEVEL           tinyint not null,
   VALID_TIME           timestamp,
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风险评估标准表';


/*==============================================================*/
/* Table: T_SETTLEMENT                                          */
/*==============================================================*/
create table T_SETTLEMENT
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '订单ID',
   ORDER_ITEM_ID        bigint not null comment '订单子项ID 用于支持订单项退款，若此字段为空则为全部订单退款',
   STATUS               tinyint comment '结算状态  1：已生成结算单 2.已结算 3.审核拒绝 4.未生成结算单',
   SETTLE_PRICE         decimal(18,4),
   SETTLOR_NAME         varchar(60),
   SETTLE_TIME          timestamp comment '结算时间',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码
            ',
   CREATE_TIME          timestamp comment '支付记录创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='结算记录表';


/*==============================================================*/
/* Table: T_TRADE_FAIL                                          */
/*==============================================================*/
create table T_TRADE_FAIL
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '订单ID',
   TYPE                 tinyint comment '1:取消订单 2:订单失效 3:授权不通过',
   STATUS               tinyint comment '状态 0: 待审核 1：失败生效 2: 审核拒绝 ； 对于取消订单，有审核状态，其他类型的交易失败默认直接为1',
   FAIL_TIME            timestamp comment '交易失败生效的时间，即状态变为2的时间',
   FAIL_REASON          varchar(255) comment '失败备注信息，比如：用户主动取消、机构返回交易失败, ,超时等等',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码',
   CREATE_TIME          timestamp comment '创建时间，对于取消订单，创建时间即为用户申请取消订单的时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易失败记录，用于记录订单取消、订单失效、预授权不通过等交易失败情况下的信息及审核操作记录';

/*==============================================================*/
/* Table: T_USER_CONTRACT                                       */
/*==============================================================*/
create table T_USER_CONTRACT
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '若需签约，则不为空',
   MDSE_NO              varchar(10) comment '商品编号',
   EX_PRODUCT_NO        varchar(8) comment '产品代码',
   SKU_ID               bigint comment 'SKUID库存单位',
   CONTRACT_MODE_CODE   varchar(10) comment '合约模型代码',
   CONTRACT_MODE_VERSION tinyint comment '合约模型版本号',
   CUST_NO              varchar(15) not null comment '客户编号',
   SIGN_TIME            timestamp not null comment '签约/变更时间',
   TYPE                 tinyint not null comment '1:钱包签约 2:理财签约 3:代销基金签约 4:直销基金签约 5:贵金属签约 6:三方存管签约 7:绑定卡签约  8:水费代扣费  9:电费代缴费  10:煤费代缴费 11:信用卡代缴费 12:融资融券 13:金生宝钱包 14:快捷支付签约15:小额免密支付签约',
   VALID_TIME           timestamp not null comment '合约生效时间',
   INVALID_TIME         timestamp not null comment '合约失效时间',
   STATUS               tinyint not null comment '1:申请：当销售机构不是委托平台签约，则先申请签约
            2:激活：生效。若委托平台签约，创建合约即生效
            3:撤销：合约失效，合约多方就商品或者服务的约定解除
            4:到期：客户账户结清，或者合约有效期已过
            5:解约申请中
            6:失败：创建合约时发生异常',
   IS_TERMINATE         tinyint comment '1:是 0:否  默认为否',
   IS_REGULAR           tinyint comment '1:是 0:否  默认为否  当为定投、代扣等定期执行的合约，为是',
   FIRST_PARTY_CODE     varchar(10) comment '甲方编号即会员编号',
   SECOND_PARTY_CODE    varchar(10) comment '乙方编号即多机构编号',
   RISK_LEVEL           tinyint comment '会员对应的风评等级，若不需评估则为空',
   ORG_NO               varchar(16) comment '由签约请求带入,根据业务种类判断是否输入。09－贵金属不填；18-普通存管、24-融资融券  填写券商编号；21-输入基金登记机构代号',
   CHANNEL_NO           varchar(5) comment '由外部请求传入',
   CHANNEL_ORG_NO       varchar(5) comment '对应多机构中的导流机构编号',
   REQUEST_SERIAL_NO    varchar(20) comment '渠道下发签约申请时的流水号',
   REQUEST_TIME         timestamp comment '来自渠道的原请求时间，格式为YYYYMMDDhhmmss',
   DESCRIPTION          varchar(255) comment '本合约签订原因，比如合约变更、解除等',
   REMARK               varchar(255) comment '备注',
   VERSION              tinyint comment '客户合约版本号',
   CREATE_BY            varchar(15) character set utf8 comment '创建人编码',
   CREATE_TIME          timestamp comment '订单创建时间',
   UPDATE_BY            varchar(15) character set utf8 comment '更新人编码',
   UPDATE_TIME          timestamp comment '更新时间',
   DELETE_FLAG          tinyint comment '删除标识 0：有效 1：已删除',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户合约信息表';


/*==============================================================*/
/* 修改字段长度                       */
/* Created on:     2015/12/23 15:07:18                          */
/*==============================================================*/
ALTER TABLE `t_user_contract`
MODIFY COLUMN `FIRST_PARTY_CODE`  varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '甲方编号即会员编号' AFTER `IS_REGULAR`,
MODIFY COLUMN `SECOND_PARTY_CODE`  varchar(21) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '乙方编号即多机构编号' AFTER `FIRST_PARTY_CODE`;

ALTER TABLE `t_contract_party_info`
MODIFY COLUMN `SECOND_AGENCY_NO`  varchar(21) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '乙方机构编号' AFTER `FIRST_FINANCIAL_ACCOUNT`;


/*==============================================================*/
/* 修改字段长度                       */
/* Created on:     2015/12/30 10:43:18                          */
/*==============================================================*/
ALTER TABLE `t_user_contract`
MODIFY COLUMN `MDSE_NO`  varchar(15) CHARACTER SET utf8  DEFAULT NULL COMMENT '商品代码' ;


ALTER TABLE `t_order_item`
MODIFY COLUMN `MDSE_NO`  varchar(15) CHARACTER SET utf8 DEFAULT NULL COMMENT '商品代码';
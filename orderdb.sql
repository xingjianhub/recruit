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
   ORDER_ID             bigint not null comment '����ID',
   AGENT_ID             bigint comment '������ID',
   NAME                 varchar(60) comment '����������',
   PHONE_NUM            varchar(20) comment '�����˵绰',
   CREATE_TIME          timestamp comment '��¼����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='������������Ϣ��';

/*==============================================================*/
/* Table: T_CONSTANT_CONFIGURE                                  */
/*==============================================================*/
create table T_CONSTANT_CONFIGURE
(
   ID                   bigint not null auto_increment comment 'ID',
   KEY_NAME             varchar(255) comment '������',
   KEY_CODE             varchar(255) comment '��',
   VALUE_NAME           varchar(255) comment 'ֵ����',
   VALUE_CODE           varchar(255) comment 'ֵ',
   DEADLINE             int comment '����ʱ�䣬����Ϊ��λ',
   GROUP_NAME           varchar(255) comment 'Ŀ¼��������',
   GROUP_CODE           varchar(255) comment '�������',
   ORDER_BY             int comment '�����ֶ�',
   REMARK               varchar(255) comment '��ע',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


/*==============================================================*/
/* Table: T_CONTRACT_AGENT                                      */
/*==============================================================*/
create table T_CONTRACT_AGENT
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '�ͻ���Լ���',
   USER_CONTRACT_VERSION tinyint comment '�ͻ���Լ�汾��',
   AGENT_ID             bigint comment '��������Ϊƽ̨�û�����Ϊ�û�ID',
   NAME                 varchar(60) comment '����������',
   PHONE_NUM            varchar(20) comment '�����˵绰',
   PROCESS_TIME         timestamp comment 'ϵͳ���ɣ�ͬǩԼʱ��',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱��� 
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='��������Ϣ��';


/*==============================================================*/
/* Table: T_CONTRACT_CONTROL_INFO                               */
/*==============================================================*/
create table T_CONTRACT_CONTROL_INFO
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '�ͻ���Լ���',
   USER_CONTRACT_VERSION tinyint comment '�ͻ���Լ�汾��',
   CURRENT_PERIOD       int comment '��ǰ����',
   TYPE                 tinyint not null comment '1�������ڶ���Ͷ��
            2�����ÿ����۷ѣ����ÿ��˵��ս����Զ��ɷ�
            3��ˮ�Ѵ��ɷѣ�ˮ���˵����Զ��ɷ�
            4����Ѵ��ɷѣ�����˵����Զ��ɷ�
            5��ú�Ѵ��ɷѣ�ú���˵����Զ��ɷ�
            ',
   INTO_ACCOUNT_NAME    varchar(60) comment 'ת���˻�����',
   INTO_ACCOUNT         varchar(32) comment 'ת���˻�����������ÿ����������������ÿ����Ŷ����˻����',
   OUT_ACCOUNT_NAME     varchar(60) comment 'ת���˻�����',
   OUT_ACCOUNT          varchar(32) comment 'ת���˻�',
   AMOUNT               decimal(18,4) comment '���',
   START_TIME           timestamp comment '��Ͷ/���ۿ�ʼ����',
   PERIOD_TYPE          tinyint comment '1: ÿ���� 2:ÿ������',
   FAIL_PERIOD_TIME     int comment 'ִ��ʧ������',
   FAIL_TIME            int comment 'ÿ��ʧ�ܴ���',
   PERIOD_FAIL_TIME     int comment '��¼����ʧ�ܴ���',
   NEXT_EXECUTE_TIME    timestamp comment '�´�ִ��ʱ�䣬����job�������',
   EXECUTE_SIGN         tinyint comment '0:δִ�� 1:ִ�гɹ�  2:ִ��ʧ�� 3:ʧ�ܴ������� 4:��ִ��(�����ں�Լ����\����\����ʧЧʱ���)',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱���',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='��Լ������Ϣ��';

/*==============================================================*/
/* Table: T_CONTRACT_EXECUTE_FAIL                               */
/*==============================================================*/
create table T_CONTRACT_EXECUTE_FAIL
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '�ͻ���Լ���',
   USER_CONTRACT_VERSION tinyint comment '�ͻ���Լ�汾��',
   PERIOD               int comment '����',
   PERIOD_FAIL_TIME     int comment 'ÿ��ʧ�ܴ���',
   CREATE_TIME          timestamp comment '����ʱ��',
   UPDATE_TIME          timestamp comment '����ʱ��',
   IS_VALID             tinyint comment '�Ƿ�ǰ��Ч 1:��ǰ��Ч 2: ��ʷ��¼',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='��Լִ��ʧ��ͳ�Ʊ�';

/*==============================================================*/
/* Table: T_CONTRACT_EXECUTE_RECORD                             */
/*==============================================================*/
create table T_CONTRACT_EXECUTE_RECORD
(
   ID                   bigint not null auto_increment comment 'ID',
   SERIAL_NO            varchar(21) not null comment '��ˮ�� ϵͳ�Զ�����
            2�����ÿ����ɷѣ����ÿ��˵��ս����Զ��ɷ�
            3��ˮ�Ѵ��۷ѣ�ˮ���˵����Զ��ɷ�
            4����Ѵ��۷ѣ�����˵����Զ��ɷ�',
   ORDER_NO             varchar(21) not null comment '�������',
   PERIOD               int comment '����',
   USER_CONTRACT_NO     varchar(21) not null comment '�ͻ���Լ���',
   USER_CONTRACT_VERSION tinyint not null comment '�ͻ���Լ�汾��',
   EXECUTE_TIME         timestamp not null comment 'ִ��ʱ��',
   RESULT               tinyint not null comment '1: �ɹ� 2: ʧ��',
   FAIL_REASON          varchar(255) comment 'ʧ��ԭ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='��Լִ�м�¼��';


/*==============================================================*/
/* Table: T_CONTRACT_PARTY_INFO                                 */
/*==============================================================*/
create table T_CONTRACT_PARTY_INFO
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '�ͻ���Լ���',
   USER_CONTRACT_VERSION tinyint comment '�ͻ���Լ�汾��',
   FIRST_UNIT           varchar(100) comment '�׷��ɷѵ�λ',
   FIRST_ACCOUNT        varchar(32) comment '�׷�����',
   FIRST_CENTER_ACCOUNT varchar(32) comment '�׷��˻���ţ��������𣺿����˻���������������˻���������ܣ������˻����ƹ�Ǯ�����ƹ�Ǯ���˻���ţ�������Ǯ����������Ǯ���˻���ţ��󶨿������󶨱��',
   FIRST_GROUP          varchar(100) comment '�׷�����',
   FIRST_FINANCIAL_ACCOUNT varchar(32) comment '�׷�����˻�',
   SECOND_AGENCY_NO     varchar(10) comment '�ҷ��������',
   SECOND_CENTER_ACCOUNT varchar(30) comment '�ҷ��˻���ţ��ʽ��˻���ţ�',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='ǩԼ����Ϣ��';

/*==============================================================*/
/* Table: T_CONTRACT_TERMINATE_AUDIT                            */
/*==============================================================*/
create table T_CONTRACT_TERMINATE_AUDIT
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '�ͻ���Լ���',
   USER_CONTRACT_VERSION tinyint comment '�ͻ���Լ�汾��',
   STATUS               tinyint comment 'Ĭ��Ϊ�� 0: ����� 1: ���ͨ�� 2: ��˲�ͨ��',
   AUDIT_TIME           timestamp comment '���ʱ��',
   AUDIT_REMARK         varchar(255) comment '������',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱��� 
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='�����Լ�����Ϣ��';


/*==============================================================*/
/* Table: T_DELIVERY_INFO                                       */
/*==============================================================*/
create table T_DELIVERY_INFO
(
   ID                   bigint not null auto_increment comment '����',
   ORDER_ID             bigint not null comment '����ID',
   PROVINCE_NO          varchar(10) comment 'ʡ�ݱ���',
   CITY_NO              varchar(10) comment '���б���',
   DISTRICT_NO          varchar(10) comment '���ر���',
   ADDRESS              varchar(255) comment '��ϸ��ַ',
   POST_CODE            varchar(10) comment '��������',
   RECEIVER_NAME        varchar(20) comment '�ջ�������',
   PHONE                varchar(20) comment '�ջ��˵绰1',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱��
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱��',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='�ջ���ַ��Ϣ';


/*==============================================================*/
/* Table: T_EXTERNAL_TRADE_LOG                                  */
/*==============================================================*/
create table T_EXTERNAL_TRADE_LOG
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_NO             varchar(21) not null comment '�������',
   TXN_STATUS           varchar(4) comment '��Ʒ/ҵ��ϵͳ���صĽ���״̬',
   TXN_TIME             datetime not null comment '��Ʒ/ҵ��ϵͳ�н��׵Ĵ���ʱ��',
   FAIL_REASON          varchar(255) comment '�����ؽ���ʧ�ܣ�ʧ��ԭ��',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱��� 
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�Խ�ϵͳ������Ϣ��';

/*==============================================================*/
/* Table: T_INVOICE_INFO                                        */
/*==============================================================*/
create table T_INVOICE_INFO
(
   ID                   bigint not null auto_increment comment '����',
   ORDER_ID             bigint not null comment '����ID',
   TYPE                 tinyint comment '1����ͨ��Ʊ 2����ֵ˰��Ʊ�� Ĭ��Ϊ1',
   TITLE                varchar(255) comment '��Ʊ̧ͷ 1������  2����˾',
   COMPANY_NAME         varchar(100) comment '��Ʊ��˾����',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱��
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱��',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='��Ʊ��Ϣ��';

/*==============================================================*/
/* Table: T_ORDER                                               */
/*==============================================================*/
create table T_ORDER
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_NO             varchar(21) not null comment '�������',
   CREATE_TYPE          tinyint not null comment '������������ 1:ƽ̨���� 2:�յ�����',
   TYPE                 tinyint not null comment '1:����ˮ�Ѷ��� 2:���ɵ�Ѷ���  3:����ú�Ѷ���  4:��ӰƱ���� 5:������Ʒ���� 6:�ƹ�Ǯ��ת�붩�� 7:�ƹ�Ǯ��ת������ 8:������Ǯ��ת�붩�� 9:������Ǯ��ת������ 10:��ƶ��� 11:������ 12:�������𶩵� 13:����������� 14:ֱ�����𶩵� 15:ֱ��������� 16:��������� 17:��������� 18:���������ת��19:�������֤ת�� 20:���ÿ����� 21:ͨ����ѧ�� 22:�˻� 23:��ͨ��Ʒ 24:���˻��˿� ',
   CATEGORY             tinyint comment '1: ���˶��� 2: ��������',
   STATUS               tinyint not null comment '0: ��֧��������������δ֧��   1: ��֧����������֧��  2:�ѷ������ϳ��� 3: ���׳ɹ�������/�̻���ȷ�϶�����Ԥ��Ȩͨ���������������ˣ��ɷ��ࣩ 4: ����ʧ�ܣ�����ȡ��������ʧЧ��Ԥ��Ȩ��ͨ�� 5:��������� 6:���ȡ�� 7:��سɹ� 8:���ʧ�� 9���˻������� 10���ܾ�  11��ͬ���˿� 12��������˿�',
   DELIVERY_STATUS      tinyint comment '0:������ 1:�ѷ��� 2:���ջ� 3:��ǩ',
   EXPRESS_NO           varchar(20) comment '�˵���',
   CARRIAGE             decimal(8,2) comment '�˷�',
   DEADLINE_DELIVERY_TIME timestamp comment '��ֹ�ջ�ʱ��',
   DELIVERY_TIME        timestamp comment '�û�ʵ���ջ�ʱ��',
   DELAY_FLAG           tinyint comment '0δ�ӳ� 1���ӳ� Ĭ��Ϊ0',
   DEADLINE_TIME        datetime comment '֧����ֹʱ�䣬������ʱ��󶩵���Ϊ����ʧ��',
   PAY_TYPE             tinyint comment '1.�� 2.Ǯ��  3.ȯ֧�� 4.��+ȯ���֧��',
   VALID_TIME           timestamp comment '�����ֶ�',
   REQUEST_SERIAL_NO    varchar(21) comment '�¶�������ʱ����ˮ��',
   REQUEST_TIME         datetime comment '�¶�������ʱ��',
   CUST_NO              varchar(15) not null comment '�ͻ����',
   BUYER_NAME           varchar(20),
   USER_CONTRACT_NO     varchar(21) comment '����ǩԼ����Ϊ��',
   USER_CONTRACT_VERSION tinyint comment '�ͻ���Լ��Ӧ�汾��',
   QUANTITY             decimal(18,2) comment '��������ݶ�',
   AMOUNT               decimal(18,4) comment '����������',
   VALID_QUANTITY       decimal(18,2) comment '�ɽ��ݶ�',
   VALID_AMOUNT         decimal(18,4) comment '�ɽ��ܽ��',
   ACTUAL_AMOUNT        decimal(18,4) comment 'ʵ��֧�����',
   COUPON_AMOUNT        decimal(18,4) comment 'ȯ�ֿ۽��',
   POINT_AMOUNT         decimal(18,4) comment '���ֵֿ۽��',
   ORIGINAL_ORDER_NO    varchar(25) comment 'ԭ�����ţ����ڹ����˻�ʱ��ԭ������',
   REFUND_FLAG          tinyint comment '0: δ�����˿Ĭ�ϣ� 1:�����˿�  2:�����˿� 3:ȫ���˿�',
   IS_CANCEL_AUDIT      tinyint comment 'ȡ������ʱ�Ƿ���Ҫ�˹���� 0: ����Ҫ  1: ��Ҫ   Ĭ��Ϊ0',
   REMARK               varchar(255) comment '����ժҪ',
   RETURN_GOOD_CODE     varchar(20) comment '�����ţ������ò�Ʒ/ҵ��ϵͳ��Ҫ���ص���ˮ��',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱��� 
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=utf8 COMMENT='������';


/*==============================================================*/
/* Table: T_ORDER_AUDIT                                         */
/*==============================================================*/
create table T_ORDER_AUDIT
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '����ID',
   TYPE                 tinyint comment '1:ȡ��������  Ŀǰֻ����һ����ˣ�������չ',
   STATUS               tinyint comment '״̬ 0������� 1: ���ͨ�� 2����˾ܾ�',
   REMARK               varchar(255) comment '���ͨ����ܾ��ı�ע',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱���',
   CREATE_TIME          timestamp comment '����ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������˱�һЩ��Ҫ��˵Ĳ�����¼�ڴ˱��У�֧��ͬһҵ�񳡾��Ķ༶��˲���';


/*==============================================================*/
/* Table: T_ORDER_COUPON                                        */
/*==============================================================*/
create table T_ORDER_COUPON
(
   ID                   bigint not null auto_increment comment '����',
   ORDER_ID             bigint not null comment '����ID',
   COUPON_NO            varchar(20) comment 'ȯ��',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱��
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱��',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='������ȯ��Ϣ';

/*==============================================================*/
/* Table: T_ORDER_ITEM                                          */
/*==============================================================*/
create table T_ORDER_ITEM
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '����ID',
   ORDER_ITEM_NO        varchar(18) comment '����������',
   SALE_ORG_NO          varchar(32) not null comment '���ۻ������',
   MDSE_NO              varchar(10) comment '��Ʒ����',
   EX_PRODUCT_NO        varchar(8) comment '��Ʒ����',
   SKU_ID               bigint comment 'SKUID��浥λ',
   TA_NO                varchar(20) comment 'TA����',
   MDSE_VERSION         tinyint comment '��Ʒ�汾��',
   MDSE_NAME            varchar(100) comment '��Ʒ����',
   QUANTITY             decimal(18,2) comment '��Ʒ����',
   PRICE                decimal(18,4) comment '��Ʒ���۵���/��Ʒ��ֵ',
   PAY_PRICE            decimal(18,4) comment '���ڲƸ�����Ʒ����������Ľ��',
   PROD_CAT_NO          varchar(10),
   SALE_CAT_CODE        varchar(10),
   SETTLE_PRICE         decimal(18,4) comment '���̼ҽ����õļ۸�',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱���
            ',
   CREATE_TIME          timestamp comment '����ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '������id',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COMMENT='���������';


/*==============================================================*/
/* Table: T_ORG_CUSTOMER                                        */
/*==============================================================*/
create table T_ORG_CUSTOMER
(
   ID                   bigint not null auto_increment comment 'ID',
   CUST_NO              varchar(15) not null comment '�ͻ����',
   LEVEL                tinyint comment '��Ȩ����',
   CREATE_BY            varchar(15) character set utf8 comment '����������id 
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '������id',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�����ͻ���Ȩ���ñ�';

/*==============================================================*/
/* Table: T_ORG_CUSTOMER_LOG                                    */
/*==============================================================*/
create table T_ORG_CUSTOMER_LOG
(
   ID                   bigint not null auto_increment comment 'ID',
   CUST_NO              varchar(15) not null comment '�ͻ����',
   OPT_ROLE             varchar(20) comment '������ɫ',
   OPT_TYPE             tinyint comment '1: һ����Ȩ 2:: ������Ȩ  3: ������Ȩ',
   CREATE_BY            varchar(15) character set utf8 comment '����������id 
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '������id',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�����ͻ���Ȩ��־��';


/*==============================================================*/
/* Table: T_PAYMENT_REFUND_LOG                                  */
/*==============================================================*/
create table T_PAYMENT_REFUND_LOG
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '����ID',
   ORDER_ITEM_ID        bigint comment '��������ID ����֧�ֶ������˿�����ֶ�Ϊ����Ϊȫ�������˿�',
   TYPE                 tinyint comment '1:֧����¼ 2���˿��¼ 3��ת�˼�¼',
   PAYMENT_NO           varchar(21) not null comment '֧����ˮ��',
   CURRENCY             char(3) comment '����',
   AMOUNT               decimal(18,4) not null,
   STATUS               tinyint not null comment '0: ��֧��  1: ֧���ɹ�  2: ֧��ʧ��  3: ���˿�  4: �˿�ɹ�  5: �˿�ʧ�� 6����Ӫ���� 7:��ʱ',
   PAYMENT_TIME         timestamp not null comment '֧��ʱ��',
   REMARK               varchar(255) comment '��¼ʧ��ԭ����߲��ر�ע����Ϣ',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱���',
   CREATE_TIME          timestamp comment '����ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='֧���˿��¼��';



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='����/����嵥��';

/*==============================================================*/
/* Table: T_RISK_ASSESS_QUESTIONAIRE                            */
/*==============================================================*/
create table T_RISK_ASSESS_QUESTIONAIRE
(
   ID                   bigint not null auto_increment comment 'ID',
   TYPE                 tinyint not null comment '0:���յȼ����� 1:�����ʺ϶Ⱦ���  Ĭ��Ϊ0',
   PAPER_NO             varchar(32) not null,
   PAPER_NAME           varchar(60) not null comment '�Ծ�����',
   QUESTION_NO          varchar(10) not null comment '������',
   BUSINESS_TYPE        char(2) comment 'ҵ�����࣬�����ֶ�',
   QUESTION_TYPE        tinyint comment '0 ��ѡ��Ŀ 1 ��ѡ��Ŀ Ĭ��Ϊ0',
   OPTION_TIP           varchar(20) comment '����Ϊnull ����ΪA��B��C��D',
   CONTENT              varchar(255) comment '��ʾ����',
   SCORE                decimal(4,2) comment '��Ϊ��ʱ����ֵ',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱��� 
            ',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='���������ʾ��';


/*==============================================================*/
/* Table: T_RISK_ASSESS_RESULT                                  */
/*==============================================================*/
create table T_RISK_ASSESS_RESULT
(
   ID                   bigint not null auto_increment comment 'ID',
   CUST_NO              varchar(15) not null comment '�ͻ����',
   CUST_NAME            varchar(60) comment '��Ա����',
   CERT_TYPE            varchar(2) not null comment '֤������ 1�����֤ 2������ �����Ի�Ա���Ķ���Ϊ׼',
   CERT_NO              varchar(20) not null comment '֤������',
   PROD_CAT_NO          varchar(10) not null comment '��Ӧ��Ʒ���࣬������ơ����𡢹��������Ӧ��Ʒ�����еı���',
   RISK_LEVEL           tinyint not null comment '�ͻ��ύ�ʾ�󣬸��ݷ���������׼�ó��ͻ��ķ��յȼ�',
   ANSWER               varchar(30),
   SCORE                char(3),
   CHANNEL              char(3) comment '�������� 204:���� 208:app 101:����',
   START_TIME           timestamp comment 'Ĭ�ϴ浱ǰ����ʱ��',
   END_TIME             timestamp comment 'Ĭ��Ϊ��Ч���ں�һ��',
   IS_FACE_SIGN         tinyint comment '0: ���� 1: ��   ��Ϊ�����й������ʱ��Ϊ��',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱���',
   CREATE_TIME          timestamp comment '����ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ͻ����������';

/*==============================================================*/
/* Table: T_RISK_ASSESS_STANDARD                                */
/*==============================================================*/
create table T_RISK_ASSESS_STANDARD
(
   ID                   bigint not null auto_increment comment 'ID',
   CUSTOMER_TYPE        tinyint comment '1�����˿ͻ� 2�������ͻ�    Ĭ��Ϊ���˿ͻ�',
   CUSTOMER_LEVEL       tinyint comment '�ͻ��㼶����δʹ�ã���ֵΪ0',
   TYPE                 tinyint not null comment '�ʾ�����',
   PROD_CAT_NO          varchar(10) not null comment '��Ӧ��Ʒ���࣬������ơ����𡢹��������Ӧ��Ʒ�����еı���',
   PAPER_NO             varchar(32) not null comment 'ÿ���ʾ��Ψһ���',
   MIN_SCORE            decimal(4,2) not null,
   MAX_SCORE            decimal(4,2) not null,
   RISK_LEVEL           tinyint not null,
   VALID_TIME           timestamp,
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='����������׼��';


/*==============================================================*/
/* Table: T_SETTLEMENT                                          */
/*==============================================================*/
create table T_SETTLEMENT
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '����ID',
   ORDER_ITEM_ID        bigint not null comment '��������ID ����֧�ֶ������˿�����ֶ�Ϊ����Ϊȫ�������˿�',
   STATUS               tinyint comment '����״̬  1�������ɽ��㵥 2.�ѽ��� 3.��˾ܾ� 4.δ���ɽ��㵥',
   SETTLE_PRICE         decimal(18,4),
   SETTLOR_NAME         varchar(60),
   SETTLE_TIME          timestamp comment '����ʱ��',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱���
            ',
   CREATE_TIME          timestamp comment '֧����¼����ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�����¼��';


/*==============================================================*/
/* Table: T_TRADE_FAIL                                          */
/*==============================================================*/
create table T_TRADE_FAIL
(
   ID                   bigint not null auto_increment comment 'ID',
   ORDER_ID             bigint not null comment '����ID',
   TYPE                 tinyint comment '1:ȡ������ 2:����ʧЧ 3:��Ȩ��ͨ��',
   STATUS               tinyint comment '״̬ 0: ����� 1��ʧ����Ч 2: ��˾ܾ� �� ����ȡ�������������״̬���������͵Ľ���ʧ��Ĭ��ֱ��Ϊ1',
   FAIL_TIME            timestamp comment '����ʧ����Ч��ʱ�䣬��״̬��Ϊ2��ʱ��',
   FAIL_REASON          varchar(255) comment 'ʧ�ܱ�ע��Ϣ�����磺�û�����ȡ�����������ؽ���ʧ��, ,��ʱ�ȵ�',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱���',
   CREATE_TIME          timestamp comment '����ʱ�䣬����ȡ������������ʱ�伴Ϊ�û�����ȡ��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='����ʧ�ܼ�¼�����ڼ�¼����ȡ��������ʧЧ��Ԥ��Ȩ��ͨ���Ƚ���ʧ������µ���Ϣ����˲�����¼';

/*==============================================================*/
/* Table: T_USER_CONTRACT                                       */
/*==============================================================*/
create table T_USER_CONTRACT
(
   ID                   bigint not null auto_increment comment 'ID',
   USER_CONTRACT_NO     varchar(21) not null comment '����ǩԼ����Ϊ��',
   MDSE_NO              varchar(10) comment '��Ʒ���',
   EX_PRODUCT_NO        varchar(8) comment '��Ʒ����',
   SKU_ID               bigint comment 'SKUID��浥λ',
   CONTRACT_MODE_CODE   varchar(10) comment '��Լģ�ʹ���',
   CONTRACT_MODE_VERSION tinyint comment '��Լģ�Ͱ汾��',
   CUST_NO              varchar(15) not null comment '�ͻ����',
   SIGN_TIME            timestamp not null comment 'ǩԼ/���ʱ��',
   TYPE                 tinyint not null comment '1:Ǯ��ǩԼ 2:���ǩԼ 3:��������ǩԼ 4:ֱ������ǩԼ 5:�����ǩԼ 6:�������ǩԼ 7:�󶨿�ǩԼ  8:ˮ�Ѵ��۷�  9:��Ѵ��ɷ�  10:ú�Ѵ��ɷ� 11:���ÿ����ɷ� 12:������ȯ 13:������Ǯ�� 14:���֧��ǩԼ15:С������֧��ǩԼ',
   VALID_TIME           timestamp not null comment '��Լ��Чʱ��',
   INVALID_TIME         timestamp not null comment '��ԼʧЧʱ��',
   STATUS               tinyint not null comment '1:���룺�����ۻ�������ί��ƽ̨ǩԼ����������ǩԼ
            2:�����Ч����ί��ƽ̨ǩԼ��������Լ����Ч
            3:��������ԼʧЧ����Լ�෽����Ʒ���߷����Լ�����
            4:���ڣ��ͻ��˻����壬���ߺ�Լ��Ч���ѹ�
            5:��Լ������
            6:ʧ�ܣ�������Լʱ�����쳣',
   IS_TERMINATE         tinyint comment '1:�� 0:��  Ĭ��Ϊ��',
   IS_REGULAR           tinyint comment '1:�� 0:��  Ĭ��Ϊ��  ��Ϊ��Ͷ�����۵ȶ���ִ�еĺ�Լ��Ϊ��',
   FIRST_PARTY_CODE     varchar(10) comment '�׷���ż���Ա���',
   SECOND_PARTY_CODE    varchar(10) comment '�ҷ���ż���������',
   RISK_LEVEL           tinyint comment '��Ա��Ӧ�ķ����ȼ���������������Ϊ��',
   ORG_NO               varchar(16) comment '��ǩԼ�������,����ҵ�������ж��Ƿ����롣09����������18-��ͨ��ܡ�24-������ȯ  ��дȯ�̱�ţ�21-�������Ǽǻ�������',
   CHANNEL_NO           varchar(5) comment '���ⲿ������',
   CHANNEL_ORG_NO       varchar(5) comment '��Ӧ������еĵ����������',
   REQUEST_SERIAL_NO    varchar(20) comment '�����·�ǩԼ����ʱ����ˮ��',
   REQUEST_TIME         timestamp comment '����������ԭ����ʱ�䣬��ʽΪYYYYMMDDhhmmss',
   DESCRIPTION          varchar(255) comment '����Լǩ��ԭ�򣬱����Լ����������',
   REMARK               varchar(255) comment '��ע',
   VERSION              tinyint comment '�ͻ���Լ�汾��',
   CREATE_BY            varchar(15) character set utf8 comment '�����˱���',
   CREATE_TIME          timestamp comment '��������ʱ��',
   UPDATE_BY            varchar(15) character set utf8 comment '�����˱���',
   UPDATE_TIME          timestamp comment '����ʱ��',
   DELETE_FLAG          tinyint comment 'ɾ����ʶ 0����Ч 1����ɾ��',
   primary key (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ͻ���Լ��Ϣ��';


/*==============================================================*/
/* �޸��ֶγ���                       */
/* Created on:     2015/12/23 15:07:18                          */
/*==============================================================*/
ALTER TABLE `t_user_contract`
MODIFY COLUMN `FIRST_PARTY_CODE`  varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '�׷���ż���Ա���' AFTER `IS_REGULAR`,
MODIFY COLUMN `SECOND_PARTY_CODE`  varchar(21) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '�ҷ���ż���������' AFTER `FIRST_PARTY_CODE`;

ALTER TABLE `t_contract_party_info`
MODIFY COLUMN `SECOND_AGENCY_NO`  varchar(21) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '�ҷ��������' AFTER `FIRST_FINANCIAL_ACCOUNT`;


/*==============================================================*/
/* �޸��ֶγ���                       */
/* Created on:     2015/12/30 10:43:18                          */
/*==============================================================*/
ALTER TABLE `t_user_contract`
MODIFY COLUMN `MDSE_NO`  varchar(15) CHARACTER SET utf8  DEFAULT NULL COMMENT '��Ʒ����' ;


ALTER TABLE `t_order_item`
MODIFY COLUMN `MDSE_NO`  varchar(15) CHARACTER SET utf8 DEFAULT NULL COMMENT '��Ʒ����';
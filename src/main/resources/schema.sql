-- Temporarily disabling referential constraints
SET FOREIGN_KEY_CHECKS=0; 

-- Demo Table
-- initialize tables
DROP TABLE IF EXISTS `BANK_ACCOUNT`;

create table BANK_ACCOUNT
(
  ID        BIGINT not null,
  FULL_NAME VARCHAR(128) not null,
  BALANCE   DOUBLE not null
) ;

alter table BANK_ACCOUNT add constraint BANK_ACCOUNT_PK primary key (ID);
Insert into Bank_Account(ID, Full_Name, Balance) values (1, 'Tom', 1000);
Insert into Bank_Account(ID, Full_Name, Balance) values (2, 'Jerry', 2000);
Insert into Bank_Account(ID, Full_Name, Balance) values (3, 'Donald', 3000);
commit;

-- initialize tables
DROP TABLE IF EXISTS `user_authority`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `authority`;

CREATE TABLE user
(
id bigint NOT NULL AUTO_INCREMENT,
username VARCHAR(50) NOT NULL,
password VARCHAR(100) NOT NULL,
firstname VARCHAR(50) NOT NULL,
lastname VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
enabled boolean,
lastpasswordresetdate timestamp NOT NULL,
active_date datetime,
inactive_date datetime,
create_date datetime DEFAULT CURRENT_TIMESTAMP,
update_date datetime,
create_user bigint,
update_user bigint,
CONSTRAINT user_pkey PRIMARY KEY (id),
CONSTRAINT uk_user_username UNIQUE KEY(username),
CONSTRAINT fk_user_create_user FOREIGN KEY (create_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_user_update_user FOREIGN KEY (update_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TABLE IF EXISTS `authority`;

CREATE TABLE authority
(
id bigint NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
description VARCHAR(100) NOT NULL,
CONSTRAINT authority_pkey PRIMARY KEY (id),
CONSTRAINT uk_authority_name UNIQUE KEY(name)
);

CREATE TABLE user_authority
(
user_id bigint NOT NULL,
authority_id bigint NOT NULL,
CONSTRAINT user_authority_pkey PRIMARY KEY (user_id,authority_id),
CONSTRAINT fk_authority_id_user_authority FOREIGN KEY (authority_id) REFERENCES authority (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_user_id_user_authority FOREIGN KEY (user_id) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);


INSERT INTO USER (ID, USERNAME, PASSWORD, FIRSTNAME, LASTNAME, EMAIL, ENABLED, LASTPASSWORDRESETDATE, create_user) VALUES (1, 'admin', '$2a$08$lDnHPz7eUkSi6ao14Twuau08mzhWrL4kyZGGU5xfiGALO/Vxd5DOi', 'admin', 'admin', 'admin@admin.com', 1, STR_TO_DATE('01-01-2016', 'dd-MM-yyyy'), 1);
INSERT INTO USER (ID, USERNAME, PASSWORD, FIRSTNAME, LASTNAME, EMAIL, ENABLED, LASTPASSWORDRESETDATE, create_user) VALUES (2, 'user', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'user', 'user', 'enabled@user.com', 1, STR_TO_DATE('01-01-2016','dd-MM-yyyy'), 1);
INSERT INTO USER (ID, USERNAME, PASSWORD, FIRSTNAME, LASTNAME, EMAIL, ENABLED, LASTPASSWORDRESETDATE, create_user) VALUES (3, 'disabled', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'user', 'user', 'disabled@user.com', 0, STR_TO_DATE('01-01-2016','dd-MM-yyyy'), 1);

INSERT INTO AUTHORITY (ID, NAME, DESCRIPTION) VALUES (1, 'ROLE_ADMIN', '管理者');
INSERT INTO AUTHORITY (ID, NAME, DESCRIPTION) VALUES (2, 'ROLE_USER', '一般用戶');


INSERT INTO USER_AUTHORITY (USER_ID, AUTHORITY_ID) VALUES (1, 1);
INSERT INTO USER_AUTHORITY (USER_ID, AUTHORITY_ID) VALUES (1, 2);
INSERT INTO USER_AUTHORITY (USER_ID, AUTHORITY_ID) VALUES (2, 2);
INSERT INTO USER_AUTHORITY (USER_ID, AUTHORITY_ID) VALUES (3, 2);

-- Enable referential constraints
SET FOREIGN_KEY_CHECKS=1; 
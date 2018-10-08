-- Temporarily disabling referential constraints
SET FOREIGN_KEY_CHECKS=0; 

-- initialize tables
DROP TABLE IF EXISTS `system_config`;
DROP TABLE IF EXISTS `user_profile`;
DROP TABLE IF EXISTS `app_codes`;

CREATE TABLE system_config 
(
id bigint NOT NULL auto_increment,
param_name VARCHAR(100) NOT NULL,
param_value VARCHAR(100) NOT NULL,
param_desc VARCHAR(100),
note text,
create_date datetime DEFAULT CURRENT_TIMESTAMP,
update_date datetime,
create_user bigint,
update_user bigint,
CONSTRAINT pk_systemconfig PRIMARY KEY (id),
CONSTRAINT uk_systemconfig_param_name UNIQUE KEY(param_name),
CONSTRAINT fk_systemconfig_create_user FOREIGN KEY (create_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_systemconfig_update_user FOREIGN KEY (update_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE user_profile 
(
id bigint NOT NULL auto_increment,
user_id bigint NOT NULL,
param_name VARCHAR(100) NOT NULL,
param_value VARCHAR(100) NOT NULL,
param_desc VARCHAR(100),
note text,
create_date datetime DEFAULT CURRENT_TIMESTAMP,
update_date datetime,
create_user bigint,
update_user bigint,
CONSTRAINT pk_user_profile PRIMARY KEY (id),
CONSTRAINT uk_user_profile_param_name UNIQUE KEY(param_name),
CONSTRAINT fk_user_profile_user_id FOREIGN KEY (user_id) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_user_profile_create_user FOREIGN KEY (create_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_user_profile_update_user FOREIGN KEY (update_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE app_codes
(
id bigint NOT NULL auto_increment,
app_name VARCHAR(100) not null,
code_type VARCHAR(50) not null,
code_value VARCHAR(100) NOT NULL,
code_desc text,
code_desc_eng text,
create_date datetime DEFAULT CURRENT_TIMESTAMP,
update_date datetime,
create_user bigint,
update_user bigint,
CONSTRAINT pk_app_codes PRIMARY KEY (id),
CONSTRAINT uk_app_codes_app_name UNIQUE KEY (app_name, code_type, code_value ),
CONSTRAINT fk_app_codes_create_user FOREIGN KEY (create_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_app_codes_update_user FOREIGN KEY (update_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);



-- Enable referential constraints
SET FOREIGN_KEY_CHECKS=1; 
-- Temporarily disabling referential constraints
SET FOREIGN_KEY_CHECKS=0;

-- initialize tables
DROP TABLE IF EXISTS `company`;
DROP TABLE IF EXISTS `department`;
DROP TABLE IF EXISTS `user_details`;

CREATE TABLE company 
(
id bigint NOT NULL auto_increment,
code VARCHAR(60) NOT NULL,
name VARCHAR(120) NOT NULL,
name_eng VARCHAR(120) ,
superintendent VARCHAR(120) NOT NULL,
address VARCHAR(255) NOT NULL,
address_eng VARCHAR(255),
telephone VARCHAR(30),
fax VARCHAR(30),
website VARCHAR(30),
note text,
start_date datetime,
end_date datetime,
create_date datetime DEFAULT CURRENT_TIMESTAMP,
update_date datetime,
create_user bigint,
update_user bigint,
CONSTRAINT pk_company PRIMARY KEY (id),
CONSTRAINT uk_company_code UNIQUE KEY(code),
CONSTRAINT uk_company_name UNIQUE KEY(name),
CONSTRAINT fk_company_create_user FOREIGN KEY (create_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_company_update_user FOREIGN KEY (update_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

INSERT INTO `company` (`id`, `code`, `name`, `name_eng`, `superintendent`, `address`, `address_eng`, `telephone`, `fax`, `website`, `note`, `start_date`, `end_date`, `create_date`, `update_date`, `create_user`, `update_user`) VALUES
(1, 'DB', '資料庫公司', 'Data Base', 'POLIN', 'Data Base', 'Data Base', NULL, NULL, NULL, NULL, '1900-01-01 00:00:00', NULL, '2019-01-16 11:48:29', NULL, 1, NULL),
(100, 'Demo', '範例公司', 'Demo', 'Scott', '台中', 'Taichung', NULL, NULL, NULL, NULL, '1900-01-01 00:00:00', NULL, '2019-01-17 11:22:00', NULL, 1, NULL);

CREATE TABLE department 
(
id bigint NOT NULL auto_increment,
name VARCHAR(120) NOT NULL,
name_eng VARCHAR(120) ,
cost_center VARCHAR(60),
company_id bigint NOT NULL,
manager_id bigint,
upper_dept_id bigint,
start_date datetime,
end_date datetime,
create_date datetime DEFAULT CURRENT_TIMESTAMP,
update_date datetime,
create_user bigint,
update_user bigint,
CONSTRAINT pk_department PRIMARY KEY (id),
CONSTRAINT uk_department_name UNIQUE KEY(name),
CONSTRAINT fk_department_company_id FOREIGN KEY (company_id) REFERENCES company (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_department_manager_id FOREIGN KEY (manager_id) REFERENCES user_details (id) MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
CONSTRAINT fk_department_upper_dept_id FOREIGN KEY (upper_dept_id) REFERENCES department (id) MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
CONSTRAINT fk_department_create_user FOREIGN KEY (create_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_department_update_user FOREIGN KEY (update_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

INSERT INTO `department` (`id`, `name`, `name_eng`, `cost_center`, `company_id`, `manager_id`, `upper_dept_id`, `start_date`, `end_date`, `create_date`, `update_date`, `create_user`, `update_user`) VALUES
(1, '總部', 'HQ', '總部', 1, NULL, NULL, '1900-01-01 00:00:00', NULL, '2019-01-16 11:52:27', NULL, 1, NULL),
(100, '總經理室', 'CEO', 'CEO', 100, NULL, NULL, '1900-01-01 00:00:00', NULL, '2019-01-17 11:23:12', NULL, 1, NULL),
(101, '管理室', 'CFO', 'CFO', 100, 100, 100, '1900-01-01 00:00:00', NULL, '2019-01-17 11:26:33', NULL, 1, NULL),
(102, '資訊處', 'IT', 'IT', 100, 101, 101, '1900-01-01 00:00:00', NULL, '2019-01-17 11:27:24', NULL, 1, NULL);

CREATE TABLE user_details 
(
id bigint NOT NULL auto_increment,
user_id bigint NOT NULL,
emp_no VARCHAR(30) NOT NULL,
company_id bigint,
department_id bigint,
manager_id bigint,
hire_date datetime,
resignation_date datetime,
job_title VARCHAR(50),
work_address VARCHAR(200),
create_date datetime DEFAULT CURRENT_TIMESTAMP,
update_date datetime,
create_user bigint,
update_user bigint,
CONSTRAINT pk_user_details PRIMARY KEY (id),
CONSTRAINT uk_user_details_emp_no UNIQUE KEY(emp_no),
CONSTRAINT fk_user_details_user_id FOREIGN KEY (user_id) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_user_details_company_id FOREIGN KEY (company_id) REFERENCES company (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_user_details_department_id FOREIGN KEY (department_id) REFERENCES department (id) MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
CONSTRAINT fk_user_details_manager_id FOREIGN KEY (manager_id) REFERENCES user_details (id) MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
CONSTRAINT fk_user_details_create_user FOREIGN KEY (create_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_user_details_update_user FOREIGN KEY (update_user) REFERENCES user (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

INSERT INTO `user_details` (`id`, `user_id`, `emp_no`, `company_id`, `department_id`, `manager_id`, `hire_date`, `resignation_date`, `job_title`, `work_address`, `create_date`, `update_date`, `create_user`, `update_user`) VALUES
(1, 1, '1', 1, 1, NULL, '1900-01-01 00:00:00', '1900-01-01 00:00:00', 'Administrator', NULL, '2019-01-16 11:54:24', NULL, 1, NULL),
(100, 5, '100', 100, 100, NULL, '1996-03-01 00:00:00', NULL, 'CEO', NULL, '2019-01-17 11:32:20', NULL, 1, NULL),
(101, 5, '101', 100, 101, 100, '1996-03-01 00:00:00', NULL, 'CFO', NULL, '2019-01-17 11:33:31', NULL, 1, NULL),
(102, 5, '102', 100, 102, 101, '1996-03-01 00:00:00', NULL, 'Dircetor', NULL, '2019-01-17 11:34:22', NULL, 1, NULL);


-- Enable referential constraints
SET FOREIGN_KEY_CHECKS=1; 
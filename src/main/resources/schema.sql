-- initialize tables
DROP TABLE IF EXISTS `user_authority`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `authority`;


CREATE TABLE user
(
id bigint NOT NULL,
username VARCHAR(50) NOT NULL,
password VARCHAR(100) NOT NULL,
firstname VARCHAR(50) NOT NULL,
lastname VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
enabled boolean,
lastpasswordresetdate timestamp NOT NULL,
CONSTRAINT user_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `authority`;

CREATE TABLE authority
(
id bigint NOT NULL,
name VARCHAR(50) NOT NULL,
CONSTRAINT authority_pkey PRIMARY KEY (id)
);

CREATE TABLE user_authority
(
user_id bigint NOT NULL,
authority_id bigint NOT NULL,
CONSTRAINT fk_authority_id_user_authority FOREIGN KEY (authority_id)
REFERENCES authority (id) MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT fk_user_id_user_authority FOREIGN KEY (user_id)
REFERENCES user (id) MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION
);
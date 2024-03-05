CREATE DATABASE shopapp;
use shopapp;

CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) DEFAULT '',
    password VARCHAR(100) NOT NULL,
    created_date DATETIME,
    updated_date DATETIME,
    is_active TINYINT(1) DEFAULT 1,
    date_of_birth DATE,
    facebook_account_id INT DEFAULT 0,
    google_account_id INT DEFAULT 0
);

CREATE TABLE tokens(
    id int PRIMARY KEY AUTO_INCREMENT,
    token VARCHAR(255) unique NOT null,
    token_type VARCHAR(50) not null,
    expiration_date DATETIME,
    revoked TINYINT(1) not null,
    expired TINYINT(1) not null,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE social_accounts(
    id int PRIMARY key AUTO_INCREMENT,
    provider VARCHAR(20) not null comment 'Ten nha social network',
    provider_id varchar(50) not null,
    email varchar(150) not null comment 'email tai khoan',
    name varchar(100) not null comment 'ten nguoi dung',
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
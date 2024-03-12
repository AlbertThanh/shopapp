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
ALTER TABLE users ADD COLUMN role_id INT;

CREATE TABLE roles(
    id INT PRIMARY KEY,
    name varchar(20) not null,
)
ALTER TABLE users ADD FOREIGN KEY(role_id) REFERENCES roles(id);

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
--login tu facebook or google
CREATE TABLE social_accounts(
    id int PRIMARY key AUTO_INCREMENT,
    provider VARCHAR(20) not null comment 'Ten nha social network',
    provider_id varchar(50) not null,
    email varchar(150) not null comment 'email tai khoan',
    name varchar(100) not null comment 'ten nguoi dung',
    user_id int,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

--bang danh muc san pham
CREATE TABLE categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL DEFAULT '' comment 'ten danh muc, do dien tu'
);

--bang chua san pham(Product)
CREATE TABLE products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(350) comment 'ten san pham',
    price FLOAT NOT NULL CHECK(price >= 0),
    thumbnail varchar(300) DEFAULT '',
    description LONGTEXT DEFAULT '',
    created_at DATETIME,
    updated_at DATETIME,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
--dat hang
CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    fullname varchar(100) DEFAULT '',
    email varchar(100) DEFAULT '',
    phone_number varchar(20) NOT NULL,
    address varchar(100) not null,
    note varchar(100) DEFAULT '',
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status varchar(20),
    total_money FLOAT CHECK(total_money >=0)
);
ALTER TABLE orders ADD COLUMN shipping_method VARCHAR(100);
ALTER TABLE orders ADD COLUMN shipping_adrress VARCHAR(200);
ALTER TABLE orders ADD COLUMN shipping_date DATE;
ALTER TABLE orders ADD COLUMN tracking_number VARCHAR(100);
ALTER TABLE orders ADD COLUMN payment_method VARCHAR(100);
ALTER TABLE orders ADD COLUMN active TINYINT(1);

ALTER TABLE orders MODIFY COLUMN status ENUM('pending','processing','shipped','delivered', 'cancelled') comment 'Trang thai don hang';

CREATE TABLE order_details(
    id INT PRIMARY KEY,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    price FLOAT CHECK (price >= 0),
    number_of_product INT CHECK (number_of_product >= 0),
    total_money FLOAT CHECK (number_of_product >= 0),
    color VARCHAR(20) DEFAULT ''
);
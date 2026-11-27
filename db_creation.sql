CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE,
hashed_pw VARCHAR(255) NOT NULL,
admin BOOLEAN NOT NULL DEFAULT FALSE,
blocked BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE closure (
id INT AUTO_INCREMENT PRIMARY KEY,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
id_admin INT NOT NULL,
reason VARCHAR(255),
CONSTRAINT closure_dates CHECK (end_date >= start_date),
CONSTRAINT fk_closure_user FOREIGN KEY (id_admin) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE product (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
quantity INT NOT NULL DEFAULT 0,
price INT NOT NULL DEFAULT 0,
available BOOLEAN NOT NULL DEFAULT TRUE,
CONSTRAINT product_quantity CHECK (quantity >= 0),
CONSTRAINT product_price CHECK (price >= 0)
);


CREATE TABLE menu (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
quantity INT NOT NULL DEFAULT 0,
price INT NOT NULL DEFAULT 0,
CONSTRAINT menu_quantity CHECK (quantity >= 0),
CONSTRAINT menu_price CHECK (price >= 0)
);


CREATE TABLE availability (
id INT AUTO_INCREMENT PRIMARY KEY,
id_menu INT NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
weekday INT NOT NULL,
CONSTRAINT availability_dates CHECK (end_date >= start_date),
CONSTRAINT availability_weekday CHECK (weekday BETWEEN 1 AND 7),
CONSTRAINT fk_availability_menu FOREIGN KEY (id_menu) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE menu_product (
id_menu INT NOT NULL,
id_product INT NOT NULL,
quantity INT NOT NULL DEFAULT 1,
PRIMARY KEY (id_menu, id_product),
CONSTRAINT menu_product_quantity CHECK (quantity > 0),
CONSTRAINT fk_menu_product_menu FOREIGN KEY (id_menu) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_menu_product_product FOREIGN KEY (id_product) REFERENCES product(id) ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE orders (
id INT AUTO_INCREMENT PRIMARY KEY,
recovered BOOLEAN NOT NULL DEFAULT FALSE,
order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
pickup_date DATETIME NOT NULL,
recovered_date DATETIME NULL,
id_user INT NOT NULL,
price INT NOT NULL DEFAULT 0,
CONSTRAINT orders_price CHECK (price >= 0),
CONSTRAINT orders_pickup CHECK (pickup_date >= order_date),
CONSTRAINT fk_orders_user FOREIGN KEY (id_user) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE orders_menu (
id_order INT NOT NULL,
id_menu INT NOT NULL,
quantity INT NOT NULL DEFAULT 1,
price INT NOT NULL DEFAULT 0,
PRIMARY KEY (id_order, id_menu),
CONSTRAINT orders_menu_quantity CHECK (quantity > 0),
CONSTRAINT orders_menu_price CHECK (price >= 0),
CONSTRAINT fk_orders_menu_order FOREIGN KEY (id_order) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_orders_menu_menu FOREIGN KEY (id_menu) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE orders_product (
id_order INT NOT NULL,
id_product INT NOT NULL,
quantity INT NOT NULL DEFAULT 1,
price INT NOT NULL DEFAULT 0,
PRIMARY KEY (id_order, id_product),
CONSTRAINT orders_product_quantity CHECK (quantity > 0),
CONSTRAINT orders_product_price CHECK (price >= 0),
CONSTRAINT fk_orders_product_order FOREIGN KEY (id_order) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_orders_product_product FOREIGN KEY (id_product) REFERENCES product(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

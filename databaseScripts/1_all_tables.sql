CREATE DATABASE IF NOT EXISTS skyhat;

USE skyhat;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS dealers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS itemCPLog;
DROP TABLE IF EXISTS itemSPLog;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS orderStates;
DROP TABLE IF EXISTS purchaseOrders;
DROP TABLE IF EXISTS purchasedItems;
DROP TABLE IF EXISTS vendorOrders;
DROP TABLE IF EXISTS vendedItems;


CREATE TABLE IF NOT EXISTS users(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(200) NOT NULL,
phoneNumber VARCHAR(13) NOT NULL UNIQUE,
email VARCHAR(700) NOT NULL UNIQUE,
username VARCHAR(100) NOT NULL,
password VARCHAR(128) NOT NULL,
accessLevel INT NOT NULL DEFAULT 0,
updateTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
createTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dealers(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
agentName VARCHAR(100) NOT NULL,
firmName VARCHAR(360) NOT NULL,
email VARCHAR(400) NOT NULL,
phoneNumber VARCHAR(13) NOT NULL,
address VARCHAR(1000) NOT NULL,
updateTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
createTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customers(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
agentName VARCHAR(100) NOT NULL,
firmName VARCHAR(360) NOT NULL,
email VARCHAR(400) NOT NULL,
phoneNumber VARCHAR(13) NOT NULL,
address VARCHAR(1000) NOT NULL,
updateTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
createTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS items(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(270)
);

CREATE TABLE IF NOT EXISTS itemCPLog(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
itemId INT UNSIGNED NOT NULL,
FOREIGN KEY(itemId) REFERENCES items(id),
CP INT DEFAULT 0 NOT NULL,
createTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS itemSPLog(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
itemId INT UNSIGNED NOT NULL,
FOREIGN KEY(itemId) REFERENCES items(id),
SP INT DEFAULT 1 NOT NULL,
createTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS inventory(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
itemId INT UNSIGNED NOT NULL,
FOREIGN KEY(itemId) REFERENCES items(id),
currentQuantity INT DEFAULT 0 NOT NULL,
updateTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
createTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orderStates(
id INT AUTO_INCREMENT PRIMARY KEY,
stateTitle VARCHAR(100) NOT NULL,
stateText VARCHAR(250) NOT NULL,
stateColor VARCHAR(20) DEFAULT 'blue'
);

CREATE TABLE IF NOT EXISTS purchaseOrders(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
dealerId INT UNSIGNED NOT NULL,
FOREIGN KEY(dealerId) REFERENCES dealers(id),
name VARCHAR(70),
totalCost INT DEFAULT 0 NOT NULL,
userid INT UNSIGNED NOT NULL,
FOREIGN KEY(userid) REFERENCES users(id),
orderStatus INT,
FOREIGN KEY(orderStatus) REFERENCES orderStates(id),
paymentStatus INT DEFAULT 0, #0 - not paid, 1 - initiated, 2 - paid
updateTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
createTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS purchasedItems(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
purchaseId INT UNSIGNED NOT NULL,
FOREIGN KEY (purchaseId) REFERENCES purchaseOrders(id),
itemId INT UNSIGNED NOT NULL,
FOREIGN KEY (itemId) REFERENCES items(id),
quantity INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS vendorOrders(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
userid INT UNSIGNED NOT NULL,
FOREIGN KEY (userid) REFERENCES users(id),
customerId INT UNSIGNED NOT NULL,
FOREIGN KEY (customerId) REFERENCES customers(id),
totalCredit INT UNSIGNED DEFAULT 0 NOT NULL,
orderStatus INT,
FOREIGN KEY (orderStatus) REFERENCES orderStates(id),
deliveryDatetime DATETIME DEFAULT NULL,
paymentStatus INT DEFAULT NULL,
paymentDatetime DATETIME DEFAULT NULL,
updateTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
createTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS vendedItems(
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
orderId INT UNSIGNED NOT NULL,
FOREIGN KEY (orderId) REFERENCES vendorOrders(id),
itemId INT UNSIGNED NOT NULL,
FOREIGN KEY(itemId) REFERENCES items(id),
quantity INT NOT NULL DEFAULT 0
);
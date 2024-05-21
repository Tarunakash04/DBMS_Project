1. Users:

user_id (INT PRIMARY KEY): Unique identifier for the user.
username (VARCHAR(255) UNIQUE): Username for login.
password_hash (VARCHAR(255)): Secure hash of the user's password.
email (VARCHAR(255) UNIQUE): User's email address (optional).

2. Wallets:

wallet_id (INT PRIMARY KEY): Unique identifier for the wallet.
user_id (INT FOREIGN KEY REFERENCES Users(user_id)): Links the wallet to a specific user.
name (VARCHAR(255)): User-defined name for the wallet.
balance (DECIMAL(20,8)): Total Bitcoin balance in the wallet (including unspent outputs).
created_at (DATETIME): Timestamp of wallet creation.

3. Transactions:

transaction_id (INT PRIMARY KEY): Unique identifier for the transaction.
wallet_id (INT FOREIGN KEY REFERENCES Wallets(wallet_id)): Links the transaction to a specific wallet.
tx_hash (VARCHAR(255)): The Bitcoin transaction hash from the blockchain. (optional)
type (ENUM('sent', 'received')): Indicates whether the transaction sent or received Bitcoin.
amount (DECIMAL(20,8)): Amount of Bitcoin involved in the transaction.
fee (DECIMAL(20,8)): Transaction fee paid (optional).
counterparty_address (VARCHAR(255)): Address of the sender/receiver (depending on transaction type). (optional)
confirmation_count (INT): Number of confirmations for the transaction on the blockchain.
created_at (DATETIME): Timestamp of the transaction.

4. Addresses:

address (VARCHAR(255) PRIMARY KEY): The Bitcoin address itself.
wallet_id (INT FOREIGN KEY REFERENCES Wallets(wallet_id)): Links the address to a specific wallet.

5. Orders:

order_id (INT PRIMARY KEY): Unique identifier for the order.
wallet_id (INT FOREIGN KEY REFERENCES Wallets(wallet_id)): Links the order to a specific wallet.
type (ENUM('buy', 'sell')): Indicates whether the order is to buy or sell Bitcoin.
amount (DECIMAL(20,8)): Amount of Bitcoin involved in the order.
price (DECIMAL(20,8)): Price per unit of Bitcoin for the order (optional).
status (ENUM('pending', 'completed', 'canceled')): Current status of the order.
created_at (DATETIME): Timestamp of the order creation.
exchange_id (INT FOREIGN KEY REFERENCES Exchanges(exchange_id)): Links the order to a specific exchange (optional).

6. Exchanges:

exchange_id (INT PRIMARY KEY): Unique identifier for the exchange.
name (VARCHAR(255)): Name of the Bitcoin exchange.
api_key (VARCHAR(255)): API key for the exchange (optional).
api_secret (VARCHAR(255)): API secret for the exchange (optional).
created_at (DATETIME): Timestamp of the exchange record creation.


CREATING TABLES

CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE
);

CREATE TABLE Wallets (
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  balance DECIMAL(20,8) NOT NULL,
  wallet_label CHAR(20),
  wallet_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

 CREATE TABLE Transactions (
  tx_hash VARCHAR(255),
  counterparty_address VARCHAR(255),
  transaction_id INT PRIMARY KEY,
  amount DECIMAL(20,8) NOT NULL,
  confirmation_count INT,
  fee DECIMAL(20,8)
  );

CREATE TABLE Addresses (
  address VARCHAR(255) PRIMARY KEY,
  wallet_id INT NOT NULL,
  FOREIGN KEY (wallet_id) REFERENCES Wallets(wallet_id)
);

CREATE TABLE Orders (
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  order_id INT PRIMARY KEY,
  wallet_id INT NOT NULL,
  status varchar(25),
  is_buy NUMBER(1) DEFAULT 0 NOT NULL,
  is_sell NUMBER(1) DEFAULT 0 NOT NULL,
  amount NUMBER(20,8) NOT NULL,
  price NUMBER(20,8),
  PRIMARY KEY (order_id),
  FOREIGN KEY (wallet_id) REFERENCES Wallets(wallet_id)
 
);

CREATE TABLE Exchanges (
  exchange_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL
);



INSERTING VALUES 

TABLE : 1

INSERT INTO users (USER_ID, USERNAME, PASSWORD_HASH, EMAIL)
VALUES (101, 'jane_smith', 'janes_pass123', 'jane.smith@example.com');

INSERT INTO users (USER_ID, USERNAME, PASSWORD_HASH, EMAIL)
VALUES (102, 'bob_jackson', 'B0b_pass789', 'bob.jackson@example.com');

INSERT INTO users (USER_ID, USERNAME, PASSWORD_HASH, EMAIL)
VALUES (103, 'emily_wilson', 'emily123!', 'emily.wilson@example.com');

INSERT INTO users (USER_ID, USERNAME, PASSWORD_HASH, EMAIL)
VALUES (104, 'mike_johnson', 'passw0rd456', 'mike.johnson@example.com');

INSERT INTO users (USER_ID, USERNAME, PASSWORD_HASH, EMAIL)
VALUES (105, 'sarah_anderson', 'codingrocks123', 'sarah.anderson@example.com');

TABLE : 2

INSERT INTO Wallets (balance, wallet_label, wallet_id, user_id) VALUES (100.00, 'Savings', 1, 101);

INSERT INTO Wallets (balance, wallet_label, wallet_id, user_id) VALUES (50.50, 'Expense', 2, 102);

INSERT INTO Wallets (balance, wallet_label, wallet_id, user_id) VALUES (200.00, 'Vacation', 3, 103);

INSERT INTO Wallets (balance, wallet_label, wallet_id, user_id) VALUES (75.25, 'Emergency', 4, 104);

INSERT INTO Wallets (balance, wallet_label, wallet_id, user_id) VALUES (300.00, 'Investment', 5, 105);

TABLE 3:

INSERT INTO Transactions (transaction_id, tx_hash, counterparty_address, amount, confirmation_count, fee) VALUES (1, 'tx_hash_1', 'counterparty_address_1', 1.23456789, 6,  0.00100000);

INSERT INTO Transactions (transaction_id, tx_hash, counterparty_address, amount, confirmation_count, fee) VALUES (2, 'tx_hash_2', 'counterparty_address_2', 5.67890123, 120, 0.00250000);

INSERT INTO Transactions (transaction_id, tx_hash, counterparty_address, amount, confirmation_count, fee) VALUES (3, 'tx_hash_3', 'counterparty_address_3', 0.10000000, 1,  0.00010000);

INSERT INTO Transactions (transaction_id, tx_hash, counterparty_address, amount, confirmation_count, fee) VALUES (4, 'tx_hash_4', 'counterparty_address_4', 0.50000000, 30, 0.00050000);

INSERT INTO Transactions (transaction_id, tx_hash, counterparty_address, amount, confirmation_count, fee) VALUES  (5, 'tx_hash_5', 'counterparty_address_5', 2.00000000, 2, 0.00020000);



TABLE : 6
INSERT INTO Exchanges (exchange_id, name, created_at)
VALUES (1, 'Exchange1', TIMESTAMP '2024-04-16 10:00:00');

INSERT INTO Exchanges (exchange_id, name, created_at)
VALUES (2, 'Exchange2', TIMESTAMP '2024-04-16 11:00:00');

INSERT INTO Exchanges (exchange_id, name, created_at)
VALUES (3, 'Exchange3', TIMESTAMP '2024-04-16 12:00:00');

INSERT INTO Exchanges (exchange_id, name, created_at)
VALUES (4, 'Exchange4', TIMESTAMP '2024-04-16 13:00:00');

INSERT INTO Exchanges (exchange_id, name, created_at)
VALUES (5, 'Exchange5', TIMESTAMP '2024-04-16 14:00:00');

TABLE : 4
INSERT INTO Addresses (address, wallet_id) VALUES ('Sunita Nagar, 1);

INSERT INTO Addresses (address, wallet_id) VALUES ('Rajesh Vihar, 2);

INSERT INTO Addresses (address, wallet_id) VALUES ('Amit Gupta Lane, 3);

INSERT INTO Addresses (address, wallet_id) VALUES ('Priya Enclave, 4);

INSERT INTO Addresses (address, wallet_id) VALUES ('Sanjay Chowk, 5);


TABLE : 5
INSERT INTO Orders (order_id, wallet_id, status, amount, price) 
VALUES (2, 2, 'Completed', 1.25, 750.00);

INSERT INTO Orders (order_id, wallet_id, status, amount, price) 
VALUES (3, 3, 'Pending', 2.75, 1200.00);

INSERT INTO Orders (order_id, wallet_id, status, amount, price) 
VALUES (4, 4, 'Cancelled', 0.75, 900.00);

INSERT INTO Orders (order_id, wallet_id, status, amount, price) 
VALUES (5, 5, 'Completed', 3.50, 1500.00);

INSERT INTO Orders (order_id, wallet_id, status, amount, price) 
VALUES (6, 1, 'Pending', 1.80, 850.00);

4C:
NORMALISATION:
1NF:
BEFORE:
Here's a User table in an unnormalized state for a Bitcoin management system:
This table combines information about the user and their Bitcoin holdings. It violates the principles of First Normal Form (1NF) because:
A user can have multiple Bitcoin addresses, leading to data redundancy.
Changes to account type information would require updates across multiple rows.
CREATE TABLE USERNAME (
  User_ID INT PRIMARY KEY,
  Username VARCHAR(20) NOT NULL,
  Email VARCHAR(20) NOT NULL,
  Phone_Number VARCHAR(20),
  Bitcoin_Address_1 VARCHAR(5),
  Bitcoin_Address_2 VARCHAR(5),
  Account_Type VARCHAR(20)
);

INSERT INTO USERNAME (User_ID, Username, Email, Phone_Number, Bitcoin_Address_1, Bitcoin_Address_2, Account_Type) VALUES (1, 'satoshi', 's@gmail.com', '+1234567890', 'fis85', NULL, 'Individual');

INSERT INTO USERNAME (User_ID, Username, Email, Phone_Number, Bitcoin_Address_1, Bitcoin_Address_2, Account_Type) VALUES(2, 'alicewonderland', 'a@xyz.com', '+9876543210', 'nfod4', 'bas61', 'Company');


After Normalization (1NF)

USER TABLE
CREATE TABLE User (
  User_ID INT PRIMARY KEY,
  Username VARCHAR(20) NOT NULL,
  Email VARCHAR(20) NOT NULL,
  Phone_Number VARCHAR(20),
   Account_Type VARCHAR(20)
);

INSERT INTO User (User_ID, Username, Email, Phone_Number, Bitcoin_Address_1, Bitcoin_Address_2, Account_Type) VALUES (1, 'satoshi', 's@gmail.com', '+1234567890','Individual');

INSERT INTO User (User_ID, Username, Email, Phone_Number, Bitcoin_Address_1, Bitcoin_Address_2, Account_Type) VALUES(2, 'alicewonderland', 'a@xyz.com', '+9876543210', 'Company');

BITCOIN ADDRESS TABLE
CREATE TABLE Bitcoin_Address (
  User_ID INT PRIMARY KEY REFERENCES User(User_ID),
  Bitcoin_Address VARCHAR(34)
);

INSERT INTO Bitcoin_Address (User_ID, Bitcoin_Address)
VALUES (1, 'bc1qaz2wlpqrstuwvxzy0');
INSERT INTO Bitcoin_Address (User_ID, Bitcoin_Address)
VALUES (2, 'bc1qpjl2wep8xpz2');

2NF:
BEFORE :
CREATE TABLE Wallets (
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  balance DECIMAL(20,8) NOT NULL,
  wallet_label CHAR(20),
  wallet_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

1. Wallets Table:
CREATE TABLE Wallets (
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  balance DECIMAL(20,8) NOT NULL,
  wallet_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Wallets (created_at, balance, wallet_label, user_id)
VALUES (CURRENT_TIMESTAMP, 10.00000000, 'Main Wallet', 1);

INSERT INTO Wallets (created_at, balance, wallet_label, user_id)
VALUES (CURRENT_TIMESTAMP, 5.23456789, 'Savings', 2);
2. Wallet_Labels Table (Optional):
CREATE TABLE Wallet_Labels (
  wallet_id INT PRIMARY KEY REFERENCES Wallets(wallet_id),  -- Optional foreign key
  user_id INT NOT NULL,
  wallet_label CHAR(20),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


INSERT INTO Wallet_Labels (wallet_id, user_id, wallet_label)
VALUES (1, 1, 'Main Wallet');  -- Wallet ID from Wallets table
INSERT INTO Wallet_Labels (wallet_id, user_id, wallet_label)
VALUES (2, 2, 'Savings');     -- Wallet ID from Wallets table

3NF:
before:

CREATE TABLE Transactions (
  tx_hash VARCHAR(255),
  counterparty_address VARCHAR(255),
  transaction_id INT PRIMARY KEY,
  amount DECIMAL(20,8) NOT NULL,
  confirmation_count INT,
  fee DECIMAL(20,8)
  );

After Normalization Tables:
1. Transactions Table:
CREATE TABLE Transactions (
  tx_hash VARCHAR(255),
  counterparty_address VARCHAR(255),
  transaction_id INT PRIMARY KEY,
  FOREIGN KEY (transaction_id) REFERENCES Transaction_Details(transaction_id)
);

INSERT INTO Transactions (tx_hash, counterparty_address, transaction_id)
VALUES ('txhash123', 'bc1qwertzyuiop', 1);
INSERT INTO Transactions (tx_hash, counterparty_address, transaction_id)
VALUES ('txhash456', 'bc1asdfghjkl', 2);

2. Transaction_Details Table:

CREATE TABLE Transaction_Details (
  transaction_id INT PRIMARY KEY REFERENCES Transactions(transaction_id),
  amount DECIMAL(20,8) NOT NULL,
  confirmation_count INT,
  fee DECIMAL(20,8)
);

INSERT INTO Transaction_Details (transaction_id, amount, confirmation_count, fee)
VALUES (1, 2.50000000, 3, 0.001);
INSERT INTO Transaction_Details (transaction_id, amount, confirmation_count, fee)
VALUES (2, 1.78900000, 1, 0.002);

4NF:

CREATE TABLE Transaction_Hash_Counterparty (
  transaction_id INT PRIMARY KEY,
  tx_hash VARCHAR(255),
  counterparty_address VARCHAR(255),
  FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);

INSERT INTO Transaction_Hash_Counterparty (transaction_id, tx_hash, counterparty_address)
VALUES (1, 'txhash123', 'bc1qwertzyuiop');

INSERT INTO Transaction_Hash_Counterparty (transaction_id, tx_hash, counterparty_address)
VALUES (2, 'txhash456', 'bc1asdfghjkl');

5NF:

CREATE TABLE Transaction_Hash (
  transaction_id INT PRIMARY KEY,
  tx_hash VARCHAR(255),
  FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);
CREATE TABLE Transaction_Counterparty (
  transaction_id INT PRIMARY KEY,
  counterparty_address VARCHAR(255),
  FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);
INSERT INTO Transaction_Hash (transaction_id, tx_hash)
VALUES (1, 'txhash123');

INSERT INTO Transaction_Hash (transaction_id, tx_hash)
VALUES (2, 'txhash456');
INSERT INTO Transaction_Counterparty (transaction_id, counterparty_address)
VALUES (1, 'bc1qwertzyuiop');
INSERT INTO Transaction_Counterparty (transaction_id, counterparty_address)
VALUES (2, 'bc1asdfghjkl');

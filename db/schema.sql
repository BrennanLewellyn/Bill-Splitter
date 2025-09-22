BEGIN;

CREATE DATABASE bill_splitter_db;
USE bill_splitter_db;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE bills (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'active'
);

CREATE TABLE friends (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    bill_id INTEGER REFERENCES bills(id) ON DELETE CASCADE
);

CREATE TABLE bill_items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price NUMERIC(10, 2),
    bill_id INTEGER REFERENCES bills(id) ON DELETE CASCADE
);

CREATE TABLE item_assignments (
    item_id INTEGER REFERENCES bill_items(id) ON DELETE CASCADE,
    friend_id INTEGER REFERENCES friends(id) ON DELETE CASCADE,
    is_paid BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (item_id, friend_id)
);

COMMIT;
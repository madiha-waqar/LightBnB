-- Drop tables if they exist with cascading dependencies
DROP TABLE IF EXISTS users CASCADE;

-- Create the users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);
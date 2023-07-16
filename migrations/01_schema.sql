/* Drop tables if they exist with cascading dependencies */
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS properties CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS property_reviews CASCADE;

/* Create the users table */
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

/* Create the properties table */
CREATE TABLE properties (
  id SERIAL PRIMARY KEY NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  thumbnail_photo_url VARCHAR(255) NOT NULL,
  cover_photo_url VARCHAR(255) NOT NULL,
  cost_per_night DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  parking_spaces SMALLINT NOT NULL DEFAULT 0,
  number_of_bathrooms SMALLINT NOT NULL DEFAULT 0,
  number_of_bedrooms SMALLINT NOT NULL DEFAULT 0,
  country VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  province VARCHAR(255) NOT NULL,
  post_code VARCHAR(255) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

/* Create the reservations table */
CREATE TABLE reservations (
  id SERIAL PRIMARY KEY NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE,
  guest_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

/* Create the property_reviews table */
CREATE TABLE property_reviews (
  id SERIAL PRIMARY KEY NOT NULL,
  rating SMALLINT NOT NULL DEFAULT 0,
  message TEXT,
  guest_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE,
  reservation_id INTEGER REFERENCES reservations(id) ON DELETE CASCADE
);
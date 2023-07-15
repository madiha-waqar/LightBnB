const properties = require("./json/properties.json");
const users = require("./json/users.json");

/// Connections

// Importing the Pool object from the 'pg' module
const { Pool } = require('pg');

// Creating a new Pool instance with the database connection configuration
const pool = new Pool({
  user: 'labber',
  password: '123',
  host: 'localhost',
  database: 'lightbnb'
});

// Test code to verify the connection is successfull
pool.query(`SELECT title FROM properties LIMIT 10;`).then(response => { response })


/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function (email) {
  return pool
    .query(`SELECT * FROM users WHERE email = $1`, [email])
    .then((result) => {
      // The promise resolves with a user object with the given email address, or null if that user does not exist
      return result.rows[0] || null;
    })
    .catch((err) => {
      console.log(err.message);
    });
};

/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function (id) {
  return pool
    .query(`SELECT * FROM users WHERE id = $1`, [id])
    .then((result) => {
      // The promise resolves with a user object with the given id, or null if that id does not exist
      return result.rows[0] || null;
    })
    .catch((err) => {
      console.log(err.message);
    });
};

/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser = function (user) {
  // Insert query to sign up a new user with auto-generated id
  return pool
    .query(`INSERT INTO users (name, email, password)
          VALUES ($1, $2, $3)
          RETURNING *;`, [user.name, user.email, user.password])
    .then((result) => {
      return result.rows[0];
    })
    .catch((err) => {
      console.log(err.message);
    })
};

/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function (guest_id, limit = 10) {
  return pool
    .query(`SELECT reservations.*, properties.*,avg(rating) as average_rating
      FROM reservations
      JOIN properties ON reservations.property_id = properties.id
      JOIN property_reviews ON properties.id = property_reviews.property_id
      WHERE reservations.guest_id = $1
      GROUP BY properties.id, reservations.id
      ORDER BY reservations.start_date
      LIMIT $2;`, [guest_id, limit])
    .then((result) => {
      return result.rows;
    })
    .catch((err) => {
      console.log(err.message);
    })
};

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = (options, limit = 10) => {

  // Setup an array to hold any parameters that may be available for the query
  const queryParams = [];

  // Start the query with all information that comes before the WHERE clause
  let queryString = `
  SELECT properties.*, avg(property_reviews.rating) as average_rating
  FROM properties
  JOIN property_reviews ON properties.id = property_id
  `;

  // Conditions for search filters
  // search option: city
  if (options.city) {
    queryParams.push(`%${options.city}%`);
    queryString += `
    WHERE city LIKE $${queryParams.length}`;
  }

  // when owner is logged in to app
  if (options.owner_id) {
  // Check if there are already other search filters, 
  // If there are, add "AND" to append the new condition otherwise, add "WHERE" to start a new condition
    queryParams.length ? (queryString += `AND `) : (queryString += `WHERE `);
    // Push the value of options.owner_id to the queryParams array
    queryParams.push(options.owner_id);
    // Add a condition to the queryString using the owner ID
    queryString += `properties.owner_id = $${queryParams.length} `;
  }

    // search option: minimum_price_per_night
  if (options.minimum_price_per_night) {
    // If other search filters are entered then add AND clause otherwise add WHERE clause
    queryParams.length ? (queryString += `AND `) : (queryString += `WHERE `);
    // Push the value of min price to queryParams array
    queryParams.push(options.minimum_price_per_night);
    // show result for condition: cost_per_night >= minimum_price_per_night
    queryString += `cost_per_night >= $${queryParams.length} `;
  }


  // Any query that comes after the WHERE clause
  queryParams.push(limit);
  queryString += `
  GROUP BY properties.id
  ORDER BY cost_per_night
  LIMIT $${queryParams.length};
  `;

  // Console log everything just to make sure weverything is working properly
  //console.log(queryString, queryParams);

  // Returning the promise using a database connection pool
  return pool.query(queryString, queryParams)
    .then((result) => {
      return result.rows;
    })
    .catch((err) => {
      console.log(err.message);
    })
};

/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function (property) {
  const propertyId = Object.keys(properties).length + 1;
  property.id = propertyId;
  properties[propertyId] = property;
  return Promise.resolve(property);
};

module.exports = {
  getUserWithEmail,
  getUserWithId,
  addUser,
  getAllReservations,
  getAllProperties,
  addProperty,
};

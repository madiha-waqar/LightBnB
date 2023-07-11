/* Insert temp data to users table */
INSERT INTO users (name, email, password)
VALUES ('user1', 'user1@mail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
       ('user2', 'user2@mail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
       ('user3', 'user3@mail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
       ('user4', 'user4@mail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
       ('user5', 'user5@mail.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.');

/* Insert temp data to properties table */
INSERT INTO properties (title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, parking_spaces, number_of_bathrooms, number_of_bedrooms, country, street, city, province, post_code, active, owner_id) 
VALUES ('Cozy Cottage', 'A charming cottage nestled in the countryside.', 'https://example.com/thumbnail.jpg', 'https://example.com/cover.jpg', 99.99, 2, 1, 2, 'United States', '123 Main St', 'New York City', 'New York', '10001', true, 1),
       ('Modern Apartment', 'A sleek and stylish apartment in the heart of the city.', 'https://example.com/thumbnail.jpg', 'https://example.com/cover.jpg', 149.99, 1, 1, 1, 'United States', '456 Elm St', 'Los Angeles', 'California', '90001', true, 2),
       ('Spacious Villa', 'A luxurious villa with stunning ocean views.', 'https://example.com/thumbnail.jpg', 'https://example.com/cover.jpg', 499.99, 4, 3, 4, 'Spain', '789 Oak St', 'Barcelona', 'Catalonia', '08001', true, 3),
       ('Rustic Cabin', 'A cozy cabin surrounded by nature.', 'https://example.com/thumbnail.jpg', 'https://example.com/cover.jpg', 79.99, 1, 1, 1, 'Canada', '789 Forest Rd', 'Vancouver', 'British Columbia', 'V6G 1B4', true, 4),
       ('Luxury Penthouse', 'An extravagant penthouse with panoramic city views.', 'https://example.com/thumbnail.jpg', 'https://example.com/cover.jpg', 999.99, 2, 2, 3, 'United States', '987 High St', 'Miami', 'Florida', '33139', true, 5);

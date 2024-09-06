# Dr. Lumpy's Movie Review Site

## Description

Dr. Lumpy's Movie Review Site is a web-based application developed using Ruby on Rails for both the frontend and backend. The app allows users to view, review, and receive recommendations for movies based on their reviews and preferences. Users can sign up, log in, search for movies, leave reviews, and receive movie recommendations tailored to their favorite genres. Key features include managing user accounts, leaving reviews, and generating personalized movie suggestions.

## Setup

1. **Clone the repository:**
   ```bash
   git clone git@github.com:ASPhillips8/movie-phone.git
   ```
2. **Navigate to the project directory:**
   ```bash
   cd movie-phone
   ```
3. **Install project dependencies:**
   ```bash
   bundle install
   ```
4. **Set up the database:**
   ```bash
   bundle exec rails db:migrate
   bundle exec rails db:seed
   ```
5. **Start backend server:**

   ```bash
   bundle exec rails server
   ```
6. **Open your browser and navigate to http://localhost:3000 to view and use the application.**

# Usage

## 1. User Management

- Users can sign up, log in, and log out.
- Users can view their review history and see movies they have reviewed.
- User passwords are securely hashed using bcrypt.

## 2. Movie Listings

- View the list of all movies, filtered by title or genre.
- Age-appropriate movies are displayed based on the user's age.
- Movies have an average user score calculated based on reviews.

## 3. Review System

- Users can leave reviews for movies they've watched.
- Users can edit existing reviews.
- Reviews are linked directly to movies and users.

## 4. Recommendations

- The app generates personalized recommendations based on user reviews.
- Movies from the user's favorite genre or highly rated unseen movies are suggested.

# Features

## User Management
- User sign-up and login functionality, secured by bcrypt.
- Users can manage their account details and view their review history.

## Movie Management
- Display a list of movies with details such as title, genre, runtime, rating, and description.
- Search and filter movies by title and genre.
- Calculate the average user score for each movie based on submitted reviews.

## Review Management
- Users can leave and edit reviews for movies.
- Reviews include a rating and comment.

## Recommendation System
- Users receive personalized movie recommendations based on their past reviews and favorite genres.

# Technologies Used

## Backend:
- Ruby on Rails
- Active Record
- SQLite3 

## Frontend:
- Ruby on Rails (views)

# Testing

This project includes unit and feature tests using the following tools:

- **RSpec**: For unit testing models and controllers.
- **FactoryBot**: For setting up test data and building test instances of models.
- **Capybara and Selenium-WebDriver**: For integration and feature testing, simulating user interactions with the browser.

# Running Tests

To run the tests:

### Run all tests:

```bash
rspec
```

## Future Enhancements

- Implement user watchlists to track movies users want to see.
- Expand the recommendation engine with advanced algorithms.
- Add social features for user-to-user interaction, such as commenting on reviews or adding an review upvote system
- Integrate an external movie API for additional movie data (e.g., posters, trailers).
- Introduce admin functionality for managing movies and users.

## Credits

- Ruby on Rails for the backend and frontend.
- bcrypt for password encryption.
- FactoryBot, RSpec, Capybara, and Selenium-WebDriver for testing.
- Faker for creating seed data examples



## User Stories

### Feature 1: Create a User

As a user coming to the home page, I am prompted to register or sign in.

- The user will need to create a username, password, provide age, and favorite movie genre.
- Once registered or signed in, the user is directed to the user show page.

#### Acceptance Criteria:

- User can see a registration form with all required fields.
- User receives a confirmation message upon successful registration.

### Feature 2: Movies Page

As a user, I can navigate to a movie index page and can navigate to a movie show page.

- The movie show page will show all movies in the database.
- Each movie will have a link to its movie show page.

#### Acceptance Criteria:

- Movies are displayed in a list with relevant details (title, genre).
- Each movie title is clickable and leads to the corresponding movie show page.

### Feature 3: Movie Show Page

As a user, I can view details of the movie (name, runtime, rating, description).

- The movie page will have a review section from users.

#### Acceptance Criteria:

- All movie details are displayed clearly.
- Review section is visible and accessible.

### Feature 4: Movie Review

As a user, I can add a review for a movie.

- A movie review form will be present for the current user.
- The review will have a rating from 0 to 10.
- The review will have a comment section (which does not need to be filled out).
- If the current user has already left a review, it will display the review and have a link to edit.

#### Acceptance Criteria:

- Review form is pre-filled if the user has already submitted a review.
- User receives feedback after submitting a review (success/error message).

### Feature 5: User Recommendations

As a user, when on the show page, it will display two recommended movies and show all movies reviewed.

- Recommended movies will include:
  - One movie not seen with the highest rating.
  - The highest-rated movie of the favorite genre.
- A list of the user’s reviewed movies.

#### Acceptance Criteria:

- Recommendations are updated based on the user’s viewing history.
- User can see all previously reviewed movies.

### Feature 6: Movie Search and Display

As a user, when I'm on the movie index page, I can search for movies based on title and genre.

- The overall display of movies will be limited by age and matching rating.

#### Acceptance Criteria:

- Search functionality returns relevant results based on input.
- Movies displayed adhere to age restrictions.

## Stretch Goals

### Feature 7: User Interaction with Other Users' Reviews (Stretch)

As a user, I will be able to upvote or downvote another user's review.
As a user, I will be able to comment on another user's review.

#### Acceptance Criteria:

- Users can easily interact with reviews through buttons.
- Comment section is visible and accessible.

### Feature 8: Movie Watch List (Stretch)

As a user, I will be able to add unwatched movies to a watch list.

#### Acceptance Criteria:

- User can add and remove movies from the watch list.
- Watch list is accessible from the user’s profile page.

## User Journey

1. User visits the homepage and registers.
2. User is directed to the user show page after registration.
3. User navigates to the movie index page.
4. User selects a movie to view details and leave a review.
5. User receives recommendations based on their interactions.
6. User can manage their watch list and interact with other reviews.

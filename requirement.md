## Requirements:
- [x] Uses Ruby on Rails  
- [x] Includes at least one `has_many` relationship (e.g. User `has_many` Recipes)  
      - This is accomplished with my User and Movie models. A User `has_many` Reviews, and a Movie `has_many` Reviews.  
- [x] Includes at least one `belongs_to` relationship (e.g. Post `belongs_to` User)  
      - This is accomplished with my Review model. Reviews `belongs_to` Movies and `belongs_to` Users.  
- [x] Includes at least two `has_many through` relationships (e.g. a `Recipe` could `has_many` `Items` through `Ingredients`)  
      - My Review model serves as a join table. A User `has_many` Movies through Reviews, and a Movie `has_many` Users through Reviews.  
- [x] Every model contains at least two simple attributes (e.g. ingredient#quantity)  
      - Every model has at least two attributes. Users have 7 attributes, Reviews have two attributes (besides references), Movies have 5 attributes, and Genre has two attributes.  
- [x] Includes reasonable validations  
      - All models include validations: User has `user_name` uniqueness and presence of other attributes. Movie has validations on runtime, presence of rating, and title. Genre has presence and uniqueness of the `name` attribute. Review has validation for `user_name` uniqueness in scope with `movie_id`.  
- [x] Includes a class-level ActiveRecord scope method  
      - I have two scope methods for my Movie model that are used for the movie recommendation feature, which utilizes the user-movie-review association. I also have a scope in the Review model that displays reviews based on the presence of user views.  
- [x] Includes signup, login, and logout functionality (e.g. Devise)  
      - These features are managed through a Sessions controller. Password confirmation is handled by the bcrypt gem.  
- [x] Includes nested resource show or index (e.g. `users/2/recipes`)  
      - Reviews are nested in the Movie resource.  
- [x] Includes nested resource form (e.g. `recipes/1/ingredients/new`)  
      - Reviews are nested in the Movie resource. Reviews are directly linked to the Movie being reviewed. The edit form for Reviews is also nested.  
- [x] Includes form display of validation errors  
      - I use `flash` to display sign-in errors. A partial in the layouts view is used to render errors on the user creation form and the review forms.  
- [x] Includes Unit tests for all of your models  
      - All models have tests that cover attributes, validations, associations, methods, and scopes.  
- [x] Includes at least one type of Integration test (e.g. controller, request, feature, system)  
      - I have an integration test that checks movie search functionality. It tests signing in, redirects to the movie index page, and searches for age-appropriate movies by title and/or genre.  
- [x] Use FactoryBot to build instances of your models in your tests  
      - Used FactoryBot to build factories for User, Movie, Review, and Genre models.  
- [x] Conforms to Nitro Ruby linting rules (running `rubocop` returns 0 offenses)  
      - 29 files scanned with no offenses detected.  
- [x] Includes a `README.md` with an application description and installation guide  

---

### Confirm:
- [x] The application follows DRY principles.  
- [x] Controllers contain limited logic.  
- [x] Views use helper methods where appropriate.  
- [x] Views use partials where appropriate.  

---

If you've added any additional functionality to your application that you'd like to demonstrate, please describe it below:

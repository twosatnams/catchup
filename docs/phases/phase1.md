# Phase 1: User Authentication and profile

## Roadmap
1. User Authentication
2. Upon a successful log in, a user is taken to profile (api/profiles/:id) page
3. User can add/edit following information without having to go to a new page
  * Profile picture
  * Cover picture
  * Location
  * High school
  * College
  * Workplace
4. Users can choose to hide a piece of information (e.g. age)

## Rails
### Models
* User
* Profile

### Controllers
* UsersController (create, new, edit, update)
* SessionsController (create, new, destroy)
* ApplicationController
* StaticPagesController (landing, root)
* API::ProfilesController (create, new, edit, update)

### Views
* root.html.erb

## Backbone
### Models
* Profile

### Collections

### Views
* ShowProfile

## Gems/Libraries
* BCrypt

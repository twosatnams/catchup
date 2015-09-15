# Catch Up

[Live][live]

[live]: http://www.catchup.click

## Introduction
Catchup is a social networking service, a platform to build social networks or social relations among people who share similar interests, activities, backgrounds or real-life connections. It consists of a representation of each user (a profile), his or her social links (friends), and a variety of additional services.

It allows individuals to create a public profile, create a list of users with whom to share connections, and view and cross the connections within the system. Users can also to share ideas, pictures, posts, activities, events, and interests with people in their network.

## Features

#### Profile
- Users can register and make/customize profile
- Uses BCrypt to store the user passwords as an encrypted password digest
- Users can change their profile and cover pictures by hovering and clicking "Change"
- From the profile, the user can view his friends and pictures

#### Posts
- Users can create posts only on their own profiles
- Comments can be made on any post
- Photos can be added to posts by clicking on the camera icon when creating a new post
- Post chooses the best view for displaying the pictures appropriately
- Users can choose to edit or delete the posts

#### friendships
- User can send a friend request by going to other user's profiles
- Notifications are sent to a user if they receive a friend request
- Users can choose to accept or reject friend requests
- Users can unfriend a friend by going to their profile and clicking "Unfriend"

#### Search
Search is ranked by the following criteria -
  - Match in either the first name or the last name. Uses Regular Expressions
  - Common State - 5 points
  - Common City - 15 points
  - Common School - 30 points
  - Common Age group - 10 points for being within += 5 years
  - Common Friends - 2 points for each mutual friend

All of the above mentioned criteria involve a lot of querying into the database, resulting in slow response times. Finding the mutual friends is the single most expensive function in the operation. So to improve response times, all the friends of all the user are cached - I use Redis as my caching service. As of now, a database seeded with 5,000 years can be searched through in an average time of < 100ms

#### Seed Data
For entertaining experience on the website, it's currently seeded with 10,000 artificial users -
  - Names were extracted from the 100 most common male, female and family names of 20th century released by Social Security Service.
  - All users have profile pictures of Hollywood actors, acquired from IMDB
  - Other information was generated using Faker gem

## Technologies Used
- Ruby on Rails server
- Backbone.js
- jQuery
- PostgreSQL - RDBMS
- JBuilder - to parse API data into json format
- BCrypt - to encrypt user password
- Cloudinary - to store user uploaded images
- Bootstrap - Front-end framework
- Redis - data store for caching


## Development
<!-- This is a Markdown checklist. Use it to keep track of your progress! -->

- [x] Create accounts and log in
- [x] View and modify their profiles
- [x] Create posts and mention other users in them
- [x] Like and comment on posts
- [x] Send, receive, accept and deny friend requests to/from other users
- [x] Users can search for other users and pages
- [x] Search is ranked by mutual friends, age, location and similar interests.

## Design Docs
* [View Wireframes][views]
* [DB schema][schema]

[views]: ./docs/views.md
[schema]: ./docs/schema.md

## Implementation Timeline

### Phase 1: User Authentication, Profiles (~2 days)
Implementation of user authentication and personal profiles. By the end of this
phase, a user will be able to log in and customize basic information (location,
profile picture, cover picture, schools and workplace) their profiles. I will
deploy to Heroku as soon as this is achieved.

[Details][phase-one]

### Phase 2: Posts, mentions, likes and comments (~2.5 days)
The primary focus of this phase will be posts. User will be able to CRUD posts.
By the end of this phase, users will be able to mention other users, like and
comment on posts.

[Details][phase-two]

### Phase 3: Friend requests (~2 days)
By the end of this phase, users will be able to send/receive friend requests
to/from other users and will be able to accept or deny them.

[Details][phase-three]

### Phase 4: Seed data (~0.5 day)
To be able to demo a efficient search feature I will need a lot of seed data.
The target of this phase will be to add ~5,000 fake users using faker. Seed data
will have profile pictures (celebrity or anime pictures will do). Seed data
for friendships and posts will also be required to demo the search feature in an
appealing way.

[Details][phase-four]

### Phase 5: Search (~1 day)
By the end of this phase a user will be able to search for other user by name,
location, school or workplace. The search results will be ranked by friends,
mutual friends, location and age.

[Details][phase-five]

### Bonus Features (TBD)
- [ ] Groups
- [x] User has a photos page
- [x] Users can create posts with one or multiple photos
- [ ] Create pages
- [ ] Users can follow other users or pages
- [ ] Users can choose to make their information and posts public or private
- [ ] User can have several interests
- [ ] Rank search by interests
- [x] Notifications about friend requests and mentions
- [ ] Users can message each other privately or within a group

[phase-one]: ./docs/phases/phase1.md
[phase-two]: ./docs/phases/phase2.md
[phase-three]: ./docs/phases/phase3.md
[phase-four]: ./docs/phases/phase4.md
[phase-five]: ./docs/phases/phase5.md

# Catch Up

[Heroku link][heroku]

[heroku]: https://catchup-fb.herokuapp.com

## Minimum Viable Product
Catch Up is a clone of Facebook built on Rails and Backbone. Users can:

<!-- This is a Markdown checklist. Use it to keep track of your progress! -->

- [ ] Create accounts and log in
- [ ] View and modify their profiles
- [ ] Create posts and mention other users in them
- [ ] Like and comment on posts
- [ ] Send, receive, accept and deny friend requests to/from other users
- [ ] Users can search for other users and pages
- [ ] Search is ranked by mutual friends, age, location and similar interests.

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
The target of this phase will be to add ~1,000 fake users using faker. Seed data
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
- [ ] User can a photos page
- [ ] Users can create posts with one or multiple photos
- [ ] Create pages
- [ ] Users can follow other users or pages
- [ ] Users can choose to make their information and posts public or private
- [ ] User can have several interests
- [ ] Rank search by interests
- [ ] Notifications about friend requests and mentions
- [ ] Users can message each other privately or within a group

[phase-one]: ./docs/phases/phase1.md
[phase-two]: ./docs/phases/phase2.md
[phase-three]: ./docs/phases/phase3.md
[phase-four]: ./docs/phases/phase4.md
[phase-five]: ./docs/phases/phase5.md

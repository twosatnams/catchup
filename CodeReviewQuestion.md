1. Heroku doesn't load images
2. Slow load times
3. Problem with the approach of sending all necessary data from Jbuilder -
   So, when we want to display data which doesn't have explicit columns
      e.g. - Post - it has an author_id but no author_name
    We can use rails associations and send the author_name in JBuilder...Cool

    However, the problem comes when creating a new post -
      The template for PostShow is expecting an author_name field, and since
      the newly created post doesn't have a field called author_name (model.save
      only saves the permitted attributes into database), it displays the author
      as blank.
    It fixes itself when the page is refreshed...but of course we don't want to

    I fix this problem by sending a hidden input in template, but these hidden
    inputs are increasing (author_name = currentUser.escape('name'),
                           author_avatar = currentUser.escape('profile_pic')
                           etc.)

    I The problem builds even more in case of comments and posts. Since there
    isn't any variable equivalent to currentUser for posts (currentPost), I
    have to explicitly pass in a post_id when creating an empty comment.

    Is there a better way to do this? BB associations? Post has an author()
    function and comment has author() and post() functions? That seems like a
    lot of ajax requests though....

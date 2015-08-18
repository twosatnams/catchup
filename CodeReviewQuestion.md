//this doesn't work

Started PUT "/api/posts/60" for ::1 at 2015-08-18 07:46:21 -0700
Processing by Api::PostsController#update as JSON
  Parameters: {"post"=>{"body"=>"So how about this one?"}, "numLikes"=>"0", "id"=>"60", "author_id"=>1, "body"=>"So how about this one? Lets see if this works", "created_at"=>"2015-08-18T14:45:51.287Z", "updated_at"=>"2015-08-18T14:45:51.287Z"}
  Post Load (0.2ms)  SELECT  "posts".* FROM "posts" WHERE "posts"."id" = $1 LIMIT 1  [["id", 60]]
   (0.1ms)  BEGIN
   (0.1ms)  COMMIT
Completed 200 OK in 2ms (Views: 0.2ms | ActiveRecord: 0.4ms)


//this works

Started PUT "/api/posts/60" for ::1 at 2015-08-18 07:48:20 -0700
Processing by Api::PostsController#update as JSON
  Parameters: {"id"=>"60", "author_id"=>1, "body"=>"So how about this one? Let's see if this works", "numLikes"=>0, "post"=>{"id"=>"60", "author_id"=>1, "body"=>"So how about this one? Let's see if this works"}}
  Post Load (0.3ms)  SELECT  "posts".* FROM "posts" WHERE "posts"."id" = $1 LIMIT 1  [["id", 60]]
Unpermitted parameters: id, author_id
   (0.1ms)  BEGIN
  SQL (0.2ms)  UPDATE "posts" SET "body" = $1, "updated_at" = $2 WHERE "posts"."id" = $3  [["body", "So how about this one? Let's see if this works"], ["updated_at", "2015-08-18 14:48:20.118247"], ["id", 60]]
   (0.9ms)  COMMIT
Completed 200 OK in 6ms (Views: 0.9ms | ActiveRecord: 1.5ms)


editQuestionBody: function () {
    $('.question-body').attr('contenteditable', 'true');
    $('.question-body').focus();
  },

  saveQuestionBody: function (e) {
    e.preventDefault();
    var formData = $(e.currentTarget).text();
    this.model.save({body: formData});
  }
});

Catchup.Views.PostShow = Backbone.CompositeView.extend({
  template: JST['post/post_show'],
  className: 'post-content',

  initialize: function () {
    this.listenTo(this.model, 'add', this.addCommentsSubview);
    this.listenTo(this.model, 'sync change:numLikes change', this.render);
    this.listenTo(this.model.like(), 'change', this.render);
    this.listenTo(this.model.comments(), 'sync', this.render);
    this.listenTo(this.model.comments(), 'add', this.addCommentsSubview);

    this.addNewCommentSubview();

    this.model.comments().each(function (comment) {
      this.addCommentsSubview(comment);
    }.bind(this));
  },

  events: {
    'click .post-like' : 'toggleLike',
    'click #edit-post' : 'startEdit',
    'click #delete-post' : 'deletePost',
    'blur input': 'stopEdit',
    'click #btn-done-editing' : 'stopEdit'
  },

  toggleLike: function(event) {
    if (this.model.isLiked()){
      this.unlikePost();
    } else {
      this.likePost();
    }
  },

  likePost: function() {
    this.model.like().save({
      post_id: this.model.id,
      success: function () {
        this.$(".like-button").addClass('liked');
      }
    });
    this.model.set({numLikes: this.model.get('numLikes') + 1});
  },

  unlikePost: function() {
    this.model.like().destroy();
    this.model.like().clear();
    this.model.set({numLikes: this.model.get('numLikes') - 1});
  },

  startEdit: function (event) {
    event.preventDefault();
    var $target = this.$(".post-body");
    var $input = $("<textarea class='post-body' id='being-edited' rows='4'></textarea>");
    $input.val(this.model.get("body"));
    $target.replaceWith($input);
    $('#btn-done-editing').show();
  },

  stopEdit: function (event) {
    event.preventDefault();
    var $target = this.$(".post-body");
    var newBody = $target.val();
    var $input = $("<div></div>");
    $input.text(newBody);
    $target.replaceWith($input);
    this.model.save({body: newBody});
    $('#btn-done-editing').hide();
  },

  deletePost: function () {

  },

  addNewCommentSubview: function () {
    var newComment = new Catchup.Models.Comment({author_name: currentUser.get('name')});
    var subview = new Catchup.Views.CommentForm({
      model: newComment,
      collection: this.model.comments(),
      post_id: this.model.get('id')
    });
    this.addSubview('.new-comment-container', subview);
  },

  addCommentsSubview: function (comment) {
    var subview = new Catchup.Views.CommentShow({
      model: comment
    });
    this.addSubview('.comments-container', subview);
  },

  render: function () {
    var content = this.template({
      post: this.model
    });
    $('#btn-done-editing').hide();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});

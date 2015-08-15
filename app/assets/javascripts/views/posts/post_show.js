Catchup.Views.PostShow = Backbone.CompositeView.extend({
  template: JST['post/post_show'],
  className: 'post-content',

  initialize: function () {
    this.addNewCommentSubview();

    this.listenTo(this.model, 'add', this.addCommentsSubview);
    this.listenTo(this.model, 'sync change:numLikes', this.render);
    this.listenTo(this.model.like(), 'change', this.render);
    this.listenTo(this.model.comments(), 'add', this.render);

    this.model.comments().each(function (comment) {
      this.addCommentsSubview(comment);
    }.bind(this));
  },

  events: {
    'click .post-like' : 'toggleLike',
  },

  toggleLike: function(event) {
    if (this.model.isLiked()){
      this.unlikePost();
    } else {
      this.likePost();
    }
  },

  likePost: function() {
    this.model.like().save({post_id: this.model.id});
    this.model.set({numLikes: this.model.get('numLikes') + 1});
  },

  unlikePost: function() {
    this.model.like().destroy();
    this.model.like().clear();
    this.model.set({numLikes: this.model.get('numLikes') - 1});
  },

  addNewCommentSubview: function () {
    var newComment = new Catchup.Models.Comment();
    var subview = new Catchup.Views.CommentForm({
      model: newComment,
      collection: this.model.comments()
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
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});

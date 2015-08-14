Catchup.Views.PostShow = Backbone.CompositeView.extend({
  template: JST['post/post_show'],
  className: 'post-content',

  initialize: function () {
    this.listenTo(this.model, 'add', this.addCommentSubview);
    // this.listenTo(this.model, 'sync', this.render);
    this.model.comments().each(function (comment) {
      this.addCommentSubview(comment);
    }.bind(this));
  },

  addCommentSubview: function (comment) {
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

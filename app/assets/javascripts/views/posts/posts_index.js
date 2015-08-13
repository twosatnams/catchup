Catchup.Views.PostsIndex = Backbone.CompositeView.extend({
  template: JST['post/post_index'],

  initialize: function () {
    this.addPostsSubview();
    this.listenTo(this.collection, 'sync', this.addPostsSubview);
    this.listenTo(this.collection, 'sync', this.render);
  },

  addPostsSubview: function () {
    var that = this;
    this.collection.each(function (post) {
      var post = new Catchup.Views.PostShow({
        model: post
      });
      that.addSubview("ul.posts", post);
    });
  },

  render: function () {
    var content = this.template({
      posts: this.collection
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});

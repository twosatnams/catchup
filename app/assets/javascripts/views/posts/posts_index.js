Catchup.Views.PostsIndex = Backbone.CompositeView.extend({
  template: JST['post/post_index'],

  initialize: function () {
    this.listenTo(this.collection, 'add remove reset', this.addPostSubview);
    this.listenTo(this.collection, 'sync', this.render);

    var that = this;
    this.collection.each(function (post) {
      that.addPostSubview(post);
    });
  },

  addPostSubview: function (post) {
    var postSubview = new Catchup.Views.PostShow({
      model: post
    });
    this.addSubview("ul.posts", postSubview);
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

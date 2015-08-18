Catchup.Views.PostsIndex = Backbone.CompositeView.extend({
  template: JST['post/post_index'],

  initialize: function () {
    this.listenTo(this.collection, 'add reset', this.addPostSubview);
    this.listenTo(this.collection, 'remove', this.removePostSubview);
    this.listenTo(this.collection, 'sync reset', this.render);

    var that = this;
    this.collection.each(function (post) {
      that.addPostSubview(post);
    });
  },

  addPostSubview: function (post) {
    var postSubview = new Catchup.Views.PostShow({
      model: post,
      collection: this.collection
    });
    this.addSubview("ul.posts", postSubview, true);
  },

  removePostSubview: function (model, collection, options) {
    this.removeModelSubview("ul.posts", model);
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

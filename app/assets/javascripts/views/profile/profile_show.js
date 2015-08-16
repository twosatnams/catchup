Catchup.Views.ProfileShow = Backbone.CompositeView.extend({
  template: JST['profile/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model, 'sync', this.addPostsIndexSubview);
    this.listenTo(this.model, 'sync', this.addNewPostSubview);
    // this.addPostsIndexSubview();
    // this.addNewPostSubview();
    this.listenTo(this.model, 'sync', this.addBasicInfoSubview);
  },

  addBasicInfoSubview: function () {
    var basicInfo = new Catchup.Views.BasicInfo({
      model: this.model
    });
    this.addSubview("ul.basic-info", basicInfo);
  },

  addNewPostSubview: function () {
    var post = new Catchup.Models.Post();
    var form = new Catchup.Views.PostForm({
      model: post,
      collection: this.model.posts()
    });
    this.addSubview(".new-post-form", form);
  },

  addPostsIndexSubview: function () {
    var posts = new Catchup.Views.PostsIndex({
      collection: this.model.posts()
    });
    this.addSubview(".posts-holder", posts);
  },

  render: function () {
    var content = this.template({
      user: this.model
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});

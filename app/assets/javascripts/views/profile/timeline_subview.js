Catchup.Views.TimelineSubview = Backbone.CompositeView.extend({
  template: JST['profile/timeline_subview'],

  initialize: function () {
    if (this.model.escape('id') === currentUser.escape('id')) {
      this.addNewPostSubview();
    }
    this.addPostsIndexSubview();
    this.addBasicInfoSubview();
  },

  addBasicInfoSubview: function () {
    var basicInfo = new Catchup.Views.BasicInfo({
      model: this.model
    });
    this.addSubview(".basic-info", basicInfo);
  },

  addNewPostSubview: function () {
    var post = new Catchup.Models.Post();
    var form = new Catchup.Views.PostForm({
      model: post,
      collection: this.model.posts()
    });
    this.addSubview(".new-post-form", form);
  },

  nineRandomFriends: function () {
    var friends = _.shuffle(this.model.friends().models);
    return friends.slice(0, 10);
  },

  nineRandomPhotos: function () {

  },

  addPostsIndexSubview: function () {
    var posts = new Catchup.Views.PostsIndex({
      collection: this.model.posts()
    });
    this.addSubview(".posts-holder", posts);
  },

  render: function () {
    var content = this.template({
      user: this.model,
      friends: this.nineRandomFriends(),
      photos: this.nineRandomPhotos()
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});

Catchup.Views.ProfileShow = Backbone.CompositeView.extend({
  template: JST['profile/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.addPostsIndexSubview();
    this.addNewPostSubview();
    this.addBasicInfoSubview();
  },

  events: {
    'click #change-cover' : 'updateCover',
    'click #change-avatar' : 'updateAvatar',
    'click #photos' : 'replaceWithPhotosSubview',
    'click #about' : 'replaceWithAboutSubview',
    'click #timeline' : 'replaceWithTimelineSubview'
  },

  addBasicInfoSubview: function () {
    var basicInfo = new Catchup.Views.BasicInfo({
      model: this.model
    });
    this.addSubview(".basic-info", basicInfo);
  },

  updateCover: function(event) {
    event.preventDefault();
    var that = this;
    cloudinary.openUploadWidget(CLOUDINARY_OPTIONS, function(error, result){
      var data = result[0];
      that.model.set({cover_pic: data.url});
      that.model.save({}, {
        success: function () {
          console.log('cover change worked');
        }
      });
    });
  },

  updateAvatar: function(event) {
    event.preventDefault();
    var that = this;
    cloudinary.openUploadWidget(CLOUDINARY_OPTIONS, function(error, result){
      var data = result[0];
      that.model.set({profile_pic: data.url});
      that.model.save({}, {
        success: function () {
          console.log('cover change worked');
        }
      });
    });
  },

  removeExistingSubviews: function () {
    this.eachSubview(function () {

    });
  },

  redirectToFriends: function (id) {
    Backbone.history.navigate("users/" + id + "/friends", {trigger: true});
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

  replaceWithFriendsSubview: function (event) {
    event.preventDefault();
    this.removeSubview('.posts-holder', this.subviews('.posts-holder').first());
    this.removeSubview('.new-post-form', this.subviews('.new-post-form').first());
    this.removeSubview('.basic-info', this.subviews('.basic-info').first());

    var friendsSubview = new Catchup.CompositeView.FriendsShow({
      collection: this.model.friends()
    });
    this.addSubview(".friends-container", friendsSubview);
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

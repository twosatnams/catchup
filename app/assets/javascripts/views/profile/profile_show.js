Catchup.Views.ProfileShow = Backbone.CompositeView.extend({
  template: JST['profile/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync change', this.render);
    // this.listenTo(this.model, 'sync', this.replaceWithTimelineSubview());
    this.replaceWithTimelineSubview();

    if (currentUser.get('id') !== parseInt(this.model.id)) {
      this.addFriendStatusButton();
    };
  },

  events: {
    'click #change-cover' : 'updateCover',
    'click #change-avatar' : 'updateAvatar',
    'click #photos-show' : 'replaceWithPhotosSubview',
    'click #about' : 'replaceWithAboutSubview',
    'click #timeline-show' : 'replaceWithTimelineSubview',
    'click #friends-show' : 'replaceWithFriendsSubview',
    'click .photos-thumbs': 'replaceWithPhotosSubview',
  },

  addFriendStatusButton: function () {
    var button = new Catchup.Views.FriendStatus({
      model: this.model
    });
    this.addSubview('.btn-friendship-status', button);
  },

  updateCover: function(event) {
    event.preventDefault();
    var that = this;
    cloudinary.openUploadWidget(CLOUDINARY_OPTIONS, function(error, result){
      var data = result[0];
      that.model.set({cover_pic: data.url});
      that.model.save();
    });
  },

  updateAvatar: function(event) {
    event.preventDefault();
    var that = this;
    cloudinary.openUploadWidget(CLOUDINARY_OPTIONS, function(error, result){
      var data = result[0];
      that.model.set({profile_pic: data.url});
      that.model.save();
    });
  },

  replaceWithTimelineSubview: function (event) {
    if (event !== undefined) {
      event.preventDefault();
    }
    var timeline = new Catchup.Views.TimelineSubview({
      model: this.model
    });
    this.swapSubview(timeline);
  },


  replaceWithFriendsSubview: function (event) {
    event.preventDefault();
    var friendsList = this.model.friends();
    var friendRequests = this.model.friendRequests();

    var friendsView = new Catchup.Views.FriendsShow({
      collection: friendsList,
      friendRequests: friendRequests
    });
    this.swapSubview(friendsView);
  },

  replaceWithPhotosSubview: function (event) {
    if (event !== undefined) {
      event.preventDefault();
    }
    var view = new Catchup.Views.PhotosShow({
      collection: this.model.photos()
    });
    this.swapSubview(view);
  },

  swapSubview: function (newView) {
    if (this.activeSubview !== undefined) {
      this.removeSubview(".active-subview", this.activeSubview);
    }
    this.activeSubview = newView;
    this.addSubview('.active-subview',this.activeSubview);
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

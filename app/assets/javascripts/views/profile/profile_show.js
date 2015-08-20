Catchup.Views.ProfileShow = Backbone.CompositeView.extend({
  template: JST['profile/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.replaceWithTimelineSubview();
    if (currentUser.get('id') !== this.model.id) {
      this.addFriendStatusButton();
    }
  },

  events: {
    'click #change-cover' : 'updateCover',
    'click #change-avatar' : 'updateAvatar',
    'click #add-friend' : 'addFriend',
    'click #un-friend' : 'unfriend',
    'click #photos' : 'replaceWithPhotosSubview',
    'click #about' : 'replaceWithAboutSubview',
    'click #timeline-show' : 'replaceWithTimelineSubview',
    'click #friends-show' : 'replaceWithFriendsSubview'
  },

  addFriendStatusButton: function () {
    this.model.fetch();
    var button = new Catchup.Views.FriendStatus({
      model: this.model
    });
    this.addSubview('.btn-friendship-status', button);
  },

  unfriend: function (event) {
    event.preventDefault();
    var friendship = new Catchup.Models.Friendship({
      id: this.model.friendshipID
    });
    friendship.destroy();
  },

  addFriend: function (event) {
    event.preventDefault();
    var friendship = new Catchup.Models.Friendship({
      user_id: currentUser.get('id'),
      friend_id: this.model.id,
      pending: true
    });
    friendship.save();
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

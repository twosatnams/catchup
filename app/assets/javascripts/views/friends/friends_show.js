Catchup.Views.FriendsShow = Backbone.CompositeView.extend({
  template: JST['friend/friends_show'],
  className: 'friends-show',

  initialize: function (options) {
    this.friendRequests = options.friendRequests;

    this.listenTo(this.collection, 'add reset', this.addFriendSubview);
    this.listenTo(this.collection, 'sync', this.render);

    this.listenTo(this.friendRequests, 'add reset', this.addFriendRequestsSubview);
    this.listenTo(this.friendRequests, 'sync', this.render);
    this.listenTo(this.friendRequests, 'remove', this.removeFriendRequestSubview);


    var that = this;
    this.collection.each(function (friend) {
      that.addFriendSubview(friend);
    });

    if (currentUser.get('id') === this.collection.user.id) {
      this.friendRequests.each(function (friend) {
        that.addFriendRequestsSubview(friend);
      });
    }
  },

  addFriendRequestsSubview: function (friend) {
    var subview = new Catchup.Views.FriendRequestSubview({
      model: friend,
      collection: this.friendRequests,
      friends: this.collection
    });
    // WTF is true doing here?
    this.addSubview(".friend-requests-list", subview, true);
  },

  addFriendSubview: function (friend) {
    var subview = new Catchup.Views.FriendSubview({
      model: friend,
      collection: this.collection
    });
    // WTF is true doing here?
    this.addSubview(".friends-list", subview, true);
  },

  removeFriendRequestSubview: function (model, collection, options) {
    this.removeModelSubview(".friend-requests-list", model);
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

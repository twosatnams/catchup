Catchup.Views.FriendsShow = Backbone.CompositeView.extend({
  template: JST['friend/friends_show'],

  initialize: function () {
    this.listenTo(this.collection, 'add reset', this.addFriendSubview);
    this.listenTo(this.collection, 'sync', this.render);

    var that = this;
    this.collection.each(function (friend) {
      that.addFriendSubview(friend);
    });
  },

  addFriendSubview: function (friend) {
    var subview = new Catchup.Views.FriendSubview({
      model: friend,
      collection: this.collection
    });
    // WTF is true doing here?
    this.addSubview(".friends-list", subview, true);
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

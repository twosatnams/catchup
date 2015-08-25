Catchup.Views.FriendStatus = Backbone.View.extend({
  template: JST['profile/friendship_status'],

  initialize: function () {
    this.listenTo(this.model, 'sync change reset', this.render);
  },

  events: {
    'click #add-friend' : 'addFriend',
    'click #un-friend' : 'unFriend',
    'click #friend-request-sent' : 'doNothing',
    'click #accept-friend-request' : 'doNothing',
    'click .friendship-status' : 'render'
  },

  addFriend: function (event) {
    event.preventDefault();
    var friendship = new Catchup.Models.Friendship({
      user_id: currentUser.get('id'),
      friend_id: this.model.id,
      pending: true
    });
    friendship.save();
    this.model.friendshipStatus = 'friend-request-sent';
  },

  unFriend: function (event) {
    event.preventDefault();
    var friendship = new Catchup.Models.Friendship({
      id: this.model.friendshipID
    });
    friendship.destroy();
    this.model.friendshipStatus = 'add-friend';
  },

  doNothing: function (event) {
    event.preventDefault();
  },

  buttonText: function () {
    if (this.model.friendshipStatus === 'add-friend') {
      return "Add Friend";
    } else if (this.model.friendshipStatus === 'un-friend') {
      return "Unfriend";
    } else if (this.model.friendshipStatus === 'friend-request-sent') {
      return "Request Sent";
    } else if (this.model.friendshipStatus === 'accept-friend-request') {
      return "Request Received"
    } else {
      return "something's wrong"
    }
  },

  render: function () {
    var content = this.template({
      buttonText: this.buttonText(),
      id: this.model.friendshipStatus
    });
    this.$el.html(content);
    return this;
  }
});

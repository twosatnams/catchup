Catchup.Views.FriendRequestSubview = Backbone.View.extend({
  template: JST['friend/friend_request_subview'],
  tagName: 'li',
  className: 'friend-request-item',

  events: {
    'click .accept-friend' : 'acceptFriend',
    'click .decline-friend' : 'declineFriend'
  },

  initialize: function (options) {
    this.friends = options.friends;
  },

  viewProfile: function (event) {
    event.preventDefault();
    debugger
    // Backbone.history.navigate("users/" + , {trigger: true});
  },

  acceptFriend: function (event) {
    event.preventDefault();
    var request = new Catchup.Models.Friendship({id: this.model.id});

    var that = this;
    request.save({pending: false}, {
      success: function () {
        that.collection.remove(that.model);
        that.friends.add(that.model);
      }
    });
  },

  declineFriend: function (event) {
    event.preventDefault();
    var request = new Catchup.Models.Friendship({id: this.model.id});

    var that = this;
    request.destroy({
      success: function () {
        that.collection.remove(that.model);
      }
    });
  },

  render: function () {
    var content = this.template({
      friend: this.model
    });
    this.$el.html(content);
    return this;
  }
});

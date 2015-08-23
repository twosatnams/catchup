Catchup.Models.User = Backbone.Model.extend({
  urlRoot: 'api/users',

  posts: function () {
    if (!this._posts) {
      this._posts = new Catchup.Collections.Posts([], { user: this });
    }

    return this._posts;
  },

  friends: function () {
    if (!this._friends) {
      this._friends = new Catchup.Collections.Friends([], { user: this });
    }

    return this._friends;
  },

  photos: function () {
    if (!this._photos) {
      this._photos = new Catchup.Collections.Photos([], { user: this });
    }

    return this._photos;
  },

  unsuccessfulRequests: function () {
    if (!this._unsuccessful_requests) {
      this._unsuccessful_requests = new Catchup.Collections.Friends([], { user: this });
    }

    return this._unsuccessful_requests;
  },

  friendRequests: function () {
    if (!this._friend_requests) {
      this._friend_requests = new Catchup.Collections.Friends([], { user: this });
    }

    return this._friend_requests;
  },

  friendshipStatus: "",
  friendshipID: 0,

  mutualFriends: function () {
    if (!this._mutual_friends) {
      this._mutual_friends = new Catchup.Collections.Friends([], { user: this });
    }

    return this._mutual_friends;
  },


  parse: function (response) {

    if (response.posts) {
      this.posts().set(response.posts, { parse: true });
      delete response.posts;
    }

    if (response.friends) {
      this.friends().set(response.friends);
      delete response.friends;
    }

    if (response.unsuccessful_requests) {
      this.unsuccessfulRequests().set(response.unsuccessful_requests);
      delete response.unsuccessful_requests;
    }

    if (response.friend_requests) {
      this.friendRequests().set(response.friend_requests);
      delete response.friend_requests;
    }

    if (response.mutual_friends) {
      this.mutualFriends().set(response.mutual_friends);
      delete response.mutual_friends;
    }

    if (response.friendship_status) {
      this.friendshipStatus = response.friendship_status;
      delete response.friendship_status;
    }

    if (response.friendshipID) {
      this.friendshipID = response.friendshipID;
      delete response.friendshipID;
    }

    if (response.photos) {
      this.photos().set(response.photos);
      delete response.photos;
    }

    return response;
  }
});

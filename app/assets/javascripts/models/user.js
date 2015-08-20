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

  // friendshipStatus: function () {
  //   if (!this._friendship_status) {
  //     this._friendship_status = new Catchup.Collections.Friends([], { user: this });
  //   }
  //
  //   return this._friend_requests;
  // },

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
    return response;
  }
});

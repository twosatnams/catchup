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
      this._posts = new Catchup.Collections.Friends([], { user: this });
    }

    return this._posts;
  },

  parse: function (response) {
    if (response.posts) {
      this.posts().set(response.posts, { parse: true });
      delete response.posts;
    }

    if (response.friends) {
      this.friends().set(response.friends, { parse: true });
      delete response.friends;
    }

    return response;
  }
});

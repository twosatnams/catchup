Catchup.Models.Post = Backbone.Model.extend({
  urlRoot: '/api/posts',

  likes: function () {
    if (!this._likes) {
      this._likes = new Catchup.Collections.Posts([], { user: this });
    }

    return this._likes;
  },

  parse: function (response) {
    if (response.posts) {
      this.posts().set(response.posts, { parse: true });
      delete response.posts;
    }

    return response;
  }
});

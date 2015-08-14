Catchup.Models.Post = Backbone.Model.extend({
  urlRoot: '/api/posts',

  likes: function () {
    if (!this._likes) {
      this._likes = new Catchup.Collections.Likes([], { post: this });
    }

    return this._likes;
  },

  comments: function () {
    if (!this._comments) {
      this._comments = new Catchup.Collections.Comments([], { post: this });
    }

    return this._comments;
  },

  photos: function () {
    if (!this._photos) {
      this._photos = new Catchup.Collections.Photos([], { post: this });
    }

    return this._photos;
  },

  parse: function (response) {
    if (response.likes) {
      this.likes().set(response.likes, { parse: true });
      delete response.likes;
    }

    if (response.comments) {
      this.comments().set(response.comments, { parse: true });
      delete response.comments;
    }

    if (response.photos) {
      this.photos().set(response.photos, { parse: true });
      delete response.photos;
    }

    return response;
  }
});

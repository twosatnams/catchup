Catchup.Models.Post = Backbone.Model.extend({
  urlRoot: '/api/posts',

  likes: function () {
    return this._likes.length
  },

  parse: function () {

  }

});

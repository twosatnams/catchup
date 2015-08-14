Catchup.Collections.Likes = Backbone.Collection.extend({
  url: '/api/likes',
  model: Catchup.Models.Like,

  getOrFetch: function (id) {
    var model = this.get(id);
    if (!model) {
      model = new Catchup.Models.Like({id: id});
      model.fetch({
        success: function () {
          this.add(model);
        }.bind(this)
      })
    } else {
      model.fetch();
    }

    return model;
  },

  initialize: function (models, options) {
    this.post = options.post;
  }
});

Catchup.Collections.Photos = Backbone.Collection.extend({
  url: '/api/photos',
  model: Catchup.Models.Photo,

  getOrFetch: function (id) {
    var model = this.get(id);
    if (!model) {
      model = new Catchup.Models.Photo({id: id});
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
    this.user = options.user;
  }
});

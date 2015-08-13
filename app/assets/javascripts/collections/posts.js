Catchup.Collections.Posts = Backbone.Collection.extend({
  url: '/api/posts',
  model: Catchup.Models.Post,

  getOrFetch: function (id) {
    var model = this.get(id);
    if (!model) {
      model = new Catchup.Models.Post({id: id});
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
    this.user = options.user;
  }
});

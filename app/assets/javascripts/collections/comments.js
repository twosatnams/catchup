Catchup.Collection.Comments = Backbone.Collection.extend({
  url: '/api/comments'
  model: Catchup.Models.Comment,

  getOrFetch: function (id) {
    var model = this.get(id);
    if (!model) {
      model = new Catchup.Models.Comment({id: id});
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

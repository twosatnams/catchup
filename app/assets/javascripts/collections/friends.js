Catchup.Collections.Friends = Backbone.Collection.extend({
  url: '/api/friends',
  model: Catchup.Models.User,

  initialize: function (models, options) {
    this.user = options.user;
  },

  getOrFetch: function (id) {
    var model = this.get(id);
    if (!model) {
      model = new Catchup.Models.User({id: id});
      model.fetch({
        success: function () {
          this.add(model);
        }.bind(this)
      })
    } else {
      model.fetch();
    }

    return model;
  }

});

Catchup.Collections.Users = Backbone.Collection.extend({
  url: '/api/users',
  model: Catchup.Models.User,

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
  },

});

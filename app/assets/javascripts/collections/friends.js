Catchup.Collections.Friends = Backbone.Collection.extend({

  initialize: function (models, options) {
    this.user_id = options.user_id;
  },

  model: Catchup.Models.User,

  url: function () {
    return '/api/users/' + this.user_id + '/friends';
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

Catchup.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = $('#content');
    this.user = options.model;
  },

  routes: {
    "" : "redirect_to_profile",
    "users/:id" : "show",
    "users/:id/edit" : "edit",
  },

  redirect_to_profile: function () {
    Backbone.history.navigate("users/" + currentUser.get('id'), {trigger: true});
  },

  show: function (id) {
    if (id !== currentUser.escape('id')) {
      var user = new Catchup.Models.User({id: id});
      user.fetch();
    } else {
      user = this.user;
    }
    var view = new Catchup.Views.ProfileShow({
      model: user
    });
    this._swapview(view);
  },

  edit: function (id) {
    //do this using currentUser
    // var user = new Catchup.Models.User({id: id});
    this.user.fetch();
    var view = new Catchup.Views.ProfileEdit({
      model: this.user
    });
    this._swapview(view);
  },

  _swapview: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});

Catchup.Routers.Router = Backbone.Router.extend({
  initialize: function () {
    this.$rootEl = $('#content');
    // this.user = new Catchup.Models.User();
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
    //To Do, do this using currentUser
    var user = new Catchup.Models.User({id: id});
    user.fetch();
    var view = new Catchup.Views.ProfileShow({
      model: user
    });
    this._swapview(view);
  },

  edit: function (id) {
    //do this using currentUser
    var user = new Catchup.Models.User({id: id});
    user.fetch();
    var view = new Catchup.Views.ProfileEdit({
      model: user
    });
    this._swapview(view);
  },

  _swapview: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});

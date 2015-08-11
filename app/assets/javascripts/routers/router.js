Catchup.Routers.Router = Backbone.Router.extend({
  initialize: function () {
    this.$rootEl = $('#content');
    // this.user = new Catchup.Models.User();
  },

  routes: {
    "users/:id" : "show"
  },

  show: function (id) {
    var user = new Catchup.Models.User({id: id});
    user.fetch();
    var view = new Catchup.Views.ProfileShow({
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

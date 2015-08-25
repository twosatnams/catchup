window.Catchup = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var user = new Catchup.Models.User({
      id: currentUser.escape('id')
    });
    user.fetch()

    var router = new Catchup.Routers.Router({
      model: user
    });

    var nav = new Catchup.Views.NavBar({
      router: router,
      model: user
    });
    $("#nav-bar").html(nav.render().$el);

    Backbone.history.start();
  }
};

// $(document).ready(function(){
//   $(".dropdown-toggle").dropdown();
// });

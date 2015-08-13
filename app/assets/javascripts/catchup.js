window.Catchup = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    var router = new Catchup.Routers.Router();

    var nav = new Catchup.Views.NavBar({
      router: router
    });

    $("#nav-bar").html(nav.render().$el);

    Backbone.history.start();
  }
};

$(document).ready(function(){
  Catchup.initialize();
});

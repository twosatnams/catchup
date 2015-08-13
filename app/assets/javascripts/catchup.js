window.Catchup = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new Catchup.Routers.Router;

    // var nav = new BackboneDemo.Views.NavShow({
    //   router: router,
    //   collection: tweets
    // });
    //
    // $("#navbar").html(nav.render().$el);


    Backbone.history.start();
  }
};

$(document).ready(function(){
  Catchup.initialize();
});

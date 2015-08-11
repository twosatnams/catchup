window.Catchup = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new Catchup.Routers.Router;
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Catchup.initialize();
});

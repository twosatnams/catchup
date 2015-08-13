Catchup.Views.NavBar = Backbone.View.extend({
  template: JST["navbar/nav_bar"],

  initialize: function (options) {
    this.router = options.router;
    this.listenTo(this.router, "route", this.handleRoute);
  },

  handleRoute: function (routeName, params) {
    this.$el.find(".active").removeClass("active");
    this.$el.find("." + routeName).addClass("active");
  },

  // updateCount: function () {
  //   this.$("#tweets-count").text(this.collection.length);
  // },

  render: function () {
    var content = this.template({
      currentUser: this.currentUser
    });
    this.$el.html(content);
    return this;
  }
});

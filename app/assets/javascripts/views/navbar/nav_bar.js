Catchup.Views.NavBar = Backbone.CompositeView.extend({
  template: JST["navbar/nav_bar"],

  initialize: function (options) {
    this.router = options.router;
    this.listenTo(this.router, "route", this.handleRoute);

    this.users = new Catchup.Collections.Users();

    this.listenTo(this.users, "sync", this.renderResults);
    this.listenTo(this.users, "add", this.addUserResult);
    this.listenTo(this.users, "remove", this.removeUserResult);

    $(document).keyup(this.handleKey.bind(this));
  },

  events: {
    "click #edit-profile" : "editProfile",
    "input input[type=text]": "search",
    "click a": "removeSearch",
    "click .transparent-background": "removeSearch"
  },

  editProfile: function () {
    Backbone.history.navigate("users/" + currentUser.get('id') + "/edit", {trigger: true});
  },

  handleRoute: function (routeName, params) {
    this.$el.find(".active").removeClass("active");
    this.$el.find("." + routeName).addClass("active");
  },

  handleKey: function (e) {
    if (e.keyCode === 27) {
      this.removeSearch();
    }
  },

  removeSearch: function (e) {
    this.$('.results').addClass("empty");
    this.$('input.form-control').val("");
  },

  renderResults: function () {
    if (this.users.length !== 0) {
      this.$('.results').removeClass("empty");
    } else {
      this.$('.results').addClass("empty");
    }
  },

  addUserResult: function (user) {
    var view = new Catchup.Views.UserSearchItem({ model: user});
    this.addSubview("ul.results", view);
  },

  removeUserResult: function (user) {
    this.removeModelSubview("ul.results", user)
  },

  search: function (e) {
    e.preventDefault();
    var search = this.$("input.form-control").val();
    this.users.fetch({ data: { search: search }});
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.$el.find('#sign_out_auth_token')
            .val($('meta[name=csrf-token]').attr('content'));
    return this;
  }
});

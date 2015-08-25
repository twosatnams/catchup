Catchup.Views.NavBar = Backbone.CompositeView.extend({
  template: JST["navbar/nav_bar"],

  initialize: function (options) {
    this.router = options.router;
    this.listenTo(this.router, "route", this.handleRoute);

    this.model = options.router.user;
    this.listenTo(this.model, 'sync', this.render);

    this.friendRequests = this.model.friendRequests();
    this.friends = this.model.friends();
    this.listenTo(this.friendRequests, "add remove", this.updateCount);

    this.users = new Catchup.Collections.Users();

    this.listenTo(this.users, "sync", this.renderResults);
    this.listenTo(this.users, "add", this.addUserResult);
    this.listenTo(this.users, "remove", this.removeUserResult);

    this.listenTo(this.friendRequests, 'add reset', this.addFriendRequestsSubview);
    this.listenTo(this.friendRequests, 'sync', this.render);
    this.listenTo(this.friendRequests, 'remove', this.removeFriendRequestSubview);

    this.friendRequests.each(function (friend) {
      that.addFriendRequestsSubview(friend);
    });

    $(document).keyup(this.handleKey.bind(this));
  },

  events: {
    "click #edit-profile" : "editProfile",
    "input input[type=text]": "search",
    "click a": "removeSearch",
    "click .transparent-background" : "removeSearch",
    "click .friend-requests-badge" : "showFriendRequests",
    "click a" : "hideFriendRequests",
    "click .transparent-background" : "hideFriendRequests"
  },

  addFriendRequestsSubview: function (friend) {
    var subview = new Catchup.Views.FriendRequestSubview({
      model: friend,
      collection: this.friendRequests,
      friends: this.friends
    });
    // WTF is true doing here?
    this.addSubview(".friend-requests-list", subview, true);
  },

  updateCount: function () {
    this.$("#requests-count").text(this.friendRequests.length);
  },

  showFriendRequests: function () {
    this.$('.friend-requests-list').show();
  },

  hideFriendRequests: function () {
    this.$('.friend-requests-list').hide();
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
    this.$('.search-results-list').hide();
    this.$('.search-results-list').addClass("empty");
    this.$('input.form-control').val("");
  },

  renderResults: function () {
    if (this.users.length !== 0) {
      this.$('.search-results-list').removeClass("empty");
    } else {
      this.$('.search-results-list').addClass("empty");
    }
  },

  addUserResult: function (user) {
    var view = new Catchup.Views.UserSearchItem({ model: user});
    this.addSubview(".search-results-list", view);
  },

  removeUserResult: function (user) {
    this.removeModelSubview(".search-results-list", user)
  },

  search: function (e) {
    e.preventDefault();
    this.$('.search-results-list').show();
    var search = this.$("input.form-control").val();
    this.users.fetch({ data: { search: search }});
  },

  render: function () {
    var content = this.template({
      user: this.model
    });
    this.$el.html(content);
    this.attachSubviews();
    this.$('.friend-requests-list').hide();
    this.$el.find('#sign_out_auth_token')
            .val($('meta[name=csrf-token]').attr('content'));
    return this;
  }
});

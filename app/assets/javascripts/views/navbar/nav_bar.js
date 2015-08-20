Catchup.Views.NavBar = Backbone.View.extend({
  template: JST["navbar/nav_bar"],

  initialize: function (options) {
    this.router = options.router;
    this.listenTo(this.router, "route", this.handleRoute);
    this.users = new Catchup.Collections.Users();
    this.listenTo(this.users, "sync", this.renderResults);
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

  // BEGINNING OF DARREN STUFF

  handleKey: function (e) {
    if (e.keyCode === 27) {
      this.eachSubview(function (subview) { subview.remove(); });
      // this.$('.teams-results').addClass("empty");
      // this.$('.tournaments-results').addClass("empty");
      // this.$('input.form-control').val("");
    }
  },

  removeSearch: function (e) {
    // this.eachSubview(function (subview) { subview.remove(); });
    // this.$('.teams-results').addClass("empty");
    // this.$('.tournaments-results').addClass("empty");
    // this.$('input').val("");
  },

  renderResults: function () {
    this.eachSubview(function (subview) { subview.remove(); });
    if (this.teams.length === 0 && this.tournaments.length === 0) {
      this.$('.empty').removeClass("empty").addClass("empty");
    } else {
      if (this.teams.length !== 0) {
        this.$('.teams-results').removeClass("empty");
        this.teams.each(this.addTeamName.bind(this));
      } else {
        this.$('.teams-results').addClass("empty");
      }

      if (this.tournaments.length !== 0) {
        this.$('.tournaments-results').removeClass("empty");
        this.tournaments.each(this.addTournamentTitle.bind(this));
      } else {
        this.$('.tournaments-results').addClass("empty");
      }

      // this.$('.teams-results').removeClass("empty");
      // this.teams.each(this.addTeamName.bind(this));
      // this.$('.tournaments-results').removeClass("empty");
      // this.tournaments.each(this.addTournamentTitle.bind(this));
    }
  },

  addTeamName: function (team) {
    var view = new TournaGen.Views.TeamsIndexItem({ model: team });
    this.addSubview("ul.teams-results", view);
  },

  addTournamentTitle: function (tournament) {
    var view = new TournaGen.Views.TournamentsIndexItem({ model: tournament });
    this.addSubview("ul.tournaments-results", view);
  },

  search: function (e) {
    e.preventDefault();
    var search = this.$("input.form-control").val();
    if (search !== "") {
      this.teams.fetch({ data: { search: search }});
      this.tournaments.fetch({ data: { search: search }});
      this.renderResults();
    } else {
      this.eachSubview(function (subview) { subview.remove(); });
      this.$('.teams-results').addClass("empty");
      this.$('.tournaments-results').addClass("empty");
    }
  },

  //END OF DARREN STUFF

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.$el.find('#sign_out_auth_token')
            .val($('meta[name=csrf-token]').attr('content'));
    return this;
  }
});

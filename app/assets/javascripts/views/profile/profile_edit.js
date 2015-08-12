Catchup.Views.ProfileEdit = Backbone.View.extend({
  template: JST['profile/profile_edit'],
  tagName: 'form',

  events: {
    "click .submit-changes" : "submit"
  },

  render: function () {
    var content = this.template({
      user: this.model
    });
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();
    var attrs = this.$el.serializeJSON();
    this.model.set(attrs);
    debugger
    this.model.save({}, {
      success: function () {
        Backbone.history.navigate("users/" + currentUser.get("id"), {trigger: true});
      }
    });
  }
});

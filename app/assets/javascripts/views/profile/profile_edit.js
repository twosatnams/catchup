Catchup.Views.ProfileEdit = Backbone.View.extend({
  template: JST['profile/profile_edit'],
  tagName: 'form',
  className: 'form-edit-profile',

  initialize: function () {

  },

  events: {
    "click .submit-changes" : "submit"
  },

  render: function () {
    var content = this.template({
      user: this.model
    });
    this.$el.html(content);
    // this.$('.transparent-background').hide();
    return this;
  },

  submit: function (event) {
    event.preventDefault();
    var attrs = this.$el.serializeJSON();
    this.model.set(attrs);
    this.model.save({}, {
      success: function () {
        Backbone.history.navigate("users/" + currentUser.get("id"), {trigger: true});
      }
    });
  }
});

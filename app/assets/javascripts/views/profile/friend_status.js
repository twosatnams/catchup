Catchup.Views.FriendStatus = Backbone.View.extend({
  template: JST['profile/friendship_status'],

  buttonText: function () {
    if (this.model.get('friendship_status') === 'add-friend') {
      return "Add Friend";
    } else if (this.model.get('friendship_status') === 'un-friend') {
      return "Unfriend";
    } else if (this.model.get('friendship_status') === 'friend-request-sent') {
      return "Request Sent";
    } else if (this.model.get('friendship_status') === 'accept-friend-request') {
      return "Accept Request"
    } else {
      return "something's wrong"
    }
  },

  render: function () {
    debugger
    var content = this.template({
      buttonText: this.buttonText(),
      id: this.model.get('friendship_status')
    });
    this.$el.html(content);
    return this;
  }
});

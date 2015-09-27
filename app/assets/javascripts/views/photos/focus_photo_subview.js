Catchup.Views.focusPhotoSubview = Backbone.View.extend({
  template: JST['photo/focus_photo'],

  events: {
    'click .fp-background': 'remove'
  },

  render: function () {
    var content = this.template({
      photo: this.model
    });
    this.$el.html(content);
    return this;
  }
})

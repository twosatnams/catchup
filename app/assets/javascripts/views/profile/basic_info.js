Catchup.Views.BasicInfo = Backbone.View.extend({
  template: JST['profile/basic_info'],

  render: function () {
    var content = this.template({
      user: this.model
    });
    this.$el.html(content);
    return this;
  }
});

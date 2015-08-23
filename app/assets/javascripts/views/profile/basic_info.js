Catchup.Views.BasicInfo = Backbone.View.extend({
  template: JST['profile/basic_info'],
  tagName: 'ul',
  className: 'list-group basic-info-list',

  render: function () {
    var content = this.template({
      user: this.model
    });
    this.$el.html(content);
    return this;
  }
});

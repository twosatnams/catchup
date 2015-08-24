Catchup.Views.UserSearchItem = Backbone.View.extend({
  template: JST['navbar/user_search_item'],
  tagName: 'li',
  className: 'search-result-item',

  render: function () {
    var content = this.template({
      user: this.model
    });
    this.$el.html(content);
    return this;
  }
});

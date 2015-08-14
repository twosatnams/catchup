Catchup.Views.PostForm = Backbone.View.extend({
  template: JST['post/post_form'],
  tagName: 'form',

  render: function () {
    var content = this.template({
      post: this.model
    });
    this.$el.html(content);
    return this;
  }
});

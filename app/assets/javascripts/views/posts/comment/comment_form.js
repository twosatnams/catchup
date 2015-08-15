Catchup.Views.CommentForm = Backbone.View.extend({
  template: JST['post/comment/comment_form'],
  tagName: 'form',

  render: function () {
    var content = this.template({
      comment: this.model
    });
    this.$el.html(content);
    return this;
  }
});

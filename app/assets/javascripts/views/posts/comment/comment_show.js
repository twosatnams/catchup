Catchup.Views.CommentShow = Backbone.View.extend({
  template: JST['post/comment/comment_show'],

  author: function () {
    var author_id = this.model.get('author_id');
    var author = new Catchup.Models.User({ id: author_id});
    author.fetch();
    return author;
  },

  render: function () {
    var content = this.template({
      comment: this.model,
      author: this.author()
    });
    this.$el.html(content);
    return this;
  }
});

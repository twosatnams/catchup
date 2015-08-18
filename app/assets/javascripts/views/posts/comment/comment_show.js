Catchup.Views.CommentShow = Backbone.View.extend({
  template: JST['post/comment/comment_show'],
  // tagName: 'li',

  events: {
    'click .edit-comment' : 'startEdit',
    'click .delete-comment' : 'deleteComment',
    'blur .comment-body': 'stopEdit'
  },

  startEdit: function (event) {
    event.preventDefault();
    this.$('.comment-body').attr('contenteditable', 'true');
    this.$('.comment-body').focus();
  },

  stopEdit: function (event) {
    event.preventDefault();
    var formData = this.$('.comment-body').text();
    this.model.save({body: formData});
  },

  deleteComment: function (event) {
    event.preventDefault();
    var comment = this.collection.get(this.model.escape('id'));
    comment.destroy();
  },

  render: function () {
    var content = this.template({
      comment: this.model
    });
    this.$el.html(content);
    return this;
  }
});

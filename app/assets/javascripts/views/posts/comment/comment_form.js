Catchup.Views.CommentForm = Backbone.View.extend({
  template: JST['post/comment/comment_form'],
  tagName: 'form',

  events: {
    'click .btn-create-comment' : 'newComment'
  },

  newComment: function () {
    var attrs = this.$el.serializeJSON();

    var that = this;
    this.model.set(attrs);
    this.model.save({}, {
      success: function () {
        that.collection.add(that.model);
      }
    });
  },

  render: function () {
    var content = this.template({
      comment: this.model
    });
    this.$el.html(content);
    return this;
  }
});

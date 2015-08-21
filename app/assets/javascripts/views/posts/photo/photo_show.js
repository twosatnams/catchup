Catchup.Views.PhotoShow = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  template: function () {
    if (this.collection.length === 1) {
      return JST['post/photo/single_photo'];
    } else if (this.collection.length === 2) {
      return JST['post/photo/double_photo'];
    } else {
      return JST['post/photo/triple_photo'];
    }
  },

  render: function () {
    var content = this.template({
      photos: this.collection
    });
    this.$el.html(content);
    return this;
  }
});

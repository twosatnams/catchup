Catchup.Views.PhotoShow = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  template: function (options) {
    if (this.collection.length === 1) {
      return JST['post/photo/single_photo'](options);
    } else if (this.collection.length === 2) {
      return JST['post/photo/double_photo'](options);
    } else {
      return JST['post/photo/triple_photo'](options);
    }
  },

  render: function () {
    var content = this.template({ photos: this.collection });
    this.$el.html(content);
    return this;
  }
});

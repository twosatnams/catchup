Catchup.Views.PhotoSubview = Backbone.View.extend({
  template: JST['photo/photo_subview'],

  tagName: 'li',
  className: 'photo-list-item',

  render: function () {
    var content = this.template({
      photo: this.model
    });
    this.$el.html(content);
    return this;
  }
});

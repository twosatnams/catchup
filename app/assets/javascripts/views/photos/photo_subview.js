Catchup.Views.PhotoSubview = Backbone.View.extend({
  template: JST['photo/photo_subview'],

  events: {
    'click img': 'focusPhoto'
  },

  tagName: 'li',
  className: 'photo-list-item',

  focusPhoto: function (event) {
    event.preventDefault();
    var subview = new Catchup.Views.focusPhotoSubview({
      model: this.model
    });
    $('body').append(subview.$el);
    subview.render();
  },

  render: function () {
    var content = this.template({
      photo: this.model
    });
    this.$el.html(content);
    return this;
  }
});

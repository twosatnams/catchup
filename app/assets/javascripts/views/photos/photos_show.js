Catchup.Views.PhotosShow = Backbone.CompositeView.extend({
  template: JST['photo/photos_show'],
  className: 'photo-show',

  initialize: function () {
    this.listenTo(this.collection, 'add reset', this.addPhotoSubview);
    this.listenTo(this.collection, 'sync', this.render);

    var that = this;
    this.collection.each(function (photo) {
      that.addPhotoSubview(photo);
    });
  },

  addPhotoSubview: function (photo) {
    var subview = new Catchup.Views.PhotoSubview({
      model: photo,
    });
    // WTF is true doing here?
    this.addSubview(".photos-list", subview, true);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});

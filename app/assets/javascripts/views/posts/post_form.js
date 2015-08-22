Catchup.Views.PostForm = Backbone.View.extend({
  template: JST['post/post_form'],
  tagName: 'form',

  initialize: function(){
    this._attachedPhotos = [];
  },

  events: {
    'click .btn-submit-post' : 'newPost',
    'click .btn-add-photo' : 'addPhoto',
    'focus .txt-new-post-form' : 'showButtonsPanel'
  },

  showButtonsPanel: function (event) {
    event.preventDefault();
    this.$('.txt-new-post-form').attr('rows', '3');
    this.$('.panel-new-post-buttons').slideDown('fast');
  },

  hideButtonsPanel: function (event) {
    if (event !== undefined) {
      event.preventDefault();
    }
    this.$('.panel-new-post-buttons').slideToggle('fast');
  },

  newPost: function (event) {
    event.preventDefault();
    var attrs = this.$el.serializeJSON();
    var that = this;
    this.model.set(attrs.post);
    this.model.set('photos', this._attachedPhotos);

    this.model.save({}, {
      success: function (model, response, options) {
        that.collection.unshift(that.model, {merge: true});
        that.model = new Catchup.Models.Post();
      }
    });
  },

  addPhoto: function (event) {
    event.preventDefault();
    var that = this;
    cloudinary.openUploadWidget(CLOUDINARY_OPTIONS, function(error, result){
      var data = result[0];
      that._attachedPhotos.push({url: data.url});
    });
  },

  render: function () {
    var content = this.template({
      post: this.model
    });
    this.$el.html(content);
    this.$('.panel-new-post-buttons').hide();
    return this;
  }
});

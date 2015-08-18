Catchup.Views.ProfileShow = Backbone.CompositeView.extend({
  template: JST['profile/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model, 'sync', this.addPostsIndexSubview);
    this.listenTo(this.model, 'sync', this.addNewPostSubview);
    // this.addPostsIndexSubview();
    // this.addNewPostSubview();
    this.listenTo(this.model, 'sync', this.addBasicInfoSubview);
  },

  events: {
    'click #change-cover' : 'updateCover',
    'click #change-avatar' : 'updateAvatar'
  },

  addBasicInfoSubview: function () {
    var basicInfo = new Catchup.Views.BasicInfo({
      model: this.model
    });
    this.addSubview("ul.basic-info", basicInfo);
  },

  updateCover: function(event) {
    event.preventDefault();
    var that = this;
    cloudinary.openUploadWidget(CLOUDINARY_OPTIONS, function(error, result){
      var data = result[0];
      that.model.set({cover_pic: data.url});
      that.model.save({}, {
        success: function () {
          console.log('cover change worked');
        }
      });
    });
  },

  updateAvatar: function(event) {
    event.preventDefault();
    var that = this;
    cloudinary.openUploadWidget(CLOUDINARY_OPTIONS, function(error, result){
      var data = result[0];
      that.model.set({profile_pic: data.url});
      that.model.save({}, {
        success: function () {
          console.log('cover change worked');
        }
      });
    });
  },

  addNewPostSubview: function () {
    var post = new Catchup.Models.Post();
    var form = new Catchup.Views.PostForm({
      model: post,
      collection: this.model.posts()
    });
    this.addSubview(".new-post-form", form);
  },

  addPostsIndexSubview: function () {
    var posts = new Catchup.Views.PostsIndex({
      collection: this.model.posts()
    });
    this.addSubview(".posts-holder", posts);
  },

  render: function () {
    var content = this.template({
      user: this.model
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});

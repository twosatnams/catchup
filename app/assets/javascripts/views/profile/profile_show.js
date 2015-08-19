Catchup.Views.ProfileShow = Backbone.CompositeView.extend({
  template: JST['profile/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.replaceWithTimelineSubview();
  },

  events: {
    'click #change-cover' : 'updateCover',
    'click #change-avatar' : 'updateAvatar',
    'click #photos' : 'replaceWithPhotosSubview',
    'click #about' : 'replaceWithAboutSubview',
    'click #timeline' : 'replaceWithTimelineSubview',
    'click #friends-show' : 'replaceWithFriendsSubview'
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

  replaceWithTimelineSubview: function (event) {
    if (event !== undefined) {
      event.preventDefault();
    }
    var timeline = new Catchup.Views.TimelineSubview({
      model: this.model
    });
    this.swapSubview(timeline);
  },


  replaceWithFriendsSubview: function (event) {
    event.preventDefault();

    var friendsView = new Catchup.Views.FriendsShow({
      collection: this.model.friends()
    });
    this.swapSubview(friendsView);
  },

  swapSubview: function (newView) {
    if (this.activeSubview !== undefined) {
      this.removeSubview(".active-subview", this.activeSubview);
    }
    this.activeSubview = newView;
    this.addSubview('.active-subview',this.activeSubview);
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

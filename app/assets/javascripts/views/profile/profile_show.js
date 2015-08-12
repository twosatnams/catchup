Catchup.Views.ProfileShow = Backbone.CompositeView.extend({
  template: JST['profile/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model, 'sync', this.addBasicInfoSubview);
  },

  addBasicInfoSubview: function () {
    var basicInfo = new Catchup.Views.BasicInfo({
      model: this.model
    });
    this.addSubview("ul.basic-info", basicInfo);
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

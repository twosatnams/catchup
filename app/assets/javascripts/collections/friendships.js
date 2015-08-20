// Catchup.Collections.Friendships = Backbone.Collection.extend({
//   url: '/api/friends',
//   model: Catchup.Model.Friendship,
//
//   getOrFetch: function (id) {
//     var model = this.get(id);
//     if (!model) {
//       model = new Catchup.Models.Friendship({id: id});
//       model.fetch({
//         success: function () {
//           this.add(model);
//         }.bind(this)
//       })
//     } else {
//       model.fetch();
//     }
//
//     return model;
//   },
//
//   initialize: function (models, options) {
//     this.user = options.user;
//   }
// });

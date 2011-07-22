var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var PostSchema = new Schema({
    title: String,
    body: String,
    date: {type:Date default: Date.now},
    state: {type: String, enum:['draft', 'published', 'private'], default:'draft']}
    author: {
        email: {type: String},
        name: String
    }
});


mongoose.connect('mongodb://localhost/mydatabase');
mongoose.model('Post', PostSchema);

var Post = mongoose.model('Post');

var post = new Post();
post.title = 'first post';
post.body = 'post body';
post.date = Date.now();
post.state = 'published';

post.save(function(err) {
    if (err) {
        console.log(err);
    }
    else {
        console.log('saved');
        mongoose.disconnect();
    }
});



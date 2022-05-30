import mongoose from "mongoose";

// make mongoose use the built-in promises of node.
mongoose.Promise = global.Promise;
// connect mongoose to our mongodb database server
if (process.env.NODE_ENV === 'test') {
    mongoose.connect(process.env.MONGODB_URI!, {});
} else {
    mongoose.connect(process.env.MONGODB_ATLAS_URI!, {
        dbName: process.env.DB_NAME
    });
}

export = mongoose;

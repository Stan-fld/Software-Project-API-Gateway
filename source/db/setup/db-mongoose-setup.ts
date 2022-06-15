import mongoose from 'mongoose';

// connect mongoose to our mongodb database server
if (process.env.NODE_ENV === 'test') {
    mongoose.connect(process.env.MONGODB_URI!, {});
} else {
    mongoose.connect(process.env.MONGODB_URI!, {
        dbName: process.env.MONGODB_DB_NAME
    });
}

export = mongoose;

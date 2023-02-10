const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name:{
        required:true,
        type: String,
        trim:true,
    },
    number:{
        require:true,
        type: Int16Array
    },
    email:{
        required:true,
        type:String,
        trim:true,
    },
    gnumber:{
        require:true,
        type: Int16Array
    },
    gemail:{
        required:true,
        type:String,
        trim:true,
    },
    password:{
        require:true,
        type:String
    }
    //cart
});

const User = mongoose.model("User",userSchema);
module.exports = User;
const mongoose = require('mongoose');

const userScema = mongoose.Schema({
    name:{
        required: true,
        type: String,
        trim:true
    },
    email:{
        required: true,
        type: String,
        trim:true,
        validate:{
            validator:(value)=>{
                const re =
  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
               return value.match(re);
            },
            messege:'please enter a valid email address'
        },  
    },
    password:{
        required: true,
        type: String,
        // validate:{
        //     validator:(value)=>{
        //         return value.length >= 6;
        //        return value.match(re);
        //     },
        //     messege:'please enter a valid email address'
        // }, 
    },
    address:{
        default:'',
        type: String,
    },
    type:{
        type:String,
        default:'user',
    }
})

const User = mongoose.model('User', userScema);
module.exports = User;
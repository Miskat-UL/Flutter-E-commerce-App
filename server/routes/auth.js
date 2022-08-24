const express = require('express');
const User = require('../models/user');
const authExpress = express.Router();
const bcrypt = require('bcrypt');
const auth = require('../middlewares/auth');
const jwt = require('jsonwebtoken');
authExpress.post("/api/signup", async (req, res) =>  {
    // res.json({'username':'showmik','password':'123',});
    try{
    const {name, email,password} = req.body;
    const existingUser = await User.findOne({email});
    if(existingUser){
        return res.status(400).json({msg:"user email already exists"});
    };
    const hsashpassword = await bcrypt.hash(password,8);
    let user = new User({
        email,
        password: hsashpassword,
        name,
    });
    user = await user.save();
    res.json(user);
    } 
    catch(e){
        res.status(500).json({error:e.message});
    }
} );


authExpress.post('/api/login', async (req, res) =>{
    try{
        const {email, password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg:"user email not found"});
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg:"invalid credentials. Password is incorrect"});
        }
        const token = jwt.sign({id:user._id}, "passwordKey");
        res.json({token, ...user._doc});
    }catch(e){
        res.status(500).json({error:e.message});
    }
})


authExpress.post('/tokenValidation', async(req, res) =>{
    try{

        const token = req.header('x-auth-token');
        if(!token){
            return res.json(false);
        }
        const verified = jwt.verify(token, "passwordKey");
        if(!verified){
            return res.json(false);
        }
        const user = await User.findById(verified.id);
        if(!user){
            return res.json(false);
        }
        res.json(true);
        
        // const token = req.header('x-auth-token');
        // if(!token){
        //     return res.status(400).json({msg:"authorization denied"});
        // }
        // const verified = jwt.verify(token, "passwordKey");
        // if(!verified){
        //     return res.status(400).json({msg:"token is not valid"});
        // }
        // const user = await User.findById(verified.id);
        // if(!user){
        //     return res.status(400).json({msg:"user not found"});
        // }else{
        //     res.json(true);
        // }
    }catch(e){
        res.status(500).json({error:e.message});
    }
});



authExpress.get('/', auth, async (req, res) =>{
    const user = await User.findById(req.user);
    res.json({...user._doc, token:req.token});
} );
module.exports = authExpress;
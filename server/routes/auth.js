const express = require("express");
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();

authRouter.post('/api/signup',async (req,res)=>{
    try{
        const {name, number, email, gnumber, gemail, password} = req.body;

    //find if the user with the number already exists
    const existingUser = await User.findOne({number});
    if (existingUser){
        //status 400 for client side error
        return res.status(400).json({msg:'User with same number already exists!'});
    }
    const hashedpw = await bcryptjs.hash(password, 8);

    let user = new User({
        name,
        email, number, gemail,gnumber, password:hashedpw
    })
    user = await user.save();
    res.json(user);
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
});

module.exports = authRouter;
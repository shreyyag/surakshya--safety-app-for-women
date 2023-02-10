//installed express, http, mongoose, nodemon(as dev dependency)
//IMPORTS from PACKAGES
const express = require("express");
const mongoose = require("mongoose");
//IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
// import './pages/user_login.dart'

//INIT
const PORT = 3000;
const app = express();
//const DB = "mongodb+srv://shreyagurung:shreya123@cluster0.tbpyjmg.mongodb.net/?retryWrites=true&w=majority";
const DB = "mongodb://localhost:27017/Women_safety"


//middleware: connects client side and server side
app.use(authRouter);
app.use(express.json());
//connections
mongoose.connect(DB).then(()=>{
    console.log('Connection sucessful');
})
.catch((e)=>{
    console.log(e);
});
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`);
})
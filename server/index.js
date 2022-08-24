// like importing modules
const express = require('express');
const authExpress = require('./routes/auth.js');
const mongoose = require('mongoose');
// initialize express
const app = express();
const PORT = 3000;
const DB = "mongodb+srv://miskat:asd1234@cluster0.r6dvyag.mongodb.net/?retryWrites=true&w=majority"
// middleware
app.use(express.json());
app.use(authExpress);

// connection
mongoose.connect(DB).then(()=>{
    console.log("conccention successful");
}).catch((e)=>{
    console.log(e);
});

app.listen(PORT,"0.0.0.0", () => {
    console.log(`Server started on port ${PORT}`);
} );


app.get('/hello',(req, res)=>{
    res.send({
        hi: ' hello world',
        hi2: ' fuckers',
    })
});
// app.get('/p',(req, res)=>{
//     res.send({
//         hi: ' hello world',
//         hi2: ' adad',
//     })
// });

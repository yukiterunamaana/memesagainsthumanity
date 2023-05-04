const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);

var io = require("socket.io")(server);

app.use(express.json());

const db = "mongodb+srv://mnhyg_hzwxlyM:KzWBz2GTBCCtMO9k@memchiki.2iwaqos.mongodb.net/?retryWrites=true&w=majority";

io.on('connection',(socket)=>{console.log("connected!");})

mongoose.connect(db).then(()=>{console.log("Connection successful!");}).catch((e)=>{console.log(e);});
//

server.listen(port, '0.0.0.0', ()=>{console.log(`Server is up and running on port ${port}`)});


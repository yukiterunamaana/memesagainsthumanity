// const express = require("express");
// const http = require("http");
// const mongoose = require("mongoose");
//
// const app = express();
// const port = process.env.PORT || 3000;
// var server = http.createServer(app);
//
// var io = require("socket.io")(server);
//
// app.use(express.json());
//
// const db = "mongodb+srv://mnhyg_hzwxlyM:KzWBz2GTBCCtMO9k@memchiki.2iwaqos.mongodb.net/?retryWrites=true&w=majority";
//
// io.on('connection',(socket)=>{console.log("connected!");})
//
// mongoose.connect(db).then(()=>{console.log("Connection successful!");}).catch((e)=>{console.log(e);});
// //
//
// server.listen(port, '0.0.0.0', ()=>{console.log(`Server is up and running on port ${port}`)});
//

const express = require('express');
const http = require('http');
const socket_io = require('socket.io');
const moment = require('moment');
const {static} = require("express");

const app = express();
const server = http.createServer(app);
const io = socket_io(server);

const activeRooms = [];

app.get('/', (req, res) => {
    res.send('Welcome to the chat app!');
});

io.on('connection', (socket) => {
    console.log('New user connected');

    socket.on('createRoom',({nickname}) =>
    {
        console.log(nickname);
    });

    // socket.on('createRoom', (data) => {
    //     const { room, username } = data;
    //     const roomExists = activeRooms.some((r) => r.name === room);
    //
    //     if (!roomExists) {
    //         const newRoom = {
    //             name: room,
    //             users: [username],
    //             createdTime: Date.now()
    //         };
    //
    //         activeRooms.push(newRoom);
    //
    //         socket.join(room);
    //
    //         socket.emit('message', {
    //             text: `Welcome to the new chat room, ${username}!`,
    //             time: moment().format('h:mm a')
    //         });
    //     } else {
    //         socket.emit(
    //             'error',
    //             `The room "${room}" already exists. Please join the existing room instead.`
    //         );
    //     }
    // });
    // socket.on('join', (data) => {
    //     const { room, username } = data;
    //     const roomExists = activeRooms.some((r) => r.name === room);
    //
    //     if (roomExists) {
    //         socket.join(room);
    //         activeRooms.find((r) => r.name === room).users.push(username);
    //
    //         socket.emit('message', {
    //             text: `Welcome to the chat room, ${username}!`,
    //             time: moment().format('h:mm a')
    //         });
    //
    //         socket.broadcast.to(room).emit('message', {
    //             text: `${username} has joined the chat!`,
    //             time: moment().format('h:mm a')
    //         });
    //     } else {
    //         socket.emit(
    //             'error',
    //             `The room "${room}" does not exist. Please join/create another room.`
    //         );
    //     }
    // });
    //

    //
    // socket.on('leave', (data) => {
    //     const { room, username } = data;
    //
    //     socket.leave(room);
    //
    //     const roomIndex = activeRooms.findIndex((r) => r.name === room);
    //     activeRooms[roomIndex].users.splice(activeRooms[roomIndex].users.indexOf(username), 1);
    //
    //     socket.broadcast.to(room).emit('message', {
    //         text: `${username} has left the chat.`,
    //         time: moment().format('h:mm a')
    //     });
    //
    //     if (activeRooms[roomIndex].users.length === 0) {
    //         setTimeout(() => {
    //             const isStillEmpty = activeRooms[roomIndex].users.length === 0;
    //             if (isStillEmpty) {
    //                 activeRooms.splice(roomIndex, 1);
    //                 console.log(`Room "${room}" has been deleted.`);
    //             }
    //         }, 300000); // 5 minutes = 300000 milliseconds
    //     }
    // });
    //
    // socket.on('message', (data) => {
    //     const { room, username, message } = data;
    //
    //     io.to(room).emit('message', {
    //         username,
    //         text: message,
    //         time: moment().format('h:mm a')
    //     });
    // });
    //
    // socket.on('disconnect', () => {
    //     console.log('User disconnected');
    // });
});

server.listen(3000, () => {
    console.log('Server is listening on port 3000');
});
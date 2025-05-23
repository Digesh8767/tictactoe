//importing modules
const express = require("express");
const http = require("http");
const Mongoose = require("mongoose");
const Socket = require("socket.io");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require("./models/room");
var io = require("socket.io")(server);

//client -> middleware -> server
//middle ware
app.use(express.json());

const DB =
    "mongodb+srv://digesh:test123@cluster0.rqo0aya.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

io.on("connection", (socket) => {
    console.log("Connected!");
    socket.on("createRoom", async ({ nickname }) => {
        console.log(nickname);
        try {
            // room is created
            let room = new Room();

            //player is created in room
            let player = {
                socketID: socket.id,
                nickname,
                playerType: "X",
            };
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            console.log(room);
            const roomId = room._id.toString();
            socket.join(roomId);
            //tell our client that room has been created
            // go to the next page

            io.to(roomId).emit("createRoomSuccess", room);
        } catch (e) {
            console.log(e);
        }
    });
});

Mongoose.connect(DB)
    .then(() => {
        console.log("Connection successful!");
    })
    .catch((e) => {
        console.log(e);
    });

server.listen(port, "0.0.0.0", () => {
    console.log(`server started and running ${port}`);
});

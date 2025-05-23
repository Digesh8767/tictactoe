const { default: mongoose } = require('mongoose');
const Mongoose = require('mongoose');

const playerSchema = new mongoose.Schema({
    nickname:{
        type: String,
        trim: true,

    },
    socketID:{
        type: String,
        require: true,
    },
    points: {
        type: Number,
        default: 0
    },
   playerType: {
    type: String, // ✅ Correct type for "X" or "O"
    enum: ['X', 'O'], // Optional: only allow X or O
    required: true,
},

});

    module.exports = playerSchema;
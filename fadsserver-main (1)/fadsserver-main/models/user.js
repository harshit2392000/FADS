const mongoose = require('mongoose');

// Define User schema
const userSchema = new mongoose.Schema({
    phoneNumber: {
        type: String,
        required: true,
        unique: true,
    },
    packages: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Package',
    }],
}, { timestamps: true });

// Create User model
const User = mongoose.model('User', userSchema);

module.exports = User;

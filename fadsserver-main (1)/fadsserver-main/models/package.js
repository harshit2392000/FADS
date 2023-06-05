const mongoose = require('mongoose');

// Define Package schema
const packageSchema = new mongoose.Schema(
    {
        phoneNumber: { type: String, required: true },
        destination: { type: String, enum: ['bhostel1', 'bhostel2', 'ghostel1'], required: true },
        cartNumber: { type: Number, required: true },
        cartDoorNumber: { type: Number, required: true },
        otp: { type: String, required: true },
        notifications: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Notification' }],
    },
    { timestamps: true }
);

// Create Package model
const Package = mongoose.model('Package', packageSchema);

module.exports = Package;

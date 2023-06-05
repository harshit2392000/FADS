const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema(
    {
        packageId: { type: mongoose.Schema.Types.ObjectId, ref: 'Package', required: true },
        message: { type: String, required: true },
        status: { type: String, enum: ['unread', 'read'], default: 'unread' },
    },
    { timestamps: true }
);

const Notification = mongoose.model('Notification', notificationSchema);

module.exports = Notification;

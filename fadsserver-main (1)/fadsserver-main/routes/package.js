const express = require('express');
const router = express.Router();
const Package = require('../models/package');
const User = require('../models/user');
const Notification = require('../models/notification');
const tokenService = require('../services/tokenService');

router.post('/register-package', async (req, res) => {
    const { phoneNumber, destination, cartDoorNumber, cartNumber, adminSecret } = req.body;
    console.log(destination);
    if (adminSecret !== process.env.ADMIN_SECRET) {
        return res.status(401).json({ message: "you are not authorised to do this action" })
    }
    if (!['bhostel1', 'bhostel2', 'ghostel1'].includes(destination)) {
        return res.status(400).json({ message: 'Invalid destination.' });
    }

    try {
        // Create a new package
        const package = await Package.create({ phoneNumber, destination, cartDoorNumber, cartNumber, otp: 'abcd' });

        // Check if the user exists
        let user = await User.findOne({ phoneNumber });

        if (!user) {
            // Create a new user if the user doesn't exist
            user = await User.create({ phoneNumber, packages: [] });
        }

        // Add the package to the user's package list
        user.packages.push(package._id);
        await user.save();

        // Create a notification for the package
        const notification = await Notification.create({
            packageId: package._id,
            message: `Package with ID ${package._id} has been registered`,
            status: 'unread'
        });
        await notification.save();

        package.notifications.push(notification._id);
        await package.save();

        res.status(201).json({ package });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error.' });
    }
});

router.post('/all', async (req, res) => {
    try {
        const authToken = req.body.authToken;
        const ph = req.body.phoneNumber;
        const phoneNumber = tokenService.verifyToken(authToken);
        console.log(phoneNumber, ph);
        if (phoneNumber !== ph) {
            return res.status(401).json({ message: 'Unauthorized' });
        }

        const packages = await Package.find({ phoneNumber });
        res.status(200).json(packages);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router;

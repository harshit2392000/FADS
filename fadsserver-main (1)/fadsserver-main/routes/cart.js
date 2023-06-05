const express = require('express');
const router = express.Router();
const Package = require('../models/package');
const Notification = require('../models/notification');

let cartSecret = {
    "1": "qqmmqqwwnnee"
};

router.post('/sent-otp-for-package-retrieval', async (req, res) => {
    const { cartNumber, cartDoorNumber, secretId } = req.body;
    console.log("trying to generate otp for package in " + cartNumber + " and door " + cartDoorNumber);
    try {
        if (cartSecret[cartNumber] !== secretId)
            return res.status(401).json({ message: "Cart not Authorised" });

        const package = await Package.findOne({ cartNumber, cartDoorNumber });
        if (!package) {
            return res.status(404).json({ message: 'Package not found' });
        }

        const otp = Math.floor(1000 + Math.random() * 9000);
        const message = `Your OTP for package retrieval is ${otp}. Enter this OTP to retrieve your package.`;

        const notification = new Notification({
            message,
            packageId: package._id,
            status: 'unread'
        });

        await notification.save();
        package.notifications.push(notification._id);
        package.$set('otp', String(otp));
        await package.save();

        res.status(200).json({ otp });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
});

router.post('/verify-otp-for-package-retrieval', async (req, res) => {
    const { cartNumber, cartDoorNumber, otp, secretId } = req.body;
    console.log("trying to verify otp:" + otp);

    try {
        if (cartSecret[cartNumber] !== secretId)
            return res.status(401).json({ message: "Cart not Authorised" });

        const package = await Package.findOne({ cartNumber, cartDoorNumber });

        if (!package) {
            return res.status(404).json({ message: 'Package not found' });
        }

        if (package.otp === String(otp)) {
            // Otp matched, return positive response
            return res.status(200).json({ message: 'OTP verified' });
        } else {
            // Otp did not match
            return res.status(400).json({ message: 'Invalid OTP' });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server Error' });
    }
});

module.exports = router;

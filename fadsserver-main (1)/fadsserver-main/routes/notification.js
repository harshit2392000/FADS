const express = require('express');
const { verifyToken } = require('../services/tokenService');
const Package = require('../models/package');
const Notification = require('../models/notification');

const router = express.Router();

let cartSecret = {
    "1": "qqmmqqwwnnee"
};

router.post('/', async (req, res) => {
    // Get auth token and phone number
    const authToken = req.body.authToken;
    const phoneNumber = req.body.phoneNumber;
    const packageId = req.body.packageId;
    const cartNumber = req.body.cartNumber;
    const secretId = req.body.secretId;
    console.log(authToken)
    const ph = verifyToken(authToken);

    if (cartSecret[cartNumber] !== secretId)
        return res.status(401).json({ message: "Cart not Authorised" });

    if (phoneNumber !== ph) {
        return res.status(401).json({ message: 'Unauthorized' });
    }

    try {
        // Retrieve packages associated with phone number
        // const package = await Package.findById(packageId)

        const notifications = await Notification.find({ packageId: packageId });

        res.json({ notifications });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

router.post('/add-to-cart', async (req, res) => {
    console.log("post request from client");
    const { cartDoorNumber, cartNumber, secretId } = req.body;

    try {
        if (cartSecret[cartNumber] !== secretId) {
            return res.status(401).json({ message: "Cart not Authorised" });
        }
        // Finding the package with the matching door number
        const package = await Package.findOne({ cartDoorNumber, cartNumber });

        if (!package) {
            return res.status(404).json({ error: 'Package not found' });
        }

        // Creating a new notification
        const notification = new Notification({
            message: 'The package has been placed in the cart',
            packageId: package._id,
            status: 'unread'
        });

        // Saving the new notification to the notifications collection
        const savedNotification = await notification.save();

        // Adding the notification to the package's notification list
        package.notifications.push(savedNotification._id);
        await package.save();

        // Returning the updated package with the added notification
        res.json(package);

    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
})

// Sub route for adding a notification to a package
router.post('/add-notification', async (req, res) => {
    const { cartNumber, message, secretId } = req.body;
    console.log("trying to send general notification to all packages in cart " + cartNumber);
    try {

        if (cartSecret[cartNumber] !== secretId)
            return res.status(401).json({ message: "Cart not Authorised" });

        const packages = await Package.find({ cartNumber });
        const notifications = await Promise.all(packages.map(async (pkg) => {
            const notification = new Notification({ message, packageId: pkg._id, status: 'unread' });
            await notification.save();
            pkg.notifications.push(notification._id);
            await pkg.save();
            return notification;
        }));
        res.status(200).json({ notifications });
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

router.post('/arrived-at-destination', async (req, res) => {
    const { cartNumber, secretId } = req.body;
    console.log("trying to send notification of package arrival to all packages in cart " + cartNumber);
    try {

        if (cartSecret[cartNumber] !== secretId)
            return res.status(401).json({ message: "Cart not Authorised" });

        // Find all packages associated with the given cart number
        const packages = await Package.find({ cartNumber });

        // Create a notification for each package
        for (const pkg of packages) {
            const { cartDoorNumber } = pkg;

            const notification = new Notification({
                message: `Please proceed to the cart and open door ${cartDoorNumber}`,
                packageId: pkg._id,
                status: 'unread'
            });
            await notification.save();

            // Add the notification ID to the package notifications list
            pkg.notifications.push(notification._id);
            await pkg.save();
        }

        res.json({ message: 'Notifications sent' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;

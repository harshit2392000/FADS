const express = require('express');
const app = express();

const bodyParser = require('body-parser')


const notifications = [
    {
        id: 1,
        title: 'Your order has been shipped',
        description: 'Your order #12345 has been shipped and will be delivered on Monday, January 25th.',
        timestamp: new Date(),
        type: 'delivery',
    },
    {
        id: 2,
        title: 'Your order is out for delivery',
        description: 'Your order #67890 is out for delivery and will be delivered today.',
        timestamp: new Date(),
        type: 'delivery',
    },
    {
        id: 3,
        title: 'Your order has been delivered',
        description: 'Your order #54321 has been successfully delivered.',
        timestamp: new Date(),
        type: 'delivery',
    },
    {
        id: 4,
        title: 'Your order is delayed',
        description: 'Your order #09876 is delayed due to unforeseen circumstances and will be delivered tomorrow.',
        timestamp: new Date(),
        type: 'delivery',
    },
];

app.use(bodyParser.json())

app.get('/notifications', (req, res) => {
    res.json(notifications);
});

let validOtp = "1234"

app.post('/send-otp', (req, res) => {
    // Get the phone number from the request body
    const phoneNumber = req.body.phoneNumber;
    console.log("Phone number: " + phoneNumber);
    // Generate a random OTP
    const otp = Math.floor(1000 + Math.random() * 9000);
    validOtp = `${otp}`
    console.log("Otd: " + otp);
    // Send the OTP as an SMS using Twilio

    res.send("otp send succeessfully");
})

app.post('/verify-otp', (req, res) => {
    const { otp } = req.body;
    if (otp === validOtp) {
        res.status(200).json({ message: 'OTP verified' });
    } else {
        res.status(400).json({ message: 'Invalid OTP' });
    }
});

app.listen(3000, () => {
    console.log('Server started on port 3000');
});

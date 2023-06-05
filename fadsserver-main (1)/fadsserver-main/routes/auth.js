const express = require('express');
const router = express.Router();
const otpService = require('../services/otpService');
const hashingService = require('../services/hashingService');
const tokenService = require('../services/tokenService');

// Route to send OTP to user's phone number
router.post('/send-otp', async (req, res) => {
    const { phoneNumber } = req.body;
    const otp = otpService.sendOtp(phoneNumber);
    const hashedOtp = await hashingService.hashData(String(otp));
    res.send({ success: true, hashedOtp });
});

// Route to verify OTP entered by user
router.post('/verify-otp', async (req, res) => {
    const { phoneNumber, otp, hashedOtp } = req.body;
    const isValid = await hashingService.verifyData(String(otp), String(hashedOtp));
    if (isValid) {
        const authToken = tokenService.createToken(phoneNumber);
        res.send({ success: true, authToken });
    } else {
        res.status(400).send({ success: false, message: 'Invalid OTP' });
    }
});

module.exports = router;

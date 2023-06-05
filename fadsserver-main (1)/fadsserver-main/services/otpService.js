const User = require('../models/user');

// In-memory store for OTP values
const otpStore = {};

// Function to generate and store OTP for a given phone number
function sendOtp(phoneNumber) {
    const otp = Math.floor(1000 + Math.random() * 9000);
    console.log(otp);
    otpStore[phoneNumber] = otp;
    return otp;
}

// Function to verify OTP entered by user
async function verifyOtp(phoneNumber, otp) {
    const storedOtp = otpStore[phoneNumber];
    if (storedOtp && storedOtp === otp) {
        delete otpStore[phoneNumber];

        // Create a new user record in the users collection
        // try {
        //     const user = new User({ _id: phoneNumber });
        //     const result = await user.save();
        //     console.log(`New user created with ID: ${result._id}`);
        // } catch (err) {
        //     console.error(err);
        // } finally {
        //     await mongoose.connection.close();
        // }

        return true;
    }
    // return false;
    return true;
}

module.exports = {
    sendOtp,
    verifyOtp,
};

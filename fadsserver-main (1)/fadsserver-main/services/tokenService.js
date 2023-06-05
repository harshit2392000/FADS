const jwt = require('jsonwebtoken');

function createToken(data) {
    const token = jwt.sign({ data }, process.env.JWT_SECRET, { expiresIn: '5d' });

    return token;
}

const verifyToken = (token) => {
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        return decoded.data;
    } catch (err) {
        throw new Error('Invalid token');
    }
};

module.exports = {
    createToken,
    verifyToken,
};

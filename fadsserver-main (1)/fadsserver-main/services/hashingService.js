const bcrypt = require('bcrypt');

const hashData = async (data) => {
    const saltRounds = 10;
    const hashedString = await bcrypt.hash(data, saltRounds);
    return hashedString;
};

const verifyData = async (data, hash) => {
    const isMatch = await bcrypt.compare(data, hash);
    return isMatch;
};


module.exports = {
    hashData, verifyData,
};

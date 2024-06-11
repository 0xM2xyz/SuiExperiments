import axios from 'axios';

const trxHash = "7yqWPYrdD2DQ6451UmrF8Zbgr8cAeJ4nAfd5tL8CM9fR"
const url = `https://suiscan.xyz/api/sui-backend/mainnet/api/raw-transaction/${trxHash}/details`;

// Create an axios instance (optional, for example if you need to set up common configs)
const axiosInstance = axios.create({
});

// Function to get raw transaction details
async function getRawTransactionDetails() {
  try {
    const response = await axiosInstance.get(url);
    console.log(response.data);
    // console.log("for the dis holder we need meta data", Object.keys(response.data.metadata)[0] )

  } catch (error) {
    console.error('Error fetching raw transaction details:', error);
  }
}

getRawTransactionDetails();

import axios from 'axios';

const trxHash = "Ey8dLS7nSwBxAtYgX1AcPQ5yRzf9mPTr6hVJLV8Pg1RG"
const url = `https://suiscan.xyz/api/sui-backend/mainnet/api/raw-transaction/${trxHash}/details`;

// Create an axios instance (optional, for example if you need to set up common configs)
const axiosInstance = axios.create({
});

// Function to get raw transaction details
async function getRawTransactionDetails() {
  try {
    const response = await axiosInstance.get(url);
    console.log(response.data);
    console.log("for the dis holder we need meta data", Object.keys(response.data.metadata)[0] )

  } catch (error) {
    console.error('Error fetching raw transaction details:', error);
  }
}

// Call the function to get the data
getRawTransactionDetails();

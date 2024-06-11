import axios from 'axios';

const  coinAddress = "0x29b895e28b7a9a3ef97b157f8804443c2a17d95c0f6f59e75322d20688d235b0"
// Define the URL and the parameters
  const baseURL = `https://suiscan.xyz/api/sui-backend/mainnet/api/objects/${coinAddress}/transactions`;
  const params = {
    orderBy: 'ASC',
    size: 1,
    objectSourceType: 'CHANGED_OBJECT'
  };

// Create an axios instance
const axiosInstance = axios.create({
  baseURL: baseURL,
  timeout: 10000, // Optional timeout setting
});


// Function to get transactions
async function getTransactions() {
  try {
    const response = await axiosInstance.get('', { params });
    console.log(JSON.stringify(response.data));
    console.log("we want this hash from here "+response.data.content[0].hash)
  } catch (error) {
    console.error('Error fetching transactions:', error);
  }
}

// Call the function to get the data
getTransactions();

import axios from 'axios';

const COIN_OBJECT = "0x621a4c00e2222c2fe20be5207dee56eeebe28c851d7a5d73de96813bf1999947::gummy::GUMMY"
const baseURL = `https://suiscan.xyz/api/sui-backend/mainnet/api/coins/${COIN_OBJECT}/holders`;
const params = {
  page: 0,
  sortBy: 'AMOUNT',
  orderBy: 'DESC',
  searchStr: '',
  size: 50
};

const axiosInstance = axios.create({
  baseURL: baseURL,
});

async function getCoinHolders() {
  try {
    const response = await axiosInstance.get('', { params });
    console.log(response.data);
    // console.log("for the dis holder we need meta data", response.data.rawTransaction.metadata )
  } catch (error) {
    console.error('Error fetching coin holders:', error);
  }
}

// Call the function to get the data
getCoinHolders();

// Import the axios module
import axios from 'axios';

// Define the JSON-RPC request
const jsonRpcRequest = {
    jsonrpc: "2.0",
    id: 1,
    method: "sui_getObject",
    params: [
        "0x29b895e28b7a9a3ef97b157f8804443c2a17d95c0f6f59e75322d20688d235b0",
        {
            "showType": true,
            "showOwner": true,
            "showPreviousTransaction": true,
            "showDisplay": true,
            "showContent": true,
            "showBcs": true,
            "showStorageRebate": true
        }
    ]
};



const fetchCoinDataByURLAddress = async () => {
    try {
        const response = await axios.post('https://fullnode.mainnet.sui.io:443', jsonRpcRequest, {
            headers: {
                'Content-Type': 'application/json'
            }
        });

                const data =  response?.data;
        // console.log("data",data)
        const content =   data.result.data.content
        console.log(content)
    } catch (error) {
        console.error('Error fetching events:', error);
    }
};

fetchCoinDataByURLAddress();




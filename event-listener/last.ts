import axios from 'axios';

const jsonRpcRequest = 
{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "sui_getEvents",
    "params": [
        "H9JgU8niHhwEQWvBhDwUD5PWdtQ5ok24UzD6KKAvwngw"
    ]
  };

const fetchEvents = async () => {
    try {
        const response = await axios.post('https://fullnode.mainnet.sui.io:443', jsonRpcRequest, {
            headers: {
                'Content-Type': 'application/json'
            }
        });

        console.log('Events:', response.data);
    } catch (error) {
        console.error('Error fetching events:', error);
    }
};

fetchEvents();




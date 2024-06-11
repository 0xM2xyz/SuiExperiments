// Import the axios module
import axios from 'axios';

// Define the JSON-RPC request
const jsonRpcRequest = {
    jsonrpc: "2.0",
    id: 1,
    method: "sui_getObject",
  
    /* that is the transaction of the bonding curve we noted earlier, 
    it only accept the params here with the array of string only, but in docs its mentioned that you can pass event type and other data 
    
    https://docs.sui.io/references/event-query-and-subscription#move-event

    we just have to meet the criteria from this 
    https://docs.sui.io/references/event-query-and-subscription#sui-event-query-criteria

    we need to pass the data  something like this   ( ref from the noted link https://suiscan.xyz/mainnet/tx/GpFP8gzZP3r9VPA5UyCB9CeekeAQkGvtZrsLmRn6FEAQ)
    Api reference for this  https://docs.sui.io/sui-api-ref 

    MoveEventType: {
                    module: 'curve',  
                    struct: 'BondingCurveListed',
    },
                
    
      */
    params: [
        "0xaf97a2c9294af85e5358ff563ed6a20882d5bcb24469802d3e5a060c3977dcd2"
      ],
      
    // type: "object"

};

// Define the function to fetch events
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




import { JsonRpcProvider  } from '@mysten/sui.js';
// connect to local RPC server
const provider = new JsonRpcProvider("https://fullnode.devnet.sui.io");

// Initialize the provider

// Function to query the BondingCurveListed events
const queryBondingCurveListedEvents = async () => {
    try {
        const events = await provider.getEvents({
            query: {
                MoveEventType: {
                    module: 'curve',  
                    struct: 'BondingCurveListed',
                },
            },
            limit: 100,  
        });

        console.log('BondingCurveListed Events:', events);
    } catch (error) {
        console.error('Error querying events:', error);
    }
};

// Run the query
queryBondingCurveListedEvents();

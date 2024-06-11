import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';

// Package is on Testnet.
const client = new SuiClient({
  url: getFullnodeUrl('mainnet'), 
  // haseeb you have add websocket here
});

const Package = '0x378a130bf4b8310bce5743f52a9a405c47bcd24b4e2f7f02a5575e4af17bb3d6';

// const MoveEventType = '<PACKAGE_ID>::<MODULE_NAME>::<METHOD_NAME>';

async function main() {
  try {
    const object = await client.getObject({
      id: Package,
      options: { showPreviousTransaction: true },
    });

    console.log(object);

    let unsubscribe = await client.subscribeEvent({
      filter: { Package },
      onMessage: (event) => {
        console.log('subscribeEvent', JSON.stringify(event, null, 2));
      },
    });

    process.on('SIGINT', async () => {
      console.log('Interrupted...');
      if (unsubscribe) {
        await unsubscribe();
        // unsubscribe = undefined;
      }
      process.exit();
    });

  } catch (error) {
    console.error('Error:', error);
  }
}

main();

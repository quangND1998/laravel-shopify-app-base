import React from 'react'
import '@shopify/polaris/build/esm/styles.css';
import enTranslations from '@shopify/polaris/locales/en.json';
import { AppProvider, Page } from "@shopify/polaris";
import { useState } from "react";
// import { Provider } from "@shopify/app-bridge-react";
import MissingApiKey from '@/Components/MissingApiKey';
export default function LayoutShopify({ children }) {
    // const [appBridgeConfig] = useState(() => {
    //     const host = new URLSearchParams(location.search).get("host") || window.__SHOPIFY_HOST;
    //     window.__SHOPIFY_HOST = host;
    //     return {
    //         host,
    //         apiKey: import.meta.env.VITE_SHOPIFY_API_KEY,
    //         forceRedirect: true,
    //     };
    // });

    const host = new URLSearchParams(location.search).get("host") || window.__SHOPIFY_HOST;
    window.__SHOPIFY_HOST = host;
    const appBridgeConfig = {
        host: new URLSearchParams(location.search).get("host") || window.__SHOPIFY_HOST,
        apiKey: import.meta.env.VITE_SHOPIFY_API_KEY,
        forceRedirect: true,
    };
    console.log(appBridgeConfig.apiKey)

    console.log(appBridgeConfig.apiKey)
    return (
        <main>
            {!appBridgeConfig.apiKey ?
                <AppProvider i18n={enTranslations} >
                    {/* <Provider > */}
                  
                        <MissingApiKey />
                  
                    {/* </Provider> */}
                </AppProvider>
                :
                <AppProvider i18n={enTranslations} config={appBridgeConfig}>
               
                    <Page >
                        {children}
                    </Page>
                    {/* </Provider> */}
                </AppProvider>
            }

        </main>
    )
}

import React, { useState } from 'react';
import { View, Text} from 'react-native';
import { WebView } from 'react-native-webview';
import Julia from './src/julia.js';

export default function App() {
  const [msg, setMsg]= useState("Initializing...");

  return (
    <View style={ { height: 500 } }>
      <WebView
        automaticallyAdjustContentInsets={false}
        source={{ html: Julia}}
        javaScriptEnabledAndroid={true}
        onMessage={event => {
          setMsg(event.nativeEvent.data); 
        }}
      />
      <Text>{ msg }</Text>
    </View>
  );
}
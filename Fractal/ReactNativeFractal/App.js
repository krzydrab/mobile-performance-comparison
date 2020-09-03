import React, { useState } from 'react';
import { View, Text} from 'react-native';
import { WebView } from 'react-native-webview';
import Julia from './src/julia.js';

export default function App() {
  const [fps, setFps]= useState(0);

  return (
    <View style={{ height: 500 }}>
      <WebView
        style={{ margin: 50, width: 1000 }}
        automaticallyAdjustContentInsets={false}
        source={{ html: Julia}}
        javaScriptEnabledAndroid={true}
        onMessage={event => {
          setFps(event.nativeEvent.data); 
        }}
      />
      <Text>FPS: { fps }</Text>
    </View>
  );
}
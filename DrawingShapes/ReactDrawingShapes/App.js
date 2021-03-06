/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import { View, Button, Text, Dimensions } from 'react-native';

import {
  Svg,
  Circle,
  RadialGradient,
  Rect,
  Defs,
  Stop,
} from 'react-native-svg';

export default class App extends React.Component {
  //=== TEST PARAMETERS ===
  mode = "ovals";
  numberOfShapes = 125;
  //=======================

  width = Dimensions.get('window').width * 0.8;
  height = Dimensions.get('window').height * 0.8;
  ovalSize = Dimensions.get('window').width * 0.1;
  rectSize = Dimensions.get('window').width * 0.1;

  constructor(props) {
    super(props);

    this.state = { 
      frames: 0, 
      fps: 0, 
      numberOfShapes: this.numberOfShapes 
    };
    this.generateIds();
  }

  generateIds = () => {
    this.ids = Array.from({length: this.state.numberOfShapes}, (_, k) => k)
  }

  increaseShapes = () => {
    this.setState(
      (state) => ({ numberOfShapes: state.numberOfShapes + 125 }), 
      this.generateIds
    );
  }

  componentDidMount() {
    const increaseFrames = () => {
      this.setState({ frames: this.state.frames + 1 });
      requestAnimationFrame(increaseFrames);
    }
    increaseFrames();

    this.intervalId = setInterval(() => {
        console.error(this.state.frames);
        this.setState({ frames: 0, fps: this.state.frames });
      }, 1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.intervalId);
  }

  renderRects() {
    const rects = this.ids.map((id) => {
      const left = Math.floor((Math.random() * (this.width - this.rectSize)));
      const top = Math.floor((Math.random() * (this.height - this.rectSize)));
      const rotation = Math.random() * 360;
      return <Rect
       key={id}
       rotation={rotation}
       originX={left}
       originY={top}
       x={left}
       y={top}
       width={this.rectSize}
       height={this.rectSize}
       stroke="black" 
       stroke-width="2"
      />
    });

    return <View>
      <Svg height="90%" width="100%" viewBox={`0 0 ${this.width} ${this.height}`}>
        {rects}
      </Svg>
    </View>;
  }

  renderOvals() {
    const ovals = this.ids.map((id) => {
      const left = Math.floor((Math.random() * (this.width - this.ovalSize)));
      const top = Math.floor((Math.random() * (this.height - this.ovalSize)));
      return <Circle
       key={id}
       cx={left}
       cy={top}
       r={0.5 * this.ovalSize}
       fill="url(#grad)"
      />
    });

    return <View>
      <Svg height="90%" width="100%" viewBox={`0 0 ${this.width} ${this.height}`}>
        <Defs>
          <RadialGradient
            id="grad"
            gradientUnits="objectBoundingBox"
          >
            <Stop offset="0" stopColor="red" stopOpacity="0.3" />
            <Stop offset="1" stopColor="gold" stopOpacity="0.1" />
          </RadialGradient>
        </Defs>
        {ovals}
      </Svg>
    </View>;
  }

  render() {
    return <View>
      { this.mode == "ovals" && this.renderOvals() }
      { this.mode == "rects" && this.renderRects() }
      <Button onPress={this.increaseShapes} title={"Shapes: " + this.state.numberOfShapes}/>
    </View>
  }
};

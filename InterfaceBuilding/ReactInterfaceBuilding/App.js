import React, { Component } from 'react';
import { View, Text, Button, Platform } from 'react-native';

function shuffle(a) {
  for (let i = a.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

const TestType = {
  Visibility: "Visibility",
  Swap: "Swap",
  FullRebuild: "FullRebuild",
  NoChange: "NoChange"
}

const ComponentType = {
  Text: "Text",
  Button: "Button",
}
export default class App extends Component {
  constructor(props) {
    super(props);

    // ====== Test parameters ======
    this.mode = TestType.Visibility;
    this.componentType = ComponentType.Button;
    this.singleTestDuration = 10; // in sec
    this.intervalBetweenTests = 5; // in sec
    // =============================

    this.state = { items: [], frames: 0, fps: 0, timeToModify: 0, completed: false };
    this.testId = 0;
    this.results = [];
    console.log("Mode:", this.mode);
    this.generateTestData(this.testId);
  }

  generateTestData = (testId) => {
    if (this.mode == TestType.Visibility) {
      this.generateVisibilityTestData(testId);
    } else if (this.mode == TestType.Swap) {
      this.generateSwapTestData(testId);
    } else {
      this.generateFullRebuildTestData(testId);
    }
    this.testId += 1;
  }

  generateItems = (nbOfItems) => {
    return new Array(nbOfItems).fill(0).map((_, id) => (
      { 
        id, 
        value: Math.random(),
        visibility: true,
      }
    ));
  }

  generateFullRebuildTestData = (testId) => {
    const tests = Platform.OS === 'ios'
      ? [1, 250, 500, 750, 1000, 1250, 1500, 1750, 2000]
      : [1, 50, 100, 150, 200, 250, 300, 350, 400];
    this.testCount = tests.length;
    this.nbOfItems = tests[testId];
    this.items = this.generateItems(this.nbOfItems);
    this.setState({ items: this.items });
  }

  generateVisibilityTestData = (testId) => {
    const tests = Platform.OS === 'ios'
      ? [5, 25, 50, 75, 100, 125, 150, 175, 200]
      : [1, 10, 20, 30, 40, 50, 60, 70, 80];
    this.testCount = tests.length;
    this.nbOfItems = Platform.OS === 'ios' ? 500 : 150;
    this.nbOfChanges = tests[testId];
    const totalNbOfItems = this.nbOfChanges + this.nbOfItems;
    this.items = this.generateItems(totalNbOfItems);
    this.visibleRowsIds = shuffle(new Array(totalNbOfItems).fill(0).map((_, id) => id));
    this.invisibleRowsIds = this.visibleRowsIds.splice(0, this.nbOfChanges);
    this.invisibleRowsIds.forEach((id) => this.items[id].visibility = false);
  }

  generateSwapTestData = (testId) => {
    const tests = Platform.OS === 'ios'
      ? [5, 25, 50, 75, 100, 125, 150, 175, 200]
      : [1, 10, 20, 30, 40, 50, 60, 70, 80];
    this.testCount = tests.length;
    this.nbOfItems = Platform.OS === 'ios' ? 500 : 150;
    this.nbOfChanges = tests[testId];
    this.items = this.generateItems(this.nbOfItems);
    console.log(this.items.length)
  }

  componentDidMount() {
    const increaseFrames = () => {
      this.setState({ frames: this.state.frames + 1 });
      if (this.mode == TestType.Visibility) {
        this.randomVisiblityChange();
      } else if (this.mode == TestType.Swap) {
        this.randomElementsSwap();
      } else if (this.mode == TestType.FullRebuild) {
        this.fullRebuild();
      } else {
        // this.nbOfChanges = 0;
        // this.randomElementsSwap();
      }
      this.requestAnimationId = requestAnimationFrame(increaseFrames);
    }
    const testTimeout = () => {
      cancelAnimationFrame(this.requestAnimationId);
      this.results.push({
        n: this.nbOfChanges || this.nbOfItems,
        fps: this.state.frames / this.singleTestDuration,
        timeToModify: this.state.timeToModify / this.singleTestDuration,
      });
      console.log(this.testId);
      if (this.testId >= this.testCount) {
        this.setState({ completed: true });
      } else {
        setTimeout(() => {
          this.generateTestData(this.testId);
          this.setState({ frames: 0, timeToModify: 0 });
          this.timeoutId = setTimeout(testTimeout, this.singleTestDuration * 1000);
          increaseFrames();
        }, this.intervalBetweenTests * 1000)
      }
    };
    this.timeoutId = setTimeout(testTimeout, this.singleTestDuration * 1000);
    increaseFrames();
  }

  componentWillUnmount() {
    clearInterval(this.timeoutId);
  }

  randomElementsSwap = () => {
    var startTime = Date.now();
    var i = this.nbOfChanges;
    var temp;
    while(i-- > 0) {
      a = Math.floor(Math.random() * this.items.length);
      b = Math.floor(Math.random() * this.items.length);
      temp = this.items[a];
      this.items[a] = this.items[b];
      this.items[b] = temp;
    }
    var time = Date.now() - startTime + this.state.timeToModify;
    this.setState({items: this.items.concat(), timeToModify: time });
  }

  randomVisiblityChange = () => {
    var startTime = Date.now();
    this.invisibleRowsIds.forEach((id) => {
      this.items[id].visibility = true;
    });
    this.visibleRowsIds = this.invisibleRowsIds.concat(this.visibleRowsIds);
    this.invisibleRowsIds = this.visibleRowsIds.splice(-this.nbOfChanges);
    this.invisibleRowsIds.forEach((id) => {
      this.items[id].visibility = false;
    });
    var time = Date.now() - startTime + this.state.timeToModify;
    this.setState({ 
      items: this.items.filter((i) => i.visibility), 
      timeToModify: time,
    });
  }

  fullRebuild = () => {
    var startTime = Date.now();
    this.items = this.generateItems(this.nbOfItems);
    var time = Date.now() - startTime + this.state.timeToModify;
    this.setState({ items: this.items, timeToModify: time });
  }

  noOpFn = () => {};

  render() {
    return (
      <View>
        { this.state.completed ? 
          <View style={{ paddingTop: 50 }}>
            { this.results.map((result) => 
              <Text>[{this.mode}] N: {result.n}, FPS: {result.fps}, TTM: {result.timeToModify}ms</Text>
            )}
          </View>
        :
          this.componentType == ComponentType.Text 
            ? this.state.items.map((i) => <Text key={i.id}>Row: #{i.value}</Text>)
            : this.state.items.map((i) => <Button key={i.id} title={`Row: ${i.value}`} onPress={this.noOpFn}/>)
        }
      </View>
    );
  }
}

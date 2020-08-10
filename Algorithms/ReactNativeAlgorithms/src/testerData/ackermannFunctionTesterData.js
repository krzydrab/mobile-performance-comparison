import ackermannFunction from '../algorithms/ackermannFunction';

const AckermannFunctionTesterData = {
  'getDescription': (testSize) => `m: 3, n: ${3 + testSize}`,
  'getInputData': (testSize) => [3, 3 + testSize],
  'algorithm': ackermannFunction,
}

export default AckermannFunctionTesterData;
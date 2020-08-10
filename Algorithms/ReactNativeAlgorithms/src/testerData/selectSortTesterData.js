import { generateRandomList } from '../utils/array';
import selectSort from '../algorithms/selectSort';

const arraySizes = [10, 50, 100, 500, 1000, 5000, 10000, 20000, 30000, 40000];

const SelectSortTesterData = {
  'getDescription': (testSize) => `N: ${arraySizes[testSize]}`,
  'getInputData': (testSize) => [generateRandomList(arraySizes[testSize])],
  'algorithm': selectSort,
}

export default SelectSortTesterData;
import { generateRandomList } from '../utils/array';
import selectSort from '../algorithms/selectSort';

const arraySizes = [100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000];

const SelectSortTesterData = {
  'getDescription': (testSize) => `N: ${arraySizes[testSize]}`,
  'getInputData': (testSize) => [generateRandomList(arraySizes[testSize])],
  'algorithm': selectSort,
}

export default SelectSortTesterData;
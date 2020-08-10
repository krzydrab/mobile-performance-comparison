import { generateRandomList, generateRandomMatrix } from '../utils/array';
import gaussElimination from '../algorithms/gaussElimination';

const arraySizes = [10, 50, 100, 200, 400, 700, 1000, 1500, 2000, 2500, 3000];

const GaussEliminationTesterData = {
  'getDescription': function(testSize) {
    const size = arraySizes[testSize];
    return `Matrix ${size} x ${size}`;
  },
  'getInputData': function(testSize) {
    const s = arraySizes[testSize];

    // Ax = B
    // R = [A|B]
    const x = generateRandomList(s);
    const R = generateRandomMatrix(s, s + 1);
    for(var i = 0 ; i < s; i++) {
        var b = 0;
        for(var j = 0; j < s; j++) {
            b += R[i][j] * x[j];
        }
        R[i][s] = b;
    }
    return [R];
  },
  'algorithm': gaussElimination,
}

export default GaussEliminationTesterData;
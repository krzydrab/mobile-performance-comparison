import { generateRandomList, generateRandomMatrix } from '../utils/array';
import gaussElimination from '../algorithms/gaussElimination';

const arraySizes = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600];

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
import ackermannFunctionTesterData from './testerData/ackermannFunctionTesterData';
import gaussEliminationTesterData from './testerData/gaussEliminationTesterData';
import selectSortTesterData from './testerData/selectSortTesterData';

export function testAlgorithm(algorithmName, testCasesFrom = 0, testCasesTo = 10) {
  const { algorithm, getInputData, getDescription } = {
    'ackermannFunction': ackermannFunctionTesterData,
    'gaussElimination': gaussEliminationTesterData,
    'selectSort': selectSortTesterData,
  }[algorithmName];

  const range = (from, to) => Array.from({length: to - from + 1}, (_v, k) => from + k);

  return range(testCasesFrom, testCasesTo).map((testSize) => {
    var startTime = Date.now();
    algorithm(...getInputData(testSize));
    var time = Date.now() - startTime;
    console.log(`Test case ${testSize}/${testCasesTo}`);
    return {
      'time': time,
      'testSize': testSize,
      'description': getDescription(testSize),
    };
  });
}
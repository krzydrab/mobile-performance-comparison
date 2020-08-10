import gaussElimination from '../../src/algorithms/gaussElimination';

describe('gaussElimination', () => {
  it('properly solves system of equations', () => {
    const testMatrix = [
      [ 4, -2, 4, -2, 8 ],
      [ 3, 1, 4, 2, 7 ],
      [ 2, 4, 2, 1, 10 ],
      [ 2, -2, 4, 2, 2],
    ];
    const expected = [ -1, 2, 3, -2 ];
    const actual = gaussElimination(testMatrix);
    const delta = 0.0000001;
    
    expect(expected.length).toEqual(actual.length);
    expect(expected.every((v, i) => Math.abs(v - actual[i]) < delta)).toBe(true);
  });
});
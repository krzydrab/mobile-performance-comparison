import selectSort from '../../src/algorithms/selectSort';

describe('selectSort', () => {
  it('returns sorted array', () => {
    var input = [0.2, 11, 3.14, -1, 1, 0.21, 10.999];
    var expected = [-1, 0.2, 0.21, 1, 3.14, 10.999, 11];
    var actual = selectSort(input);

    expect(expected).toEqual(actual);
  });
});
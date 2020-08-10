import ackermannFunction from '../../src/algorithms/ackermannFunction';

describe('ackermannFunction', () => {
  it('returns correct value for small input', () => {
    expect(ackermannFunction(2, 3)).toBe(9);
  });

  it('returns correct value for small medium input', () => {
    expect(ackermannFunction(3, 5)).toBe(253);
  });
});
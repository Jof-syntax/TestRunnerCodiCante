function TestDisplacementComputer
InputData = load('TestData/Input data/DisplacementComputer.mat').s;
test = DisplacementComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultDisplacementComputer.mat').test;
computeError(test, expectedResult, 'TestDisplacementComputer');
end
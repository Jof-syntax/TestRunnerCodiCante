function TestStressComputer
InputData = load('TestData/Input data/StressComputer.mat').s;
test = StressComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultStressComputer.mat').test;
computeError(test, expectedResult, 'TestStressComputer');
end
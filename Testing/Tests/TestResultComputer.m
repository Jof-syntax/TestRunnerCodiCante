function TestResultComputer
InputData = load('TestData/Input data/ResultComputer.mat').s;
test = ResultComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultResultComputer.mat').test;
computeError(test, expectedResult, 'TestResultComputer');
end
function TestCGComputer
InputData = load('TestData/Input data/CGComputer.mat').s;
test = CGComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultCGComputer.mat').test;
computeError(test, expectedResult, 'TestCGComputer');
end
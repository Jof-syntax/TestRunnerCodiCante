function TestCheckSafety
InputData = load('TestData/Input data/CheckSafety.mat').s;
test = CheckSafety(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultCheckSafety.mat').test;
computeError(test, expectedResult, 'TestCheckSafety');
end
function TestForcesComputer
InputData = load('TestData/Input data/ForcesComputer.mat').s;
test = ForcesComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultForcesComputer.mat').test;
computeError(test, expectedResult, 'TestForcesComputer');
end
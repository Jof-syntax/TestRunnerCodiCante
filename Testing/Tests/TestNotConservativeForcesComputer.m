function TestNotConservativeForcesComputer
InputData = load('TestData/Input data/NotConservativeForcesComputer.mat').s;
test = NotConservativeForcesComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultNotConservativeForcesComputer.mat').test;
computeError(test, expectedResult, 'TestNotConservativeForcesComputer');
end
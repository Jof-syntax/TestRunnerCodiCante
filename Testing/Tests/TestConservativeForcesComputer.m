function TestConservativeForcesComputer
InputData = load('TestData/Input data/ConservativeForcesComputer.mat').s;
test = ConservativeForcesComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultConservativeForcesComputer.mat').test;
computeError(test, expectedResult, 'TestConservativeForcesComputer');
end
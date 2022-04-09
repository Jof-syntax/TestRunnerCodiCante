function TestDynamicSolver
InputData = load('TestData/Input data/DynamicSolver.mat').s;
test = DynamicSolver(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultDynamicSolver.mat').test;
computeError(test, expectedResult, 'TestDynamicSolver');
end
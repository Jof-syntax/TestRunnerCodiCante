function TestStiffnessMatrixComputer
InputData = load('TestData/Input data/StiffnessMatrixComputer.mat').s;
test = StiffnessMatrixComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultStiffnessMatrixComputer.mat').test;
computeError(test, expectedResult, 'TestStiffnessMatrixComputer');
end
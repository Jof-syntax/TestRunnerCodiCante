function TestNodeForceComputer
InputData = load('TestData/Input data/NodeForceComputer.mat').s;
test = NodeForceComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultNodeForceComputer.mat').test;
computeError(test, expectedResult, 'TestNodeForceComputer');
end
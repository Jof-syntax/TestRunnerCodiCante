function TestDOFSplitterComputer
InputData = load('TestData/Input data/DOFSplitterComputer.mat').s;
test = DOFSplitterComputer(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultDOFSplitterComputer.mat').test;
computeError(test, expectedResult, 'TestDOFSplitterComputer');
end
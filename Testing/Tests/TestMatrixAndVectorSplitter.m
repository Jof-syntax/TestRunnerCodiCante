function TestMatrixAndVectorSplitter
InputData = load('TestData/Input data/MatrixAndVectorSplitter.mat').s;
test = MatrixAndVectorSplitter(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultMatrixAndVectorSplitter.mat').test;
computeError(test, expectedResult, 'TestMatrixAndVectorSplitter');
end
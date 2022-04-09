function TestDimension
InputData = load('TestData/Input data/GliderDimension.mat').s;
test = Dimension(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultTestDimension.mat').test;
computeError(test, expectedResult, 'TestDimension');
end
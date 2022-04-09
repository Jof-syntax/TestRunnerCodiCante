function TestGliderAnalyser
InputData = load('TestData/Input data/TestClassDataGliderAnalyser.mat').cParams;
test = GliderAnalyser(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultTestGliderAnalyser.mat').test;
computeError(test, expectedResult, 'TestGliderAnalyser');
end


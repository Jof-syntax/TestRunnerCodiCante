function TestGliderData
InputData = load('TestData/Input data/GliderDatainput.mat').s;
test = GliderData(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultTestGliderData.mat').test;
computeError(test, expectedResult, 'TestGliderData');
end
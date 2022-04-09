function TestGliderMass
InputData = load('TestData/Input data/GliderMassInput.mat').s;
test = GliderMass(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultTestGliderMassInput.mat').test;
computeError(test, expectedResult, 'TestGliderMass');
end
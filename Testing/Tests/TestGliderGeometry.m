function TestGliderGeometry
test = GliderGeometry();
expectedResult = load('TestData/Outputdata/ResultTestGliderGeometry').test;
computeError(test, expectedResult, 'TestGliderGeometry');
end
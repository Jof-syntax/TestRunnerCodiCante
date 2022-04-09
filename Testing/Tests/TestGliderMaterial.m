function TestGliderMaterial
InputData = load('TestData/Input data/GliderMaterialInput.mat').s;
test = GliderMaterial(InputData);
test.compute();
expectedResult = load('TestData/Outputdata/ResultTestGliderMaterial.mat').test;
computeError(test, expectedResult, 'TestGliderMaterial');
end
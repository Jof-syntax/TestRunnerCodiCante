function TestExternalInfluence
InputData = load('TestData/Input data/GliderDatainput.mat').s; %same as external influence
test = ExternalInfluence(InputData);
expectedResult = load('TestData/Outputdata/ResultTestExternalInfluence').test;
computeError(test, expectedResult, 'TestExternalInfluence');
end
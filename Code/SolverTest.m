classdef SolverTest < matlab.unittest.TestCase
    
    methods (Test)
        
        function testGliderAnalyser(testCase)
            InputData = load('TestData/Input data/TestClassDataGliderAnalyser.mat').cParams;
            test = GliderAnalyser(InputData);
            test.compute();
            test.plot();
            close all;
            actSolution = test;
            expSolution = load('TestData/Outputdata/ResultTestGliderAnalyser.mat').test;
            testCase.verifyEqual(actSolution,expSolution);
        end
        
    end
    
end

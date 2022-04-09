function TestRunner
        clc;
        % does not work if the files are inside folder 'Code'
        import matlab.unittest.TestSuite
        import matlab.unittest.TestRunner
        import matlab.unittest.plugins.CodeCoveragePlugin
        
        suite = TestSuite.fromClass(?SolverTest);
        runner = TestRunner.withTextOutput;
        runner.addPlugin(CodeCoveragePlugin.forFolder(pwd));
        result = runner.run(suite);
        table(result)
end
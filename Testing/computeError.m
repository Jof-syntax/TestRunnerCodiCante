    function computeError(test, expectedResult, Name)
        if isequaln(test, expectedResult) % compares two structs
            cprintf('green',[Name,' --> ']);
            cprintf('green',' PASSED. \n');
        else
            cprintf('red',[Name,' --> ']);
            cprintf('red',' FAILED. \n');
        end
    end
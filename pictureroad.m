for i = 1:12
    switch i
        case 1
            func_num = 'The best route for 25 cities';
            case 2
            func_num = 'The best route for 50 cities';
            case 3
            func_num = 'The best route for 75 cities';
            case 4
            func_num = 'The best route for 100 cities';
            case 5
            func_num = 'The best route for 125 cities';
            case 6
            func_num = 'The best route for 150 cities';
            case 7
            func_num = 'The best route for 175 cities';
            case 8
            func_num = 'The best route for 200 cities';
            case 9
            func_num = 'The best route for 250 cities';
            case 10
            func_num = 'The best route for 300 cities';
            case 11
            func_num = 'The best route for 350 cities';
            case 12
            func_num = 'The best route for 400 cities';
    end
    
    name = ['data/sol/F' num2str(i)];
    load([name '_num2.mat']);
    figure;
    PlotSolution(EOCAEFAsol,model);
    title(['\fontsize{12}\bf',func_num]);


% semilogy
end
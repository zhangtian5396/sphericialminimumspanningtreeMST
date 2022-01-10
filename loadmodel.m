function model = loadmodel(index)
    switch index
        case 1
            load('coordinates_25_cities.mat');
        case 2
            load('coordinates_50_cities.mat');
        case 3
            load('coordinates_75_cities.mat');
        case 4
            load('coordinates_100_cities.mat');  
        case 5
            load('coordinates_125_cities.mat');    
        case 6
            load('coordinates_150_cities.mat');  
        case 7
            load('coordinates_175_cities.mat');  
        case 8
            load('coordinates_200_cities.mat');
        case 9
            load('coordinates_250_cities.mat');
        case 10
            load('coordinates_300_cities.mat');
        case 11
            load('coordinates_350_cities.mat');   
        case 12
            load('coordinates_400_cities.mat');  
        case 13
            load('rand_500_cities.mat');  
        case 14
            load('rand_600_cities.mat');     
        case 15
            load('rand_700_cities.mat');   
        case 16
            load('rand_800_cities.mat');  
        case 17
            load('rand_900_cities.mat');  
        case 18
            load('rand_1000_cities.mat');    
    end
    model.X = coordinates(:,1);
    model.Y = coordinates(:,2);
    model.Z = coordinates(:,3);
    model.n=size(model.X,1);
    model.d = distance(model);
end
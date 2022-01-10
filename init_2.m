function xline = init(x,model)

%     d = model.d;
    
    X = x(model.n+1:2*model.n);%∆Ù∑¢–≈œ¢
    x = x(1:model.n);
    [aa ind] = sort(x);
    set_begin = [ind(1) ind(2)];
    set_line(1,:) = [ind(1) ind(2)];
    for i = 1:size(x,2)-2
        mind = inf;
        a=size(set_begin,2);
%         b=randi([1,a]);
%         for j=1:a
%             if d(set_begin(j),ind(i+2))<mind
%                 mind = d(set_begin(j),ind(i+2));
%                 b = j;
%             end
%         end
%         for j=1:a
%             weights(j) = x(set_begin(j));
%             b = RouletteWheelSelection(weights);
%         end
        
        weights = -inf;
        
        for j=1:a         
            if mod(j,2)==0
                X_sin = sin(X(set_begin(j))*pi/j );
            else
                X_sin = cos(X(set_begin(j))*pi/j );
            end
            
            if X_sin>=weights
                weights = X_sin;
                b = j;
            end
        end
        
        set_line(i+1,:) = [set_begin(b) ind(i+2)];
        set_begin = [set_begin ind(i+2)];
    end
    xline = set_line;
end


function choice = RouletteWheelSelection(weights)
  accumulation = cumsum(weights);
  p = rand() * accumulation(end);
  chosen_index = randi([1,size(weights,2)]);
  for index = 1 : length(accumulation)
    if (accumulation(index) > p)
      chosen_index = index;
      break;
    end
  end
  choice = chosen_index;
end
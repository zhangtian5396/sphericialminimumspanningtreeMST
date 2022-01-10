 function d = distance(a,b)
d=sqrt((a(1)-b(1))^2+(a(2)-b(2))^2);
d = sum(sqrt((a - b).^2));
 end
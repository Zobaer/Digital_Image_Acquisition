function W  = mexHat(x)
if (abs(x) <= 1) 
    W  = 1-(2*x^2)+(abs(x))^3;
elseif (abs(x) <= 2)
    W = 4-(8*abs(x))+(5*x^2)-(abs(x))^3;
else
    W = 0;
end


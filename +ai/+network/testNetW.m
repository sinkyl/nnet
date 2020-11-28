clear, clc








% k = fnc(22);
% 
% disp(fnc(33));
% disp(k.fnc);
% disp(k.derFnc);


v = myfun;
disp(v{1}(2));
disp(v{2}(2));



function fnc = fnc(x)
   fnc.fnc = x + 2;
   fnc.derFnc = derivative(x);
   
    function d = derivative(x)
        d = x;
    end
end



function fun = myfun()
fun{1} = @(x) x + 1;
fun{2} = @(x) x + 2;
end


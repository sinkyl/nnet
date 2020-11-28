clear, clc, close;
train_file ='./data/data_train.txt';


opts = detectImportOptions(train_file);

T = readtable(train_file);      % read file
T = removevars(T, 'Var1562');   % remove the empty column
T_r = size(T);
disp(T_r(1));

% digits string representation
digits_str = ["o:", "1:", "2:", "3:", "4:", "5:", "6:", "7:", "8:", "9:"];
d = zeros(T_r(1), 1);

ds_c = size(digits_str);
% digits string type to double type
for i = 1 : ds_c(2)
    ndx = strcmpi(T.Var1, digits_str(1, i));
    d(ndx, 1) = i - 1;
end
T.Var1 = d;


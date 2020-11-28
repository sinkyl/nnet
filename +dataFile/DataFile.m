classdef DataFile < handle
    properties
        path string;
    end
    
    methods (Static)
        function matrix = data2mat(file)
            % read file
            table = readtable("./input/"+file);
            % remove the empty column
            table = removevars(table, 'Var1562');
            t_row = size(table);
            
            % digits string representation
            digits_str = ["o:", "1:", "2:", "3:", "4:", "5:", "6:", ...
                "7:", "8:", "9:"];
            d = zeros(t_row(1), 1);
            
            ds_c = size(digits_str);
            % digits string type to double type
            for i = 1 : ds_c(2)
                ndx = strcmpi(table.Var1, digits_str(1, i));
                d(ndx, 1) = i - 1;
            end
            table.Var1 = d;
            
            matrix = table{:,:};
        end
    end
end


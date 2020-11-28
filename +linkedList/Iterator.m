classdef Iterator < handle
    % Iterate on a linked list.
    % The iterator is an circular iterator.
    % Before it goes back to the first element, it returns an empty data.
    properties (Access = private)
        nbElem uint32;
        list linkedList.LinkedList;
        actElem linkedList.Node;
    end
    
    methods
        function self = Iterator(list)
            arguments
                list linkedList.LinkedList;
            end
            self.list = list;
            self.nbElem = list.nbNodes;
            self.reset;
        end
        
        function data = next(self)
            arguments
                self linkedList.Iterator;
            end
            % if it is not pointing on the first node of the list
            if (self.actElem ~= self.list.firstElem)
                data = self.actElem.data;
                self.actElem = self.actElem.next;
            elseif(~isempty(self.actElem))
                data = self.actElem.data;
                self.actElem = self.actElem.next;
            else
                self.reset;
            end
        end
        
        function data = prev(self)
            arguments
                self linkedList.Iterator;
            end
            % if it is not pointing on the first node of the list
            if (self.actElem ~= self.list.firstElem)
                self.actElem = self.actElem.prev;
                data = self.actElem.data;
            elseif(~isempty(self.actElem))
                self.actElem = self.actElem.prev;
                data = self.actElem.data;
            else
                self.reset;
            end
        end
        
        function reset(self)
            self.actElem = self.list.firstElem;
        end
    end
end


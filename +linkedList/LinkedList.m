classdef LinkedList < handle
    
    properties (GetAccess = public, SetAccess = private)
        elemCount uint32;
        firstElem linkedList.Node;
        lastElem linkedList.Node;
    end
    
    methods
        
        function self = LinkedList()
            self.elemCount = 0;
            self.firstElem = linkedList.Node.empty;
            self.lastElem = linkedList.Node.empty;
        end
        
        % ----------------------------------------------
        % -- RETRIEVE DATA FUNCTION
        % ----------------------------------------------
        function data = getDataByNodeId(list, id)
            % Retrieve Data from the list by the Node id.
            arguments
                list linkedList.LinkedList;
                id uint32;
            end
            if (id >= 0 && id <= list.elemCount)
                % hold the result
                data = [];
                n = list.firstElem;
                while (~isempty(n))
                    % if id matches
                    if (n.id == id)
                        data = n.data;
                        break;
                    end
                    n = n.next;
                end
            else
                error("Provided id is not in the actural" + ...
                    "range.");
            end
        end
        
        % ----------------------------------------------
        % -- ADD NODE FUNCTIONS
        % ----------------------------------------------
        function add(list, data)
            % Add Node to the end of the list by default.
            arguments
                list linkedList.LinkedList;
                data;
            end
            if (nargin == 2)
                addEnd(list, data);
            else
                error("All function parameters are needed.");
            end
        end
        function addBeg(list, data)
            % add node at the beginning of the list
            arguments
                list linkedList.LinkedList;
                data;
            end
            if (nargin == 2)
                node = linkedList.Node(data);
                node.id = 0;
                % if the list is not empty
                if (list.elemCount > 0)
                    node.next = list.firstElem;
                    list.firstElem.prev = node;
                    list.firstElem = node;
                    list.updateIdsFrom(node, 'lrp');
                else
                    list.firstElem = node;
                    list.lastElem = node;
                end
                list.elemCount = list.elemCount + 1;
            else
                error("All function parameters are needed.");
            end
        end
        
        function addEnd(list, data)
            % Add node at the end of the list.
            % If the node has already an id, this
            % one will be updated automatically.
            arguments
                list linkedList.LinkedList;
                data;
            end
            node = linkedList.Node(data);
            % if the list is not empty
            if (list.elemCount > 0)
                node.id = list.lastElem.id + 1;
                node.prev = list.lastElem;
                list.lastElem.next = node;
                list.lastElem = node;
            else % if the list is empty
                node.id = 0;
                list.lastElem = node;
                list.firstElem = node;
            end
            list.elemCount = list.elemCount + 1;
        end
        
        function addBefore(list, newNode, nodeAfter)
            % Add node before another node.
            % nodeAfter can either be the node id or the node it self
            arguments
                list linkedList.LinkedList;
                newNode linkedList.Node;
                nodeAfter linkedList.Node;
            end
            if (nargin == 3)
                if (list.nbNodes >= 1)
                    % if the Node after is not the first Node
                    if (~isempty(nodeAfter.prev) && ...
                            ~isempty(nodeAfter.next))
                        newNode.prev = nodeAfter.prev;
                        newNode.next = nodeAfter;
                        newNode.attachNextIdListener;
                        newNode.attachPrevIdListener;
                        nodeAfter.prev = newNode;
                        newNode.id = nodeAfter.id - 1;
                        list.nbNodes = list.nbNodes + 1;
                    elseif (nodeAfter.id == 0)
                        addNodeBeg(list, newNode);
                    elseif (nodeAfter.id == list.lastNode.id)
                        addNodeEnd(list, newNode)
                    end
                else
                    error("The list is empty.");
                end
            else
                error("All function parameters are needed.");
            end
        end
        
        % ----------------------------------------------
        % -- REMOVE NODE FUNCTIONS
        % ----------------------------------------------
        function rmvfirstElem(list)
            % Remove the first Node and update the node ids.
            arguments
                list linkedList.LinkedList;
            end
            tmp = list.firstElem.next;
            tmp.id = 0;
            list.firstElem.delete;
            list.firstElem = tmp;
            list.elemCount = list.elemCount - 1;
            list.updateIdsFrom(list.firstElem, 'lrn');
        end
        
        function rmvlastElem(list)
            % Remove the last Node.
            arguments
                list linkedList.LinkedList;
            end
            tmp = list.lastElem.prev;
            tmp.id = list.lastElem.prev.id;
            list.lastElem.delete;
            list.lastElem = tmp;
            list.elemCount = list.elemCount - 1;
        end
        
        function delete(list)
            % Delete the list completely.
            arguments
                list linkedList.LinkedList;
            end
            
            e = list.lastElem;
            while(~isempty(e))
                list.rmvlastElem;
                e = e.prev;
            end
            
            
            
            %             arr = listToArray(list);
            %             for i = 1: list.elemCount - 1
            %                 n = arr(1, i);
            %                 disp(n);
            %                 n.delete;
            %                 list.elemCount = list.elemCount - 1;
            %             end
            %             arr.delete;
        end
        
        % ----------------------------------------------
        % -- LIST TRANFORMATION FUNCTIONS
        % ----------------------------------------------
        
        function array =  listToArray(list)
            % Return the array version of the list
            arguments
                list linkedList.LinkedList;
            end
            c = listToCell(list);
            array = [c{:}];
        end
        
        % ----------------------------------------------
        % -- ARRAY TO LINKEDLIST
        % ----------------------------------------------
        function array2LinkedList(list, array)
            arguments
                list linkedList.LinkedList;
                array;
            end
            for i = array
                add(list, i);
            end
        end
    end
    
    methods (Access = private)
        function c = listToCell(list)
            % Cell array of each Nodes data
            arguments
                list linkedList.LinkedList;
            end
            c = cell(1,list.elemCount);
            n = list.firstElem;
            i = 1;
            while (~isempty(n))
                c{i} = n.data;
                n = n.next;
                i = i + 1;
            end
        end
        
        function self = updateIdsFrom(list, node, dir)
            % Update node ids from the insertion to the end.
            % the parameter dir represent the directions:
            arguments
                list linkedList.LinkedList;
                node linkedList.Node;
                dir char;
            end
            
            switch (dir)
                case 'lrp'
                    n = node.next;
                    while (~isempty(n))
                        n.id = n.id + 1;
                        n = n.next;
                    end
                case 'lrn'
                    n = node.next;
                    while (~isempty(n))
                        n.id = n.id - 1;
                        n = n.next;
                    end
                case 'rlp'
                    n = node.next;
                    while (~isempty(n))
                        n.id = n.id + 1;
                        n = n.prev;
                    end
                case 'rln'
                    n = node.next;
                    while (~isempty(n))
                        n.id = n.id - 1;
                        n = n.prev;
                    end
                otherwise
                    error("Wrong direction is provided");
            end
            self = list;
        end
    end
end

classdef Node < handle
    properties
        data;
    end
    
    properties %(Access = {?linkedList.LinkedList, ?linkedList.Iterator})
        id uint32;
        next linkedList.Node;
        prev linkedList.Node;
    end
    
    methods (Access = {?linkedList.LinkedList, ?linkedList.Iterator})
        function node = Node(data)
            % Construct a Node object
            node.data = data;
        end
        function delete(node)
            if (~isempty(node))
                % if in between
                if (~isempty(node.prev) && ~isempty(node.next))
                    node.prev.next = node.next;
                    node.next.prev = node.prev;
                elseif (~isempty(node.next)) % if first Node
                    node.next.prev = linkedList.Node.empty;
                elseif (~isempty(node.prev)) % if last Node
                    node.prev.next = linkedList.Node.empty;
                end
                delete(node);
            end
        end
    end
end






























%
%         function updateNext(eventData)
%             arguments
%                eventData handle;
%             end
%             node = eventData.AffectedObject;
%             disp(node);
%
%             if (~isempty(node.next))
%                 if (isempty(node.next.id))
%                     node.id = node.next.id;
%                     node.next.id = node.id + 1;
%                 end
%             end
%         end
%
%         function updatePrev(eventData)
%             arguments
%                 eventData handle;
%             end
%             node = eventData.AffectedObject;
%             if (~isempty(node.next))
%                 if (isempty(node.prev.id))
%                     node.id = node.prev + 1;
%                 end
%             end
%         end
%
%
%
% %         function updateNeighbors(self, eventData)
% %             arguments
% %                 self Node;
% %                 eventData handle;
% %             end
% %             disp(self);
% %             disp(eventData);
% %
% %             if (~isempty(self.next))
% %                 if (isempty(self.next.id))
% %                     self.next.id = self.id + 1;
% %                 end
% %             elseif (~isempty(self.prev))
% %                 if (isempty(self.prev.id))
% %                     self.prev.id = self.id - 1;
% %                 end
% %             end
% %         end
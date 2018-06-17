classdef Node < handle
    properties
        data
        next
        previous
    end
    
    methods
        function obj = Node(data)
            if nargin > 0
                obj.data = data;
            else
                obj.data = 'None';
            end
                obj.next = 'None';
                obj.previous = 'None';
           
        end
    end
    
end
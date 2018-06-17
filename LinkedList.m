classdef LinkedList < handle
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        head 
        tail
        size
    end
    
    methods
        function obj = LinkedList()
           obj.head = Node(); 
        end
        
        function append(obj, data)
            new_node = Node(data);
            current = obj.head;
            
            while current.next ~= 'None'
                current = current.next;
                
            end
            current.next = new_node;
        end
        
        function length = length(obj)
            current = obj.head;
            total = 0;
            
            while current.next ~= 'None'
               total = total + 1; 
               current = current.next;
            end
            obj.size = total;
            length = total;
        end
        
        function show(obj)
            elements(1,obj.size) = Node();
            cur_node = obj.head;
            i = 1;
            while cur_node.next ~= 'None'
                cur_node = cur_node.next;
                elements(i) = cur_node;
                i = i + 1;
           disp(elements)
            end
            
        end
        
        function data =  getData(obj,index)
            obj.length();
            if index > obj.size
                str = 'ERROR Index out of range';
                str
                data = NaN;
                return
            end
            
            cur_idx = 1;
            current = obj.head;
            running = true;
            while running
               current = current.next;
               
               if cur_idx == index
                   data = current.data;
                   running = false;
               else
                   cur_idx = cur_idx + 1;
               end
            end
            
            
        end
    end
    
end


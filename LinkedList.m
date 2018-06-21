classdef LinkedList < handle
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        head 
        tail
        size
    end
    
    methods
        function obj = LinkedList(data)
            if nargin > 0
             obj.head = Node(data);
             obj.tail = obj.head.next;
             obj.size = 1;
            else
              obj.head = Node();
              obj.tail = obj.head.next;
              obj.size = 0;
            end
            
        end
        
        function append(obj, data)
            new_node = Node(data);
            if obj.size == 0
                obj.head.data = data;
            
            elseif obj.size < 2
            current = obj.head;
            
            while current.next ~= 'None'
                current = current.next;
                
            end
            
            current.next = new_node;
            obj.tail = new_node;
            obj.tail.previous = current;
            
            else
                obj.tail.next = new_node;
                obj.tail.next.previous = obj.tail;
                obj.tail = obj.tail.next;
            end
            obj.size = obj.size + 1;
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
            if index > obj.size
                str = 'ERROR Index out of range';
                str
                data = NaN;
                return
            end
            
            if index == 1
                data = obj.head.data;
            elseif index == obj.size
                data = obj.tail.data;
            else
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
        
        function dataSet = getDataset(obj,someFunction)
             tempSet(1, obj.size) = zeros;
             current_node = obj.head;
             i = 1;
            if nargin > 1
                while current_node.next ~= 'None'
                    data = someFunction(current_node.data);                
                    tempSet(i) = data;
                    current_node = current_node.next;
                    i = i + 1;
                end
                
            else
                while current_node.next ~= 'None'
                tempSet(i) = current_node.data;
                current_node = current_node.next;
                i = i + 1; 
                 
                end  
            end
            
            if nargin > 1
               tempSet(obj.size) = someFunction(obj.tail.data);
           else
               tempSet(obj.size) = obj.tail.data;
            end
           
            filterSet = tempSet > 0;
            dataSet = tempSet(filterSet);
        end
        
        function erase(obj,index)
            cur_idx = 1;
            current_node = self.head;
            length = obj.size;
            running = true;
            if index > length
               str = 'index Error'
               return
            end
            
            while running
                last_node = current_node;
                current_node = last_node.next;
                if index == cur_idx
                    last_node.next = current_node.next;
                    running = false;
                else
                    cur_idx = cur_idx + 1 ;
                end
            end
            
            
        end
        
        function eraseNode(obj,node)
            previousNode = node.previous;
            nextNode = node.next;
            
            nextNode.previous = previousNode;
            previousNode.next = NextNode;
        end
    end
    
end


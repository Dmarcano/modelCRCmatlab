classdef Population <handle
    %A class of multiple linked lists that allows the sorting of people
    %depending on their health stage. Also allows for summary statistics to
    %be easily made of a population of Person classes.
   properties
       healthy
       diseased
       dead
   end
   
   methods
       function obj = Population()
           if nargin > 1
               obj.healthy = LinkedList();
               obj.diseased = LinkedList();
               obj.dead = LinkedList();
           end
       end
   end
    
    
end
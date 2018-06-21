classdef Population < handle
    %A class of multiple linked lists that allows the sorting of people
    %depending on their health stage. Also allows for summary statistics to
    %be easily made of a population of Person classes.
   properties
       healthy
       diseased
       dead
       p5Data
       SData
       LData
       RData
       DData
   end
   
   methods
       
   % ============= CONSTRUCTOR ==================
       function obj = Population()
           
               obj.healthy = LinkedList();
               obj.diseased = LinkedList();
               obj.dead = LinkedList();
               obj.p5Data = [];
               obj.SData = [];
               obj.LData = [];
               obj.RData = [];
               obj.DData = [];
               
           
       end
       % ============ GETTERS =============== 
       
       function person = getHealthyPerson(obj,index)
           person = getData(obj.healthy,index);
       end
      
       
       function data = getP5Data(obj)
           func = @getP5Time;
            
           data = getDataset(obj.healthy,func);
           
       end
       
        function data = getSData(obj)
           func = @getSTime; 
           data = getDataset(obj.healthy,func);
        end
        function data = getLData(obj)
           func = @getLTime; 
           data = getDataset(obj.healthy,func);
        end
        function data = getRData(obj)
           func = @getRTime; 
           data = getDataset(obj.healthy,func);
        end
        function data = getDData(obj)
           func = @getDTime; 
           data = getDataset(obj.healthy,func);
       end
   end
    
    
end
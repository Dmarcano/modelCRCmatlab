%A person class that is used in the CRC model progression

classdef Person < handle
   properties
      race
      age
      range
      history
      status
      health_history
      p5Progression
      crcProgression
   end
   events
       polypFormation
       In_situ
       Local
       Regional
       distant
       diagnosis
       death
   end
    methods
        function obj = Person(race,age,history)
            if nargin > 0
            obj.race = race;
            obj.age = age;
            obj.history = history;
            obj.status = 'H';
            obj.range = 'Undefined';
            obj.health_history = [];
            obj.p5Progression = [];
            obj.crcProgression = [];
            end
            
        end
        
         function obj = updateAge(obj,years)
          assert(years >0);
          newAge =  obj.age + years;
          obj.age = newAge;
         end
        
        function obj = changeStatus(obj,status)
           obj.status = status; 
        end
        
        function obj = setP5progress(obj,p5Prob)
            obj.p5Progression = p5Prob;
        end
        
        function obj = setCancerProgress(obj,canProb)
            obj.crcProgression = canProb;
        end
        
        function polypProgression(obj)
            notify(obj,"polypFormation")
        end
        function obj = calcRange(obj)
            if obj.age >= 40 && obj.age <= 49
                obj.range = 'A';
            elseif obj.age >= 50 && obj.age <= 64
                obj.range = 'B' ;
            elseif obj.age >= 65 && obj.age <= 74
                obj.range = 'C';
            elseif obj.age >= 75
                obj.range = 'D';
            end
        end
        
    end
    
    
end  
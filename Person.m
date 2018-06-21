%A person class that is used in the CRC model progression

classdef Person < handle
    %A person class that encapsulates all of the information of a person
    %for the CRC model. 
         % Each person class has the following properties
            % 1) race - a string that specifies the race of the person
            % 2) age - a double that specifies the age a person is
            % 3) range - a char that for this simulation, was used to group people
            % of similiar age ranges together
            % 4) status - A char that tells the state of the person
            % 5) colon - A child class that encapsulates the state of the person's
            % colon
            % 6) p5Progression - A hashtable or map that specifies each person's
            % individual probabilities of getting a 5mm pre-cancer polyp
            % 7) crcProgression- A hashtable or map that specifies the
            % one-step transition probabilities of a person progressing through
            % cancer stages
   
   properties
      race
      age
      range
      history
      status
      colon
      p5Progression
      crcProgression
      
   end
   
    methods
        
        % ============= CONSTRUCTOR =================
        function obj = Person(race,age,history)
            if nargin > 0
            obj.race = race;
            obj.age = age;
            obj.history = history;
            obj.status = 'H';
            obj.range = 'Undefined';
            obj.colon = Colon(age);
            obj.p5Progression = [];
            obj.crcProgression = [];
            end
            
        end
        
        % ================ SETTERS =================
         function obj = updateAge(obj,years)
          assert(years >0);
          newAge =  obj.age + years;
          obj.age = newAge;
         end
        
        function obj = changeStatus(obj,status)
           obj.status = status; 
        end
        
        function obj = setP5Progress(obj,hashtable)
            familyHistory = hashtable(obj.race);
            p5Prob = familyHistory(obj.history);
            obj.p5Progression = p5Prob;
        end
        
        function obj = setCancerProgress(obj,hashtable)
            hashtable.keys()
            familyHistory = hashtable(obj.race);
            crcProb = familyHistory(obj.history);
            obj.crcProgression = crcProb;
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
        
        % ================ GETTERS =================
        function p5Probs = getP5Probs(obj)
            p5Probs = obj.p5Progression(obj.range);
            
        end
        
        function cancerProbs = getCanProbs(obj)
            cancerProbs = obj.crcProgression(obj.status);
        end
       

        
        function p5Time = getP5Time(obj)
          p5Time = obj.colon.getP5Time();
        end
        
        function STime = getSTime(obj)
          STime = obj.colon.getSTime();
        end
        function LTime = getLTime(obj)
          LTime = obj.colon.getLTime();
        end
        
        function RTime = getRTime(obj)
          RTime = obj.colon.getRTime();
        end
        function DTime = getDTime(obj)
          DTime = obj.colon.getDTime();
        end
        
        
        %================== EVENTS =============== 
   
          function updateColon(obj)
              if obj.status =='P'
                  obj.colon.setPTime(obj.age);
              elseif obj.status =='S'
                  obj.colon.setSTime(obj.age);
              elseif obj.status =='L'
                  obj.colon.setLocalTime(obj.age);
              elseif obj.status =='R'
                  obj.colon.setRegionalTime(obj.age);
              elseif obj.status =='D'
                  obj.colon.setDistantTime(obj.age);
              end
          end
          
          function death(obj)
              obj.status = 'Dead';
              obj.colon.setDeathTime(pbj.age);
          end
        
    end
    
    
end  
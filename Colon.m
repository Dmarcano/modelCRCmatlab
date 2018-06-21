classdef Colon < handle
    %A colon class that stores specific information regarding the state of
    %a colon for each person object. It stores data such as the time a
    %person develops a specific instance of cancer and 
    properties (SetAccess = private)
        
        lastChecked
        initialTime
        polypTime
        inSituTime
        localTime
        regionalTime
        distantTime
        deathTime
        
    end
    
    properties
        status
    end
    methods
        % ============== CONSTRUCTOR =============
        function obj = Colon(age)
            if nargin > 0
                obj.status = 'H';
                obj.initialTime = age;
                obj.polypTime = 0;
                obj.inSituTime = 0;
                obj.localTime = 0;
                obj.regionalTime = 0;
                obj.distantTime = 0;
                obj.deathTime = 0;
            end
        end
        
        % ================ SETTERS ===================
        function obj = setPTime(obj,age)
            if nargin > 0
            obj.polypTime = age;
            end
        end
        
        function obj = setSTime(obj,age)
            if nargin > 0
            obj.inSituTime = age;
            end
        end
        
        function obj = setLocalTime(obj,age)
            if nargin > 0
            obj.localTime = age;
            end
        end
        
        function obj = setRegionalTime(obj,age)
            if nargin > 0
            obj.regionalTime = age;
            end
        end
        
        function obj = setDistantTime(obj,age)
            if nargin > 0
            obj.distantTime = age;
            end
        end
        
        function obj = setDeathTime(obj,age)
            if nargin > 0
            obj.deathTime = age;
            end
        end
        
        %================ GETTERS =============
        function time = getP5Time(obj)
            time = obj.polypTime;
        end
        
         function time = getSTime(obj)
            time = obj.inSituTime;
         end
         
         function time = getLTime(obj)
            time = obj.localTime;
         end
        
          function time = getRTime(obj)
            time = obj.regionalTime;
          end
        
           function time = getDTime(obj)
            time = obj.distantTime;
           end
           
         function time = getDeathTime(obj)
            time = obj.deathTime;
         end
        
        
    end
    
    
    
end
classdef Colon
    properties
        status
        initialTime
        polypTime
        inSituTime
        localTime
        regionalTime
        distantTime
        deathTime
        
    end
    methods
        function obj = Colon(age)
            obj.status = 'H';
            obj.initialTime = age;
            obj.polypTime = NaN;
            obj.inSituTime = NaN;
            obj.localTime = NaN;
            obj.regionalTime = NaN;
            obj.distantTime = NaN;
            obj.deathTime = NaN;
        end
        
        function obj = setPTime(obj,age)
            obj.polypTime = age;
        end
        
        function obj = setSTime(obj,age)
            obj.inSituTime = age;
        end
        
        function obj = setLocalTime(obj,age)
            obj.localTime = age;
        end
        
        function obj = setRegionalTime(obj,age)
            obj.regionalTime = age;
        end
        
        function obj = setDistantTime(obj,age)
            obj.distantTime = age;
        end
        
        function obj = setDeathTime(obj,age)
            obj.deathTime = age;
        end
            
        
    end
    
    
    
end
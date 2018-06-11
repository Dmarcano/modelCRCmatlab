classdef healthHistory
    properties
        initialTime
        polypTime
        inSituTime
        localTime
        regionalTime
        deathTime
        
    end
    methods
        function obj = healthHistory(age)
            obj.initialTime = age;
            obj.polypTime = NaN;
            obj.inSituTime = NaN;
            obj.localTime = NaN;
        end
        
    end
    
    
    
end
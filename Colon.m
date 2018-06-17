classdef Colon < handle
    %A colon class that stores specific information regarding the state of
    %a colon for each person object. It stores data such as the time a
    %person develops a specific instance of cancer and 
    properties
        status
        lastChecked
        initialTime
        polypTime
        inSituTime
        localTime
        regionalTime
        distantTime
        deathTime
        
    end
    methods
        % ============== CONSTRUCTOR =============
        function obj = Colon(age)
            if nargin > 0
                obj.status = 'H';
                obj.initialTime = age;
                obj.polypTime = NaN;
                obj.inSituTime = NaN;
                obj.localTime = NaN;
                obj.regionalTime = NaN;
                obj.distantTime = NaN;
                obj.deathTime = NaN;
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
            
        
    end
    
    
    
end
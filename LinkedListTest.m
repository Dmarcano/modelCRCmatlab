po%sample use of the population object
rng(100788071);
population = Population();




% =================== Polyp Probabilities =======================

%Map containers that have the polyp transition probabilities. Each
%container is accessed by a key and returns a specific value. There will be
%a specific container for each and every race: ApolypProb, CpolypProb,
%ApolypProb. 
%Each container is then stored inside a master container: p5Probs
C0Hp5Prob = containers.Map({'A'  , 'B',  'C','D'} , {0.050, 0.150, 0.500, 0.65 } );
C1Hp5Prob = containers.Map( {'A'  , 'B',  'C','D'} , { 0.050, 0.150, 0.500, 0.65 }  );
Cp5Prob = containers.Map({0,1},{C0Hp5Prob, C1Hp5Prob});

Af1Hp5Prob = containers.Map({'A'  , 'B',  'C','D'}, { 0.050, 0.150, 0.500, 0.65 } );
Af0Hp5Prob = containers.Map({'A'  , 'B',  'C','D'}, {  0.050, 0.150, 0.500, 0.65} );
Afp5Prob = containers.Map({0,1},{Af1Hp5Prob,Af0Hp5Prob});

All1Hp5Prob = containers.Map({'A', 'B',  'C','D'} , { 0.050, 0.150, 0.500, 0.65 } );
All0Hp5Prob = containers.Map({'A','B','C','D'},{  0.050, 0.150, 0.500, 0.65}  );
Allp5Prob = containers.Map({0,1}, {All0Hp5Prob,All1Hp5Prob} );

p5Probs = containers.Map({'Caucasian','African American','All'},{Cp5Prob,Afp5Prob,Allp5Prob});


%==================== Cancer Probabilities =========================

%possible states: Polyp (P) in-Situ (S) Local (L) Regional (R) Distant (D)
C0HcancerProb = containers.Map( {'P','S','L','R'} , {0.025, 0.25, 0.2, 0.65});
C1HcancerProb = containers.Map({'P','S','L','R'},  {0.045, 0.25, 0.2, 0.65} );
CcancerProb = containers.Map({0,1},{C0HcancerProb,C1HcancerProb});

Af0HcancerProb = containers.Map( {'P','S','L','R'},{0.02,0.26,0.25,0.67} );
Af1HcancerProb = containers.Map( {'P','S','L','R'},{0.04,0.26,0.25,0.68 } );
AfcancerProb = containers.Map({0,1}, { Af0HcancerProb,Af1HcancerProb }  );


All1HcancerProb = containers.Map( {'P','S','L','R'}, {0.04,0.25,0.18,0.65  } );
All0HcancerProb = containers.Map( {'P','S','L','R'}, { 0.02,0.25,0.18,0.65 }  );
AllcancerProb = containers.Map({0,1},{All0HcancerProb, All1HcancerProb}  );

canProbs = containers.Map({'Caucasian','African American','All'},{CcancerProb,AfcancerProb,AllcancerProb});




for i = 1:1000
    newPerson = createPerson(canProbs,p5Probs);
    population.healthy.append(newPerson);
end

for i = 1:60
    
    for j = 1:1000
        person = population.getHealthyPerson(j);
        oneYear(person);
    end
    
end



p5Data = population.getP5Data();
sData = population.getSData();
lData = population.getLData();
rData = population.getRData();
dData = population.getDData();




function person = createPerson(cancerHash,p5Hash)
% createPerson is a function that creates a random person using random
% number generation

race = ["Caucasian","African American","All"];
history = [0,1];
%Choosisng a random race 
 race_size = numel(race);
 random = randi(race_size);
 StringRace = race(random);
 currentR = char(StringRace);
%Choosing a random history
 currentH = history(randi(2));
 %Choosing a random age
 currentA = randi(75);
 personPlaceholder = Person(currentR,currentA, currentH);

 
 personPlaceholder.calcRange();
 personPlaceholder.setCancerProgress(cancerHash);
 personPlaceholder.setP5Progress(p5Hash);
 person = personPlaceholder;
end

function polypProgression(person)
%polypProgression is a function that determines if a person develops a
%polyp when called uppon. It is a helper to the one year function.
    p5ProgressProb = person.getP5Probs();
    probability = rand;
    
    if probability <= p5ProgressProb
        person.changeStatus('P');
        person.updateColon();
    end
end

function cancerProgression(person)
canProgressProb = person.getCanProbs();
probability = rand;

if probability <= canProgressProb
    currentStage = person.status;
    stages = ['P','S','L','R','D'];

    [j,i] = ismember(currentStage,stages);
    newStage = stages(i+1);
    person.changeStatus(newStage);
    person.updateColon();

end
end

function oneYear(person)
%oneYear is a function that simulates one year of past time for a person.
%Given Map containers (these are dictionaries/hash-tables)
%which contain the probabilities of transition from healthy states to 
%cancerous states the function will alter the Person in a way that deems it
%necessary
%The inputs are:
%   1)A Person Object. 
%   2)A hash table containg the p5 transition probabilities (master)
%   3)A hash table containg the cancer transition probabilities (master)
%The following will occur:
%   1) the Age of the person will increase by one year
%   2) the probabilities of the cancer progressing on each person is
%   calculated, depending on random number generation the health status of
%   the person will progress down the line.
    person.updateAge(1);   
    if person.age < 40
        return
    end
    person.calcRange();
    
    if (person.status ~= 'H') && (person.status ~= 'D')
        cancerProgression(person)
    elseif person.status =='D'
        
    else
    polypProgression(person);
        
    end
   
    
    
end

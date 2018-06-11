%Sample CRC transition model. 
%By: Diego Marcano 
%Swarthmore College 2018

%Discount Rate: 3%
%exprnd(1/lambda)

%seed: 100788071
%%Begin by creating a Person object

rng(100788071);


%Preset variables
race = 'Caucasian';
age=40;
history = 0;


%================= Creating the People for simulation============
%p1 = Person(race, age, history);
populationSize = 10;
population(1, populationSize) = Person();

% for k = 1:populationSize
%     population(k) = createPerson();
% end
for k = 1:populationSize
    population(k) = samplePerson();
end

% =================== Polyp Probabilities =======================

%Map containers that have the polyp transition probabilities. Each
%container is accessed by a key and returns a specific value. There will be
%a specific container for each and every race: ApolypProb, CpolypProb,
%ApolypProb. 
%Each container is then stored inside a master container: p5Probs
C0Hp5Prob = containers.Map({'A'  , 'B',  'C','D'} , {0.050, 0.150, 0.500, 0.65 } );
C1Hp5Prob = containers.Map( {'A'  , 'B',  'C','D'} , {  }  );
Cp5Prob = containers.Map({0,1},{C0Hp5Prob, C1Hp5Prob});



p5Probs = containers.Map({'Caucasian'},{C0Hp5Prob});


%==================== Cancer Probabilities =========================

%possible states: Polyp (P) in-Situ (S) Local (L) Regional (R) Distant (D)
C0HcancerProb = containers.Map( {'P','S','L','R'} , {0.025, 0.25, 0.2, 0.65});
C1HcancerProb = containers.Map({'P','S','L','R'},  {0.045, 0.25, 0.2, 0.65} );
CcancerProb = containers.Map({0,1},{C0HcancerProb,C1HcancerProb});

Af0HcancerProb = containers.Map();
Af1HcancerProb = containers.Map();
AfcancerProb = containers.Map({0,1}, { Af0HcancerProb,Af1HcancerProb }  );


AllcancerProb = containers.Map(  );

canProbs = containers.Map({'Caucasian','African American','All'},{CcancerProb,AfcancerProb,AllcancerProb});


%================ Loop to run simulation ===================
for i = 1:10
    for k = 1:populationSize
        oneYear(population(k),p5Probs,canProbs);
    end
end

%Sample simulation

% for i =1:20
%    oneYear(p1,p5Probs,canProbs); 
% end

% ===================  FUNCTIONS =================


function oneYear(person,p5Probs,canProbs)
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
        cancerProgression(person, canProbs)
    elseif person.status =='D'
        
    else
    polypProgression(person, p5Probs)
        
    end
   
    
    
end


function prob = polypTrans(person,p5Probs)
%A helper function for the oneYear function. This function takes in the
%person object along with a hash table for the probabilities of developing
%a 5mm polyp. It allows one to access the probability
%input: 1) A person object
%       2) A hash table with p5 Probabilities
%returns: the probability the specific person has of having a 5mm polyp
        hash = p5Probs(person.race);
        aRange = person.range;
        aHistory =  person.history;
        prob = hash( [aRange, aHistory] );
  
end


function prob = cancerTrans(person,canProbs)
%A helper function that is functionally the same as the polyp progression
%function rather it returns the cancer progression probabilities
%input: 1) A person object
%       2) A hash table with cancer progression probabilities
%returns: the probability the specific person has of progressing their
%cancer to the next stage 
        hash = canProbs(person.race);
        aHealth = person.status;
        aHistory =  person.history;
        prob = hash( [aHealth, aHistory] );
  
end


function person = createPerson()
% createPerson is a function that creates a random person using random
% number generation

race = ["Caucasian","African American","All"];
history = [0,1];
%Choosisng a random race 
 race_size = numel(race);
 random = randi(race_size);
 currentR = race(random);
%Choosing a random history
 currentH = history(randi(2));
 %Choosing a random age
 currentA = randi(75);

person = Person(currentR,currentA, currentH);
end

function person= samplePerson()
race = 'Caucasian';
age=40;
history = 0;

person = Person(race, age, history);
end

function polypProgression(person,p5Probs)
%polypProgression is a function that determines if a person develops a
%polyp when called uppon. It is a helper to the one year function.
    p5ProgressProb = polypTrans(person, p5Probs);
    probability = rand;
    
    if probability <= p5ProgressProb
        person.changeStatus('P');
    end
end

function cancerProgression(person, canProbs)
canProgressProb = cancerTrans(person,canProbs);
probability = rand;

if probability <= canProgressProb
currentStage = person.status;
stages = ['P','S','L','R','D'];

[j,i] = ismember(currentStage,stages);
newStage = stages(i+1);
person.changeStatus(newStage)

end

end
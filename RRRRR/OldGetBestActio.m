%get best action old script

% labels and probabilities:
labels = Agt.Policy(s).A_id;
probabilities = Agt.Policy(s).P;

% cumulative distribution
cp = [0 cumsum(probabilities)];

%Draw point at random according to probability density
draw = rand();
higher = find(cp >= draw==1,1);
drawn_a_id = labels(higher-1); 

a = Agt.Policy(s).A_id(drawn_a_id);
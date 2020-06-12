% test Strength

%% Test 1: Calculation GraphWU
A = [
    0   0.2 1
    0.2 0   0
    1   0   0];

known_strength = {[1.2, 0.2, 1]'};

g = GraphWU(A);
strength = Strength(g);

assert(isequal(strength.getValue(), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'Strength is not being calculated correctly for GraphWU')

%% Test 2: Calculation MultiplexGraphWU
A11 = [
    0   0.2 1
    0.2 0   0
    1   0   0];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0 1   0
    1 0   0.4
    0 0.4 0];
A = {
    A11     A12  
    A21     A22
    };

known_strength = {
                 [1.2, 0.2, 1]'
                 [1, 1.4, 0.4]'};
                                
g = MultiplexGraphWU(A);
strength = Strength(g);

assert(isequal(strength.getValue(), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'Strength is not being calculated correctly for MultiplexGraphWU')
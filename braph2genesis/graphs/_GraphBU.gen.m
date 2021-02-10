%% ¡header!
GraphBU < Graph (g, binary undirected graph) is a binary undirected graph.

%%% ¡description!
In a binary undirected (BU) graph, 
the edges can be either 0 (absence of connection) 
or 1 (existence of connection), and they are undirected. 
The connectivity matrix is symmetric.

%%% ¡ensemble!
false

%%% ¡graph!
graph = Graph.GRAPH;

%%% ¡connectivity!
connectivity = Graph.BINARY;

%%% ¡directionality!
directionality = Graph.UNDIRECTED;

%%% ¡selfconnectivity!
selfconnectivity = Graph.NONSELFCONNECTED;

%%% ¡negativity!
negativity = Graph.NONNEGATIVE;

%% ¡props!

%%% ¡prop!
B (data, adjacency) is the input graph adjacency matrix.

%% ¡props_update!

%%% ¡prop!
A (result, adjacency) is the symmetric binary adjacency matrix of the binary undirected graph.
%%%% ¡calculate!
B = g.get('B');
A = B;

varargin = {}; %% TODO add props to manage the relevant properties of symmetrize, dediagonalize, semipositivize, binarize
A = symmetrize(A, varargin{:}); %% enforces symmetry of adjacency matrix
A = dediagonalize(A, varargin{:}); %% removes self-connections by removing diagonal from adjacency matrix
A = semipositivize(A, varargin{:}); %% removes negative weights
A = binarize(A, varargin{:}); %% enforces binary adjacency matrix

value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
B = rand(randi(10));
g = GraphBU('B', B);

A = symmetrize(binarize(semipositivize(dediagonalize(B))));

assert(isequal(g.get('A'), A), ...
       [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_ERR], ...
       'GraphBU is not constructing well.')

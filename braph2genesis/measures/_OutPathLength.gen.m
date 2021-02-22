%% ¡header!
OutPathLength < Measure (m, out-path length) is the graph out-path length.

%%% ¡description!
The out-path length is the average shortest out-path lengths of one
node to all other nodes without a layer.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphWD
MultiplexGraphBD
MultiplexGraphWD

%% ¡props!
%%% ¡prop! 
rule (metadata, OPTION) 
%%%% ¡settings!
{'subgraphs' 'harmonic' 'default'}
%%%% ¡default!
'default'

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.nodenumber();
L = g.layernumber();

out_path_length = cell(L, 1);                    
path_length_rule = m.get('rule');

distance = Distance('G', g).get('M');

for li = 1:1:L
    path_length_layer = zeros(N(1), 1);
    distance_layer = distance{li};

    switch lower(path_length_rule)
        case {'subgraphs'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = mean(Du(Du~=Outf & Du~=0));
            end
            path_length_layer(isnan(path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
        case {'harmonic'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = harmmean(Du(Du~=0));
            end
        otherwise  % 'default'
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = mean(Du(Du~=0));
            end
    end
    out_path_length(li) = {path_length_layer};
end
value = out_path_length;


%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0 
    ];

known_out_path_length = {[Inf Inf Inf Inf Inf]'};

g = GraphBD('B', A);
out_path_length = OutPathLength('G', g).get('M');

assert(isequal(out_path_length, known_out_path_length), ...
    [BRAPH2.STR ':OutPathLength:' BRAPH2.BUG_ERR], ...
    'OutPathLength is not beoutg calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
%%%% ¡code!
A11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0 
      ];

A22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0 
      ];
A = {A11  A22};

known_out_path_length = {
                    [Inf Inf Inf Inf Inf]'
                    [Inf Inf Inf Inf Inf]'
                    };

g = MultiplexGraphBD('B', A);
out_path_length = OutPathLength('G', g).get('M');

assert(isequal(out_path_length, known_out_path_length), ...
    [BRAPH2.STR ':OutPathLength:' BRAPH2.BUG_ERR], ...
    'OutPathLength is not beoutg calculated correctly for MultiplexGraphBD.')
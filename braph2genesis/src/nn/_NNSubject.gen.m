%% ¡header!
NNSubject < Subject (sub, subject with connectivity matrix) is a subject for a neural network analysis.

%%% ¡description!
NNSubject contains the required informationto be analyzed by neural network analysis.

%%% ¡seealso!
Subject, NNGroup

%% ¡props!

%%% ¡prop!
G (data, item) is a graph obtained from the data of the subject.
%%%% ¡settings!
'Graph'

%%% ¡prop!
INPUT (data, cell) is an input obtained from the data of subject for the neural network analysis.

%%% ¡prop!
FEATURE_MASK (data, cell) is a feature mask generated by feature selection analysis.

%%% ¡prop!
MASKED_INPUT (result, cell) is a masked input with a feature mask.
%%%% ¡calculate!
feature_mask = sub.get('FEATURE_MASK');
if isempty(feature_mask)
    masked_input = {};
else
    input = sub.get('INPUT');
    for i = 1:1:length(feature_mask)
        input_per_cluster = input{i};
        mask_per_cluster = feature_mask{i};
        input_per_cluster(mask_per_cluster == 0) = 0;
        masked_input{i} = input_per_cluster;
    end
end

value = masked_input;

%%% ¡prop!
TARGET_NAME (data, string) is the name of the target for the neural network analysis.

%%% ¡prop!
TARGET (data, cell) is the encoded values of a target for the neural network analysis.

%%% ¡prop!
PREDICTION (data, cell) is the prediction of the subject from the neural network analysis.

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

%%% ¡prop!
age (data, scalar) is a scalar number containing the age of the subject.
%%%% ¡default!
0

%%% ¡prop!
sex (data, option) is an option containing the sex of the subject (female/male).
%%%% ¡default!
'unassigned'
%%%% ¡settings!
{'Female', 'Male', 'unassigned'}
%% ¡header!
NNGroup < Group (gr, group of subjects) is a group of subjects for a neural network analysis.

%%% ¡description!
NNGroup represents a group of NNSubjects whose class is defined in the property SUB_CLASS.
NNGroup provides the ready-to-use inputs and targets from all NN subjects, for 
performing a neural network analysis.

%%% ¡seealso!
Group, NNSubject

%% ¡props!

%%% ¡prop!
INPUTS (result, cell) is a collection of the input from all NN subjects.
%%%% ¡calculate!
if gr.get('SUB_DICT').length() == 0
    inputs = {};
else
    inputs = cellfun(@(x) x.get('MASKED_INPUT'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false);
end

value = inputs;

%%% ¡prop!
TARGETS (result, cell) is a collection of the target from all NN subjects.
%%%% ¡calculate!
if gr.get('SUB_DICT').length() == 0
    targets = {};
else
    targets = cellfun(@(x) x.get('TARGET'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false);
end

value = targets;
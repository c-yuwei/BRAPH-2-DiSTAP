%% EXAMPLE_NN_CON_WU_CLASSIFICATION_ADJACENCYMATRIX
% Script example pipeline for NN classification with input of adjacency matrix

clear variables %#ok<*NASGU>

%% Load brain atlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_NN_CON_WU_Classification_AdjacencyMatrix')) filesep 'example data CON (DTI)' filesep 'desikan_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_CON_WU_Classification_AdjacencyMatrix')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_CON_WU_Classification_AdjacencyMatrix')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Construct the dataset
nnd = NNClassifierData_CON_WU( ...
    'GR1', gr1, ...
    'GR2', gr2, ...
    'SPLIT_GR1', 0.2, ...
    'SPLIT_GR2', 0.2, ...
    'FEATURE_MASK', 0.05 ...
    );

gr_train = nnd.get('GR_TRAIN_FS');
gr_val = nnd.get('GR_VAL_FS');

%% Train the neural network classifier with the training set
classifier = NNClassifierDNN( ...
    'GR', gr_train, ...
    'VERBOSE', true, ...
    'SHUFFLE', 'every-epoch' ...
    );
classifier.memorize('MODEL');

%% Evaluate the classifier for the training set
nne_train = NNClassifierEvaluator( ...
    'GR', gr_train, ...
    'NN', classifier, ...
    'PLOT_CM', true, ...
    'PLOT_ROC', true, ...
    'PLOT_MAP', true ...
    );

auc_train = nne_train.get('AUC');
cm_train = nne_train.get('CONFUSION_MATRIX');
%map = nne_train.get('FEATURE_MAP'); %TODO: visualize for all cases

%% Evaluate the classifier for the validation set
nne_val = NNClassifierEvaluator( ...
    'GR', gr_val, ...
    'NN', classifier, ...
    'PLOT_CM', true, ...
    'PLOT_ROC', true, ...
    'PLOT_MAP', true ...
    );

auc_val = nne_val.get('AUC');
cm_val = nne_val.get('CONFUSION_MATRIX');

%% Load another groups of subjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_CON_WU_Classification_AdjacencyMatrix')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_unseen = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_CON_WU_Classification_AdjacencyMatrix')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_unseen = im_gr2.get('GR');

%% Evaluate the classifier with the testing set
nnd_test = NNClassifierData_CON_WU( ...
    'GR1', gr1_unseen, ...
    'GR2', gr2_unseen, ...
    'SPLIT_GR1', 1.0, ...
    'SPLIT_GR2', 1.0, ...
    'FEATURE_MASK', nnd.get('FEATURE_SELECTION_ANALYSIS') ...
    );

gr_test = nnd_test.get('GR_VAL_FS');

nne_test = NNClassifierEvaluator( ...
    'GR', gr_test, ...
    'NN', classifier ...
    );

auc_test = nne_test.get('AUC');
cm_test = nne_test.get('CONFUSION_MATRIX');

close all
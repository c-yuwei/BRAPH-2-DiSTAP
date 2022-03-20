%EXAMPLE_NNCV_ST_CLASSIFICATION
% Script example pipeline NNCV ST Classification

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_NNCV_ST_Classification')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST as a Training Set
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_NNCV_ST_Classification')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_NNCV_ST_Classification')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Initiate the Cross Validation Analysis
nncv = NNClassifierCrossValidation_ST( ...
    'GR1', gr1, ...
    'GR2', gr2, ...
    'KFOLD', 5, ...
    'REPETITION', 1, ...
    'FEATURE_MASK', 0.05, ...
    'PLOT_CM', true, ...
    'PLOT_ROC', true, ...
    'PLOT_MAP', true ...
    );

%% Evaluate the Performance
nncv.memorize('NNE_DICT');
auc = nncv.memorize('AUC');
auc_cil = nncv.get('AUC_CIL');
auc_ciu = nncv.get('AUC_CIU');
cm = nncv.get('CONFUSION_MATRIX');
map = nncv.get('CONTRIBUTION_MAP');

close all
%% EXAMPLE_NNCV_CON_WU_REGRESSION_GRAPHMEASURES
% Script example pipeline for NN regression with the input of graph measures 

clear variables %#ok<*NASGU>

%% Load brain atlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_NNCV_CON_WU_Regression_GraphMeasures')) filesep 'example data CON (DTI)' filesep 'desikan_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load group of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_NNCV_CON_WU_Regression_GraphMeasures')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

%% Construct the dataset
nnd = NNData_CON_WU( ...
    'GR', gr, ...
    'INPUT_TYPE', 'graph_measures', ...
    'MEASURES', {'DegreeAv' 'Clustering' 'Eccentricity'}, ...
    'TARGET_NAME', 'age' ...
    );

gr_nn = nnd.get('GR_NN');


%% Initiate the cross validation analysis
nncv = NNRegressorCrossValidation( ...
    'GR', gr_nn, ...
    'KFOLD', 5, ...
    'REPETITION', 1, ...
    'FEATURE_MASK', 0.05 ...
    );

%% Evaluate the Performance
gr_cv = nncv.get('GR_PREDICTION');
rmse_cv = nncv.get('RMSE');

close all
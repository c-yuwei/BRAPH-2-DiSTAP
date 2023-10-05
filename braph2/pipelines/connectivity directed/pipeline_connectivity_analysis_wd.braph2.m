%% Pipeline Connectivity Analysis WD

% This is the pipeline script to analyze a group of subjects using connectivity data and a weighted directed graph.
% The connectivity data can be derived from imaging modalities like diffusion weighted imaging (DWI).
% 1. It loads a brain atlas from an XLS file (e.g., desikan_atlas.xlsx).
% 2. It loads the data of one group of subjects from two directories (e.g., GroupName1 and GroupName2) containing XLS files of each subject.
% 3. It analyzes these data using a connectivity analysis (CON) based on a weighted undirected graph (WD).

% PDF: 
% README: 

%% Brain Atlas
ba = ImporterBrainAtlasXLS('WAITBAR', true).get('GET_FILE').get('BA'); % Load Brain Atlas from XLS % Brain Atlas

%% Group
gr = ImporterGroupSubjectCON_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR'); % Load Group CON from XLS % Group CON

%% Analysis
a_WD = AnalyzeEnsemble_CON_WD('GR', gr); % Analyze Group % Group Analysis
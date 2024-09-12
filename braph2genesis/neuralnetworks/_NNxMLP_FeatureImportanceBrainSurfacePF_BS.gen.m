%% ¡header!
NNxMLP_FeatureImportanceBrainSurfacePF_BS < NNxMLP_FeatureImportanceBrainSurfacePF (pf, panel figure for feature importance brain) is a plot of a feature importance brain.

%%% ¡description!
A panel figure for the neural networks feature importance on brain surface (NNxMLP_FeatureImportanceBrainSurfacePF_BS) manages the plot
 of the feature importance ploted over the brain with the binodal-superglobal graph measures.  
NNxMLP_FeatureImportanceBrainSurfacePF utilizes the surface created from BrainAtlasPF to integrate 
 the feature importance values into the brain regions.

%%% ¡seealso!
NNxMLP_FeatureImportanceBrainSurface, NNxMLP_FeatureImportanceBrainSurfacePF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for the neural networks feature importance on brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePF_BS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for the neural networks feature importance on brain surface.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for the neural networks feature importance on brain surface.
%%%% ¡default!
'A panel figure for the neural networks feature importance on brain surface (NNxMLP_FeatureImportanceBrainSurfacePF_BS) manages the plot of the feature importance ploted over the brain with the binodal-superglobal graph measures. NNxMLP_FeatureImportanceBrainSurfacePF utilizes the surface created from BrainAtlasPF to integrate the feature importance values into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for the neural networks feature importance on brain surface.
%%%% ¡settings!
'NNxMLP_FeatureImportanceBrainSurfacePF_BS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for the neural networks feature importance on brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePF_BS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for the neural networks feature importance on brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePF_BS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for the neural networks feature importance on brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePF_BS notes'

%%% ¡prop!
DRAW (query, logical) draws the figure brain atlas.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, NNxMLP_FeatureImportanceBrainSurfacePF_BS.DRAW, varargin{:}); % also warning
if value    
    % trigger setup
    pf.get('SETUP');
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, NNxMLP_FeatureImportanceBrainSurfacePF_BS.DELETE, varargin{:}); % also warning
if value
    % do nothing
end

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[NNxMLP_FeatureImportanceBrainSurfacePF_BS.PARENT NNxMLP_FeatureImportanceBrainSurfacePF_BS.H NNxMLP_FeatureImportanceBrainSurfacePF_BS.ST_POSITION NNxMLP_FeatureImportanceBrainSurfacePF_BS.ST_AXIS NNxMLP_FeatureImportanceBrainSurfacePF_BS.ST_SURFACE NNxMLP_FeatureImportanceBrainSurfacePF_BS.ST_AMBIENT NNxMLP_FeatureImportanceBrainSurfacePF_BS.FI NNxMLP_FeatureImportanceBrainSurfacePF_BS.D]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF_BS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF_BS'])

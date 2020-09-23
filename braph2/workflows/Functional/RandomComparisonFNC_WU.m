classdef RandomComparisonFNC_WU < RandomComparison
    % RandomComparisonFNC_WU A random comparison of functional data with weighted undirected graphs
    % RandomComparisonFNC_WU is a subclass of Comparison, it implements the
    % initialization of data methods.
    %
    % RandomComparisonFNC_WU implements the initialization of the data which the
    % class will save. It checks if the data being saved has correct
    % dimensions. Functional data can be for example fMRI data.
    %
    % RandomComparisonFNC_WU constructor methods:
    %  RandomComparisonFNC_WU       - Constructor
    %
    % RandomComparisonFNC_WU basic methods:
    %  disp                         - displays the comparison
    %
    % RandomComparisonFNC_WU get methods:
    %  getGroupValue                - returns the group measurement value
    %  getRandomValue               - returns the random group measurement value
    %  getDifference                - returns the difference between values
    %  getAllDifferences            - returns all the differecens between values
    %  getP1                        - returns the p-values single tail
    %  getP2                        - returns the p-values double tail
    %  getConfidenceIntervalMin     - returns the min value of the confidence interval
    %  getConfidenceIntervalMax     - returns the max value of the confidence interval
    %
    % RandomComparisonFNC_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % RandomComparisonFNC_WU descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getRandcomComparison         - returns a new random comparison
    %
    % RandomComparisonFNC_WU plot methods (Static):
    %  getRandomComparisonSettingsPanel - returns a UIPanel
    %
    % See also Comparison, AnalysisFNC_WU, MeasurementFNC_WU, ComparisonFNC_WU.
    
    properties
        value_group  % array with the value_group of the measure for each subject of group
        value_random  % array with the value_group of the measure for each subject of random group
        average_value_group  % average value of group
        average_value_random  % average value of the random group
        difference  % difference
        all_differences  % all differences obtained through the permutation test
        p1  % p value single tailed
        p2  % p value double tailed
        confidence_interval_min  % min value of the 95% confidence interval
        confidence_interval_max  % max value of the 95% confidence interval
    end
    methods  % Constructor
        function rc =  RandomComparisonFNC_WU(id, label, notes, atlas, measure_code, group, varargin)
            % RANDOMCOMPARISONFNC_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and a random group. It initializes the
            % RANDOMCOMPARISONFNC_WU with default settings.
            %
            % RANDOMCOMPARISONFNC_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and a random group. It initializes the
            % RANDOMCOMPARISONFNC_WU with VALUE settings.
            %
            % See also MeasurementFNC_WU, ComparisonFNC_WU, AnalysisFNC_WU.
            
            graph_type = AnalysisFNC_WU.getGraphType();
            measure_list = Graph.getCompatibleMeasureList(graph_type);
            assert(ismember(measure_code, measure_list), ...
                [BRAPH2.STR ':RandomComparisonFNC_WU:' BRAPH2.BUG_FUNC], ...
                'RandomComparisonFNC_WU measure_code is not compatible with the permited Measures.');
            
            rc = rc@RandomComparison(id, label, notes, atlas, measure_code, group, varargin{:});
        end
    end
    methods  % Basic function
        function disp(rc)
            % DISP overrides RandomComparison disp
            %
            % DISP(M) overrides RandomComparison disp and displays additional
            % information about the difference of the RandomComparisonFNC_WU.
            %
            % See also Comparison
            
            rc.disp@RandomComparison()
            disp(['value group (' tostring(size(rc.value_group{1}, 1)) 'x' tostring(size(rc.value_group{1}, 2)) ') = {' tostring(rc.value_group{1}) '}' ])
            disp(['value random (' tostring(size(rc.value_random{1}, 1)) 'x' tostring(size(rc.value_random{1}, 2)) ') = {' tostring(rc.value_random{1}) '}' ])
            disp(['average value of group (' tostring(size(rc.average_value_group{1}, 1)) 'x' tostring(size(rc.average_value_group{1}, 2)) ') = {' tostring(rc.average_value_group) '}'])
            disp(['average value of random (' tostring(size(rc.average_value_random{1}, 1)) 'x' tostring(size(rc.average_value_random{1}, 2)) ') = {' tostring(rc.average_value_random) '}'])
            disp(['difference (' tostring(size(rc.difference{1}, 1)) 'x' tostring(size(rc.difference{1}, 2)) ') = {' tostring(rc.difference{1}) '}' ])
            disp(['p1 (' tostring(size(rc.p1{1}, 1)) 'x' tostring(size(rc.p1{1}, 2)) ') = {' tostring(rc.p1{1}) '}' ])
            disp(['p2 (' tostring(size(rc.p2{1}, 1)) 'x' tostring(size(rc.p2{1}, 2)) ') = {' tostring(rc.p2{1}) '}' ])
            disp(['confidence interval min (' tostring(size(rc.confidence_interval_min{1}, 1)) 'x' tostring(size(rc.confidence_interval_min{1}, 2)) ') = {' tostring(rc.confidence_interval_min{1}) '}' ])
            disp(['confidence interval max (' tostring(size(rc.confidence_interval_max{1}, 1)) 'x' tostring(size(rc.confidence_interval_max{1}, 2)) ') = {' tostring(rc.confidence_interval_max{1}) '}' ])
        end
    end
    methods  % Get functions
        function value = getGroupValue(rc)
            % GETGROUPVALUE returns the measure value of the group
            %
            % VALUE = GETGROUPVALUE(RC) returns the measure value of the group.
            %
            % See also getRandomValue, getDifference, getAllDifferences.
            
            value = rc.value_group;
        end
        function random_value = getRandomValue(rc)
            % GETRANDOMVALUE returns the measure value of the random group
            %
            % RANDOM_VALUE = GETRANDOMVALUE(RC) returns the measure value
            % of the random group.
            %
            % See also getGroupValue, getDifference, getAllDifferences.
            
            random_value = rc.value_random;
        end
        function average_value = getAverageValue(c)
            average_value = c.average_value_group;
        end
        function average_random_value = getAverageRandomValue(c)
            average_random_value = c.average_value_random;
        end
        function difference = getDifference(rc)
            % GETDIFFERENCE returns the difference between measure values
            %
            % DIFFERENCE = GETDIFFERENCE(C) returns the difference between
            % measure values of both groups. This difference is the mean of
            % all differences.
            %
            % See also getGroupValue, getGroupValues, getAllDifferences.
            
            difference = rc.difference;
        end
        function all_differences = getAllDifferences(rc)
            % GETALLDIFFERENCES returns the all differences between measure values
            %
            % ALL_DIFFERENCES = GETALLDIFFERENCE(RC) returns all differences between
            % measure values of both groups.
            %
            % See also getGroupValue, getGroupValues, getDifference.
            
            all_differences = rc.all_differences;
        end
        function p1 = getP1(rc)
            % GETP1 returns the single tail p-value of the random comparison
            %
            % P1 = GETP1(C) returns the single tail p-value of the random comparison
            %
            % See also getP2, getConfidenceIntervalMin, getConfidenceIntervalMax.
            
            p1 = rc.p1;
        end
        function p2 = getP2(rc)
            % GETP2 returns the double tail p-value of the random comparison
            %
            % P2 = GETP2(C) returns the double tail p-value of the random comparison
            %
            % See also getP1, getConfidenceIntervalMin, getConfidenceIntervalMax.
            
            p2 = rc.p2;
        end
        function confidence_interval_min = getConfidenceIntervalMin(rc)
            % GETFNCFIDENCEINTERVALMIN returns minimum value of the confidence interval
            %
            % FNCFIDENCE_INTERVAL_MIN = GETFNCFIDENCEINTERVALMIN(C)
            % returns minimum value of the confidence interval
            %
            % See also getP1, getP2, getConfidenceIntervalMax.
            
            confidence_interval_min = rc.confidence_interval_min;
        end
        function confidence_interval_max = getConfidenceIntervalMax(rc)
            % GETFNCFIDENCEINTERVALMAX returns maximum value of the confidence interval
            %
            % FNCFIDENCE_INTERVAL_MAX = GETFNCFIDENCEINTERVALMAX(C)
            % returns maximum value of the confidence interval
            %
            % See also getP1, getP2, getConfidenceIntervalMin.
            
            confidence_interval_max = rc.confidence_interval_max;
        end
    end
    methods (Access=protected)  % Initialize data
        function initialize_data(rc, varargin)
            % INITIALIZE_DATA initialize and check the data for the random comparison
            %
            % INITIALIZE_DATA(C) initialize and check the data for the
            % random comparison. It initializes with default settings.
            %
            % INITIALIZE_DATA(C, PROPERTY, VALUE, ...) initialize and
            % check the data for the random comparison. It initializes
            % with VALUE settings.
            % Admissible rules are:
            %  'RandomComparisonFNC.RandomizationNumber'  - number of randomizations
            %  'RandomComparisonFNC.value_group'     - value of the group
            %  'RandomComparisonFNC.value_random'    - value of random group
            %  'RandomComparisonFNC.average_value_group'  - average of group values
            %  'RandomComparisonFNC.average_value_random' - average of random values
            %  'RandomComparisonFNC.difference'      - value of difference
            %  'RandomComparisonFNC.all_differences' - value of all differences
            %  'RandomComparisonFNC.p1'              - single tail p-value
            %  'RandomComparisonFNC.p2'              - double tail p-value
            %  'RandomComparisonFNC.confidence_min'  - min value in confidence interval
            %  'RandomComparisonFNC.confidence_max'  - max value in confidence interval
            %
            % See also AnalysisFNC_WU.
            
            atlases = rc.getBrainAtlases();
            atlas = atlases{1};
            
            group = rc.getGroup();
            measure_code = rc.getMeasureCode();
            
            number_of_randomizations = rc.getSettings('RandomComparisonFNC.RandomizationNumber');
            
            if Measure.is_global(measure_code)  % global measure
                rc.value_group = get_from_varargin( ...
                    repmat({0}, 1, group.subjectnumber()), ...
                    'RandomComparisonFNC.value_group', ...
                    varargin{:});
                assert(iscell(rc.getGroupValue()) && ...
                    isequal(size(rc.getGroupValue()), [1, group.subjectnumber()]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getGroupValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.value_random = get_from_varargin( ...
                    repmat({0}, 1, group.subjectnumber()), ...
                    'RandomComparisonFNC.value_random', ...
                    varargin{:});
                assert(iscell(rc.getRandomValue()) && ...
                    isequal(size(rc.getRandomValue()), [1, group.subjectnumber()]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getRandomValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.average_value_group = get_from_varargin( ...
                    {0}, ...
                    'RandomComparisonFNC.average_value_group', ...
                    varargin{:});
                assert(iscell(rc.getAverageValue()) && ...
                    isequal(size(rc.getAverageValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getAverageValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.average_value_random = get_from_varargin( ...
                    {0}, ...
                    'RandomComparisonFNC.average_value_random', ...
                    varargin{:});
                assert(iscell(rc.getAverageRandomValue()) && ...
                    isequal(size(rc.getAverageRandomValue()), [1, 1])&& ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getAverageRandomValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.difference = get_from_varargin( ...
                    {0}, ...
                    'RandomComparisonFNC.difference', ...
                    varargin{:});
                assert(iscell(rc.getDifference()) && ...
                    isequal(size(rc.getDifference()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getDifference())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.all_differences = get_from_varargin( ...
                    repmat({0}, 1, number_of_randomizations), ...
                    'RandomComparisonFNC.all_differences', ...
                    varargin{:});
                assert(iscell(rc.getAllDifferences()) && ...
                    isequal(size(rc.getAllDifferences()), [1, number_of_randomizations]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getAllDifferences())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.p1 = get_from_varargin( ...
                    {0}, ...
                    'RandomComparisonFNC.p1', ...
                    varargin{:});
                assert(iscell(rc.getP1()) && ...
                    isequal(size(rc.getP1()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getP1())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.p2 = get_from_varargin( ...
                    {0}, ...
                    'RandomComparisonFNC.p2', ...
                    varargin{:});
                assert(iscell(rc.getP2()) && ...
                    isequal(size(rc.getP2()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getP2())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.confidence_interval_min = get_from_varargin( ...
                    {0}, ...
                    'RandomComparisonFNC.confidence_min', ...
                    varargin{:});
                assert(iscell(rc.getConfidenceIntervalMin()) && ...
                    isequal(size(rc.getConfidenceIntervalMin()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getConfidenceIntervalMin())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.confidence_interval_max = get_from_varargin( ...
                    {0}, ...
                    'RandomComparisonFNC.confidence_max', ...
                    varargin{:});
                assert(iscell(rc.getConfidenceIntervalMax()) && ...
                    isequal(size(rc.getConfidenceIntervalMin()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), rc.getConfidenceIntervalMax())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
            elseif Measure.is_nodal(measure_code)  % nodal measure
                rc.value_group = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, group.subjectnumber()), ...
                    'RandomComparisonFNC.value_group', ...
                    varargin{:});
                assert(iscell(rc.getGroupValue()) && ...
                    isequal(size(rc.getGroupValue()), [1, group.subjectnumber()]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getGroupValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.value_random = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, group.subjectnumber()), ...
                    'RandomComparisonFNC.value_random', ...
                    varargin{:});
                assert(iscell(rc.getRandomValue()) && ...
                    isequal(size(rc.getRandomValue()), [1, group.subjectnumber()]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getRandomValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.average_value_group = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'RandomComparisonFNC.average_value_group', ...
                    varargin{:});
                assert(iscell(rc.getAverageValue()) && ...
                    isequal(size(rc.getAverageValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getAverageValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.average_value_random = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'RandomComparisonFNC.average_value_random', ...
                    varargin{:});
                assert(iscell(rc.getAverageRandomValue()) && ...
                    isequal(size(rc.getAverageRandomValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getAverageRandomValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.difference = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'RandomComparisonFNC.difference', ...
                    varargin{:});
                assert(iscell(rc.getDifference()) && ...
                    isequal(size(rc.getDifference()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getDifference())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.all_differences = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, number_of_randomizations), ...
                    'RandomComparisonFNC.all_differences', ...
                    varargin{:});
                assert(iscell(rc.getAllDifferences()) && ...
                    isequal(size(rc.getAllDifferences()), [1, number_of_randomizations]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getAllDifferences())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.p1 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'RandomComparisonFNC.p1', ...
                    varargin{:});
                assert(iscell(rc.getP1()) && ...
                    isequal(size(rc.getP1()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getP1())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.p2 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'RandomComparisonFNC.p2', ...
                    varargin{:});
                assert(iscell(rc.getP2()) && ...
                    isequal(size(rc.getP2()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getP2())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.confidence_interval_min = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'RandomComparisonFNC.confidence_min', ...
                    varargin{:});
                assert(iscell(rc.getConfidenceIntervalMin()) && ...
                    isequal(size(rc.getConfidenceIntervalMin()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getConfidenceIntervalMin())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.confidence_interval_max = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'RandomComparisonFNC.confidence_max', ...
                    varargin{:});
                assert(iscell(rc.getConfidenceIntervalMax()) && ...
                    isequal(size(rc.getConfidenceIntervalMax()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), rc.getConfidenceIntervalMax())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
            elseif Measure.is_binodal(measure_code)  % binodal measure
                rc.value_group = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, group.subjectnumber()), ...
                    'RandomComparisonFNC.value_group', ...
                    varargin{:});
                assert(iscell(rc.getGroupValue()) && ...
                    isequal(size(rc.getGroupValue()), [1, group.subjectnumber()]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getGroupValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.value_random = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, group.subjectnumber()), ...
                    'RandomComparisonFNC.value_random', ...
                    varargin{:});
                assert(iscell(rc.getRandomValue()) && ...
                    isequal(size(rc.getRandomValue()), [1, group.subjectnumber()]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getRandomValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.average_value_group = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'RandomComparisonFNC.average_value_group', ...
                    varargin{:});
                assert(iscell(rc.getAverageValue()) && ...
                    isequal(size(rc.getAverageValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getAverageValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.average_value_random = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'RandomComparisonFNC.average_value_random', ...
                    varargin{:});
                assert(iscell(rc.getAverageRandomValue()) && ...
                    isequal(size(rc.getAverageRandomValue()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getAverageRandomValue())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.difference = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'RandomComparisonFNC.difference', ...
                    varargin{:});
                assert(iscell(rc.getDifference()) && ...
                    isequal(size(rc.getDifference()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getDifference())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.all_differences = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, number_of_randomizations), ...
                    'RandomComparisonFNC.all_differences', ...
                    varargin{:});
                assert(iscell(rc.getAllDifferences()) && ...
                    isequal(size(rc.getAllDifferences()), [1, number_of_randomizations]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getAllDifferences())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.p1 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'RandomComparisonFNC.p1', ...
                    varargin{:});
                assert(iscell(rc.getP1()) && ...
                    isequal(size(rc.getP1()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getP1())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.p2 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'RandomComparisonFNC.p2', ...
                    varargin{:});
                assert(iscell(rc.getP2()) && ...
                    isequal(size(rc.getP2()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getP2())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.confidence_interval_min = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'RandomComparisonFNC.confidence_min', ...
                    varargin{:});
                assert(iscell(rc.getConfidenceIntervalMin()) && ...
                    isequal(size(rc.getConfidenceIntervalMin()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getConfidenceIntervalMin())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
                rc.confidence_interval_max = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'RandomComparisonFNC.confidence_max', ...
                    varargin{:});
                assert(iscell(rc.getConfidenceIntervalMax()) && ...
                    isequal(size(rc.getConfidenceIntervalMax()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), rc.getConfidenceIntervalMax())), ...
                    [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with: ' class(rc)])
                
            end
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of functional random comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonFNC_WU'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonFNC_WU';
        end
        function name = getName()
            % GETNAME returns the name of functional random comparison
            %
            % NAME = GETNAME() returns the name, RandomComparison FNC WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison FNC WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional random comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonFNC_WU.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = 'FNC random comparison with weighted graphs.';
        end
        function atlas_number = getBrainAtlasNumber()
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % ATLAS_NUMBER = GETBRAINATLASNUMBER() returns the number of
            % brain atlases.
            %
            % See also getList, getClass, getName.
            
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'RandomComparisonFNC_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisFNC_WU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of functional random comparison subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of RandomComparisonFNC_WU subject, 'SubjectFNC'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectFNC';
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of functional random comparison
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS() returns the
            % available settings of RandomComparisonFNC_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {
                'RandomComparisonFNC.RandomizationNumber', BRAPH2.NUMERIC, 1000, {}; ...
                'RandomComparisonFNC.AttemptsPerEdge', BRAPH2.NUMERIC, 5, {}; ...
                'RandomComparisonFNC.NumberOfWeights', BRAPH2.NUMERIC, 1, {}; ...
                };
        end
        function sub = getRandomComparison(random_comparison_class, id, label, notes, atlas, measure_code, group, varargin)
            % GETRANDOMCOMPARISON returns a new comparison
            %
            % SUB = GETRANDOMCOMPARISON(RANDOMCOMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % returns a new RandomComparisonFNC_WU object with RANDOMCOMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            %
            % SUB = GETRANDOMCOMPARISON(RANDOMCOMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % returns a new RandomComparisonFNC_WU object with RANDOMCOMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with VALUE settings.
            %
            % See also getClass, getName, getDescription.
            
            sub = eval([random_comparison_class '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
    methods (Static)  % Plot ComparisonGUI Child Panel
        function handle = getRandomComparisonSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible and
            % Randomization.
            %
            % See also RandomComparisonST_WU.
            
            set(uiparent, 'Visible', 'on')
            
            ui_randomization_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_randomization_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_attempts_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_attempts_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            ui_weights_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_weights_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                
                set(ui_randomization_text, 'String', 'Randomization Number')
                set(ui_randomization_text, 'Position', [.01 .86 .47 .08])
                set(ui_randomization_text, 'Fontweight', 'bold')
                
                set(ui_randomization_edit, 'String', 1000)
                set(ui_randomization_edit, 'Position', [.5 .87 .45 .08])
                set(ui_randomization_edit, 'Callback', {@cb_randomcomparison_randomization})
                
                set(ui_attempts_text, 'String', 'Attempts per Edge')
                set(ui_attempts_text, 'Position', [.01 .76 .47 .08])
                set(ui_attempts_text, 'Fontweight', 'bold')
                
                set(ui_attempts_edit, 'String', 5)
                set(ui_attempts_edit, 'Position', [.5 .77 .45 .08])
                set(ui_attempts_edit, 'Callback', {@cb_randomcomparison_attempts})
                
                set(ui_weights_text, 'String', 'Number of Weights')
                set(ui_weights_text, 'Position', [.01 .66 .47 .08])
                set(ui_weights_text, 'Fontweight', 'bold')
                
                set(ui_weights_edit, 'String', 1)
                set(ui_weights_edit, 'Position', [.5 .67 .45 .08])
                set(ui_weights_edit, 'Callback', {@cb_randomcomparison_weights})
            end
            function cb_randomcomparison_randomization(~, ~)
                setappdata(uiparent, 'randomization', str2double(get(ui_randomization_edit, 'String')))
            end
            function cb_randomcomparison_attempts(~, ~)
                setappdata(uiparent, 'attempts', str2double(get(ui_attempts_edit, 'String')))
            end
            function cb_randomcomparison_weights(~, ~)
                setappdata(uiparent, 'weights', str2double(get(ui_weights_edit, 'String')))
            end
            handle.variables = [];
            handle.randomization = ui_randomization_edit;
            setappdata(uiparent, 'randomization', str2double(get(ui_randomization_edit, 'String')))
            setappdata(uiparent, 'attempts', str2double(get(ui_attempts_edit, 'String')))
            setappdata(uiparent, 'weights', str2double(get(ui_weights_edit, 'String')))
        end
    end
end
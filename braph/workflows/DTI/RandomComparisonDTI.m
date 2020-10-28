classdef RandomComparisonDTI < RandomComparison
    properties
        measure_code  % class of measure
        values_group  % array with the values of the measure for each subject
        values_random  % array with the random values of the measure
        average_value_group  % average value of group 1
        average_value_random  % average of random values
        difference  % difference
        all_differences  % all differences obtained through the permutation test
        p1  % p value single tailed
        p2  % p value double tailed
        confidence_interval_min  % min value of the 95% confidence interval
        confidence_interval_max  % max value of the 95% confidence interval
    end
    methods
        function c =  RandomComparisonDTI(id, atlas, group, varargin)
            c = c@RandomComparison(id, atlas, group, varargin{:});
        end
        function measure_code = getMeasureCode(c)
            measure_code = c.measure_code;
        end
        function values = getGroupValue(c) %#ok<*INUSL>
            values = c.values_group;
        end
        function average_value = getAverageValue(c)
            average_value = c.average_value_group;
        end
        function random_values = getRandomValue(c)
            random_values = c.values_random;
        end
        function average_random_value = getAverageRandomValue(c)
            average_random_value = c.average_value_random;
        end
        function difference = getDifference(c)
            difference = c.difference;
        end
        function all_differences = getAllDifferences(c)
            all_differences = c.all_differences;
        end
        function p1 = getP1(c)
            p1 = c.p1;
        end
        function p2 = getP2(c)
            p2 = c.p2;
        end
        function confidence_interval_min = getConfidenceIntervalMin(c)
            confidence_interval_min = c.confidence_interval_min;
        end
        function confidence_interval_max = getConfidenceIntervalMax(c)
            confidence_interval_max = c.confidence_interval_max;
        end
    end
    methods (Access=protected)
        function initialize_data(c, varargin)
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            group = c.getGroup();
            
            c.measure_code = get_from_varargin('Degree', ...
                'RandomComparisonDTI.measure_code', ...
                varargin{:});
            number_of_permutations = get_from_varargin(1, ...
                'RandomComparisonDTI.number_of_permutations', ...
                varargin{:});
            
            if Measure.is_global(c.getMeasureCode())  % global measure
                % values
                c.values_group = get_from_varargin( ...
                    repmat({0}, 1, group.subjectnumber()), ...
                    'RandomComparisonDTI.values_group', ...
                    varargin{:});
                c.values_random = get_from_varargin( ...
                    repmat({0}, 1, group.subjectnumber()), ...
                    'RandomComparisonDTI.values_random', ...
                    varargin{:});
                assert(iscell(c.getGroupValue()) & ...
                    isequal(size(c.getGroupValue()), [1, group.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getGroupValue())), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])  %#ok<*NBRAK>
                assert(iscell(c.getRandomValue()) & ...
                    isequal(size(c.getRandomValue()), [1, group.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getRandomValue())), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                
                % average values
                c.average_value_group = get_from_varargin( ...
                    0, ...
                    'RandomComparisonDTI.average_values_1', ...
                    varargin{:});
                c.average_value_random = get_from_varargin( ...
                    0, ...
                    'RandomComparisonDTI.average_values_2', ...
                    varargin{:});
                assert(isequal(size(c.getAverageValue()), [1, 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getAverageRandomValue()), [1, 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                
                % statistic measures
                c.difference = get_from_varargin( ...
                    0, ...
                    'RandomComparisonDTI.difference', ...
                    varargin{:});
                c.all_differences = get_from_varargin( ...
                    repmat({0}, 1, number_of_permutations), ...
                    'RandomComparisonDTI.all_differences', ...
                    varargin{:});
                c.p1 = get_from_varargin( ...
                    0, ...
                    'RandomComparisonDTI.p1', ...
                    varargin{:});
                c.p2 = get_from_varargin( ...
                    0, ...
                    'RandomComparisonDTI.p2', ...
                    varargin{:});
                c.confidence_interval_min = get_from_varargin( ...
                    0, ...
                    'RandomComparisonDTI.confidence_min', ...
                    varargin{:});
                c.confidence_interval_max = get_from_varargin( ...
                    0, ...
                    'RandomComparisonDTI.confidence_max', ...
                    varargin{:});
                
                assert(isequal(size(c.getDifference()), [1, 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getAllDifferences()), [1, number_of_permutations]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getP1()), [1, 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getP2()), [1, 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                
            elseif Measure.is_nodal(c.getMeasureCode())  % nodal measure
                c.values_group = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, group.subjectnumber()), ...
                    'RandomComparisonDTI.values_group', ...
                    varargin{:});
                c.values_random = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, group.subjectnumber()), ...
                    'RandomComparisonDTI.values_random', ...
                    varargin{:});
                assert(iscell(c.getGroupValue()) & ...
                    isequal(size(c.getGroupValue()), [1, group.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getGroupValue())), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(iscell(c.getRandomValue()) & ...
                    isequal(size(c.getRandomValue()), [1, group.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getRandomValue())), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                
                c.average_value_group = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'RandomComparisonDTI.average_values_1', ...
                    varargin{:});
                c.average_value_random = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'RandomComparisonDTI.average_values_2', ...
                    varargin{:});
                assert(isequal(size(c.getAverageValue()), [atlas.getBrainRegions().length(), 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getAverageRandomValue()), [atlas.getBrainRegions().length(), 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                
                % statistic values
                c.difference = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'RandomComparisonDTI.difference', ...
                    varargin{:});
                c.all_differences = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, number_of_permutations), ...
                    'RandomComparisonDTI.all_differences', ...
                    varargin{:});
                c.p1 = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'RandomComparisonDTI.p1', ...
                    varargin{:});
                c.p2 = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'RandomComparisonDTI.p2', ...
                    varargin{:});
                c.confidence_interval_min = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'RandomComparisonDTI.confidence_min', ...
                    varargin{:});
                c.confidence_interval_max = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'RandomComparisonDTI.confidence_max', ...
                    varargin{:});
                
                assert(isequal(size(c.getDifference()), [atlas.getBrainRegions().length(), 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getAllDifferences()), [1, number_of_permutations]), ...  % it should be like this currently the second dimension is expanding depending on modality.
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getP1()), [atlas.getBrainRegions().length(), 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getP2()), [atlas.getBrainRegions().length(), 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getConfidenceIntervalMin()), [atlas.getBrainRegions().length(), 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getConfidenceIntervalMax()), [atlas.getBrainRegions().length(), 1]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                
            elseif Measure.is_binodal(c.getMeasureCode())  % binodal measure
                c.values_group = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, group.subjectnumber()), ...
                    'RandomComparisonDTI.values_group', ...
                    varargin{:});
                c.values_random = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, group.subjectnumber()), ...
                    'RandomComparisonDTI.values_random', ...
                    varargin{:});
                assert(iscell(c.getGroupValue()) & ...
                    isequal(size(c.getGroupValue()), [1, group.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getGroupValue())), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(iscell(c.getRandomValue()) & ...
                    isequal(size(c.getRandomValue()), [1, group.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getRandomValue())), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                
                c.average_value_group = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'RandomComparisonDTI.average_values_1', ...
                    varargin{:});
                c.average_value_random = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'RandomComparisonDTI.average_values_2', ...
                    varargin{:});
                assert(isequal(size(c.getAverageValue()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getAverageRandomValue()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                
                % statistic values
                c.difference = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'RandomComparisonDTI.difference', ...
                    varargin{:});
                c.all_differences = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, number_of_permutations), ...
                    'RandomComparisonDTI.all_differences', ...
                    varargin{:});
                c.p1 = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'RandomComparisonDTI.p1', ...
                    varargin{:});
                c.p2 = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'RandomComparisonDTI.p2', ...
                    varargin{:});
                c.confidence_interval_min = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'RandomComparisonDTI.confidence_min', ...
                    varargin{:});
                c.confidence_interval_max = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'RandomComparisonDTI.confidence_max', ...
                    varargin{:});
                
                assert(isequal(size(c.getDifference()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getAllDifferences()), [1, number_of_permutations]), ...  % it should be like this currently the second dimension is expanding depending on modality.
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getP1()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getP2()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getConfidenceIntervalMin()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
                assert(isequal(size(c.getConfidenceIntervalMax()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                    ['BRAPH:RandomComparisonDTI:WrongData'], ...
                    ['Data not compatible with RandomComparisonDTI.'])
            end
        end
    end
    methods (Static)
        function measurementClass = getClass(c) %#ok<*INUSD>
            measurementClass = 'RandomComparisonDTI';
        end
        function name = getName(c)
            name = 'RandomComparison DTI';
        end
        function description = getDescription(c)
            % comparison description missing
            description = '';
        end
        function atlas_number = getBrainAtlasNumber(c)
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass(c)
            analysis_class = 'AnalysisDTI';
        end
        function subject_class = getSubjectClass(c)
            subject_class = 'SubjectDTI';
        end
        function sub = getComparison(comparisonClass, id, atlas, group, varargin)
            sub = eval([comparisonClass '(id, atlas, group, varargin{:})']);
        end
    end
end
% test RandomComparisonCON_BUT

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

subject_class = RandomComparison.getSubjectClass('RandomComparisonCON_BUT');

sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlas);
sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlas);
sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlas);
sub4 = Subject.getSubject(subject_class, 'id4', 'label 4', 'notes 4', atlas);
sub5 = Subject.getSubject(subject_class, 'id5', 'label 5', 'notes 5', atlas);
group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3, sub4, sub5});

graph_type = AnalysisCON_WU.getGraphType();
measures = Graph.getCompatibleMeasureList(graph_type);

%% Test 1: Instantiation
for i = 1:1:numel(measures)
    randomcomparison = RandomComparisonCON_BUT('rc1', 'label', 'notes', atlas,  measures{i}, group);    
end

%% Test 2: Correct Size defaults
for i = 1:1:numel(measures)
    number_of_randomizations = 10;
    
    randomcomparison = RandomComparisonCON_BUT('rc1', 'label', 'notes', atlas,  measures{i}, group, 'RandomComparisonCON.RandomizationNumber', number_of_randomizations);
    
    value_group = randomcomparison.getGroupValue();    
    value_random = randomcomparison.getRandomValue();
    average_group = randomcomparison.getAverageValue();
    average_random = randomcomparison.getAverageRandomValue();
    difference = randomcomparison.getDifference();  % difference
    all_differences = randomcomparison.getAllDifferences(); % all differences obtained through the permutation test
    p1 = randomcomparison.getP1(); % p value single tailed
    p2 = randomcomparison.getP2();  % p value double tailed
    confidence_interval_min = randomcomparison.getConfidenceIntervalMin();  % min value of the 95% confidence interval
    confidence_interval_max = randomcomparison.getConfidenceIntervalMax(); % max value of the 95% confidence interval

    if Measure.is_global(measures{i})
        
        assert(iscell(value_group) && ...
            isequal(numel(value_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), value_group)),  ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
                
        assert(iscell(value_random) && ...
            isequal(numel(value_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), value_random)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
 
        assert(iscell(average_group) && ...
            isequal(numel(average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), average_group)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(average_random) && ...
            isequal(numel(average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), average_random)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(difference) && ...
            isequal(numel(difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), difference)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')

        assert(iscell(all_differences) && ...
            isequal(numel(all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), all_differences)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')

        assert(iscell(p1) && ...
            isequal(numel(p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), p1)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(p2) && ...
            isequal(numel(p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), p2)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(confidence_interval_min) && ...
            isequal(numel(confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')

        assert(iscell(confidence_interval_max) && ...
            isequal(numel(confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
    elseif Measure.is_nodal(measures{i})
        
        assert(iscell(value_group) && ...
            isequal(numel(value_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), value_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(value_random) && ...
            isequal(numel(value_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), value_random)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(average_group) && ...
            isequal(numel(average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), average_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(average_random) && ...
            isequal(numel(average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), average_random)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(difference) && ...
            isequal(numel(difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), difference)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')

        assert(iscell(all_differences) && ...
            isequal(numel(all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), all_differences)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')

        assert(iscell(p1) && ...
            isequal(numel(p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), p1)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(p2) && ...
            isequal(numel(p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), p2)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(confidence_interval_min) && ...
            isequal(numel(confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')

        assert(iscell(confidence_interval_max) && ...
            isequal(numel(confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
    elseif Measure.is_binodal(measures{i})
      
        assert(iscell(value_group) && ...
            isequal(numel(value_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), value_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(value_random) && ...
            isequal(numel(value_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), value_random)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(average_group) && ...
            isequal(numel(average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), average_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(average_random) && ...
            isequal(numel(average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), average_random)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(difference) && ...
            isequal(numel(difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), difference)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')

        assert(iscell(all_differences) && ...
            isequal(numel(all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), all_differences)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')

        assert(iscell(p1) && ...
            isequal(numel(p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), p1)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(p2) && ...
            isequal(numel(p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), p2)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(confidence_interval_min) && ...
            isequal(numel(confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')

        assert(iscell(confidence_interval_max) && ...
            isequal(numel(confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
    end
end

%% Test 3: Initialize with values
for i = 1:1:numel(measures)
    % setup
    number_of_randomizations = 10;
    
    % the values are not realistic, just the right format
    for j = 1:1:group.subjectnumber()
        A = rand(atlas.getBrainRegions().length());
        g = Graph.getGraph('GraphWU', A);
        m  = Measure.getMeasure(measures{i}, g);
        values{j} =  cell2mat(m.getValue()); %#ok<SAGROW>
    end
    
    average_values = {mean(reshape(cell2mat(values), [size(values{1}, 1), size(values{1}, 2), group.subjectnumber()]), 3)};
    
    difference  = average_values;
    all_differences = repmat(values(1), 1, number_of_randomizations);
    p1 = difference;  % all similar
    p2 = difference;
    confidence_interval_min = difference;
    confidence_interval_max = difference;
    
        % act
    random_comparison = RandomComparisonCON_BUT('rc1', ...
        'rcomparison label', ...
        'rcomparison notes', ...
        atlas, ...
        measures{i}, ...
        group, ...
        group, ...
        'RandomComparisonCON.RandomizationNumber', number_of_randomizations, ...
        'RandomComparisonCON.value_group', values, ...
        'RandomComparisonCON.value_random', values, ...
        'RandomComparisonCON.average_value_group', average_values, ...
        'RandomComparisonCON.average_value_random', average_values, ...
        'RandomComparisonCON.difference', difference, ...
        'RandomComparisonCON.all_differences', all_differences, ...
        'RandomComparisonCON.p1', p1, ...
        'RandomComparisonCON.p2', p2, ....
        'RandomComparisonCON.confidence_min', confidence_interval_min, ...
        'RandomComparisonCON.confidence_max', confidence_interval_max ...
        );
    
    randomcomparison_value_group = random_comparison.getGroupValue();
    randomcomparison_value_random = random_comparison.getRandomValue();
    randomcomparison_average_group = random_comparison.getAverageValue();
    randomcomparison_average_random = random_comparison.getAverageRandomValue();
    randomcomparison_difference = random_comparison.getDifference();
    randomcomparison_all_differences = random_comparison.getAllDifferences();
    randomcomparison_p1 = random_comparison.getP1();
    randomcomparison_p2 = random_comparison.getP2();
    randomcomparison_confidence_interval_min = random_comparison.getConfidenceIntervalMin();
    randomcomparison_confidence_interval_max = random_comparison.getConfidenceIntervalMax();
    
    % assert
    if Measure.is_global(measures{i})
        assert(iscell(randomcomparison_value_group) && ...
            isequal(numel(randomcomparison_value_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_value_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(randomcomparison_value_random) && ...
            isequal(numel(randomcomparison_value_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_value_random)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(randomcomparison_average_group) && ...
            isequal(numel(randomcomparison_average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_average_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(randomcomparison_average_random) && ...
            isequal(numel(randomcomparison_average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_average_random)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
       
        assert(iscell(randomcomparison_difference) && ...
            isequal(numel(randomcomparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_difference)), ...        
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(randomcomparison_all_differences) && ...
            isequal(numel(randomcomparison_all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_all_differences)), ...        
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(randomcomparison_p1) && ...
            isequal(numel(randomcomparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_p1)), ...        
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')

        assert(iscell(randomcomparison_p2) && ...
            isequal(numel(randomcomparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_p2)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
        assert(iscell(randomcomparison_confidence_interval_min) && ...
            isequal(numel(randomcomparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')

        assert(iscell(randomcomparison_confidence_interval_max) && ...
            isequal(numel(randomcomparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with global measures')
        
    elseif Measure.is_nodal(measures{i})
       
       assert(iscell(randomcomparison_value_group) && ...
            isequal(numel(randomcomparison_value_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_value_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(randomcomparison_value_random) && ...
            isequal(numel(randomcomparison_value_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_value_random)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(randomcomparison_average_group) && ...
            isequal(numel(randomcomparison_average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_average_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(randomcomparison_average_random) && ...
            isequal(numel(randomcomparison_average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_average_random)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(randomcomparison_difference) && ...
            isequal(numel(randomcomparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_difference)), ...        
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(randomcomparison_all_differences) && ...
            isequal(numel(randomcomparison_all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_all_differences)), ...        
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(randomcomparison_p1) && ...
            isequal(numel(randomcomparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_p1)), ...        
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')

        assert(iscell(randomcomparison_p2) && ...
            isequal(numel(randomcomparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_p2)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
        assert(iscell(randomcomparison_confidence_interval_min) && ...
            isequal(numel(randomcomparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')

        assert(iscell(randomcomparison_confidence_interval_max) && ...
            isequal(numel(randomcomparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with nodal measures')
        
    elseif Measure.is_binodal(measures{i})
 
      assert(iscell(randomcomparison_value_group) && ...
            isequal(numel(randomcomparison_value_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_value_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(randomcomparison_value_random) && ...
            isequal(numel(randomcomparison_value_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_value_random)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
 
        assert(iscell(randomcomparison_average_group) && ...
            isequal(numel(randomcomparison_average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_average_group)) , ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(randomcomparison_average_random) && ...
            isequal(numel(randomcomparison_average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_average_random)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(randomcomparison_difference) && ...
            isequal(numel(randomcomparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_difference)), ...        
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(randomcomparison_all_differences) && ...
            isequal(numel(randomcomparison_all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_all_differences)), ...        
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(randomcomparison_p1) && ...
            isequal(numel(randomcomparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_p1)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'ComparisonMRI does not initialize correctly with binodal measures')

        assert(iscell(randomcomparison_p2) && ...
            isequal(numel(randomcomparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_p2)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')
        
        assert(iscell(randomcomparison_confidence_interval_min) && ...
            isequal(numel(randomcomparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')

        assert(iscell(randomcomparison_confidence_interval_max) && ...
            isequal(numel(randomcomparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonCON_BUT:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonCON_BUT does not initialize correctly with binodal measures')        
    end 
end
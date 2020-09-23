% test AnalysisCON_WU

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

sub11 = SubjectCON('ID11', 'label 11', 'notes 11', atlas, 'age', 20, 'CON', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub12 = SubjectCON('ID12', 'label 12', 'notes 12', atlas, 'age', 20, 'CON', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub13 = SubjectCON('ID13', 'label 13', 'notes 13', atlas, 'age', 20, 'CON', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub14 = SubjectCON('ID14', 'label 14', 'notes 14', atlas, 'age', 20, 'CON', .5 + .5 * rand(atlas.getBrainRegions().length()));

group1 = Group('SubjectCON', 'group 1 id', 'group 1 label', 'group 1 notes', {sub11, sub12, sub13, sub14}, 'GroupName', 'GroupTestCON1');

sub21 = SubjectCON('ID21', 'label 21', 'notes 21', atlas, 'age', 20, 'CON', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub22 = SubjectCON('ID22', 'label 22', 'notes 22', atlas, 'age', 20, 'CON', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub23 = SubjectCON('ID23', 'label 23', 'notes 23', atlas, 'age', 20, 'CON', .5 + .5 * rand(atlas.getBrainRegions().length()));

group2 = Group('SubjectCON', 'group 2 id', 'group 2 label', 'group 2 notes', {sub21, sub22, sub23}, 'GroupName', 'GroupTestCON2');

cohort = Cohort('Cohort CON', 'cohort label', 'cohort notes', 'SubjectCON', atlas, {sub11, sub12, sub13, sub14, sub21, sub22, sub23});
cohort.getGroups().add(group1.getID(), group1)
cohort.getGroups().add(group2.getID(), group2)

graph_type = AnalysisCON_WU.getGraphType();
measures = Graph.getCompatibleMeasureList(graph_type);

%% Test 1: Instantiation
analysis = AnalysisCON_WU('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {}); %#ok<NASGU>

%% Test 2: Create correct ID
analysis = AnalysisCON_WU('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});

measurement_id = analysis.getMeasurementID('Degree', group1);
expected_value = [ ...
    tostring(analysis.getMeasurementClass()) ' ' ...
    tostring('Degree') ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group1)) ...
    ];
assert(ischar(measurement_id), ...
    [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
    'AnalysisCON_WU.getMeasurementID() not creating an ID')
assert(isequal(measurement_id, expected_value), ...
    [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
    'AnalysisCON_WU.getMeasurementID() not creating correct ID')

comparison_id = analysis.getComparisonID('Distance', group1, group2);
expected_value = [ ...
    tostring(analysis.getComparisonClass()) ' ' ...
    tostring('Distance') ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group1)) ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group2)) ...
    ];
assert(ischar(comparison_id), ...
    ['BRAPH:AnalysisCON_WU:getComparisonID'], ...
    ['AnalysisCON_WU.getComparisonID() not creating an ID']) %#ok<*NBRAK>
assert(isequal(comparison_id, expected_value), ...
    ['BRAPH:AnalysisCON_WU:getComparisonID'], ...
    ['AnalysisCON_WU.getComparisonID() not creating correct ID']) %#ok<*NBRAK>

randomcomparison_id = analysis.getRandomComparisonID('PathLength', group1);
expected_value = [ ...
    tostring(analysis.getRandomComparisonClass()) ' ' ...
    tostring('PathLength') ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group1)) ...
    ];
assert(ischar(randomcomparison_id), ...
    ['BRAPH:AnalysisCON_WU:getRandomComparisonID'], ...
    ['AnalysisCON_WU.getRandomComparisonID() not creating an ID']) %#ok<*NBRAK>
assert(isequal(randomcomparison_id, expected_value), ...
    ['BRAPH:AnalysisCON_WU:getRandomComparisonID'], ...
    ['AnalysisCON_WU.getRandomComparisonID() not creating correct ID']) %#ok<*NBRAK>

%% Test 3: Calculate Measurement
for i = 1:1:length(measures)
    measure = measures{i};
    analysis = AnalysisCON_WU('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});
    calculated_measurement = analysis.getMeasurement(measure, group1);
    
    assert(~isempty(calculated_measurement), ...
        [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.BUG_FUNC], ...
        ['AnalysisCON_WU.getMeasurement() not working']) %#ok<*NBRAK>
    
    measurement_keys = analysis.getMeasurements().getKeys();
    
    for j = 1:1:numel(measurement_keys)
        calculated_measurement = analysis.getMeasurements().getValue(measurement_keys{j});
        calculated_value = calculated_measurement.getMeasureValues();
        calculted_average = calculated_measurement.getGroupAverageValue();
        
        if Measure.is_global(measure)
            
            assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
                [BRAPH2.STR ':AnalysisCON_WU:calculateMeasurement'], ...
                ['AnalysisCON_WU.calculateMeasurement() not working for global']) %#ok<*NBRAK>
            assert(iscell(calculated_value) & ...
                isequal(numel(calculated_value), group1.subjectnumber) & ...
                all(cellfun(@(x) isequal(size(x), [1, 1]), calculated_value)), ...
                [BRAPH2.STR ':AnalysisCON_WU:Instantiation'], ...
                ['AnalysisCON_WU does not initialize correctly with global measures.']) %#ok<*NBRAK>
            assert(isequal(size(calculted_average), [1 1]), ...
                [BRAPH2.STR ':AnalysisCON_WU:Instantiation'], ...
                ['AnalysisCON_WU does not initialize correctly with global measures.']) %#ok<*NBRAK>
            
        elseif Measure.is_nodal(measure)
            
            assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
                [BRAPH2.STR ':AnalysisCON_WU:calculateMeasurement'], ...
                ['AnalysisCON_WU.calculateMeasurement() not working for nodal']) %#ok<*NBRAK>
            assert(iscell(calculated_value) & ...
                isequal(numel(calculated_value), group1.subjectnumber) & ...
                all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), calculated_value)), ...
                [BRAPH2.STR ':AnalysisCON_WU:Instantiation'], ...
                ['AnalysisCON_WU does not initialize correctly with nodal measures.']) %#ok<*NBRAK>
            assert(isequal(size(calculted_average), [atlas.getBrainRegions().length(), 1]), ...
                [BRAPH2.STR ':AnalysisCON_WU:Instantiation'], ...
                ['AnalysisCON_WU does not initialize correctly with nodal measures.']) %#ok<*NBRAK>
            
        elseif Measure.is_binodal(measure)
            
            assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
                [BRAPH2.STR ':AnalysisCON_WU:calculateMeasurement'], ...
                ['AnalysisCON_WU.calculateMeasurement() not working for binodal']) %#ok<*NBRAK>
            assert(iscell(calculated_value) & ...
                isequal(numel(calculated_value), group1.subjectnumber) & ...
                all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), calculated_value)), ...
                [BRAPH2.STR ':AnalysisCON_WU:Instantiation'], ...
                ['MeasurementCON does not initialize correctly with binodal measures.']) %#ok<*NBRAK>
            assert(isequal(size(calculted_average), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
                [BRAPH2.STR ':AnalysisCON_WU:Instantiation'], ...
                ['MeasurementCON does not initialize correctly with binodal measures.']) %#ok<*NBRAK>
        end
    end
end

%% Test 4 RandomCompare
for i = 1:1:numel(measures)
measure = measures{i};
    analysis = AnalysisCON_WU('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});
    group = group1;
      
    number_of_randomizations = 10;
    calculated_randomcomparison = analysis.getRandomComparison(measure, group, 'RandomizationNumber', number_of_randomizations);
    
    assert(~isempty(calculated_randomcomparison), ...
        [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.BUG_FUNC], ...
        'AnalysisCON_WU.getComparison() not working')
    
    assert(analysis.getRandomComparisons().length() == 1, ...
        [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.BUG_FUNC], ...
        'AnalysisCON_WU.getRandomComparisons() not working')
    
    randomComparison = analysis.getRandomComparisons().getValue(1);
    randomComparison_values_group = randomComparison.getGroupValue();
    randomComparison_values_random = randomComparison.getRandomValue();
    randomcomparison_average_group = randomComparison.getAverageValue();
    randomcomparison_average_random = randomComparison.getAverageRandomValue();
    randomcomparison_difference = randomComparison.getDifference();
    randomcomparison_all_differences = randomComparison.getAllDifferences();
    randomcomparison_p1 = randomComparison.getP1();
    randomcomparison_p2 = randomComparison.getP2();
    randomcomparison_confidence_interval_min = randomComparison.getConfidenceIntervalMin();
    randomcomparison_confidence_interval_max = randomComparison.getConfidenceIntervalMax();
    
    if Measure.is_global(measures{i})
   
        assert(iscell(randomComparison_values_group) && ...
            isequal(numel(randomComparison_values_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomComparison_values_group)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(randomComparison_values_random) && ...
            isequal(numel(randomComparison_values_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomComparison_values_random)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(randomcomparison_average_group) && ...
            isequal(numel(randomcomparison_average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_average_group)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(randomcomparison_average_random) && ...
            isequal(numel(randomcomparison_average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_average_random)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(randomcomparison_difference) && ...
            isequal(numel(randomcomparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_difference)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(randomcomparison_all_differences) && ...
            isequal(numel(randomcomparison_all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(randomcomparison_p1) && ...
            isequal(numel(randomcomparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_p1)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 

        assert(iscell(randomcomparison_p2) && ...
            isequal(numel(randomcomparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_p2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(randomcomparison_confidence_interval_min) && ...
            isequal(numel(randomcomparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 

        assert(iscell(randomcomparison_confidence_interval_max) && ...
            isequal(numel(randomcomparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), randomcomparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
    elseif Measure.is_nodal(measures{i})

        assert(iscell(randomComparison_values_group) && ...
            isequal(numel(randomComparison_values_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomComparison_values_group)) , ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(randomComparison_values_random) && ...
            isequal(numel(randomComparison_values_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomComparison_values_random)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 

        assert(iscell(randomcomparison_average_group) && ...
            isequal(numel(randomcomparison_average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_average_group)) , ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(randomcomparison_average_random) && ...
            isequal(numel(randomcomparison_average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_average_random)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(randomcomparison_difference) && ...
            isequal(numel(randomcomparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_difference)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(randomcomparison_all_differences) && ...
            isequal(numel(randomcomparison_all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures')  
        
        assert(iscell(randomcomparison_p1) && ...
            isequal(numel(randomcomparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_p1)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 

        assert(iscell(randomcomparison_p2) && ...
            isequal(numel(randomcomparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_p2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(randomcomparison_confidence_interval_min) && ...
            isequal(numel(randomcomparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 

        assert(iscell(randomcomparison_confidence_interval_max) && ...
            isequal(numel(randomcomparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), randomcomparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
    elseif Measure.is_binodal(measures{i})

        assert(iscell(randomComparison_values_group) && ...
            isequal(numel(randomComparison_values_group), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomComparison_values_group)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(randomComparison_values_random) && ...
            isequal(numel(randomComparison_values_random), group.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomComparison_values_random)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures')  

        assert(iscell(randomcomparison_average_group) && ...
            isequal(numel(randomcomparison_average_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_average_group)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(randomcomparison_average_random) && ...
            isequal(numel(randomcomparison_average_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_average_random)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures')  
        
        assert(iscell(randomcomparison_difference) && ...
            isequal(numel(randomcomparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_difference)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(randomcomparison_all_differences) && ...
            isequal(numel(randomcomparison_all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(randomcomparison_p1) && ...
            isequal(numel(randomcomparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_p1)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 

        assert(iscell(randomcomparison_p2) && ...
            isequal(numel(randomcomparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_p2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(randomcomparison_confidence_interval_min) && ...
            isequal(numel(randomcomparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 

        assert(iscell(randomcomparison_confidence_interval_max) && ...
            isequal(numel(randomcomparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), randomcomparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
    end    
end

%% Test 5: Compare
for i = 1:1:numel(measures)
    measure = measures{i};
    analysis = AnalysisCON_WU('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});
      
    number_of_permutations = 10;
    calculated_comparison = analysis.getComparison(measure, group1, group2, 'PermutationNumber', number_of_permutations);
    
    assert(~isempty(calculated_comparison), ...
        [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.BUG_FUNC], ...
        'AnalysisCON_WU.getComparison() not working')
    
    assert(analysis.getComparisons().length() == 1, ...
        [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.BUG_FUNC], ...
        'AnalysisCON_WU.getComparison() not working')
    
    comparison = analysis.getComparisons().getValue(1);
    comparison_values_1 = comparison.getGroupValue(1);
    comparison_values_2 = comparison.getGroupValue(2);
    comparison_average_1 = comparison.getGroupAverageValue(1);
    comparison_average_2 = comparison.getGroupAverageValue(2);
    comparison_difference = comparison.getDifference();
    comparison_all_differences = comparison.getAllDifferences();
    comparison_p1 = comparison.getP1();
    comparison_p2 = comparison.getP2();
    comparison_confidence_interval_min = comparison.getConfidenceIntervalMin();
    comparison_confidence_interval_max = comparison.getConfidenceIntervalMax();
    
    if Measure.is_global(measures{i})
   
        assert(iscell(comparison_values_1) && ...
            isequal(numel(comparison_values_1), group1.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_values_1)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(comparison_values_2) && ...
            isequal(numel(comparison_values_2), group2.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_values_2)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(comparison_average_1) && ...
            isequal(numel(comparison_average_1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_average_1)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(comparison_average_2) && ...
            isequal(numel(comparison_average_2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_average_2)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(comparison_difference) && ...
            isequal(numel(comparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_difference)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(comparison_all_differences) && ...
            isequal(numel(comparison_all_differences), number_of_permutations) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(comparison_p1) && ...
            isequal(numel(comparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_p1)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 

        assert(iscell(comparison_p2) && ...
            isequal(numel(comparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_p2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
        assert(iscell(comparison_confidence_interval_min) && ...
            isequal(numel(comparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 

        assert(iscell(comparison_confidence_interval_max) && ...
            isequal(numel(comparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with global measures') 
        
    elseif Measure.is_nodal(measures{i})

        assert(iscell(comparison_values_1) && ...
            isequal(numel(comparison_values_1), group1.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_values_1)) , ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(comparison_values_2) && ...
            isequal(numel(comparison_values_2), group2.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_values_2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 

        assert(iscell(comparison_average_1) && ...
            isequal(numel(comparison_average_1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_average_1)) , ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(comparison_average_2) && ...
            isequal(numel(comparison_average_2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_average_2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(comparison_difference) && ...
            isequal(numel(comparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_difference)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(comparison_all_differences) && ...
            isequal(numel(comparison_all_differences), number_of_permutations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures')  
        
        assert(iscell(comparison_p1) && ...
            isequal(numel(comparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_p1)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 

        assert(iscell(comparison_p2) && ...
            isequal(numel(comparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_p2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
        assert(iscell(comparison_confidence_interval_min) && ...
            isequal(numel(comparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 

        assert(iscell(comparison_confidence_interval_max) && ...
            isequal(numel(comparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with nodal measures') 
        
    elseif Measure.is_binodal(measures{i})

        assert(iscell(comparison_values_1) && ...
            isequal(numel(comparison_values_1), group1.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_values_1)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(comparison_values_2) && ...
            isequal(numel(comparison_values_2), group2.subjectnumber()) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_values_2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures')  

        assert(iscell(comparison_average_1) && ...
            isequal(numel(comparison_average_1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_average_1)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(comparison_average_2) && ...
            isequal(numel(comparison_average_2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_average_2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures')  
        
        assert(iscell(comparison_difference) && ...
            isequal(numel(comparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_difference)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(comparison_all_differences) && ...
            isequal(numel(comparison_all_differences), number_of_permutations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(comparison_p1) && ...
            isequal(numel(comparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_p1)), ...        
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 

        assert(iscell(comparison_p2) && ...
            isequal(numel(comparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_p2)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
        
        assert(iscell(comparison_confidence_interval_min) && ...
            isequal(numel(comparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 

        assert(iscell(comparison_confidence_interval_max) && ...
            isequal(numel(comparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisCON_WU:' BRAPH2.WRONG_OUTPUT], ...
            'AnalysisCON_WU.getComparison() not working with binodal measures') 
    end    
end

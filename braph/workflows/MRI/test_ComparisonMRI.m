% test ComparisionMRI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

subject_class = Comparison.getSubjectClass('ComparisonMRI');

sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
group = Group(subject_class, {sub1, sub2, sub3});

measures = {'Assortativity', 'Degree', 'Distance'};

%% Test 1: Instantiation
for i = 1:1:numel(measures)
    comparison = ComparisonMRI('c1', atlas, {group group}, 'ComparisonMRI.measure_code', measures{i});
    
    assert(~isempty(comparison), ...
        ['BRAPH:ComparisionDTI:Instantiation'], ...
        ['ComparisionDTI does not initialize correctly.']) %#ok<*NBRAK>
end

%% Test 2: Correct Size defaults
for i = 1:1:numel(measures)
    number_of_permutations = 10;
    
    comparison = ComparisonDTI('c1', atlas, {group group}, 'ComparisonDTI.measure_code', measures{i}, 'ComparisonDTI.number_of_permutations', number_of_permutations);
    
    value_1 = comparison.getGroupValue(1);    
    value_2 = comparison.getGroupValue(2);
    all_differences = comparison.getAllDifferences(); % all differences obtained through the permutation test

    if Measure.is_global(measures{i})
        assert(iscell(value_1) & ...
            isequal(numel(value_1), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), value_1)) & ...
            iscell(value_2) & ...
            isequal(numel(value_2), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), value_2)), ...
            ['BRAPH:ComparisonDTI:Instantiation'], ...
            ['ComparisonDTI does not initialize correctly with global measures.']) %#ok<*NBRAK>
        assert(isequal(numel(all_differences), number_of_permutations), ...
            ['BRAPH:ComparisonDTI:Instantiation'], ...
            ['ComparisonDTI does not initialize correctly with global measures.']) %#ok<*NBRAK>
    elseif Measure.is_nodal(measures{i})
        assert(iscell(value_1) & ...
            isequal(numel(value_1), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), value_1)) & ...
            iscell(value_2) & ...
            isequal(numel(value_2), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), value_2)) , ...
            ['BRAPH:ComparisonDTI:Instantiation'], ...
            ['ComparisonDTI does not initialize correctly with nodal measures.']) %#ok<*NBRAK>
        assert(isequal(size(all_differences), [1, number_of_permutations]) , ...
            ['BRAPH:ComparisonDTI:Instantiation'], ...
            ['ComparisonDTI does not initialize correctly with nodal measures.']) %#ok<*NBRAK>
    elseif Measure.is_binodal(measures{i})
        assert(iscell(value_1) & ...
            isequal(numel(value_1), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), value_1)) & ...
            iscell(value_2) & ...
            isequal(numel(value_2), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), value_2)), ...
            ['BRAPH:ComparisonDTI:Instantiation'], ...
            ['ComparisonDTI does not initialize correctly with binodal measures.']) %#ok<*NBRAK>
        assert(isequal(size(all_differences), [1, number_of_permutations]), ...
            ['BRAPH:ComparisonDTI:Instantiation'], ...
            ['ComparisonDTI does not initialize correctly with binodal measures.']) %#ok<*NBRAK>
    end
end

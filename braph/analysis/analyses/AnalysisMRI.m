classdef AnalysisMRI < Analysis
    methods
        function analysis = AnalysisMRI(cohort, measurements, randomcomparisons, comparisons, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisMRI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectMRI';
        end
        function name = getName()
            name = 'Analysis Structural MRI';
        end
        function description = getDescription()
            description = [ ...
                'Analysis based on structural MRI data, ' ...
                'such as cortical thickness for each brain region' ...
                ];
        end
        function measurmentList = getMeasurementClass()
            measurmentList =  'MeasurementMRI'; % excludeSuffix('fmri', 'Measurement', Measurement.getList());
        end
        function randomcomparisonList = getRandomComparisonClass()
            randomcomparisonList = 'RandomComparisonMRI';  %e xcludeSuffix('fmri', 'RandomComparison', RandomComparison.getList());
        end
        function comparisonList = getComparisonClass()           
            comparisonList = 'ComparisonMRI';  % excludeSuffix('fmri', 'Comparison', Comparison.getList());
        end
    end
end
classdef MeasurementMultiplexMRI < Measurement
    % single group of mri subjects
    properties
        value  % value of the measure for the group
    end
    methods  % Constructor
        function m =  MeasurementMultiplexMRI(id, label, notes, atlas, group, varargin)
            
            m = m@Measurement(id, label, notes, atlas, group, varargin{:});
        end
    end
    methods  % Get functions
        function value = getMeasureValue(m)
            value = m.value;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            measure_code = m.getSettings('MeasurementMultiplexMRI.MeasureCode');
            
            if Measure.is_global(measure_code)  % global measure
                m.value = get_from_varargin( ...
                    repmat({0}, 1, 1), ...  % 1 measure per group
                    'MeasurementMultiplexMRI.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) & ...
                    isequal(size(m.getMeasureValue()), [1, 1]) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementMultiplexMRI:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementMultiplexMRI')
            elseif Measure.is_nodal(measure_code)  % nodal measure
                m.value = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, 1), ...
                    'MeasurementMultiplexMRI.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) & ...
                    isequal(size(m.getMeasureValue()), [1, 1]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementMultiplexMRI:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementMultiplexMRI')
            elseif Measure.is_binodal(measure_code)  % binodal measure
                m.value = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, 1), ...
                    'MeasurementMultiplexMRI.Value', ...
                    varargin{:});
                assert(iscell(m.getMeasureValue()) & ...
                    isequal(size(m.getMeasureValue()), [1, 1]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), m.getMeasureValue())), ...
                    [BRAPH2.STR ':MeasurementMultiplexMRI:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with MeasurementMultiplexMRI')
            end
        end
    end
    methods (Static)
        function class = getClass()
            class = 'MeasurementMultiplexMRI';
        end
        function name = getName()
            name = 'Measurement multiplex MRI';
        end
        function description = getDescription()
            description = 'Multiplex MRI measurement.';
        end
        function atlas_number = getBrainAtlasNumber()
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass()
            % measurement analysis class
            analysis_class = 'AnalysisMultiplexMRI';
        end
        function subject_class = getSubjectClass()
            % measurement subject class
            subject_class = 'SubjectMultiplexMRI';
        end        
        function available_settings = getAvailableSettings()
% TODO: get graph type from Analysis
            graph_type = 'GraphWU';
            measure_list = Graph.getCompatibleMeasureList(graph_type);
            
            available_settings = {
                'MeasurementMultiplexMRI.MeasureCode', BRAPH2.STRING, measure_list{1}, measure_list;
                };
        end
        function m = getMeasurement(measurement_class, id, label, notes, atlas, group, varargin) %#ok<INUSD>
            m = eval([measurement_class '(id, atlas, label, notes, group, varargin{:})']);
        end
    end
end
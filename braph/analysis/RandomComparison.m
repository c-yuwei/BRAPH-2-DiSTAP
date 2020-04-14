classdef RandomComparison < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        group  % group
        atlases  % cell array with brain atlases
        settings  % settings of the RandomComparison
        data_dict  % dictionary with data for RandomComparisons
    end
    methods (Access = protected)
        function rc = RandomComparison(id, atlases, group, varargin)            
            rc.id = tostring(id);
            
            assert(iscell(atlases), ...
                ['BRAPH:RandomComparison:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects']) %#ok<NBRAK>
            rc.atlases = atlases;
            
            assert(isa(group, 'Group'), ...
                ['BRAPH:RandomComparison:GroupErr'], ...
                ['The input must be a Group object']) %#ok<NBRAK>
            rc.group = group;
            
            rc.settings = get_from_varargin(varargin, 'RandomComparisonSettings', varargin{:});
            
            rc.initialize_datadict(atlases, group, varargin{:});
            
            data_codes = rc.getDataCodes();
            for i = 1:1:numel(data_codes)
                data_code = data_codes{i};
                value = get_from_varargin(rc.getData(data_code).getValue, ...
                    data_code, varargin);
                rc.getData(data_code).setValue(value);
            end
        end
        function randomcomparison_copy = copyElement(rc)
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            randomcomparison_copy = copyElement@matlab.mixin.Copyable(rc);
            
            % Make a deep copy of datadict
            randomcomparison_copy.data_dict = containers.Map;
            data_codes = keys(rc.data_dict);
            for i = 1:1:length(data_codes)
                data_code = data_codes{i};
                d = rc.getData(data_code);
                randomcomparison_copy.datadict(data_code) = d.copy();
            end
        end
    end
    methods (Abstract, Access = protected)
        initialize_datadict(rc, varargin)  % initialize datadict
        update_brainatlas(rc, atlases)  % updates brainatlases
        update_groups(rc, groups)  % updates groups
    end
    methods
        function id = getID(m)
            id = m.id;
        end
        function str = tostring(rc)
            str = [RandomComparison.getClass(rc)]; %#ok<NBRAK>
        end
        function disp(rc)
            disp(['<a href="matlab:help ' RandomComparison.getClass(rc) '">' RandomComparison.getClass(rc) '</a>'])
            data_codes = rc.getDataCodes();
            for i = 1:1:rc.getDataNumber()
                data_code = data_codes{i};
                d = rc.getData(data_code);
                disp([data_code ' = ' d.tostring()])
            end
        end
        function d = getData(rc, data_code)
            d = rc.data_dict(data_code);
        end
        function setBrainAtlases(rc, atlases)
            % adds a atlas to the end of the cell array
            rc.update_brainatlases(atlases);
        end
        function setGroups(rc, groups)
            rc.update_groups(groups);
        end
        function atlases = getBrainAtlases(rc)
            atlases = rc.atlases;
        end
        function groups = getGroups(rc)
            groups = rc.groups;
        end
    end
    methods (Static)
        function randomComparisonList = getList()
            randomComparisonList = subclasses( ...
                'RandomComparison', ...
                [fileparts(which('RandomComparison'))  filesep 'randomcomparisons'] ...
                );
        end
        function atlas_number = getBrainAtlasNumber(rc)
            atlas_number =  eval([RandomComparison.getClass(rc) '.getBrainAtlasNumber()']);
        end
        function group_number = getGroupNumber(rc)
            group_number =  eval([RandomComparison.getClass(rc) '.getGroupNumber()']);
        end
        function RandomComparisonClass = getClass(rc)
            if isa(rc, 'RandomComparison')
                RandomComparisonClass = class(rc);
            else % mshould be a string with the RandomComparison class
                RandomComparisonClass = rc;
            end
        end
        function name = getName(rc)
            name = eval([RandomComparison.getClass(rc) '.getName()']);
        end
        function description = getDescription(rc)
            % RandomComparison description
            description = eval([RandomComparison.getClass(rc) '.getDescription()']);
        end
        function datalist = getDataList(rc)
            % list of measurments data keys
            datalist = eval([RandomComparison.getClass(rc) '.getDataList()']);
        end
        function sub = getRandomComparison(randomComparisonClass, id, varargin)
            sub = eval([randomComparisonClass '(id, varargin{:})']);
        end
        function data_codes = getDataCodes(rc)
            datalist = RandomComparison.getDataList(rc);
            data_codes = keys(datalist);
        end
        function data_number = getDataNumber(rc)
            datalist = RandomComparison.getDataList(rc);
            data_number = length(datalist);
        end
        function data_classes = getDataClasses(rc)
            datalist = RandomComparison.getDataList(rc);
            data_classes = values(datalist);
        end
        function data_class = getDataClass(rc, data_code)
            datalist = RandomComparison.getDataList(rc);
            data_class = datalist(data_code);
        end
    end
end
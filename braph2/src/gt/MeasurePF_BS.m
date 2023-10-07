classdef MeasurePF_BS < MeasurePF
	%MeasurePF_BS is the base element to plot a binodal superglobal measure.
	% It is a subclass of <a href="matlab:help MeasurePF">MeasurePF</a>.
	%
	% A Panel Figure for Binodal Superglobal Measure (MeasurePF_BS) manages the basic functionalities to plot of a binodal superglobal measure.
	%
	% MeasurePF_BS methods (constructor):
	%  MeasurePF_BS - constructor
	%
	% MeasurePF_BS methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% MeasurePF_BS methods (display):
	%  tostring - string with information about the panel figure for binodal superglobal measure
	%  disp - displays information about the panel figure for binodal superglobal measure
	%  tree - displays the tree of the panel figure for binodal superglobal measure
	%
	% MeasurePF_BS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for binodal superglobal measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for binodal superglobal measure
	%
	% MeasurePF_BS methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for binodal superglobal measure as b2 file
	%  load - loads a BRAPH2 panel figure for binodal superglobal measure from a b2 file
	%
	% MeasurePF_BS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for binodal superglobal measure
	%
	% MeasurePF_BS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for binodal superglobal measure
	%
	% MeasurePF_BS methods (inspection, Static):
	%  getClass - returns the class of the panel figure for binodal superglobal measure
	%  getSubclasses - returns all subclasses of MeasurePF_BS
	%  getProps - returns the property list of the panel figure for binodal superglobal measure
	%  getPropNumber - returns the property number of the panel figure for binodal superglobal measure
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% MeasurePF_BS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasurePF_BS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasurePF_BS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasurePF_BS methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasurePF_BS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasurePF_BS constants</a>.
	%
	%
	% See also Measure.
	
	properties (Constant) % properties
		NODES = MeasurePF.getPropNumber() + 1;
		NODES_TAG = 'NODES';
		NODES_CATEGORY = Category.FIGURE;
		NODES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function pf = MeasurePF_BS(varargin)
			%MeasurePF_BS() creates a panel figure for binodal superglobal measure.
			%
			% MeasurePF_BS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasurePF_BS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@MeasurePF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for binodal superglobal measure.
			%
			% CLASS = MeasurePF_BS.GETCLASS() returns the class 'MeasurePF_BS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for binodal superglobal measure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasurePF_BS') returns 'MeasurePF_BS'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasurePF_BS')
			%  are less computationally efficient.
			
			pf_class = 'MeasurePF_BS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for binodal superglobal measure.
			%
			% LIST = MeasurePF_BS.GETSUBCLASSES() returns all subclasses of 'MeasurePF_BS'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for binodal superglobal measure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasurePF_BS') returns all subclasses of 'MeasurePF_BS'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasurePF_BS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for binodal superglobal measure.
			%
			% PROPS = MeasurePF_BS.GETPROPS() returns the property list of panel figure for binodal superglobal measure
			%  as a row vector.
			%
			% PROPS = MeasurePF_BS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for binodal superglobal measure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasurePF_BS'[, CATEGORY]) returns the property list of 'MeasurePF_BS'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MeasurePF.getProps() ...
						MeasurePF_BS.NODES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MeasurePF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MeasurePF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MeasurePF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MeasurePF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MeasurePF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MeasurePF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MeasurePF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MeasurePF.getProps(Category.FIGURE) ...
						MeasurePF_BS.NODES ...
						];
				case Category.GUI
					prop_list = [ ...
						MeasurePF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for binodal superglobal measure.
			%
			% N = MeasurePF_BS.GETPROPNUMBER() returns the property number of panel figure for binodal superglobal measure.
			%
			% N = MeasurePF_BS.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for binodal superglobal measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for binodal superglobal measure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasurePF_BS') returns the property number of 'MeasurePF_BS'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasurePF_BS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for binodal superglobal measure/error.
			%
			% CHECK = MeasurePF_BS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasurePF_BS, PROP) checks whether PROP exists for MeasurePF_BS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasurePF_BS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_BS:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_BS:WrongInput]
			%  Element.EXISTSPROP(MeasurePF_BS, PROP) throws error if PROP does NOT exist for MeasurePF_BS.
			%   Error id: [BRAPH2:MeasurePF_BS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasurePF_BS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_BS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_BS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasurePF_BS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for binodal superglobal measure/error.
			%
			% CHECK = MeasurePF_BS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasurePF_BS, TAG) checks whether TAG exists for MeasurePF_BS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasurePF_BS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_BS:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_BS:WrongInput]
			%  Element.EXISTSTAG(MeasurePF_BS, TAG) throws error if TAG does NOT exist for MeasurePF_BS.
			%   Error id: [BRAPH2:MeasurePF_BS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measurepf_bs_tag_list = cellfun(@(x) MeasurePF_BS.getPropTag(x), num2cell(MeasurePF_BS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measurepf_bs_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_BS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_BS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasurePF_BS.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(MeasurePF_BS, POINTER) returns property number of POINTER of MeasurePF_BS.
			%  PROPERTY = PF.GETPROPPROP(MeasurePF_BS, POINTER) returns property number of POINTER of MeasurePF_BS.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measurepf_bs_tag_list = cellfun(@(x) MeasurePF_BS.getPropTag(x), num2cell(MeasurePF_BS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measurepf_bs_tag_list)); % tag = pointer
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(MeasurePF_BS, POINTER) returns tag of POINTER of MeasurePF_BS.
			%  TAG = PF.GETPROPTAG(MeasurePF_BS, POINTER) returns tag of POINTER of MeasurePF_BS.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasurePF_BS.NODES
						tag = MeasurePF_BS.NODES_TAG;
					otherwise
						tag = getPropTag@MeasurePF(prop);
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(MeasurePF_BS, POINTER) returns category of POINTER of MeasurePF_BS.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasurePF_BS, POINTER) returns category of POINTER of MeasurePF_BS.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF_BS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_BS.NODES
					prop_category = MeasurePF_BS.NODES_CATEGORY;
				otherwise
					prop_category = getPropCategory@MeasurePF(prop);
			end
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(MeasurePF_BS, POINTER) returns format of POINTER of MeasurePF_BS.
			%  FORMAT = PF.GETPROPFORMAT(MeasurePF_BS, POINTER) returns format of POINTER of MeasurePF_BS.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF_BS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_BS.NODES
					prop_format = MeasurePF_BS.NODES_FORMAT;
				otherwise
					prop_format = getPropFormat@MeasurePF(prop);
			end
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasurePF_BS, POINTER) returns description of POINTER of MeasurePF_BS.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasurePF_BS, POINTER) returns description of POINTER of MeasurePF_BS.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF_BS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_BS.NODES
					prop_description = 'NODES (figure, rvector) are the node numbers of the binodal measure.';
				case MeasurePF_BS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for binodal superglobal measure.';
				case MeasurePF_BS.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for binodal superglobal measure.';
				case MeasurePF_BS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for binodal superglobal measure.';
				case MeasurePF_BS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for binodal superglobal measure.';
				case MeasurePF_BS.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for binodal superglobal measure.';
				case MeasurePF_BS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for binodal superglobal measure.';
				case MeasurePF_BS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for binodal superglobal measure.';
				case MeasurePF_BS.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it.';
				otherwise
					prop_description = getPropDescription@MeasurePF(prop);
			end
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(MeasurePF_BS, POINTER) returns settings of POINTER of MeasurePF_BS.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasurePF_BS, POINTER) returns settings of POINTER of MeasurePF_BS.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF_BS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_BS.NODES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MeasurePF_BS.TEMPLATE
					prop_settings = 'MeasurePF_BS';
				otherwise
					prop_settings = getPropSettings@MeasurePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasurePF_BS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF_BS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasurePF_BS, POINTER) returns the default value of POINTER of MeasurePF_BS.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasurePF_BS, POINTER) returns the default value of POINTER of MeasurePF_BS.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasurePF_BS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_BS.NODES
					prop_default = Format.getFormatDefault(Format.RVECTOR, MeasurePF_BS.getPropSettings(prop));
				case MeasurePF_BS.ELCLASS
					prop_default = 'MeasurePF_BS';
				case MeasurePF_BS.NAME
					prop_default = 'Panel Figure for Binodal Superglobal Measure';
				case MeasurePF_BS.DESCRIPTION
					prop_default = 'A Panel Figure for Binodal Superglobal Measure (MeasurePF_BS) manages the basic functionalities to plot of a binodal superglobal measure.';
				case MeasurePF_BS.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasurePF_BS.getPropSettings(prop));
				case MeasurePF_BS.ID
					prop_default = 'MeasurePF_BS ID';
				case MeasurePF_BS.LABEL
					prop_default = 'MeasurePF_BS label';
				case MeasurePF_BS.NOTES
					prop_default = 'MeasurePF_BS notes';
				otherwise
					prop_default = getPropDefault@MeasurePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasurePF_BS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF_BS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasurePF_BS, POINTER) returns the conditioned default value of POINTER of MeasurePF_BS.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasurePF_BS, POINTER) returns the conditioned default value of POINTER of MeasurePF_BS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasurePF_BS.getPropProp(pointer);
			
			prop_default = MeasurePF_BS.conditioning(prop, MeasurePF_BS.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(MeasurePF_BS, PROP, VALUE) checks VALUE format for PROP of MeasurePF_BS.
			%  CHECK = PF.CHECKPROP(MeasurePF_BS, PROP, VALUE) checks VALUE format for PROP of MeasurePF_BS.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasurePF_BS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasurePF_BS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasurePF_BS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF_BS.
			%   Error id: €BRAPH2.STR€:MeasurePF_BS:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasurePF_BS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF_BS.
			%   Error id: €BRAPH2.STR€:MeasurePF_BS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasurePF_BS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasurePF_BS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_BS.NODES % __MeasurePF_BS.NODES__
					check = Format.checkFormat(Format.RVECTOR, value, MeasurePF_BS.getPropSettings(prop));
				case MeasurePF_BS.TEMPLATE % __MeasurePF_BS.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF_BS.getPropSettings(prop));
				otherwise
					if prop <= MeasurePF.getPropNumber()
						check = checkProp@MeasurePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_BS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_BS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasurePF_BS.getPropTag(prop) ' (' MeasurePF_BS.getFormatTag(MeasurePF_BS.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case MeasurePF_BS.SETUP % __MeasurePF_BS.SETUP__
					%%%__WARN_TBI__
					value = [];
					
				otherwise
					if prop <= MeasurePF.getPropNumber()
						value = calculateValue@MeasurePF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case MeasurePF_BS.NODES % __MeasurePF_BS.NODES__
					pr = MeasurePF_BxPP_Node('EL', pf, 'PROP', MeasurePF_BS.NODE);
					
				otherwise
					pr = getPanelProp@MeasurePF(pf, prop, varargin{:});
					
			end
		end
	end
end

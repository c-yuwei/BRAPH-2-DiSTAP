%TEST_ELEMENT

%% Test 1: Inspection methods
el_class_list = subclasses('Element', [], [], true);

for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    el = eval([el_class '()']);

% % %     assert(strcmp(Element.getClass(el_class), el_class) && ...
% % %         strcmp(Element.getClass(el), el_class) && ...
% % %         strcmp(eval([el_class '.getClass()']), el_class) && ...
% % %         strcmp(el.getClass(), el_class), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %         [el_class '.getClass should return ' el_class '.'])
% % %     
% % %     assert(ischar(Element.getName(el_class)) && ...
% % %         ischar(Element.getName(el)) && ...
% % %         ischar(el.getName()) && ...
% % %         ischar(eval([el_class '.getName()'])), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %         [el_class '.getName should return a char array.'])
% % % 
% % %     assert(ischar(Element.getDescription(el_class)) && ...
% % %         ischar(Element.getDescription(el)) && ...
% % %         ischar(el.getDescription()) && ...
% % %         ischar(eval([el_class '.getDescription()'])), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %         [el_class '.getDescription should return a char array.'])
% % %     
% % % 	assert(all(Element.getProps(el_class) == [1:1:length(Element.getProps(el_class))]') && ...
% % %         all(Element.getProps(el) == [1:1:length(Element.getProps(el))]') && ...
% % %         all(eval([el_class '.getProps()']) == [1:1:length(Element.getProps(el))]') && ...
% % %         all(el.getProps() == [1:1:length(Element.getProps(el))]'), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %         [el_class '.getProps should return a column vector 1:1:N.']) %#ok<NBRAK>
% % %     
% % %     assert(Element.getPropNumber(el_class) == length(Element.getProps(el_class)) && ...
% % %         Element.getPropNumber(el) == length(Element.getProps(el)) && ...
% % %         eval([el_class '.getPropNumber()']) == length(eval([el_class '.getProps()'])) && ...
% % %         el.getPropNumber() == length(el.getProps()), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %         [el_class '.getPropNumber should return an integer equal to the number of properties.'])
% % %     
% % %     assert(~Element.existsProp(el_class, NaN) && ...
% % %         ~Element.existsProp(el, NaN) && ...
% % %         ~el.existsProp(NaN) && ...
% % %         ~eval([el_class '.existsProp(NaN)']), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %         [el_class '.existsProp does not work.'])
% % % 
% % %     assert(~Element.existsTag(el_class, '') && ...
% % %         ~Element.existsTag(el, '') && ...
% % %         ~el.existsTag('') && ...
% % %         ~eval([el_class '.existsTag('''')']), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %         [el_class '.existsTag does not work.'])
% % %     
% % %     for prop = 1:1:Element.getPropNumber(el_class)
% % %         Element.existsProp(el_class, prop)
% % %         Element.existsProp(el, prop)
% % %         el.existsProp(prop)
% % %         eval([el_class '.existsProp(prop)'])
% % % 
% % %         assert(Element.getPropProp(el_class, prop) == prop && ...
% % %             Element.getPropProp(el, prop) == prop && ...
% % %             el.getPropProp(prop) == prop && ...
% % %             eval([el_class '.getPropProp(prop)']) == prop, ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %             [el_class '.getPropTag should return the integer value of the prop (' int2str(prop) ').'])
% % % 
% % %         assert(ischar(Element.getPropTag(el_class, prop)) && ...
% % %             ischar(Element.getPropTag(el, prop)) && ...
% % %             ischar(el.getPropTag(prop)) && ...
% % %             ischar(eval([el_class '.getPropTag(prop)'])), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %             [el_class '.getPropTag should return a char array.'])
% % %         
% % %         tag = el.getPropTag(prop);
% % %         
% % %         Element.existsTag(el_class, tag)
% % %         Element.existsTag(el, tag)
% % %         el.existsTag(tag)
% % %         eval([el_class '.existsTag(tag)'])
% % %         
% % %         assert(Element.getPropProp(el_class, tag) == prop && ...
% % %             Element.getPropProp(el, tag) == prop && ...
% % %             el.getPropProp(tag) == prop && ...
% % %             eval([el_class '.getPropProp(tag)']) == prop, ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %             [el_class '.getPropTag should return the integer value of the prop (' int2str(prop) ').'])
% % % 
% % %         assert(ischar(Element.getPropTag(el_class, tag)) && ...
% % %             ischar(Element.getPropTag(el, tag)) && ...
% % %             ischar(el.getPropTag(tag)) && ...
% % %             ischar(eval([el_class '.getPropTag(tag)'])), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %             [el_class '.getPropTag should return a char array.'])        
% % % 
% % %         Category.existsCategory(Element.getPropCategory(el_class, prop))
% % %         Category.existsCategory(Element.getPropCategory(el, prop))
% % %         Category.existsCategory(el.getPropCategory(prop))
% % %         Category.existsCategory(eval([el_class '.getPropCategory(prop)']))
% % %         Category.existsCategory(Element.getPropCategory(el_class, tag))
% % %         Category.existsCategory(Element.getPropCategory(el, tag))
% % %         Category.existsCategory(el.getPropCategory(tag))
% % %         Category.existsCategory(eval([el_class '.getPropCategory(tag)']))
% % % 
% % %         Format.existsFormat(Element.getPropFormat(el_class, prop))
% % %         Format.existsFormat(Element.getPropFormat(el, prop))
% % %         Format.existsFormat(el.getPropFormat(prop))
% % %         Format.existsFormat(eval([el_class '.getPropFormat(prop)']))
% % %         Format.existsFormat(Element.getPropFormat(el_class, tag))
% % %         Format.existsFormat(Element.getPropFormat(el, tag))
% % %         Format.existsFormat(el.getPropFormat(tag))
% % %         Format.existsFormat(eval([el_class '.getPropFormat(tag)']))
% % % 
% % %         assert(ischar(Element.getPropDescription(el_class, prop)) && ...
% % %             ischar(Element.getPropDescription(el, prop)) && ...
% % %             ischar(el.getPropDescription(prop)) && ...
% % %             ischar(eval([el_class '.getPropDescription(prop)'])), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %             [el_class '.getPropDescription should return a char array.'])
% % %         assert(ischar(Element.getPropDescription(el_class, tag)) && ...
% % %             ischar(Element.getPropDescription(el, tag)) && ...
% % %             ischar(el.getPropDescription(tag)) && ...
% % %             ischar(eval([el_class '.getPropDescription(tag)'])), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %             [el_class '.getPropDescription should return a char array.'])
% % %         
% % %         assert(islogical(Element.checkProp(el_class, prop, 'probably wrong value')) && ...
% % %             islogical(Element.checkProp(el, prop, 'probably wrong value')) && ...
% % %             islogical(el.checkProp(prop, 'probably wrong value')) && ...
% % %             islogical(eval([el_class '.checkProp(prop, ''probably wrong value'')'])), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %             [el_class '.checkProp should return a logical value.'])
% % %         assert(islogical(Element.checkProp(el_class, tag, 'probably wrong value')) && ...
% % %             islogical(Element.checkProp(el, tag, 'probably wrong value')) && ...
% % %             islogical(el.checkProp(tag, 'probably wrong value')) && ...
% % %             islogical(eval([el_class '.checkProp(tag, ''probably wrong value'')'])), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.WRONG_OUTPUT], ...
% % %             [el_class '.checkProp should return a logical value.'])
% % %         
% % %         Element.checkProp(el_class, prop, Element.getPropDefaultConditioned(el_class, prop))
% % %         Element.checkProp(el, prop, Element.getPropDefaultConditioned(el, prop))
% % %         el.checkProp(prop, el.getPropDefaultConditioned(prop))
% % %         eval([el_class '.checkProp(prop, ' el_class '.getPropDefaultConditioned(prop))'])
% % %         Element.checkProp(el_class, tag, Element.getPropDefaultConditioned(el_class, tag))
% % %         Element.checkProp(el, tag, Element.getPropDefaultConditioned(el, tag))
% % %         el.checkProp(tag, el.getPropDefaultConditioned(tag))
% % %         eval([el_class '.checkProp(tag, ' el_class '.getPropDefaultConditioned(tag))'])
% % %     end
end

% % % %% Test 2: Deep copy
% % % el_class_list = subclasses('Element', [], [], true);
% % % 
% % % for i = 1:1:length(el_class_list)
% % %     el_class = el_class_list{i};
% % %     el = eval([el_class '()']);
% % % 
% % %     el_copy = el.copy();
% % %     
% % %     assert(el_copy ~= el, ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %         [el_class '.copy() does not work. A copied element must point to a copied element.'])
% % %     assert(isequal(el_copy, el), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %         [el_class '.copy() does not work. A copied element must have the same property values of the original element.'])
% % %     
% % %     for prop = 1:1:Element.getPropNumber(el_class)
% % %         value = el.getr(prop);
% % %         value_copy = el_copy.getr(prop);
% % %         
% % %         if isa(value, 'NoValue')
% % %             assert(value_copy == value, ...
% % %                 [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %                 [el_class '.copy() does not work. ' ...
% % %                 'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is a NoValue handle ' ...
% % %                 'must point to the unique instance of NoValue given by NoValue.getNoValue() for computational efficiency.'])
% % %         elseif isa(value, 'Element')
% % %             assert(value_copy ~= value, ...
% % %                 [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %                 [el_class '.copy() does not work. ' ...
% % %                 'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is an element handle of a copied element ' ...
% % %                 'must point to a copied element.'])
% % %             assert(isequal(value_copy, value), ...
% % %                 [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %                 [el_class '.copy() does not work. ' ...
% % %                 'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is an element handle of a copied element ' ...
% % %                 'must have the same property values of the original element.'])
% % %         elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
% % %             for j = 1:1:length(value)
% % %                 assert(value_copy{j} ~= value{j}, ...
% % %                     [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %                     [el_class '.copy() does not work. ' ...
% % %                     'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is an element handle of a copied element ' ...
% % %                     'must point to a copied element.'])
% % %                 assert(isequal(value_copy{j}, value{j}), ...
% % %                     [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %                     [el_class '.copy() does not work. ' ...
% % %                     'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is an element handle of a copied element ' ...
% % %                     'must have the same property values of the original element.'])
% % %             end
% % %         else
% % %             assert(all(value_copy == value), ...
% % %                 [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %                 [el_class '.copy() does not work. ' ...
% % %                 'A non-handle property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') of a copied element must be the same as in the original element.'])
% % %         end
% % %         
% % %         assert(el_copy.isLocked(prop) == el.isLocked(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %             [el_class '.copy() does not work. ' ...
% % %             'The locked status of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of the copied and original elements must be the same.'])
% % %         
% % %         assert(el_copy.isChecked(prop) == el.isChecked(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %             [el_class '.copy() does not work. ' ...
% % %             'The checked status of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of the copied and original elements must be the same.'])
% % % 
% % %         assert(el_copy.getPropSeed(prop) == el.getPropSeed(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_COPY], ...
% % %             [el_class '.copy() does not work. ' ...
% % %             'The seed of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of the copied and original elements must be the same.'])
% % %     end
% % % end
% % % 
% % % %% Test 3: Clone
% % % el_class_list = subclasses('Element', [], [], true);
% % % 
% % % for i = 1:1:length(el_class_list)
% % %     el_class = el_class_list{i};
% % %     el = eval([el_class '()']);
% % %     el.lock()
% % % 
% % %     el_clone = el.clone();
% % %     
% % %     assert(el_clone ~= el, ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %         [el_class '.clone() does not work. A cloned element must point to a cloned element.'])
% % %     
% % %     for prop = 1:1:Element.getPropNumber(el_class)
% % %         value = el.getr(prop);
% % %         value_clone = el_clone.getr(prop);
% % %         
% % %         switch el.getPropCategory(prop)
% % %             case {Category.METADATA, Category.PARAMETER}       
% % %                 if isa(value, 'NoValue')
% % %                     assert(value_clone == value, ...
% % %                         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                         [el_class '.clone() does not work. ' ...
% % %                         'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is a NoValue handle ' ...
% % %                         'must point to the unique instance of NoValue given by NoValue.getNoValue() for computational efficiency.'])
% % %                 elseif isa(value, 'Element')
% % %                     assert(value_clone ~= value, ...
% % %                         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                         [el_class '.clone() does not work. ' ...
% % %                         'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is an element handle of a cloned element ' ...
% % %                         'must point to a cloned element.'])
% % %                 elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
% % %                     for j = 1:1:length(value)
% % %                         assert(value_clone{j} ~= value{j}, ...
% % %                             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                             [el_class '.clone() does not work. ' ...
% % %                             'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is an element handle of a cloned element ' ...
% % %                             'must point to a cloned element.'])
% % %                     end
% % %                 else
% % %                     assert(all(value_clone == value), ...
% % %                         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                         [el_class '.clone() does not work. ' ...
% % %                         'A non-handle property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') of a cloned element must be the same as in the original element.'])
% % %                 end
% % %             case {Category.DATA, Category.RESULT}
% % %                 assert(isa(value_clone, 'NoValue'), ...
% % %                     [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                     [el_class '.clone() does not work. ' ...
% % %                     'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') of category Data or Result ' ...
% % %                     'must point to the unique instance of NoValue given by NoValue.getNoValue().'])
% % %         end
% % %         
% % %         assert(~el_clone.isLocked(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %             [el_class '.clone() does not work. ' ...
% % %             'The status of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of a cloned element must be unlocked, even if the original element was locked.'])
% % % 
% % %         assert(el_clone.isChecked(prop) == el.isChecked(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %             [el_class '.clone() does not work. ' ...
% % %             'The checked status of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of the cloned and original elements must be the same.'])
% % % 
% % %         assert(el_clone.getPropSeed(prop) ~= el.getPropSeed(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %             [el_class '.clone() does not work. ' ...
% % %             'The seed of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of the cloned and original elements must be different (with extemely high probability).'])
% % %     end
% % % end
% % % 
% % % %% Test 4: DeepClone
% % % el_class_list = subclasses('Element', [], [], true);
% % % 
% % % for i = 1:1:length(el_class_list)
% % %     el_class = el_class_list{i};
% % %     el = eval([el_class '()']);
% % %     el.lock()
% % % 
% % %     el_clone = el.deepclone();
% % %     
% % %     assert(el_clone ~= el, ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %         [el_class '.deepclone() does not work. A cloned element must point to a cloned element.'])
% % %     
% % %     for prop = 1:1:Element.getPropNumber(el_class)
% % %         value = el.getr(prop);
% % %         value_clone = el_clone.getr(prop);
% % %         
% % %         switch el.getPropCategory(prop)
% % %             case {Category.METADATA, Category.PARAMETER, Category.DATA}       
% % %                 if isa(value, 'NoValue')
% % %                     assert(value_clone == value, ...
% % %                         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                         [el_class '.deepclone() does not work. ' ...
% % %                         'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is a NoValue handle ' ...
% % %                         'must point to the unique instance of NoValue given by NoValue.getNoValue() for computational efficiency.'])
% % %                 elseif isa(value, 'Element')
% % %                     assert(value_clone ~= value, ...
% % %                         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                         [el_class '.deepclone() does not work. ' ...
% % %                         'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is an element handle of a cloned element ' ...
% % %                         'must point to a cloned element.'])
% % %                 elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
% % %                     for j = 1:1:length(value)
% % %                         assert(value_clone{j} ~= value{j}, ...
% % %                             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                             [el_class '.deepclone() does not work. ' ...
% % %                             'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') that is an element handle of a cloned element ' ...
% % %                             'must point to a cloned element.'])
% % %                     end
% % %                 else
% % %                     assert(all(value_clone == value), ...
% % %                         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                         [el_class '.clone() does not work. ' ...
% % %                         'A non-handle property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') of a cloned element must be the same as in the original element.'])
% % %                 end
% % %             case Category.RESULT
% % %                 assert(isa(value_clone, 'NoValue'), ...
% % %                     [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %                     [el_class '.deepclone() does not work. ' ...
% % %                     'A property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') of category Data or Result ' ...
% % %                     'must point to the unique instance of NoValue given by NoValue.getNoValue().'])
% % %         end
% % %         
% % %         assert(~el_clone.isLocked(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %             [el_class '.deepclone() does not work. ' ...
% % %             'The status of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of a cloned element must be unlocked, even if the original element was locked.'])
% % % 
% % %         assert(el_clone.isChecked(prop) == el.isChecked(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %             [el_class '.deepclone() does not work. ' ...
% % %             'The checked status of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of the cloned and original elements must be the same.'])
% % % 
% % %         assert(el_clone.getPropSeed(prop) ~= el.getPropSeed(prop), ...
% % %             [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_CLONE], ...
% % %             [el_class '.deepclone() does not work. ' ...
% % %             'The seed of a property (' int2str(prop) ', ' Element.getPropTag(el_class, prop) ') ' ...
% % %             'of the cloned and original elements must be different (with extemely high probability).'])
% % %     end
% % % end

% % % %% Test 5: JSON
% % % for i = 1:1:length(el_class_list)
% % %     el_class = el_class_list{i};
% % %     el = eval([el_class '()']);
% % %     
% % %     [json, struct, el_list] = encodeJSON(el);
% % %     
% % %     [el_dec, struct_dec, el_list_dec] = Element.decodeJSON(json);
% % % 
% % %     assert(el_dec ~= el, ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_JSON], ...
% % %         [el_class '.encodeJSON() or ' el_class '.decodeJSON() does not work. A JSON encoded/decoded element must point to an element other than the original one.'])
% % %     assert(isequal(el_dec, el), ...
% % %         [BRAPH2.STR ':' el_class ':' BRAPH2.BUG_JSON], ...
% % %         [el_class '.encodeJSON() or ' el_class '.decodeJSON does not work. A JSON encoded/decoded element must have the same property values of the original element.'])
% % % end
% % % 
% % % %% Test 6: JSON encode-decode with ITEMLIST
% % % idict = IndexedDictionary( ...
% % %     'id', 'idict', ...
% % %     'it_class', 'ETA', ...
% % %     'it_key', 17, ...
% % %     'it_list', {ETA()} ...
% % %     );
% % % 
% % % % encode to json
% % % [json, ~, ~] = encodeJSON(idict);
% % % 
% % % % decode from json
% % % idict_decoded = Element.decodeJSON(json);
% % % 
% % % assert(iscell(idict_decoded.getr('IT_LIST')), ...
% % %     [BRAPH2.STR ':JSON:' BRAPH2.BUG_JSON], ...
% % %     'Error in JSON encode/decode because the decoded IT_LIST is not a cell.')
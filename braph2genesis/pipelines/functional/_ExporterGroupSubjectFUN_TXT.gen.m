%% ¡header!
ExporterGroupSubjectFUN_TXT < Exporter (ex, exporter of FUN subject group in TXT) exports a group of subjects with functional data to a series of TXT file.

%%% ¡description!
ExporterGroupSubjectFUN_TXT exports a group of subjects with functional data to a series of TXT file and their covariates age and sex (if existing) to another TXT file.
All these files are saved in the same folder.
Each file contains a table with each row correspoding to a time serie and each column to a brain region.
The TXT file containing the covariates consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SunbjectCON, ImporterGroupSubjectFUN_TXT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the FUN subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectFUN_TXT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the FUN subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectFUN_TXT exports a group of subjects with functional data to a series of TXT file and their covariates age and sex (if existing) to another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the FUN subject group exporter in TXT.

%%% ¡prop!
ID (data, string) is a few-letter code for the FUN subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectFUN_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the FUN subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectFUN_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the FUN subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectFUN_TXT notes'

%% ¡props!

%%% ¡prop!
GR (data, item) is a group of subjects with functional data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectFUN', [], [], true))); % Format.checkFormat(Format.ITEM, value) already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))

%%% ¡prop!
DIRECTORY (data, string) is the directory name where to save the group of subjects with functional data.
%%%% ¡default!
[fileparts(which('test_braph2')) filesep 'default_group_subjects_FUN_most_likely_to_be_erased']

%%% ¡prop!
PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with functional data.
%%%% ¡settings!
'ExporterGroupSubjectFUN_TXT'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
    ex.set('DIRECTORY', directory);
end
value = ex;

%%% ¡prop!
SAVE (result, empty) saves the group of subjects with functional data in TXT files in the selected directory.
%%%% ¡calculate!
directory = ex.get('DIRECTORY');

if isfolder(directory)
    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');

    gr = ex.get('GR');

    gr_directory = [directory filesep() gr.get('ID')];
    if ~exist(gr_directory, 'dir')
        mkdir(gr_directory)
    end

    braph2waitbar(wb, .15, 'Organizing info ...')

    sub_dict = gr.get('SUB_DICT');
    sub_number = sub_dict.length();
    sub_id = cell(sub_number, 1);
% % %     age = cell(sub_number, 1);
% % %     sex = cell(sub_number, 1);

    for i = 1:1:sub_number
        braph2waitbar(wb, .25 + .75 * i / sub_number, ['Saving subject ' num2str(i) ' of ' num2str(sub_number) '...'])
        
        sub = sub_dict.getItem(i);
        sub_id(i) = {sub.get('ID')};
        sub_FUN = sub.get('FUN');
% %         age{i} =  sub.get('AGE');
% %         sex{i} =  sub.get('SEX');
                
        tab = table(sub_FUN);
        
        sub_file = [gr_directory filesep() sub_id{i} '.txt'];

        % save file
        writetable(tab, sub_file, 'Delimiter', '\t', 'WriteVariableNames', 0);
    end
    
% % %     % if covariates save them in another file
% % %     if sub_number ~= 0 && ~isequal(sex{:}, 'unassigned')  && ~isequal(age{:},  0) 
% % %         tab2 = cell(1 + sub_number, 3);
% % %         tab2{1, 1} = 'ID';
% % %         tab2{1, 2} = 'Age';
% % %         tab2{1, 3} = 'Sex';
% % %         tab2(2:end, 1) = sub_id;
% % %         tab2(2:end, 2) = age;
% % %         tab2(2:end, 3) = sex;
% % %         tab2 = table(tab2);
% % %         
% % %         % save
% % %         cov_directory = [gr_directory filesep() 'covariates'];
% % %         if ~exist(cov_directory, 'dir')
% % %             mkdir(cov_directory)
% % %         end
% % %         writetable(tab2, [cov_directory filesep() gr.get('ID') '_covariates.txt'], 'Delimiter', '\t', 'WriteVariableNames', 0);
% % %     end
    
    braph2waitbar(wb, 'close')
end

% sets value to empty
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ExporterGroupSubjectFUN_TXT.PUT_DIR]

%%% ¡test!
%%%% ¡name!
Delete directory TBE
%%%% ¡probability!
1
%%%% ¡code!
warning('off', 'MATLAB:DELETE:FileNotFound')
dir_to_be_erased = ExporterGroupSubjectFUN_TXT.getPropDefault('DIRECTORY');
if isfolder(dir_to_be_erased)
    rmdir(dir_to_be_erased, 's')
end
warning('on', 'MATLAB:DELETE:FileNotFound')

%%% ¡test!
%%%% ¡name!
Export and import
%%%% ¡probability!
.01
%%%% ¡code!
br1 = BrainRegion( ...
    'ID', 'ISF', ...
    'LABEL', 'superiorfrontal', ...
    'NOTES', 'notes1', ...
    'X', -12.6, ...
    'Y', 22.9, ...
    'Z', 42.4 ...
    );
br2 = BrainRegion( ...
    'ID', 'lFP', ...
    'LABEL', 'frontalpole', ...
    'NOTES', 'notes2', ...
    'X', -8.6, ...
    'Y', 61.7, ...
    'Z', -8.7 ...
    );
br3 = BrainRegion( ...
    'ID', 'lRMF', ...
    'LABEL', 'rostralmiddlefrontal', ...
    'NOTES', 'notes3', ...
    'X', -31.3, ...
    'Y', 41.2, ...
    'Z', 16.5 ...
    );
br4 = BrainRegion( ...
    'ID', 'lCMF', ...
    'LABEL', 'caudalmiddlefrontal', ...
    'NOTES', 'notes4', ...
    'X', -34.6, ...
    'Y', 10.2, ...
    'Z', 42.8 ...
    );
br5 = BrainRegion( ...
    'ID', 'lPOB', ...
    'LABEL', 'parsorbitalis', ...
    'NOTES', 'notes5', ...
    'X', -41, ...
    'Y', 38.8, ...
    'Z', -11.1 ...
    );

ba = BrainAtlas( ...
    'ID', 'TestToSaveCoolID', ...
    'LABEL', 'Brain Atlas', ...
    'NOTES', 'Brain atlas notes', ...
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_KEY', 1, 'IT_LIST', {br1, br2, br3, br4, br5}) ...
    );

sub1 = SubjectFUN( ...
    'ID', 'SUB FUN 1', ...
    'LABEL', 'Subejct FUN 1', ...
    'NOTES', 'Notes on subject FUN 1', ...
    'BA', ba, ... % % %     'age', 75, ... % % %     'sex', 'female', ...
    'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
    );
sub2 = SubjectFUN( ...
    'ID', 'SUB FUN 2', ...
    'LABEL', 'Subejct FUN 2', ...
    'NOTES', 'Notes on subject FUN 2', ...
    'BA', ba, ... % % %     'age', 70, ... % % %     'sex', 'male', ...
    'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
    );
sub3 = SubjectFUN( ...
    'ID', 'SUB FUN 3', ...
    'LABEL', 'Subejct FUN 3', ...
    'NOTES', 'Notes on subject FUN 3', ...
    'BA', ba, ... % % %     'age', 50, ... % % %     'sex', 'female', ...
    'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
    );

gr = Group( ...
    'ID', 'GR FUN', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN', 'IT_KEY', 1, 'IT_LIST', {sub1, sub2, sub3}) ...
    );

directory = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_FUN_to_be_erased'];
if ~exist(directory, 'dir')
    mkdir(directory)
end

ex = ExporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', directory, ...
    'GR', gr ...
    );
ex.get('SAVE');

% import with same brain atlas
im1 = ImporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)], ...
    'BA', ba ...
    );
gr_loaded1 = im1.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded1.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectFUN_TXT:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded1.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded1.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('BA'), sub_loaded.get('BA')) & ... % % %         isequal(sub.get('AGE'), sub_loaded.get('AGE')) & ... % % %         isequal(sub.get('SEX'), sub_loaded.get('SEX')) & ...
        isequal(round(sub.get('FUN'), 10), round(sub_loaded.get('FUN'), 10)), ...
        [BRAPH2.STR ':ExporterGroupSubjectFUN_TXT:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

% import with new brain atlas
im2 = ImporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)], ...
    'BA', ba ...
    );
gr_loaded2 = im2.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded2.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectFUN_TXT:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded2.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded2.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...        
        isequal(round(sub.get('FUN'), 10), round(sub_loaded.get('FUN'), 10)), ...
        [BRAPH2.STR ':ExporterGroupSubjectFUN_TXT:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

rmdir(directory, 's')
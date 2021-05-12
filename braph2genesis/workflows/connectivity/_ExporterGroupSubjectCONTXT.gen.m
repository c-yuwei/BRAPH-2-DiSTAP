%% ¡header!
ExporterGroupSubjectCONTXT < Exporter (ex, exporter of CON subject group in TXT) exports a group of subjects with connectivity data to a series of TXT file.

%%% ¡description!
ExporterGroupSubjectCONTXT exports a group of subjects with connectivity data to a series of TXT file and their covariates age and sex (if existing) to another TXT file.
All these files are saved in the same folder.
Each file contains a table of values corresponding to the adjacency matrix.
The TXT file containing the covariates consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Exporter, ImporterGroupSubjectCONTXT

%% ¡props!

%%% ¡prop!
GR (data, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))

%%% ¡prop!
DIRECTORY (data, string) is the directory name where to save the group of subjects with connectivity data.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
SAVE (result, empty) saves the group of subjects with connectivity data in TXT files in the selected directory.
%%%% ¡calculate!
directory = ex.get('DIRECTORY');

if isfolder(directory)
    f = waitbar(0, 'Retrieving Path ...', 'Name', BRAPH2.NAME);
    set_icon(f)
    gr = ex.get('GR');

    gr_directory = [directory filesep() gr.get('ID')];
    if ~exist(gr_directory, 'dir')
        mkdir(gr_directory)
    end
    waitbar(.15, f, 'Organizing Info ...');
    sub_dict = gr.get('SUB_DICT');
    sub_number = sub_dict.length();
    sub_id = cell(sub_number, 1);
    age = cell(sub_number, 1);
    sex = cell(sub_number, 1);
    
    for i = 1:1:sub_number
        if i == floor(sub_number/2)
            waitbar(.55, f, 'Saving Info ...');
        end
        sub = sub_dict.getItem(i);
        sub_id(i) = {sub.get('ID')};
        sub_CON = sub.get('CON');
        age{i} =  sub.get('AGE');
        sex{i} =  sub.get('SEX');

        tab = table(sub_CON);

        sub_file = [gr_directory filesep() sub_id{i} '.txt'];

        % save file
        writetable(tab, sub_file, 'Delimiter', '\t', 'WriteVariableNames', 0);
    end
        
    % if covariates save them in another file
    if sub_number ~= 0 && ~isequal(sex{:}, 'unassigned')  && ~isequal(age{:},  0) 
        tab2 = cell(1 + sub_number, 3);
        tab2{1, 1} = 'ID';
        tab2{1, 2} = 'Age';
        tab2{1, 3} = 'Sex';
        tab2(2:end, 1) = sub_id;
        tab2(2:end, 2) = age;
        tab2(2:end, 3) = sex;
        tab2 = table(tab2);
        
        % save
        cov_directory = [gr_directory filesep() 'covariates'];
        if ~exist(cov_directory, 'dir')
            mkdir(cov_directory)
        end
        writetable(tab2, [cov_directory filesep() gr.get('ID') '_covariates.txt'], 'Delimiter', '\t', 'WriteVariableNames', 0);
    end
    
    % sets value to empty
    value = [];
else
    value = ex.getr('SAVE');    
end
if exist('f', 'var')
    waitbar(1, f, 'Finishing')
    pause(.5)
    close(f)
end

%% ¡methods!
function uigetdir(ex)
    % UIGETDIR opens a dialog box to set the directory where to save the group of subjects with connectivity data.
    
    directory = uigetdir('Select directory');
    if isfolder(directory)
        ex.set('DIRECTORY', directory);
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
export and import
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

sub1 = SubjectCON( ...
    'ID', 'SUB CON 1', ...
    'LABEL', 'Subejct CON 1', ...
    'NOTES', 'Notes on subject CON 1', ...
    'BA', ba, ...
    'age', 75, ...
    'sex', 'female', ...
    'CON', rand(ba.get('BR_DICT').length()) ...
    );
sub2 = SubjectCON( ...
    'ID', 'SUB CON 2', ...
    'LABEL', 'Subejct CON 2', ...
    'NOTES', 'Notes on subject CON 2', ...
    'BA', ba, ...
    'age', 70, ...
    'sex', 'male', ...
    'CON', rand(ba.get('BR_DICT').length()) ...
    );
sub3 = SubjectCON( ...
    'ID', 'SUB CON 3', ...
    'LABEL', 'Subejct CON 3', ...
    'NOTES', 'Notes on subject CON 3', ...
    'BA', ba, ...
    'age', 50, ...
    'sex', 'female', ...
    'CON', rand(ba.get('BR_DICT').length()) ...
    );

gr = Group( ...
    'ID', 'GR CON', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON', 'IT_KEY', 1, 'IT_LIST', {sub1, sub2, sub3}) ...
    );

directory = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_CON_to_be_erased'];
if ~exist(directory, 'dir')
    mkdir(directory)
end

ex = ExporterGroupSubjectCONTXT( ...
    'DIRECTORY', directory, ...
    'GR', gr ...
    );
ex.get('SAVE');

% import with same brain atlas
im1 = ImporterGroupSubjectCONTXT( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)], ...
    'BA', ba ...
    );
gr_loaded1 = im1.get('GR');

assert(gr.get('SUB_DICT').length() == gr_loaded1.get('SUB_DICT').length(), ...
	[BRAPH2.STR ':ExporterGroupSubjectCONTXT:' BRAPH2.BUG_IO], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').length(), gr_loaded1.get('SUB_DICT').length())
    sub = gr.get('SUB_DICT').getItem(i);
    sub_loaded = gr_loaded1.get('SUB_DICT').getItem(i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('BA'), sub_loaded.get('BA')) & ...
        isequal(sub.get('AGE'), sub_loaded.get('AGE')) & ...
        isequal(sub.get('SEX'), sub_loaded.get('SEX')) & ...
        isequal(round(sub.get('CON'), 10), round(sub_loaded.get('CON'), 10)), ...
        [BRAPH2.STR ':ExporterGroupSubjectCONTXT:' BRAPH2.BUG_IO], ...
        'Problems saving or loading a group.')    
end

% import with new brain atlas
im2 = ImporterGroupSubjectCONTXT( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)] ...
    );
gr_loaded2 = im2.get('GR');

assert(gr.get('SUB_DICT').length() == gr_loaded2.get('SUB_DICT').length(), ...
	[BRAPH2.STR ':ExporterGroupSubjectCONTXT:' BRAPH2.BUG_IO], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').length(), gr_loaded2.get('SUB_DICT').length())
    sub = gr.get('SUB_DICT').getItem(i);
    sub_loaded = gr_loaded2.get('SUB_DICT').getItem(i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        ~isequal(sub.get('BA').get('ID'), sub_loaded.get('BA').get('ID')) & ...
        isequal(round(sub.get('CON'), 10), round(sub_loaded.get('CON'), 10)), ...
        [BRAPH2.STR ':ExporterGroupSubjectCONTXT:' BRAPH2.BUG_IO], ...
        'Problems saving or loading a group.')    
end

rmdir(directory, 's')
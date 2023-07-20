%% ¡header!
SettingsPP < PanelProp (pr, settings panel) is the panel for settings.

%%% ¡description!
SettingsPP is the base element for the panels of the Settings.
In particular, it provides the updated PanelProp listeners.
It works for all categories.

%%% ¡seealso!
Settings

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the settings panel.
%%%% ¡default!
'SettingsPP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the settings panel.
%%%% ¡default!
'SettingsPP is the base element for the panels of the Settings. In particular, it provides the updated PanelProp listeners.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the settings panel.
%%%% ¡settings!
'SettingsPP'

%%% ¡prop!
ID (data, string) is a few-letter code for the settings panel.
%%%% ¡default!
'SettingsPP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the settings panel.
%%%% ¡default!
'SettingsPP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the settings panel.
%%%% ¡default!
'SettingsPP notes'

%%% ¡prop!
LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
%%%% ¡calculate!
value = {listener(pr.get('EL').get(pr.get('PROP')), 'PropSet', @cb_listener_set)}; 
%%%% ¡calculate_callbacks!
function cb_listener_set(~, event)
    if pr.get('DRAWN')
    % % % if ismember(pr.get('PROP'), cell2mat(event.props)) && pr.get('DRAWN')
        pr.get('UPDATE')
        pr.get('REDRAW')        
    end
end

%%% ¡prop!
LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
%%%% ¡calculate!
value = {listener(pr.get('EL').get(pr.get('PROP')), 'PropMemorized', @cb_listener_memorized)};
%%%% ¡calculate_callbacks!
function cb_listener_memorized(~, event)
    if pr.get('DRAWN')
    % % % if pr.get('PROP') == event.prop && pr.get('DRAWN')
        pr.get('UPDATE')
        pr.get('REDRAW')        
    end
end

%%% ¡prop!
LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
%%%% ¡calculate!
value = {listener(pr.get('EL').get(pr.get('PROP')), 'PropLocked', @cb_listener_locked)};
%%%% ¡calculate_callbacks!
function cb_listener_locked(~, event)
    if pr.get('DRAWN')
    % % % if pr.get('PROP') == event.prop && pr.get('DRAWN')
        pr.get('UPDATE')
        pr.get('REDRAW')
    end
end

%% ¡tests!

%%% ¡excluded_props!
[SettingsPP.PARENT SettingsPP.H SettingsPP.LISTENER_CB SettingsPP.BUTTON_AXISCOLOR SettingsPP.CHECKBOX_AXIS SettingsPP.CHECKBOX_GRID SettingsPP.CHECKBOX_EQUAL SettingsPP.CHECKBOX_TIGHT SettingsPP.CHECKBOX_BOX]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SettingsPP'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SettingsPP'])

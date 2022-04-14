%% ¡header!
PlotEnsembleMPLine < Plot (pr, plot graph mp) is a line plot of the multilayer measure values.

%%% ¡description!
Plot is the line plot of the multilayer measure values.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pr.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
h_plot % plot handle
pp
h_settings
m % measure

%% ¡props!

%%% ¡prop!
PLOTTITLE(metadata, string) to set plot line title.

%%% ¡prop!
A(data, item) to set ensemble line information.


%%% ¡prop!
X(data, rvector) to set plot line graph x range.

%%% ¡prop!
XLABEL(metadata, string) to set plot line x label.

%%% ¡prop!
YLABEL(metadata, string) to set plot line y label.

%%% ¡prop!
PLOTVALUE(data, cell) to set plot line atlas.

%%% ¡prop!
MEASURE(data, string) to set plot line measure.

%%% ¡prop!
LAYER (metadata, scalar) to set plot line layer.
%%%% ¡default!
1

%%% ¡prop!
CIL (metadata, CELL) to set plot line cil.

%%% ¡prop!
CIU (metadata, CELL) to set plot line ciu.

%%% ¡prop!
NODE1 (metadata, scalar) to set plot line node 1.
%%%% ¡default!
1

%%% ¡prop!
NODE2 (metadata, scalar) to set plot line node 2.
%%%% ¡default!
2

%%% ¡prop!
LINECOLOR (metadata, rvector) to set plot line color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
LINE_STYLE (metadata, string) to set plot line style.
%%%% ¡default!
'-'

%%% ¡prop!
LINE_WIDTH (metadata, scalar) to set plot line width.
%%%% ¡default!
0.5

%%% ¡prop!
MARKER (metadata, string) to set plot marker style.
%%%% ¡default!
'none'

%%% ¡prop!
MARKER_SIZE (metadata, scalar) to set plot marker size.
%%%% ¡default!
6

%%% ¡prop!
MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
MARKERFACECOLOR (metadata, rvector) to set plot marker face color.
%%%% ¡default!
[0 0 0]

%% ¡methods!
function h_figure = draw(pr, varargin)
    %DRAW draws the plot line.
    %
    % DRAW(PR) draws the plot line.
    %
    % H = DRAW(PR) returns a handle to the plot line.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the plot line
    %  with custom property-value couples.
    %  All standard plot properties of plot line can be used.
    %
    % see also settings, uipanel, isgraphics, Plot.


    pr.pp = draw@Plot(pr, varargin{:});
    pr.h_figure = get(pr.pp, 'Parent');
    subpanel = uipanel(pr.h_figure, ...
        'BackGroundColor', 'w', ...
        'Units', 'normalized', ...
        'Position', [.0 .0 1 1] ...
        );

    pr.h_axes = axes(subpanel);

    if nargout > 0
        h_figure = pr.h_figure;
    end
end
function f_settings = settings(pr, varargin)
    %SETTINGS opens the property editor GUI.
    %
    % SETTINGS(PR) allows the user to specify the properties of the plot
    %  by opening a GUI property editor.
    %
    % F = SETTINGS(PR) returns a handle to the property editor GUI.
    %
    % SETTINGS(PR, 'Property', VALUE, ...) sets the properties of the
    %  property editor GUI with custom property-value couples.
    %  All standard plot properties of figure can be used.
    %
    % See also draw, figure, isgraphics.

    pr.h_settings = settings@Plot(pr, varargin{:});
    set_braph2icon(pr.h_settings);

    % constants
    line_style = {'-', '--', ':', ':.', 'none'}; % TODO: move to BRAPH2
    marker_style = {'o', '+', '*', '.', 'x', ...
        '_', '|', 'square', 'diamond', '^', ...
        '>', '<', 'pentagram', 'hexagram', 'none'}; % TODO: move to BRAPH2
    % values
    analyze_ensemble = pr.get('A');
    me_dict = analyze_ensemble.get('ME_DICT');
    pr.m = me_dict.getItem(1); % its a cell;

    % atlas
    sub = analyze_ensemble.get('GR').get('SUB_DICT').getItem(1);
    atlas = sub.get('BA');
    node_labels = cellfun(@(x) x.get('ID') , atlas.get('BR_DICT').getItems(), 'UniformOutput', false);

    % measure list
    measure_list = me_dict.getKeys();

    plot_properties_panel = uipanel(pr.h_settings, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Position', [0 0 1 1]);
    
    measure_panel = uipanel(plot_properties_panel, ...
        'Units', 'normalized', ...
        'BackgroundColor',  pr.h_settings.Color, ...
        'Position', [.01 .85 .98 .14] ...
        );

    % line properties
    measure_list_id = uicontrol(measure_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Measure', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .01 .1 .8]);
    measure_list_popup = uicontrol(measure_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.11 .02 .1 .8], ...
        'String', measure_list, ...
        'TooltipString', 'Plot Line Style', ...
        'Callback', {@cb_measure_selection} ...
        );

        function cb_measure_selection(~,~)
            val = measure_list_popup.Value;
            str = measure_list_popup.String;
            pr.m = me_dict.getItem(val);
            pr.set('YLABEL', pr.m.get('MEASURE'))
            rules_node_popmenu_deactivation()
            pr.update_plot()
        end

    node_1_id = uicontrol(measure_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Brain Region 1', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.22 .01 .1 .8]);
    node_2_id = uicontrol(measure_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Brain Region 2', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.44 .01 .1 .9]);
    ui_node1_popmenu  = uicontrol('Parent', measure_panel, 'Style', 'popupmenu', 'String', node_labels);
    ui_node2_popmenu  = uicontrol('Parent', measure_panel, 'Style', 'popupmenu', 'String', node_labels);
    
    function update()
        pr.update_plot();
    end
    function init_measure_plot_area()
        set(ui_node1_popmenu, ...
            'Units', 'normalized', ...
            'Tooltip', 'Select the Node to be Plotted.', ...
            'String', node_labels, ...
            'Value', pr.get('NODE1'), ...
            'Position', [.33 .02 .1 .8], ...
            'Callback', {@cb_node_1} ...
            );
        set(ui_node2_popmenu, ...
            'Units', 'normalized', ...
            'Tooltip', 'Select the Node to be Plotted.', ...
            'String', node_labels, ...
            'Value', pr.get('NODE2'), ...
            'Position', [.55 .02 .1 .8], ...
            'Callback', {@cb_node_2} ...
            );
        rules_node_popmenu_deactivation()
    end
    function rules_node_popmenu_deactivation()
        if Measure.is_global(pr.m.get('Measure'))
            set(ui_node1_popmenu, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
            set(ui_node2_popmenu, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
            set(node_1_id, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
            set(node_2_id, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
            
        elseif Measure.is_nodal(pr.m.get('Measure'))
            set(ui_node1_popmenu, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
            set(ui_node2_popmenu, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
            set(node_1_id, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
            set(node_2_id, ...
                'Visible', 'off', ...
                'Enable', 'off' ...
                )
            node_1_id.String = 'Brain Region';
            
        else
            set(ui_node1_popmenu, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
            set(ui_node2_popmenu, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
            set(node_1_id, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
            set(node_2_id, ...
                'Visible', 'on', ...
                'Enable', 'on' ...
                )
            node_1_id.String = 'Brain Region 1';
        end
    end
    function cb_node_1(source, ~)
        node1_to_plot = double(source.Value);
        pr.set('NODE1', node1_to_plot)
        update();
    end
    function cb_node_2(source, ~)
        node2_to_plot = double(source.Value);
        pr.set('NODE2', node2_to_plot)
        update();
    end

    layer_selector_id = uicontrol(measure_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Layer Selection', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.66 .02 .1 .8]);

    graph = pr.m.get('A').get('G_Dict').getItem(1);
    layer_number = size(graph.get('B'), 2);
    layer_popup = uicontrol('Parent', measure_panel,...
        'Style', 'popupmenu',...
        'Units', 'normalized', ...
        'String', arrayfun(@(x) [num2str(x)], [1:layer_number], 'UniformOutput', false));
    init_layer_section()
        function init_layer_section()
            set(layer_popup, 'Position', [.77 .02 .1 .8], ...
                'Value', pr.get('LAYER'), ...
                'Callback', {@layer_popup_selector});

        end
        function layer_popup_selector(src, ~)
            layer_to_plot = double(src.Value);
            pr.set('LAYER', layer_to_plot)
            update();
        end
    
    plot_style_panel = uipanel(plot_properties_panel, ...
        'Units', 'normalized', ...
        'BackgroundColor',  pr.h_settings.Color, ...
        'Position', [.01 .01 .98 .84] ...
        );

    line_style_id = uicontrol(plot_style_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Line Style', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .72 .32 .1]);

    ui_line_style = uicontrol(plot_style_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.34 .72 .64 .1], ...
        'String', line_style, ...
        'TooltipString', 'Plot Line Style', ...
        'Callback', {@cb_line_style});

        function cb_line_style(~, ~)  % (src, event)
            val = ui_line_style.Value;
            str = ui_line_style.String;
            pr.set('LINE_STYLE', str{val})
            update()
        end

    line_color_id = uicontrol(plot_style_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Line Color', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .6 .32 .1]);

    ui_line_color = uicontrol(plot_style_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.34 .6 .64 .1], ...
        'String', 'Line Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Plot Line Color', ...
        'Callback', {@cb_line_color});

        function cb_line_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pr.set('LINECOLOR', color)
                update()
            end
        end

    line_width_id = uicontrol(plot_style_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Line Width', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .48 .32 .1]);
    ui_line_width = uicontrol(plot_style_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.34 .48 .64 .1], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_line_width});

        function cb_line_width(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pr.set('LINE_WIDTH', value)
            update()
        end

    % markers
    narker_style_id = uicontrol(plot_style_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Marker Style', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .36 .32 .1]);
    ui_marker_style = uicontrol(plot_style_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.34 .36 .64 .1], ...
        'String', marker_style, ...
        'TooltipString', 'Plot Marker Style', ...
        'Callback', {@cb_marker_style});

        function cb_marker_style(~, ~)  % (src, event)
            val = ui_marker_style.Value;
            str = ui_marker_style.String;
            pr.set('MARKER', str{val})
            update()
        end

    marker_width_id = uicontrol(plot_style_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Marker Width', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .12 .32 .1]);
    ui_marker_size = uicontrol(plot_style_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.34 .12 .64 .1], ...
        'String', '5', ...
        'TooltipString', 'Marker Line Width', ...
        'Callback', {@cb_marker_size});

        function cb_marker_size(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pr.set('MARKER_SIZE', value)
            update()
        end

    marker_edge_id = uicontrol(plot_style_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Marker Edge Color', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .24 .32 .1]);
    ui_marker_edge_color = uicontrol(plot_style_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.34 .24 .64 .1], ...
        'String', 'Marker Edge Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Edge Color', ...
        'Callback', {@cb_marker_edge_color});

        function cb_marker_edge_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pr.set('MARKEREDGECOLOR', color)
                update()
            end
        end

    marker_face_id = uicontrol(plot_style_panel, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'String', 'Marker Face Color', ...
        'BackgroundColor', pr.h_settings.Color, ...
        'Position', [.01 .01 .32 .1]);
    ui_marker_face_color = uicontrol(plot_style_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.34 .01 .64 .1], ...
        'String', 'Marker Face Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Face Color', ...
        'Callback', {@cb_marker_face_color});

        function cb_marker_face_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pr.set('MARKERFACECOLOR', color)
                update()
            end
        end

    init_measure_plot_area()

    if nargin > 0
        f_settings = pr.h_settings;
    end
end
function update_plot(pr)
    measure = pr.m;
    plot_value = measure.get('M');
    graph = pr.m.get('A').get('G_Dict').getItem(1);
    layer_number = size(graph.get('B'), 2);
    choosen_layer = pr.get('LAYER');

    if Measure.is_global(pr.m.get('Measure')) && ~Measure.is_superglobal(pr.m.get('Measure')) % global
        is_inf_vector = cellfun(@(x) isinf(x), plot_value);
        if any(is_inf_vector)
            f = warndlg('The measure cannot be plotted because it contains Inf values.');
            set_braph2icon(f);
            return;
        end
        y_ = [plot_value{choosen_layer:layer_number:end}];
    elseif Measure.is_nodal(pr.m.get('Measure')) && ~Measure.is_superglobal(pr.m.get('Measure')) % nodal
        tmp_index = 1;
        for l = choosen_layer:layer_number:length(plot_value)
            tmp = plot_value{l};
            tmp_y = tmp(pr.get('NODE1'));
            if isinf(tmp_y)
                f = warndlg('The measure cannot be plotted because it contains Inf values.');
                set_braph2icon(f);
                return;
            end
            y_(tmp_index) = tmp_y; %#ok<AGROW>
            tmp_index = tmp_index + 1;
        end
    elseif  Measure.is_binodal(pr.m.get('Measure')) && ~Measure.is_superglobal(pr.m.get('Measure')) % binodal
        tmp_index = 1;
        for l = choosen_layer:layer_number:length(plot_value)
            tmp = plot_value{l};
            tmp_y = tmp(pr.get('NODE1'), pr.get('NODE2'));
            if isinf(tmp_y)
                f = warndlg('The measure cannot be plotted because it contains Inf values.');
                set_braph2icon(f);
                return;
            end
            y_(tmp_index) = tmp_y; %#ok<AGROW>
            tmp_index = tmp_index + 1;
        end
    elseif Measure.is_superglobal(pr.m.get('Measure')) % superglobal
        if Measure.is_global(pr.m.get('Measure'))
            is_inf_vector = cellfun(@(x) isinf(x), plot_value);
            if any(is_inf_vector)
                f = warndlg('The measure cannot be plotted because it contains Inf values.');
                set_braph2icon(f);
                return;
            end
            y_ = [plot_value{:}];
        elseif Measure.is_nodal(pr.m.get('Measure'))
            tmp_index = 1;
            for l = 1:length(plot_value)
                tmp = plot_value{l};
                tmp_y = tmp(pr.get('NODE1'));
                if isinf(tmp_y)
                    f = warndlg('The measure cannot be plotted because it contains Inf values.');
                    set_braph2icon(f);
                    return;
                end
                y_(tmp_index) = tmp_y; %#ok<AGROW>
                tmp_index = tmp_index + 1;
            end
        else
            tmp_index = 1;
            for l = 1:length(plot_value)
                tmp = plot_value{l};
                tmp_y = tmp(pr.get('NODE1'), pr.get('NODE2'));
                if isinf(tmp_y)
                    f = warndlg('The measure cannot be plotted because it contains Inf values.');
                    set_braph2icon(f);
                    return;
                end
                y_(tmp_index) = tmp_y; %#ok<AGROW>
                tmp_index = tmp_index + 1;
            end
        end
    end
    pr.plotline(pr.get('X'), y_)
end
function plotline(pr, x, y)
    pr.h_plot = plot( ...
        pr.h_axes, ...
        x, ...
        y, ...
        'Marker', pr.get('MARKER'), ...
        'MarkerSize', pr.get('MARKER_SIZE'), ...
        'MarkerEdgeColor', pr.get('MARKEREDGECOLOR'), ...
        'MarkerFaceColor', pr.get('MARKERFACECOLOR'), ...
        'LineStyle', pr.get('LINE_STYLE'), ...
        'LineWidth', pr.get('LINE_WIDTH'), ...
        'Color', pr.get('LINECOLOR') ...
        );

    title(pr.h_axes, pr.get('PLOTTITLE'))
    xlabel(pr.h_axes, pr.get('XLABEL'))
    ylabel(pr.h_axes, pr.get('YLABEL'))
end
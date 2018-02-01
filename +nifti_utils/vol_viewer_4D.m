function f = vol_viewer_4D(data, f)
    % Simple viewer for 4D volume
    % NOTE: purposely do not squeeze singleton dimensions

    % Prepare figure
    if ~exist('f','var')
        f = figure();
    end

    clf(f);
    ax = axes('Parent',f,'units','normalized','Position',[0.2000    0.2000    0.6000    0.6000]);

    % Slider for 3rd dimension
    b1 = uicontrol('Parent',f,'Style','slider','units','normalized', ...
        'Position',[0.2000    0.0500    0.6000    0.1000],'Value',1,'min',1,'max',size(data,3), ...
        'Callback',@(es,ed) slider_callback());
    if size(data,3) == 1
        set(b1,'Enable','off');
    end

    t1 = uicontrol('Parent',f,'Style','text','units','normalized', ...
        'Position',[0.8000    0.0800    0.2000    0.0400],'String','text1');

    % Slider for 4th dimension
    b2 = uicontrol('Parent',f,'Style','slider','units','normalized', ...
        'Position',[0.0500    0.2000    0.1000    0.6000],'Value',1,'min',1,'max',size(data,4), ...
        'Callback',@(es,ed) slider_callback());
    if size(data,4) == 1
        set(b2,'Enable','off');
    end

    t2 = uicontrol('Parent',f,'Style','text','units','normalized', ...
        'Position',[0    0.8800    0.2000    0.0400],'String','text2');

    % Initialize
    slider_callback();

    function slider_callback()
        idx1 = 1;
        if size(data,3) ~= 1
            idx1 = round(b1.Value);
        end

        idx2 = 1;
        if size(data,4) ~= 1
            idx2 = round(b2.Value);
        end

        % Show slice
        imshow(data(:,:,idx1,idx2),[],'parent',ax)

        % Update text1
        set(t1,'String',[num2str(idx1) ' of ' num2str(size(data,3))])

        % Update text2
        set(t2,'String',[num2str(idx2) ' of ' num2str(size(data,4))])        
    end
end
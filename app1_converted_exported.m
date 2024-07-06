classdef app1_converted_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure          matlab.ui.Figure
        Toolbar           matlab.ui.container.Toolbar
        LoadFile          matlab.ui.container.toolbar.PushTool
        RightPanel        matlab.ui.container.Panel
        UIAxes_3          matlab.ui.control.UIAxes
        UIAxes_2          matlab.ui.control.UIAxes
        UIAxes2           matlab.ui.control.UIAxes
        UIAxes            matlab.ui.control.UIAxes
        LeftPanel         matlab.ui.container.Panel
        MaxthrButton      matlab.ui.control.StateButton
        MaxaltButton      matlab.ui.control.StateButton
        MaxaccButton      matlab.ui.control.StateButton
        TabGroup          matlab.ui.container.TabGroup
        inoutTab          matlab.ui.container.Tab
        Slider            matlab.ui.control.Slider
        t_fSpinner        matlab.ui.control.Spinner
        t_fSpinnerLabel   matlab.ui.control.Label
        t_0Spinner        matlab.ui.control.Spinner
        t_0SpinnerLabel   matlab.ui.control.Label
        YawButton         matlab.ui.control.StateButton
        PitchButton       matlab.ui.control.StateButton
        RollButton        matlab.ui.control.StateButton
        PlotTab           matlab.ui.container.Tab
        Button4_3         matlab.ui.control.StateButton
        Button4_2         matlab.ui.control.StateButton
        TrajectoryButton  matlab.ui.control.StateButton
    end

    
    properties (Access = public)
        data; % Description
        time_in; time_out; time_thr; time_plot; time_acc; 
        data_in; data_out; data_thr; data_acc;
        flag_inout = false; flag_thr = false;
        lat_rad; lon_rad; alt;
        R = 6371e3;
        x; y; z;
        x1; x2; x3;
        max_thr; max_acc; max_alt;
    end
    
    methods (Access = private)

        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: RollButton
        function RollButtonValueChanged(app, event)
            value = app.RollButton.Value;
            
            if value == true
                cla(app.UIAxes)
                cla(app.UIAxes_2)
                app.PitchButton.Value = false;
                app.YawButton.Value = false;
                
                app.time_in = (app.data.RCIN.RCIN(:,2)-app.data.RCIN.RCIN(1,2)).*1e-6;
                app.data_in = app.data.RCIN.RCIN(:,3)-1500;

                

                app.time_out = (app.data.AHR2.AHR2(:,2)-app.data.AHR2.AHR2(1,2)).*1e-6;
                app.data_out = app.data.AHR2.AHR2(:,3);
                plot(app.UIAxes,app.time_in,app.data_in,'LineWidth',1.8); 
                plot(app.UIAxes_2,app.time_out,app.data_out,'LineWidth',1.8); 
                grid(app.UIAxes,"on"); grid(app.UIAxes_2,"on")
                hold(app.UIAxes,'on')
                hold(app.UIAxes_2,'on')

                j = find(app.time_in <= (app.time_in(end)+app.time_in(1))/2,1,'last');
                app.x1 = xline(app.UIAxes,app.time_in(j),'LineWidth',0.2,'Color','k');
                j = find(app.time_out <= (app.time_out(end)+app.time_out(1))/2,1,'last');
                app.x2 = xline(app.UIAxes_2,app.time_out(j),'LineWidth',0.2,'Color','k');

                if app.flag_inout == false
                    app.t_0Spinner.Value = app.time_in(1);
                    app.t_fSpinner.Value = app.time_in(end);
                    xlim(app.UIAxes,[app.time_in(1) app.time_in(end)]);
                    xlim(app.UIAxes_2,[app.time_in(1) app.time_in(end)]);
                else
                    xlim(app.UIAxes,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                    xlim(app.UIAxes_2,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                end
                ylim(app.UIAxes,[min(app.data_in) max(app.data_in)]);
                ylim(app.UIAxes_2,[min(app.data_out) max(app.data_out)]);

                app.Slider.Limits = [app.time_in(1) app.time_in(end)];

                app.time_thr = (app.data.RCIN.RCIN(:,2)-app.data.RCIN.RCIN(1,2)).*1e-6;
                app.data_thr = app.data.RCIN.RCIN(:,5);

                plot(app.UIAxes_3,app.time_thr,app.data_thr,'LineWidth',1.8,'color',"#0072BD"); 
 
                grid(app.UIAxes_3,"on");
                hold(app.UIAxes_3,'on');

                j = find(app.time_thr <= (app.time_thr(end)+app.time_thr(1))/2,1,'last');
                if ~isempty(app.x3)
                    delete(app.x3);
                end
                app.x3 = xline(app.UIAxes_3,app.time_thr(j),'LineWidth',0.2,'Color','k');

                xlim(app.UIAxes_3,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                ylim(app.UIAxes_3,[min(app.data_thr) max(app.data_thr)]);
                
            end
            if app.flag_inout == false
                app.flag_inout = true;
            end
        end

        % Value changed function: PitchButton
        function PitchButtonValueChanged(app, event)
            value = app.PitchButton.Value;
            if value == true
                cla(app.UIAxes)
                cla(app.UIAxes_2)
                app.RollButton.Value = false;
                app.YawButton.Value = false;
                
                app.time_in = (app.data.RCIN.RCIN(:,2)-app.data.RCIN.RCIN(1,2)).*1e-6;
                app.data_in = app.data.RCIN.RCIN(:,4)-1500;

                

                app.time_out = (app.data.AHR2.AHR2(:,2)-app.data.AHR2.AHR2(1,2)).*1e-6;
                app.data_out = app.data.AHR2.AHR2(:,4);

                plot(app.UIAxes,app.time_in,app.data_in,'LineWidth',1.8);
                plot(app.UIAxes_2,app.time_out,app.data_out,'LineWidth',1.8);
                grid(app.UIAxes,"on"); grid(app.UIAxes_2,"on")
                hold(app.UIAxes,'on')
                hold(app.UIAxes_2,'on')

                j = find(app.time_in <= (app.time_in(end)+app.time_in(1))/2,1,'last');
                app.x1 = xline(app.UIAxes,app.time_in(j),'LineWidth',0.2,'Color','k');
                j = find(app.time_out <= (app.time_out(end)+app.time_out(1))/2,1,'last');
                app.x2 = xline(app.UIAxes_2,app.time_out(j),'LineWidth',0.2,'Color','k');

                if app.flag_inout == false
                    app.t_0Spinner.Value = min(app.time_in);
                    app.t_fSpinner.Value = max(app.time_in);
                    xlim(app.UIAxes,[app.time_in(1) app.time_in(end)]);
                    xlim(app.UIAxes_2,[app.time_in(1) app.time_in(end)]);
                else
                    xlim(app.UIAxes,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                    xlim(app.UIAxes_2,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                end
                ylim(app.UIAxes,[min(app.data_in) max(app.data_in)]);
                ylim(app.UIAxes_2,[min(app.data_out) max(app.data_out)]);

                app.Slider.Limits = [app.time_in(1) app.time_in(end)];

                app.time_thr = (app.data.RCIN.RCIN(:,2)-app.data.RCIN.RCIN(1,2)).*1e-6;
                app.data_thr = app.data.RCIN.RCIN(:,5);

                plot(app.UIAxes_3,app.time_thr,app.data_thr,'LineWidth',1.8,'color',"#0072BD"); 
 
                grid(app.UIAxes_3,"on");
                hold(app.UIAxes_3,'on');

                j = find(app.time_thr <= (app.time_thr(end)+app.time_thr(1))/2,1,'last');
                if ~isempty(app.x3)
                    delete(app.x3);
                end
                app.x3 = xline(app.UIAxes_3,app.time_thr(j),'LineWidth',0.2,'Color','k');

                xlim(app.UIAxes_3,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                ylim(app.UIAxes_3,[min(app.data_thr) max(app.data_thr)]);

            end
            if app.flag_inout == false
                app.flag_inout = true;
            end
        end

        % Value changed function: YawButton
        function YawButtonValueChanged(app, event)
            value = app.YawButton.Value;
            if value == true
                cla(app.UIAxes)
                cla(app.UIAxes_2)
                app.PitchButton.Value = false;
                app.RollButton.Value = false;
                
                app.time_in = (app.data.RCIN.RCIN(:,2)-app.data.RCIN.RCIN(1,2)).*1e-6;
                app.data_in = app.data.RCIN.RCIN(:,6)-1500;
                
                

                app.time_out = (app.data.AHR2.AHR2(:,2)-app.data.AHR2.AHR2(1,2)).*1e-6;
                app.data_out = app.data.AHR2.AHR2(:,5);
                
                
                plot(app.UIAxes,app.time_in,app.data_in,'LineWidth',1.8);
                plot(app.UIAxes_2,app.time_out,app.data_out,'LineWidth',1.8);
                grid(app.UIAxes,"on"); grid(app.UIAxes_2,"on")
                hold(app.UIAxes,'on')
                hold(app.UIAxes_2,'on')

                j = find(app.time_in <= (app.time_in(end)+app.time_in(1))/2,1,'last');
                app.x1 = xline(app.UIAxes,app.time_in(j),'LineWidth',0.2,'Color','k');
                j = find(app.time_out <= (app.time_out(end)+app.time_out(1))/2,1,'last');
                app.x2 = xline(app.UIAxes_2,app.time_out(j),'LineWidth',0.2,'Color','k');
                
                if app.flag_inout == false
                    app.t_0Spinner.Value = app.time_in(1);
                    app.t_fSpinner.Value = app.time_in(end);
                    xlim(app.UIAxes,[app.time_in(1) app.time_in(end)]);
                    xlim(app.UIAxes_2,[app.time_in(1) app.time_in(end)]);
                else
                    xlim(app.UIAxes,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                    xlim(app.UIAxes_2,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                end
                ylim(app.UIAxes,[min(app.data_in) max(app.data_in)]);
                ylim(app.UIAxes_2,[min(app.data_out) max(app.data_out)]);
                app.Slider.Limits = [app.time_in(1) app.time_in(end)];
                
                app.time_thr = (app.data.RCIN.RCIN(:,2)-app.data.RCIN.RCIN(1,2)).*1e-6;
                app.data_thr = app.data.RCIN.RCIN(:,5);

                plot(app.UIAxes_3,app.time_thr,app.data_thr,'LineWidth',1.8,'color',"#0072BD"); 
 
                grid(app.UIAxes_3,"on");
                hold(app.UIAxes_3,'on');

                j = find(app.time_thr <= (app.time_thr(end)+app.time_thr(1))/2,1,'last');
                if ~isempty(app.x3)
                    delete(app.x3);
                end
                app.x3 = xline(app.UIAxes_3,app.time_thr(j),'LineWidth',0.2,'Color','k');

                xlim(app.UIAxes_3,[app.t_0Spinner.Value app.t_fSpinner.Value]);
                ylim(app.UIAxes_3,[min(app.data_thr) max(app.data_thr)]);
            end
            if app.flag_inout == false
                app.flag_inout = true;
            end
        end

        % Value changed function: t_0Spinner
        function t_0SpinnerValueChanged(app, event)
            if app.t_0Spinner.Value < min(app.time_in)
                app.t_fSpinner = min(app.time_in);
            end
            if app.t_0Spinner.Value >= app.t_fSpinner.Value
                app.t_fSpinner.Value = app.t_0Spinner.Value+1;
            end
            i = find(app.time_in >= app.t_0Spinner.Value,1,'first');
            j = find(app.time_in <= app.t_fSpinner.Value,1,'last');
            h = find(app.time_out >= app.t_0Spinner.Value,1,'first');
            k = find(app.time_out <= app.t_fSpinner.Value,1,'last');
            xlim(app.UIAxes,[app.time_in(i) app.time_in(j)]);
            xlim(app.UIAxes_2,[app.time_out(h) app.time_out(k)]);

            i = find(app.time_thr >= app.t_0Spinner.Value,1,'first');
            j = find(app.time_thr <= app.t_fSpinner.Value,1,'last');
            xlim(app.UIAxes_3,[app.time_thr(i) app.time_thr(j)]);

            app.Slider.Value = ((app.t_fSpinner.Value+app.t_0Spinner.Value)/2);
            
        end

        % Value changed function: t_fSpinner
        function t_fSpinnerValueChanged(app, event)
            if app.t_fSpinner.Value > max(app.time_in)
                app.t_fSpinner.Value = max(app.time_in);
            end
            if app.t_0Spinner.Value >= app.t_fSpinner.Value
                app.t_fSpinner.Value = app.t_fSpinner.Value-1;
            end
            i = find(app.time_in >= app.t_0Spinner.Value,1,'first');
            j = find(app.time_in <= app.t_fSpinner.Value,1,'last');
            h = find(app.time_out >= app.t_0Spinner.Value,1,'first');
            k = find(app.time_out <= app.t_fSpinner.Value,1,'last');
            xlim(app.UIAxes,[app.time_in(i) app.time_in(j)]);
            xlim(app.UIAxes_2,[app.time_out(h) app.time_out(k)]);
            
            i = find(app.time_thr >= app.t_0Spinner.Value,1,'first');
            j = find(app.time_thr <= app.t_fSpinner.Value,1,'last');
            xlim(app.UIAxes_3,[app.time_thr(i) app.time_thr(j)]);
    
            app.Slider.Value = ((app.t_fSpinner.Value+app.t_0Spinner.Value)/2);
            



        end

        % Value changed function: Slider
        function SliderValueChanged(app, event)
            value = app.Slider.Value;
            
            delta_t = app.t_fSpinner.Value-app.t_0Spinner.Value;
            
            if delta_t < app.time_in(end)-app.time_in(1)
                xlim(app.UIAxes,([-delta_t delta_t]./2)+value);
                xlim(app.UIAxes_2,([-delta_t delta_t]./2)+value);
                app.t_0Spinner.Value = -delta_t/2+value;
                app.t_fSpinner.Value = delta_t/2+value;
            end
            if value-delta_t <= app.time_in(1)
                xlim(app.UIAxes,[app.time_in(1) ( delta_t./2)+value]);
                xlim(app.UIAxes_2,[app.time_in(1) ( delta_t./2)+value]);
                app.t_0Spinner.Value = app.time_in(1);
                app.t_fSpinner.Value = delta_t/2+value;
            end
            if value+delta_t >= app.time_in(end)
                xlim(app.UIAxes,[-( delta_t./2)+value app.time_in(end)]);
                xlim(app.UIAxes_2,[-( delta_t./2)+value app.time_in(end)]);
                app.t_0Spinner.Value = -delta_t/2+value;
                app.t_fSpinner.Value = app.time_in(end);
            end


            



            
            
        end

        % Value changing function: Slider
        function SliderValueChanging(app, event)
            changingValue = event.Value;
            delta_t = app.t_fSpinner.Value-app.t_0Spinner.Value;
            
            if delta_t < app.time_in(end)-app.time_in(1)
                xlim(app.UIAxes,([-delta_t delta_t]./2)+changingValue);
                xlim(app.UIAxes_2,([-delta_t delta_t]./2)+changingValue);
                app.t_0Spinner.Value = -delta_t/2+changingValue;
                app.t_fSpinner.Value = delta_t/2+changingValue;
            end
            if changingValue  <= app.time_in(1)
                xlim(app.UIAxes,[app.time_in(1) ( delta_t./2)+changingValue]);
                xlim(app.UIAxes_2,[app.time_in(1) ( delta_t./2)+changingValue]);
                app.t_0Spinner.Value = app.time_in(1);
                app.t_fSpinner.Value = delta_t/2+changingValue;
            end
            if changingValue >= app.time_in(end)
                xlim(app.UIAxes,[-( delta_t./2)+changingValue app.time_in(end)]);
                xlim(app.UIAxes_2,[-( delta_t./2)+changingValue app.time_in(end)]);
                app.t_0Spinner.Value = -delta_t/2+changingValue;
                app.t_fSpinner.Value = app.time_in(end);
            end
            if app.TrajectoryButton.Value == true
                cla(app.UIAxes2);
                grid(app.UIAxes2,"on")
                traj = plot3(app.UIAxes2,nan,nan,nan,'LineWidth',1.6); hold(app.UIAxes2,"on");
                dot = plot3(app.UIAxes2,nan,nan,nan,'or','MarkerFaceColor',"#A2142F",'MarkerSize',5,'Marker','o');

                j = find(app.time_plot <= app.t_fSpinner.Value,1,'last');
                set(traj,'XData',app.x,'YData',app.y,'ZData',app.z);
                set(dot,'XData',app.x(j),'YData',app.y(j),'ZData',app.z(j));
            end
            j = find(app.time_in <= app.Slider.Value,1,'last');
            delete(app.x1)
            app.x1 = xline(app.UIAxes,app.time_in(j),'LineWidth',0.2,'Color','k');
            j = find(app.time_out <= app.Slider.Value,1,'last');
            delete(app.x2)
            app.x2 = xline(app.UIAxes_2,app.time_out(j),'LineWidth',0.2,'Color','k');
            j = find(app.time_thr <= app.Slider.Value,1,'last');
            delete(app.x3)
            app.x3 = xline(app.UIAxes_3,app.time_thr(j),'LineWidth',0.2,'Color','k');
            
        end

        % Value changed function: TrajectoryButton
        function TrajectoryButtonValueChanged(app, event)
            value = app.TrajectoryButton.Value;
            if value == true
                cla(app.UIAxes2);
                grid(app.UIAxes2,"on")
                traj = plot3(app.UIAxes2,nan,nan,nan,'LineWidth',1.6); hold(app.UIAxes2,"on");
                dot = plot3(app.UIAxes2,nan,nan,nan,'or','MarkerFaceColor',"#A2142F",'MarkerSize',5,'Marker','o');

                app.data.GPS_0.GPS_0
                app.time_plot = (app.data.GPS_0.GPS_0(:,2)-app.data.GPS_0.GPS_0(1,2)).*1e-6;
                app.lat_rad = deg2rad(app.data.GPS_0.GPS_0(:,9));
                app.lon_rad = deg2rad(app.data.GPS_0.GPS_0(:,10));
                app.R = 6371e3;
                app.alt = (app.data.GPS_0.GPS_0(:,11));
                app.x = app.R .* cos(app.lat_rad) .* cos(app.lon_rad);
                app.y = app.R .* cos(app.lat_rad) .* sin(app.lon_rad);
                app.z = app.alt;
                app.x = app.x-min(app.x);
                app.y = app.y-min(app.y);
                
                j = find(app.time_plot <= app.t_fSpinner.Value,1,'last');
    
                set(traj,'XData',app.x,'YData',app.y,'ZData',app.z);
            end
            
            
        end

        % Key press function: UIFigure
        function UIFigureKeyPress(app, event)
            key = event.Key;
            switch key
                case 'leftarrow'
                    if app.Slider.Value - 0.1 >= app.time_in(1)
                       app.Slider.Value = app.Slider.Value - 0.1;
                    end
                case 'rightarrow'
                    if app.Slider.Value + 0.1 <= app.time_in(end)
                       app.Slider.Value = app.Slider.Value + 0.1;
                    end
            end
            value = app.Slider.Value;
            
            delta_t = app.t_fSpinner.Value-app.t_0Spinner.Value;
            
            if delta_t < app.time_in(end)-app.time_in(1)
                xlim(app.UIAxes,([-delta_t delta_t]./2)+value);
                xlim(app.UIAxes_2,([-delta_t delta_t]./2)+value);
                xlim(app.UIAxes_3,([-delta_t delta_t]./2)+value);
                app.t_0Spinner.Value = -delta_t/2+value;
                app.t_fSpinner.Value = delta_t/2+value;
            end
            if value <= app.time_in(1)
                xlim(app.UIAxes,[app.time_in(1) ( delta_t./2)+value]);
                xlim(app.UIAxes_2,[app.time_in(1) ( delta_t./2)+value]);
                xlim(app.UIAxes_3,[app.time_in(1) ( delta_t./2)+value]);
                app.t_0Spinner.Value = app.time_in(1);
                app.t_fSpinner.Value = delta_t/2+value;
            end
            if value >= app.time_in(end)
                xlim(app.UIAxes,[-( delta_t./2)+value app.time_in(end)]);
                xlim(app.UIAxes_2,[-( delta_t./2)+value app.time_in(end)]);
                xlim(app.UIAxes_3,[-( delta_t./2)+value app.time_in(end)]);
                app.t_0Spinner.Value = -delta_t/2+value;
                app.t_fSpinner.Value = app.time_in(end);
            end
            if delta_t >= app.time_in(end)-app.time_in(1)
                xlim(app.UIAxes,[app.time_in(1) app.time_in(end)]);
                xlim(app.UIAxes_2,[app.time_out(1) app.time_out(end)]);
                xlim(app.UIAxes_3,[app.time_thr(1) app.time_thr(end)]);
                app.t_0Spinner.Value = app.time_in(1);
                app.t_fSpinner.Value = app.time_in(end);
            end
            if app.TrajectoryButton.Value == true
                cla(app.UIAxes2);
                grid(app.UIAxes2,"on")
                traj = plot3(app.UIAxes2,nan,nan,nan,'LineWidth',1.6); hold(app.UIAxes2,"on");
                dot = plot3(app.UIAxes2,nan,nan,nan,'or','MarkerFaceColor',"#A2142F",'MarkerSize',5,'Marker','o');

                j = find(app.time_plot <= app.Slider.Value,1,'last');
                set(traj,'XData',app.x,'YData',app.y,'ZData',app.z);
                set(dot,'XData',app.x(j),'YData',app.y(j),'ZData',app.z(j));
            end
            j = find(app.time_in <= app.Slider.Value,1,'last');
            delete(app.x1)
            app.x1 = xline(app.UIAxes,app.time_in(j),'LineWidth',0.2,'Color','k');
            j = find(app.time_out <= app.Slider.Value,1,'last');
            delete(app.x2)
            app.x2 = xline(app.UIAxes_2,app.time_out(j),'LineWidth',0.2,'Color','k');
            j = find(app.time_thr <= app.Slider.Value,1,'last');
            delete(app.x3)
            app.x3 = xline(app.UIAxes_3,app.time_thr(j),'LineWidth',0.2,'Color','k');
            
            
        end

        % Callback function: LoadFile
        function LoadFileClicked(app, event)
            [file, path] = uigetfile({'*.*', 'All Files'; '*.mat', 'MAT-files (*.mat)'}, 'Select a File');
            
            if isequal(file, 0)
                disp('User selected Cancel');
            else
                fullFileName = fullfile(path, file);
                disp(['User selected ', fullFileName]);
               
                info = whos('-file', fullFileName);
                dataStruct = struct();

                for i = 1:length(info)
                    varName = info(i).name;

                 
                    
                    if isvarname(varName)
                        dataStruct.(varName) = load(fullFileName,varName);
                    else
                        newVarName = matlab.lang.makeValidName(varName);
                        dataStruct.(newVarName) = load(fullFileName,newVarName);
                        %warning(['Rinominato il campo "', varName, '" in "', newVarName, '" per essere un nome di campo valido.']);
                    end
                end
                app.data= dataStruct;
            end
        end

        % Value changed function: MaxthrButton
        function MaxthrButtonValueChanged(app, event)
            value = app.MaxthrButton.Value;
            if value == true
                % app.time_thr = app.data.RCIN.RCIN(:,2);
                % app.data_thr = app.data.RCIN.RCIN(:,5);
                % j = find(app.data_thr>=max(app.data_thr).*0.95);
                % j = find(app.time_plot~=app.time_thr(j));
                % app.max_thr = plot3(app.UIAxes2,app.x(j),app.y(j),app.z(j),'Color','r');
            elseif value == false
                delete(app.max_thr);
            end

            if app.flag_thr == false
                app.flag_thr = true;
            end
        end

        % Value changed function: MaxaccButton
        function MaxaccButtonValueChanged(app, event)
            value = app.MaxaccButton.Value;
            if value == true
                app.time_acc = app.data.ACC_0.ACC_0(:,2);
                acc = (vecnorm([app.data.ACC_0.ACC_0(:,5) app.data.ACC_0.ACC_0(:,6) app.data.ACC_0.ACC_0(:,7)],2,2));
                j = find(acc>=max(acc).*0.90);
                app.max_thr = plot3(app.UIAxes2,app.x(j),app.y(j),app.z(j),'Color','r');
            elseif value == false
                delete(app.max_thr);
            end
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1367 720];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.KeyPressFcn = createCallbackFcn(app, @UIFigureKeyPress, true);

            % Create Toolbar
            app.Toolbar = uitoolbar(app.UIFigure);

            % Create LoadFile
            app.LoadFile = uipushtool(app.Toolbar);
            app.LoadFile.ClickedCallback = createCallbackFcn(app, @LoadFileClicked, true);
            app.LoadFile.Separator = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.UIFigure);
            app.LeftPanel.Position = [1 1 220 720];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.LeftPanel);
            app.TabGroup.Position = [0 393 219 326];

            % Create inoutTab
            app.inoutTab = uitab(app.TabGroup);
            app.inoutTab.Title = 'in/out';

            % Create RollButton
            app.RollButton = uibutton(app.inoutTab, 'state');
            app.RollButton.ValueChangedFcn = createCallbackFcn(app, @RollButtonValueChanged, true);
            app.RollButton.Text = 'Roll';
            app.RollButton.Position = [59 243 100 23];

            % Create PitchButton
            app.PitchButton = uibutton(app.inoutTab, 'state');
            app.PitchButton.ValueChangedFcn = createCallbackFcn(app, @PitchButtonValueChanged, true);
            app.PitchButton.Text = 'Pitch';
            app.PitchButton.Position = [60 204 100 23];

            % Create YawButton
            app.YawButton = uibutton(app.inoutTab, 'state');
            app.YawButton.ValueChangedFcn = createCallbackFcn(app, @YawButtonValueChanged, true);
            app.YawButton.Text = 'Yaw';
            app.YawButton.Position = [59 163 100 23];

            % Create t_0SpinnerLabel
            app.t_0SpinnerLabel = uilabel(app.inoutTab);
            app.t_0SpinnerLabel.HorizontalAlignment = 'right';
            app.t_0SpinnerLabel.Position = [20 110 25 22];
            app.t_0SpinnerLabel.Text = 't_0';

            % Create t_0Spinner
            app.t_0Spinner = uispinner(app.inoutTab);
            app.t_0Spinner.ValueChangedFcn = createCallbackFcn(app, @t_0SpinnerValueChanged, true);
            app.t_0Spinner.Position = [60 110 100 22];

            % Create t_fSpinnerLabel
            app.t_fSpinnerLabel = uilabel(app.inoutTab);
            app.t_fSpinnerLabel.HorizontalAlignment = 'right';
            app.t_fSpinnerLabel.Position = [20 69 25 22];
            app.t_fSpinnerLabel.Text = 't_f';

            % Create t_fSpinner
            app.t_fSpinner = uispinner(app.inoutTab);
            app.t_fSpinner.ValueChangedFcn = createCallbackFcn(app, @t_fSpinnerValueChanged, true);
            app.t_fSpinner.Position = [60 69 100 22];

            % Create Slider
            app.Slider = uislider(app.inoutTab);
            app.Slider.ValueChangedFcn = createCallbackFcn(app, @SliderValueChanged, true);
            app.Slider.ValueChangingFcn = createCallbackFcn(app, @SliderValueChanging, true);
            app.Slider.Position = [20 49 175 3];

            % Create PlotTab
            app.PlotTab = uitab(app.TabGroup);
            app.PlotTab.Title = 'Plot';

            % Create TrajectoryButton
            app.TrajectoryButton = uibutton(app.PlotTab, 'state');
            app.TrajectoryButton.ValueChangedFcn = createCallbackFcn(app, @TrajectoryButtonValueChanged, true);
            app.TrajectoryButton.Text = 'Trajectory';
            app.TrajectoryButton.Position = [58 229 100 23];

            % Create Button4_2
            app.Button4_2 = uibutton(app.PlotTab, 'state');
            app.Button4_2.Text = 'Button4';
            app.Button4_2.Position = [58 186 100 23];

            % Create Button4_3
            app.Button4_3 = uibutton(app.PlotTab, 'state');
            app.Button4_3.Text = 'Button4';
            app.Button4_3.Position = [60 141 100 23];

            % Create MaxaccButton
            app.MaxaccButton = uibutton(app.LeftPanel, 'state');
            app.MaxaccButton.ValueChangedFcn = createCallbackFcn(app, @MaxaccButtonValueChanged, true);
            app.MaxaccButton.Text = 'Max acc';
            app.MaxaccButton.Position = [59 256 100 23];

            % Create MaxaltButton
            app.MaxaltButton = uibutton(app.LeftPanel, 'state');
            app.MaxaltButton.Text = 'Max alt';
            app.MaxaltButton.Position = [59 216 100 23];

            % Create MaxthrButton
            app.MaxthrButton = uibutton(app.LeftPanel, 'state');
            app.MaxthrButton.ValueChangedFcn = createCallbackFcn(app, @MaxthrButtonValueChanged, true);
            app.MaxthrButton.Text = 'Max thr';
            app.MaxthrButton.Position = [60 297 100 23];

            % Create RightPanel
            app.RightPanel = uipanel(app.UIFigure);
            app.RightPanel.Position = [220 1 1149 720];

            % Create UIAxes
            app.UIAxes = uiaxes(app.RightPanel);
            title(app.UIAxes, 'RCIN')
            app.UIAxes.PlotBoxAspectRatio = [1.95384615384615 1 1];
            app.UIAxes.Position = [1 483 557 234];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.RightPanel);
            title(app.UIAxes2, 'Plot')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [496 11 637 695];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.RightPanel);
            title(app.UIAxes_2, 'AHR2')
            app.UIAxes_2.PlotBoxAspectRatio = [1.95384615384615 1 1];
            app.UIAxes_2.Position = [1 255 557 234];

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.RightPanel);
            title(app.UIAxes_3, 'Throttle')
            app.UIAxes_3.PlotBoxAspectRatio = [1.95384615384615 1 1];
            app.UIAxes_3.Position = [1 22 557 234];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_converted_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
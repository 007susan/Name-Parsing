f = figure('Position', [680, 558, 560, 340]);
myax = axes(f, 'Position', [ 0.1100, 0.14, 0.5650, 0.7950]);

% Create controls
name_title = uicontrol(f, 'Style', 'text', 'String', 'Enter Name', 'Position', [400, 290, 120, 20]);
txt_name = uicontrol(f, 'Style', 'edit','Position', [400, 270, 120, 20]);

gender_title = uicontrol(f, 'Style', 'text', 'String', 'Select Gender', 'Position', [400, 240, 120, 20]);
gender_choices = char('M', 'F');
gender_options = uicontrol(f, 'Style', 'popup', 'String', gender_choices, 'Position', [400, 220, 120, 20]);

display_title = uicontrol(f, 'Style', 'text', 'String', 'Display  Type', 'Position', [400, 190, 120, 20]);
display_choices = char('Occurrences', 'Popularity');
display_options = uicontrol(f, 'Style', 'popup', 'String', display_choices, 'Position', [400, 170, 120, 20]);

plot_button =  uicontrol(f, 'Style', 'pushbutton', 'String', 'Plot now!', 'fontsize', 8, 'callback', {@plotButtonPushed, txt_name, gender_options, display_options}, 'Position', [400, 120, 120, 30]);

% Button callback function
function plotButtonPushed(~, ~, txt_name, gender_options, display_options)

% Get gender into a string format to concatenate the file name to open
if gender_options.Value == 1
    gender = 'M';
elseif gender_options.Value == 2
    gender = 'F';
end

to_open = strcat(pwd, '/parsed/', txt_name.String, '_', gender, '.txt');
            if isfile(to_open)
                fid = fopen(to_open);
                tline = fgetl(fid);
                year = [];
                name_occurrences = [];
                total_occurrences = [];
                name_per_thousand = [];
                total_x = 0;
                total_y = 0;
                iterations = 0;
                while ischar(tline)
                    % Parse data accordingly
                    C = strsplit(tline,',');
                    year = [year, str2double(C(1))];
                    name_occurrences = [name_occurrences, str2double(C(2))];
                    total_occurrences = [total_occurrences, str2double(C(3))];
                    name_per_thousand = [name_per_thousand, (str2double(C(2)) / str2double(C(3)) * 1000)];
                    
                    % Get data for each best fit of line based on option
                    if display_options.Value == 1
                        total_x = total_x + str2double(C(1));
                        total_y = total_y + str2double(C(3));
                    elseif display_options.Value == 2
                        total_x = total_x + str2double(C(1));
                        total_y = total_y + (str2double(C(2)) / str2double(C(3)) * 1000);
                    end
                    iterations = iterations + 1;
                    
                    tline = fgetl(fid);
                end
                
                average_x = total_x / iterations;
                average_y = total_y / iterations;
                
                total_crossProduct = 0;
                total_xSquare_total = 0;
                
                for i = 1 : iterations
                    diff_x = year(i) - average_x;
                    if display_options.Value == 1
                        diff_y = total_occurrences(i) - average_y;
                    elseif display_options.Value == 2
                        diff_y = name_per_thousand(i) - average_y;
                    end
                    cross_product = diff_x * diff_y;
                    total_crossProduct = total_crossProduct + cross_product;
                    total_xSquare_total = total_xSquare_total + (diff_x * diff_x);
                end
                
                gradient = total_crossProduct / total_xSquare_total;
                
                y_intercept = average_y - gradient * average_x;
                % Set boundaries, years are only 1880-2020
                x_to_plot = 1880:2020;
                
                y_to_plot =  gradient * x_to_plot + y_intercept;
                
                fclose(fid);
                % Plot our data and line of fits
                if display_options.Value == 1
                    plot(year, total_occurrences, 'b.',  x_to_plot, y_to_plot, 'r-');
                    ylabel('Instances of this name');
                elseif display_options.Value == 2
                    plot(year, name_per_thousand, 'b.', x_to_plot, y_to_plot, 'r-');   
                    ylabel('Popularity per thousand instances');
                end
                title(txt_name.String);
                xlabel('Year')
            else
                title('Invalid Search');
            end
    
end
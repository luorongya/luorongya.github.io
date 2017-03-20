%%
x1 = 0:0.1:40;
y1 = 4.*cos(x1)./(x1+2);
x2 = 1:0.2:20;
y2 = x2.^2./x2.^3;
xt1 = datetime(2016,11,25,10,00,00) + minutes(0:0.25:100);
xt2 = datetime(2016,11,25,10,00,00) + minutes(52.5:0.5:100);

% create figure with number as x-axis
figure
subplot(1,2,1)
yyaxis left
plot(x1,y1)
yyaxis right
plot(x2,y2)
title('Number as x axis')

% create figure with time as x-axis
subplot(1,2,2)
yyaxis left
plot(xt1,y1)
yyaxis right
plot(xt2,y2)
title('Time as x axis')

%%
% Create the data to plot.
x1 = 0:0.1:40;
y1 = 4.*cos(x1)./(x1+2);
x2 = 1:0.2:20;
y2 = x2.^2./x2.^3;

% Use the |line| function to plot |y1| versus |x1| using a red line. Set
% the color for the _x_-axis and _y_-axis to red. 
figure
line(x1,y1,'Color','r')
ax1 = gca; % current axes
ax1.XColor = 'r';
ax1.YColor = 'r';

% Create a second axes in the same location as the first axes by setting
% the position of the second axes equal to the position of the first axes.
% Specify the location of the _x_-axis as the top of the graph and the
% _y_-axis as the right side of the graph. Set the axes |Color| to |'none'|
% so that the first axes is visible underneath the second axes.
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');

% Use the |line| function to plot |y2| versus |x2| on the second axes.
% Set the line color to black so that it matches the color of the
% corresponding _x_-axis and _y_-axis.
line(x2,y2,'Parent',ax2,'Color','k')

%%
clear
close all
% create plot data and axes
x1 = 0:0.1:40;
xt1 = datenum(datetime(2016,11,25,10,00,00) + minutes(0:0.25:100));
y1 = 4.*cos(x1)./(x1+2);

figure
h1 = line(x1,y1,'Color','b');
h1.LineWidth = 2.0;
ax1 = gca; % current axes
ax1.FontName = 'Times New Roman';
ax1.LineWidth = 1.5;
ax1.FontSize = 14;
ax1.FontWeight = 'bold';
xlabel('Length \it{pts}')
ylabel('Amplitude \it{mV}')
grid on
grid minor
legend('\it{Test Result}')
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
ax2.XLim = [xt1(1) xt1(end)];
ax2.YTick = [];
ax2.FontName = 'Times New Roman';
ax2.LineWidth = 1.5;
ax2.FontSize = 14;
ax2.FontWeight = 'bold';
datetick('x','HH:MM','keeplimits'); 

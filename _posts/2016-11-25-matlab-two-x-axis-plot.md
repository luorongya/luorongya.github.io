---
layout: page
title: "在 MATLAB 中作双轴图的方法"
excerpt: "A method to label x axis with length and time at the same time"
modified: 2017-03-02
categories: articles
tags: [MATLAB]
---

## 一. 双 y 轴作图示例

要把同一时间段采集的不同数据画在 MATLAB 的同一个图中，两条曲线共用一条 x 轴（即时间轴），添加两个区间值不一样的 y 轴对应两种数据可以很方便进行操作，之前有 plotyy 而现在有 yyaxis。

下面是 yyaxis 的一个简单的示例。

{% highlight matlab %}

    % Create data and axes to plot.
    x1 = 0:0.1:40;
    y1 = 4.*cos(x1)./(x1+2);
    x2 = 1:0.2:20;
    y2 = x2.^2./x2.^3;
    xt1 = datetime(2016,11,25,10,00,00) + minutes(0:0.25:100);
    xt2 = datetime(2016,11,25,10,00,00) + minutes(52.5:0.5:100);

    % Create a figure with number as the x-axis.
    figure
    subplot(1,2,1)
    yyaxis left
    plot(x1,y1)
    yyaxis right
    plot(x2,y2)
    title('Number as x axis')

    % Create a figure with time as the x-axis.
    subplot(1,2,2)
    yyaxis left
    plot(xt1,y1)
    yyaxis right
    plot(xt2,y2)
    title('Time as x axis')

{% endhighlight %}

![图1 yyaxis 使用例子]({{site.url}}/images/posts/matlab_2_x_axes_1.png)

需要注意的是横轴为采样长度的时候，若两条数据线长度不一样，将会按照采样频率为 1 作为默认进行作图，因此数据量较少的一条数据将会缺掉一段。而用时间轴进行作图的时候，MATLAB 会自行按照时间轴进行对准，无需过多关注数据长度。但要注意的是，每一条数据的时间横轴的长度要和各自的数据量一致，否则会报错。

## 二. 双 x 轴作图

如果想用两种方式来表达 x 轴，一种用采样长度表示数据量的多寡、另一种用时间表示时间跨度的长短，似乎并没有原生函数可以直接实现这个功能。官方文档给出了一个示例，先作一条曲线的图，然后将原来的下方的 x 轴和左侧的 y 轴的属性拷贝一份，将位置属性更改为 x 上轴和右侧的 y 轴，以此为轴再进行作图。

{% highlight matlab %}

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

{% endhighlight %}

![图2 官方样例]({{site.url}}/images/posts/matlab_2_x_axes_2.png)

## 三. 一条曲线的双 x 轴作图及优化

但这还没有达到我想要的结果。

我需要的是用两个 x 轴来表达同一条曲线，而上述的方法如果直接嫁接过来的话，需要将同一条曲线进行两次作图，如果图中数据量很大，重复作图再保存成 .fig 格式的数据图片格式文件，显然是非常多余的。

在不进行第二次作图的前提下进行更改上方 x 轴的 label tick 是可以实现的，同时，既然是同一条曲线，右侧 y 轴的值应该和左侧一致，那么应该直接让它为空最佳。

一个代码示例如下。

{% highlight matlab %}

    % Create data and axes to plot
    x1 = 0:0.1:40;
    xt1 = datenum(datetime(2016,11,25,10,00,00) + minutes(0:0.25:100));
    y1 = 4.*cos(x1)./(x1+2);

    figure
    line(x1,y1)
    ax1 = gca; % current axes
    ax1_pos = ax1.Position; % position of first axes
    ax2 = axes('Position',ax1_pos,...
        'XAxisLocation','top',...
        'YAxisLocation','right',...
        'Color','none');
    ax2.XLim = [xt1(1) xt1(end)];
    ax2.YTick = []; % Set the right y axis to void.
    datetick('x','HH:MM','keeplimits');


{% endhighlight %}

需要注意的是要进行 XLim 操作，需要将横轴转换为 datenum 格式的日期，而不能直接用 datetime 格式的矢量进行操作。

![一条曲线两条x轴]({{site.url}}/images/posts/matlab_2_x_axes_3.png)

Done!

下面就可以为了迎合制作 ppt 的清晰准确的需求，进行无聊而冗余的 Art work 了。

![一条曲线两条x轴2]({{site.url}}/images/posts/matlab_2_x_axes_4.png)
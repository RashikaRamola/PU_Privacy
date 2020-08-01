function rect = setFigureSize(gcf, ratio, type)
% set the figure size to the default
% modified from hgrc.m
% ratio:  ratio to the standard size
% type: 
%	'r': relative to the current size;
%	'a': absolute size;
%	'f': full screen size
% Yong Fuga Li
% Mar.02.2010; Apr.18,2010
% Allow ratio to be a vector of two values, 06072010,
whichMonitor = 'big'; % use the biggest monitor
% whichMonitor = 'small'; % use the smallest monitor
if ~exist('type','var')
    type = 'r'; % 'r': relative to the current size;'a': absolute size; 'f': full screen size
end
if ~exist('ratio','var') % ratio to the standard size
    ratio = 1;
end

if numel(ratio) == 1
    ratio = repmat(ratio,2,1);
end

cname = computer;
monitors = get(0, 'MonitorPositions');

if strcmp(whichMonitor, 'big')
% find the monitor with the biggest size;
    sizeMonitors = (monitors(:,3)-monitors(:,1)+1).*(monitors(:,4)-monitors(:,2)+1);
    [~,i] = max(sizeMonitors);
    screen = monitors(i,:);
elseif strcmp(whichMonitor, 'small')
    if size(monitors,1) > 1
      for i = 1:size(monitors,1)
        if monitors(i,1) < screen(1) && monitors(i,2) < screen(2)
          screen = monitors(i,:);
        end
      end
    end
end
width = screen(3) - screen(1);
height = screen(4) - screen(2);
if any(screen(3:4) ~= 1)  % don't change default if screensize == [1 1]
  if all(cname(1:2) == 'PC')
    if height >= 500
      mwwidth = 560; mwheight = 420;
      if(get(0,'screenpixelsperinch') == 116) % large fonts
        mwwidth = mwwidth * 1.2;
        mwheight = mwheight * 1.2;
      end
    else
      mwwidth = 560; mwheight = 375;
    end
    left = screen(1) + (width - mwwidth)/2;
    bottom = (height - mwheight)/2 + screen(2);
  else
    if height > 768
      mwwidth = 560; mwheight = 420;
      left = screen(1) + (width-mwwidth)/2;
      bottom = height-mwheight -100 - screen(2);
    else  % for screens that aren't so high
      mwwidth = 512; mwheight = 384;
      left = screen(1) + (width-mwwidth)/2;
      bottom = height-mwheight -76 - screen(2);
    end
  end
  % round off to the closest integer.
  left = floor(left); bottom = floor(bottom);
  if type == 'r'
      mwwidth = floor(mwwidth*ratio(1)); mwheight = floor(mwheight*ratio(2));
  else
      mwwidth = floor(ratio(1)); mwheight = floor(ratio(2));
  end

  if type == 'f'
      rect = screen;
      rect([2 4]) = [rect(2)+rect(4)/30 rect(4)*(1/30+7/8)]; 
  else
     rect = [left bottom mwwidth mwheight ];
     % rect = [left mean(screen([2 4]))-mwheight/2-220 mwwidth mwheight ];
  end
  set(gcf, 'Position',rect);
end
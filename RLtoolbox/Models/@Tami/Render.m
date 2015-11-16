function [] = Render( Env ,varargin )

switch nargin
    case 1
        error('s and a unknown')
    case 2
        error('s or a unknown')
    case 3
        s = varargin{1};
        a= varargin{2};
        steps = [];
        h = axes;        
        disp('steps and axes handle not supplied, creating new figure')
    case 4
        disp('axes handle not supplied, creating new figure')
        s = varargin{1};
        a= varargin{2};
        steps = varargin{3};
        h = axes;
    case 5
        s = varargin{1};
        a= varargin{2};
        steps = varargin{3};
        h = varargin{4};
end

axes(h)
hold on
W = ones(Env.row_dim,Env.column_dim);
[j,i] = ind2sub(size(W),s);
W(i,j) = 0;
imagesc(W)
colormap Bone

set(h,'XTick',[],...
      'YTick',[],... 
      'XTickLabel',[],... 
      'YTickLabel',[],... 
      'XGrid','on',... 
      'YGrid','on');
  
  
text(Env.row_dim-1,Env.column_dim-1,['steps: ' num2str(steps)])  
  
drawnow


  
pause(0.1)


  
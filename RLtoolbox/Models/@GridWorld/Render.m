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



if isempty(Env.RenderObj)
    
    axes(h)  
   
    hold on
    

    axis([0 Env.column_dim 0 Env.row_dim]) 
    
    [i,j] = get_plot_coords(s);
    Env.RenderObj.Circle = plot(i,j,'ko',...
                                    'MarkerSize',25,...
                                    'MarkerFaceColor',[1 0.8 0.6]);
                                                       
    Env.RenderObj.Text = text(Env.column_dim-0.9,Env.row_dim-0.13,'steps: ' ) ;
        
        
    [i,j] = get_plot_coords(Env.A_state);
    Env.RenderObj.A = text(i,j,'A' ) ;
 
    [i,j] = get_plot_coords(Env.Ap_state);
    Env.RenderObj.Ap = text(i,j,['A' ''''] ) ;
  
    [i,j] = get_plot_coords(Env.B_state);
    Env.RenderObj.B = text(i,j,'B' ) ;
  
    [i,j] = get_plot_coords(Env.Bp_state);
    Env.RenderObj.Bp = text(i,j,['B' ''''] ) ;
       
    set(h,'YDir','reverse',...
          'XTick',[0:1:Env.column_dim],...
          'YTick',[0:1:Env.row_dim],... 
          'XGrid','on',... 
          'YGrid','on',...
          'XColor',[0 0 0],...
          'YColor',[0 0 0],...
          'GridLineStyle','-');
  
  
    drawnow
    
    Env.Render(s,a,steps,h);
    
      
else

    [i,j] = get_plot_coords(s);
    set(Env.RenderObj.Circle,'XData',i,'Ydata',j)
    set(Env.RenderObj.Text,'String',['steps: ' num2str(steps)])

    drawnow

    pause(0.1)

end



    function [i,j] = get_plot_coords(state)
        
          [i,j] =   ind2sub([Env.row_dim,Env.column_dim],state);
           i  = i-0.5;
           j = j-0.5;
    end

end
  
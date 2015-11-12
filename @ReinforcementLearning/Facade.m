function varargout = Facade(RL,varargin)



function [] = HandleEpsCB(RL,varargin)

    switch nargin
        case 0
            error
        case 1
           hObject =  varargin{1};
    end

    eps = get(hObject,'Value');
    set(RL,'eps',eps);

end
     
function [] = HandleAlphaCB(RL,varargin)

end

function [] = HandleGammaCB(RL,varargin)

end

function [] = HandleNofStepsCB(RL,varargin)

end
function [] = HandleStartLearningCB(RL,varargin)

end
function [] = HandleStopLearningCB(RL,varargin)

end

function [] = HandleStartGraphicsCB(RL,varargin)

end

function [] = HandleStopGraphicsCB(RL,varargin)
end

end
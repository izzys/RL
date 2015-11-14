function varargout = Facade(RL,varargin)


if nargin && ischar(varargin{1})
    facade_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = facade_Callback(RL, varargin{:});
else
    facade_Callback(RL, varargin{:});
end

function [] = Init(RL,varargin)

if nargin>=2
HandleGammaCB(RL,[],varargin{2})
if nargin>=3
HandleAlphaCB(RL,[],varargin{3})
if nargin>=4
HandleAlphaDecreaseCB(RL,[],varargin{4})
if nargin>=5
HandleAlphaDecreaseValCB(RL,[],varargin{5})
if nargin>=6
HandleEpsCB(RL,[],varargin{6})
if nargin>=7
HandlEpsDecreaseCB(RL,[],varargin{7})
if nargin>=8
HandleEpsDecreaseValCB(RL,[],varargin{8})
if nargin>=9
HandleNofMaxStepsCB(RL,[],varargin{9})
end
end
end
end
end
end
end
end

function [] = HandleEpsCB(RL,varargin)

    eps =  varargin{2};
    if ischar(eps) ; eps = str2double(eps) ; end
    Set(RL,'eps',eps);

function [] = HandleEpsDecreaseValCB(RL,varargin)

    val =  varargin{2};
    if ischar(val) ; val = str2double(val) ; end
    Set(RL,'eps_decrease_val',val);

function [] = HandlEpsDecreaseCB(RL,varargin)

    eps_decrease =  varargin{2};
    Set(RL,'eps_decrease',eps_decrease);

function [] = HandleAlphaCB(RL,varargin)

    alpha =  varargin{2};
    if ischar(alpha) ; alpha = str2double(alpha) ; end
    Set(RL,'alpha',alpha);
        
function [] = HandleAlphaDecreaseValCB(RL,varargin)

    val =  varargin{2};
    if ischar(val) ; val = str2double(val) ; end
    Set(RL,'alpha_decrease_val',val);

function [] = HandleAlphaDecreaseCB(RL,varargin)

    alpha_decrease =  varargin{2};
    Set(RL,'alpha_decrease',alpha_decrease);

function [] = HandleGammaCB(RL,varargin)

    val =  varargin{2};
    if ischar(val) ; val = str2double(val) ; end
    Set(RL,'gamma',val);

function [] = HandleNofMaxStepsCB(RL,varargin)
    val =  varargin{2};
    if ischar(val) ; val = str2double(val) ; end
    Set(RL,'max_steps',val);

function [] = HandleStartLearningCB(RL,varargin)

% plot_learning_handle = varargin{1};
% plot_Q_handle = varargin{2};
% plot_model_handle = varargin{3};

RL.Init()
RL.StartLearning(varargin);

function [] = HandleStopLearningCB(RL,varargin)

RL.StopLearning = 1;

function [] = HandleStartGraphicsCB(RL,varargin)

function [] = HandleStopGraphicsCB(RL,varargin)

function [] = HandleSelectModelCB(RL,varargin)
selected_model = varargin{2};

if selected_model>0
Env = eval( RL.ModelList{selected_model} );
Set(RL,'Env',Env)
end

function [] = HandleSelectMethodCB(RL,varargin)
selected_method = varargin{2};

if selected_method>0
Method = RL.MethodList{selected_method};
MethodFcn = str2func(Method);
Set(RL,'MethodFcn',MethodFcn )
end

function [] = HandleRunEpisodeCB(RL,varargin)

function [] = HandleStopEpisodeCB(RL,varargin)

function [] = HandleSetIcCB(RL,varargin)

function [] = HandleRandomIcCB(RL,varargin)
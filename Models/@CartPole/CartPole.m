classdef  CartPole < Environment

    properties 

        S; % States 
        R; % Reward R(s,s',a)
        P; % Probability P(s,s',a)
        A = -1:0.1:1; % Available actions
      
        Adim;
        Sdim;
        
    end
    
    methods  (Access = public)
        
        % class cunstructor:
        function [Env] = CartPole()
            
        end
        
        
        %%%    ~  Abstract fucntions ~  %%%
        
        function [Env] = Init(Env)
                       
            Env.S = Env.BuildStateList();           
            Env.Sdim = length(Env.S);
            Env.Adim = length(Env.A);
        end

        function [r] = GetReward(Env,s,a)
            
            s_next = Env.GetNextState(s,a);
            
            x         = s_next(1);
            x_dot     = s_next(2);
            theta     = s_next(3);
            theta_dot = s_next(4);

            r = 10 - 10*abs(10*theta)^2 - 5*abs(x) - 10*theta_dot;

            fourtyfive_degrees = deg2rad(45); 
           
            if (x < -4.0 || x > 4.0  || theta < -fourtyfive_degrees || theta > fourtyfive_degrees)          
                r = -10000 - 50*abs(x) - 100*abs(theta);     
            end
     
        end

        function [s] = GetNextState(Env,s,a)
            
            % Parameters for simulation
            x          = s(1);
            x_dot      = s(2);
            theta      = s(3);
            theta_dot  = s(4);

            g               = 9.8;      %Gravity
            Mass_Cart       = 1.0;      %Mass of the cart is assumed to be 1Kg
            Mass_Pole       = 0.1;      %Mass of the pole is assumed to be 0.1Kg
            Total_Mass      = Mass_Cart + Mass_Pole;
            Length          = 0.5;      %Half of the length of the pole 
            PoleMass_Length = Mass_Pole * Length;
            Force_Mag       = 10.0;
            Tau             = 0.02;     %Time interval for updating the values
            Fourthirds      = 4.0/3.0;

            force = Force_Mag*Env.A(a);

            temp     = (force + PoleMass_Length * theta_dot * theta_dot * sin(theta)) / Total_Mass;
            thetaacc = (g * sin(theta) - cos(theta) * temp) / (Length * (Fourthirds - Mass_Pole * cos(theta) * cos(theta) / Total_Mass));
            xacc     = temp - PoleMass_Length * thetaacc * cos(theta) / Total_Mass;

            % Update the four state variables, using Euler's method.
            x         = x + Tau * x_dot;
            x_dot     = x_dot + Tau * xacc;
            theta     = theta + Tau * theta_dot;
            theta_dot = theta_dot+Tau*thetaacc;

            s = [x x_dot theta theta_dot];      
            
        end
        
        function e = Events(Env,s,a)
            
            s_next = Env.GetNextState(s,a);
            
            x         = s_next(1);
            x_dot     = s_next(2);
            theta     = s_next(3);
            theta_dot = s_next(4);
            
            e = false;
            fourtyfive_degrees = deg2rad(45); % 45º
            
            if (x < -4.0 || x > 4.0  || theta < -fourtyfive_degrees || theta > fourtyfive_degrees)          
    
                e = true;
            
            end
        end
            
        
        %%%    ~  Added fucntions ~  %%%
        
        
        function [ s ] = DiscretizeState( Env , x  )
          
            %DiscretizeState check which entry in the state list is more close to x and
            %return the index of that entry.

            statelist = Env.S;

            x(1) = sign(x(1));
            x(2) = sign(x(2));
            x(4) = sign(x(4));

            x = repmat(x,Env.Sdim,1);

            [~ , s] = min(Env.edist(statelist,x));

        end
        
        function [ d ] = edist( Env, x , y )
            %edist euclidean distance between two vectors
            d = sqrt( sum( (x-y).^2,2 ) );
        end
                
        
        function [ind] = subsindex(Env)
            ind = 0;
        end

     end
    
    
     methods  (Access = private)
        

        function [ states ] = BuildStateList(Env)


            % state discretization for the mountain car problem
            x1div = (2-(-2)) / 3.0;
            x2div = (0.1-(-0.1)) / 2.0;
            x3div = (deg2rad(12)-(deg2rad(-12)))/8.0;
            x4div = (deg2rad(10)-(deg2rad(-10)))/2.0;

            %x1  = -2:x1div:2;
            x1  = [-1  1];
            %x2  = -0.5:x2div:0.5;
            x2  = [-1 0 1];
            x3  = deg2rad(-12):x3div:deg2rad(12);
            %x4  = deg2rad(-10):x4div:deg2rad(10);
            x4   = [-1  1];


            x1dim=size(x1,2);
            x2dim=size(x2,2);
            x3dim=size(x3,2);
            x4dim=size(x4,2);
            states=[];
            index=1;
            for i=1:x1dim    
                for j=1:x2dim
                    for k=1:x3dim
                        for l=1:x4dim
                            states(index,1)=x1(i);
                            states(index,2)=x2(j);
                            states(index,3)=x3(k);
                            states(index,4)=x4(l);
                            index=index+1;
                        end
                    end
                end
            end
        end
        
%         function [ d ] = edist( Env , x , y ) 
%             %edist euclidean distance between two vectors
%             d = sqrt( sum( (x-y).^2,2 ) );
%         end
        


     end
     
     
     methods (Static)
         
           
     end
     

        
end
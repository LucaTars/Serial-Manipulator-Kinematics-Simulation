function plot_rob(q)
   persistent old_q;
   Delta = 0.1;
   qsize = max(size(q));
   
   the_ones = ones(qsize,1);
   init_q = zeros(qsize,1);
   init_q(1) = evalin('base', 'DH(1,1)');
   persistent old_angle;
   
   mode = evalin('base','mode');
   if (isempty(old_angle))
       old_angle = 0;
   end
   
   if strcmp(mode,'run')
      return; 
   end
   
   if strcmp(mode,'real') || strcmp(mode, 'all')
        servo_motor = evalin('base','servo_motor','0');
        if (servo_motor == '0') % '0' is default value for servo_motor if
                                % variable servo_motor is not found in the
                                % base workspace.
           error('Error with Arduino.'); 
        end
        angle = wrapToPi(q(1))/(2*pi) + 0.5;
        if (angle > 1)
            angle = 1;
        elseif (angle < 0)
            angle = 0;
        end
        %writePosition(servo_motor, angle);
   end
   if strcmp(mode, 'sim') || strcmp(mode, 'all')
       if ~isempty(old_q)
            must_draw = find(abs(old_q - q) > Delta*the_ones);
       end
       if isempty(old_q) | (~isempty(old_q) & ~isempty(must_draw))
            r = evalin('base','r');
            r.teach(q' + init_q');
            old_q = q;
            
       end
   end
end
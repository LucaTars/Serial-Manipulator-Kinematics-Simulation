function create_rob (filename)

    clear plot_rob;
    fd = fopen('zrobot');
    text = fscanf(fd, '%f');
    frewind(fd);
    n = str2num(fgets(fd));
    DH = zeros(n,4);
    qtype = text(2:1+n)';
    fgets(fd);
    for i = 1 : n
        DH(i,:) = text(1+n+4*(i-1)+1:1+n+4*(i-1)+4);
        fgets(fd);
    end
    DHne = text(1+n+4*n+1:1+n+4*n+4)';
    fgets(fd);
    
    Tne = transl(DHne(3), 0, 0) * r2t(rotx(DHne(4))) ...
        * r2t(rotz(DHne(1))) * transl(0, 0, DHne(2));
    c_DH = DH;
    c_DH(:,3) = [c_DH(2:n,3); DHne(3)];
    c_DH(:,4) = [c_DH(2:n,4); DHne(4)];
    
    qmin = text(1+n+4*n+4+1:1+n+4*n+4+n);
    qmax = text(1+n+4*n+4+n+1:1+n+4*n+4+n+n);
    
    for i = 1 : 2
        fgets(fd);
    end
    
    N = str2num(fgets(fd)); % number of tasks
    
    lambda = eye(N*3);
    tasks_mask = 0;
    Jrows = 0;
    cnt = 1;
    align = 0; dist = 0;
    
    for i = 1 : N
        task_str = fgets(fd);
        tokens = split(task_str, ' ');
        lambda(cnt,cnt+2) = str2num(tokens{2});
        cnt = cnt + 3;
        if strcmp(('alignment'),tokens{1})
           align = 1;
           Jrows = Jrows + 3;
        elseif strcmp(('distance'),tokens{1})
           dist = 1;
           Jrows = Jrows + 3;
        end
    end
    
    if (align)
        tasks_mask = 1;
    end
    if (dist)
        tasks_mask = tasks_mask + 2;
    end
    if tasks_mask == 3
       tasks_mask = [tasks_mask 1];
    end
    
    mode = fgets(fd);
    mode = mode(1:max(size(mode)) - 1);
    
    % Create serial link.n
    r = SerialLink(c_DH);
    r.name = fgets(fd);
    
    assignin('base','qtype',qtype);
    assignin('base','Tne',Tne);
    assignin('base','DH',DH);
    assignin('base','qmin',qmin);
    assignin('base','qmax',qmax);
    assignin('base','mode',mode);
    assignin('base','tasks_mask',tasks_mask);
    assignin('base','n',n);
    assignin('base','lambda',lambda);
    assignin('base','Jrows',Jrows);
    assignin('base','r',r);
end
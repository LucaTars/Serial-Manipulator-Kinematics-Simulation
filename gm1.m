function T_vec = gm1 (q, qtype, theta_vec, d_vec, a_vec, alpha_vec)

    n = max(size(q));
    T_vec = cell(1, n);
    
    for i = 1:n
        T_bar = r2t(rotz(theta_vec(i))) * transl(0, 0, d_vec(i)) ...
            * transl(a_vec(i), 0, 0) * r2t(rotx(alpha_vec(i)));
        
        if (strcmp(qtype(i), 'r'))
            % rotational joint
            T_q = r2t(rotz(q(i)));
        else
            % translational joint
            T_q = transl(0, 0, q(i));
        end
        
        % T_vec{1, i} is the transformation matrix from frame i - 1 to
        % frame i
        T_vec{1, i} = T_bar * T_q;
    end
    
end

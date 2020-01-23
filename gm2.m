function [T0e, T_vec] = gm2 (T_vec)
    
    n = max(size(T_vec));
    T0e = eye(4,4);
    
    for i = 1 : n
        T0e = T0e * T_vec{i};
    end
    T0e = simplify(T0e);
    % Create serial link.
    r = SerialLink(DH);

end
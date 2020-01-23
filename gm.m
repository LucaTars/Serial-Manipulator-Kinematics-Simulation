function [T0e, T_vec] = gm (q, qtype, theta_vec, d_vec, a_vec, alpha_vec)

    [T0e, T_vec] = gm2 (gm1 (q, qtype, theta_vec, d_vec, a_vec, alpha_vec));

end
6% Store measured parameters.
syms q1 q2 q3;
D1 = 0.008; % distance between joint 1 and joint 2
D2 = 0.015; % distance between joint 2 and joint 3
D3 = 0.021; % distance between joint 3 and ee

theta_vec = [0 0 0 0];
d_vec = [D1 0 0];
a_vec = [0 D2 D3];
alpha_vec = [pi/2 0 0];
n = 3;

DH = [];

% Define DH table.
for i = 1 : 3
    DH = [DH; [theta_vec(i) d_vec(i) a_vec(i) alpha_vec(i)]];
end

qtype = [0, 0, 0];

% Create serial link.
r = SerialLink(DH);

% Plot serial link.
r.plot([0 0 0]);
r.teach;

% Compute transformation matrix.
%[T0e, Tvec] = gm([q1 q2 q3], ['r' 'r' 'r'], theta_vec, d_vec, a_vec, alpha_vec);

% Compute Jacobian matrix.
%J = r.jacob0([q1 q2 q3]);
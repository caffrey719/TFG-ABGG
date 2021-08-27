function [t_out, xl_out, x_out, y_out, x_stick_out, x_slip_out, xdot_stick_out, xdot_slip_out, theta_equilibrio, ...
    theta_stick_out, theta_slip_out, thetadot_stick_out, thetadot_slip_out, y_stick_out, ...
    y_slip_out, ydot_stick_out, ydot_slip_out, xl_stick_out, xl_slip_out, vpata_stick_out, ...
    vpata_slip_out, eta_ydd_stick_out, eta_ydd_slip_out, friccion_stick_out, friccion_slip_out, ...
    normal_stick_out, normal_slip_out, fuerzasx_stick_out, fuerzasx_slip_out, fuerzasy_stick_out, ...
    fuerzasy_slip_out, fuerzayeta_stick_out, fuerzayeta_slip_out, landa1_stick_out, ...
    landa1_slip_out, t_slip_out, t_stick_out] = Simula_Vertical(f, masa, k, R, A, theta_o, uk, us)

% Condiciones comunes
g = 9.8;
Omega = 2 * pi * f;
syms anguloequilibrio1;
theta_equilibrio = vpasolve(masa * g * R * sin(anguloequilibrio1) == k * (anguloequilibrio1 - theta_o));
theta_equilibrio = double(theta_equilibrio);

% Condiciones iniciales
Theta_i = theta_equilibrio; 
Thetadot_i = 0;
x_i = R * sin(theta_equilibrio); 
xdot_i = 0;
tspan = [0 3];
tstart = tspan(1);
tend = tspan(end);

% Definición de los arrays de salida
t_out = []; xl_out = []; x_out = []; y_out = []; x_stick_out = {}; x_slip_out = {}; xl_stick_out = {}; 
xl_slip_out = {}; xldot_stick_out = {}; xldot_slip_out = {}; y_stick_out = {}; y_slip_out = {}; 
ydot_stick_out = {}; ydot_slip_out = {}; xdot_stick_out = {}; xdot_slip_out = {}; thetadot_slip_out = {}; 
thetadot_stick_out = {}; vpata_stick_out = {}; friccion_stick_out = {}; 
friccion_slip_out = {}; normal_stick_out = {}; normal_slip_out = {}; vpata_slip_out = {}; 
eta_ydd_stick_out = {}; eta_ydd_slip_out = {}; t_slip_out = {}; t_stick_out = {}; theta_slip_out = {}; 
theta_stick_out = {}; fuerzasx_stick_out = {}; fuerzasx_slip_out = {}; fuerzasy_stick_out = {}; 
fuerzasy_slip_out = {}; landa1_stick_out = {}; landa1_slip_out = {}; fuerzayeta_stick_out = {}; fuerzayeta_slip_out = {};

% Generación de las funciones que representan los sistemas de ecuaciones.
% MODO STICK
syms theta(t) x(t)

eta_y = A * sin(Omega * t);
eta_ydd = - Omega^2 * eta_y;

A3 = masa * (R^2 * sin(theta)^2);
B3 = masa * R * cos(theta);
A4 = R * cos(theta);
B4 = - 1;

F3 = - masa * R^2 * sin(theta) * cos(theta) * diff(theta)^2 + masa * R * sin(theta) * (eta_ydd) + masa * g * R * sin(theta) - k * (theta - theta_o);
F4 = R * diff(theta)^2 * sin(theta);

segundaderivadatheta_stick = (B4 * F3) / (A3 * B4 - A4 * B3) - (B3 * F4) / (A3 * B4 - A4 * B3);
segundaderivadax_stick = (A3 * F4) / (A3 * B4 - A4 * B3) - (A4 * F3) / (A3 * B4 - A4 * B3);

eqn1_stick = diff(theta, 2 ) == segundaderivadatheta_stick;
eqn2_stick = diff(x, 2) == segundaderivadax_stick;
eqns_stick = [eqn1_stick eqn2_stick];

[V, S] = odeToVectorField(eqns_stick);
M = matlabFunction(V, 'vars', {'t', 'Y'});

% MODO SLIP
syms theta1(t1) x1(t1)

Mu = uk * sign(diff(x1) - R * diff(theta1) * cos(theta1));

eta_y1 = A * sin(Omega * t1);
eta_ydd1 = - Omega^2 * eta_y1;

A1 = masa * R^2 * sin(theta1)^2 + masa * R^2 * Mu * sin(theta1) * cos(theta1);
B1 = 0;
A2 = - masa * R * Mu * sin(theta1);
B2 = masa;

F1_a = masa * R^2 * Mu * cos(theta1)^2 * diff(theta1)^2 + masa * R^2 * sin(theta1) * cos(theta1) * diff(theta1)^2;
F1_b = - masa * g * R * Mu * cos(theta1) - masa * R * Mu * eta_ydd1 * cos(theta1) - masa * R * (eta_ydd1) * sin(theta1) - masa * g * R * sin(theta1) + k * (theta1 - theta_o);

F1 = - (F1_a + F1_b);
F2 = - masa * Mu * (eta_ydd1) + masa * R * Mu * cos(theta1) * diff(theta1)^2 - Mu * masa * g;

segundaderivadatheta_slip = (B2 * F1) / (A1 * B2 - A2 * B1) - (B1 * F2) / (A1 * B2 - A2 * B1);
segundaderivadax_slip = (A1 * F2) / (A1 * B2 - A2 * B1) - (A2 * F1) / (A1 * B2 - A2 * B1);

eqn1_slip = diff(theta1, 2) == segundaderivadatheta_slip;
eqn2_slip = diff(x1, 2) == segundaderivadax_slip;
eqns_slip = [eqn1_slip eqn2_slip];

[V1, S1] = odeToVectorField(eqns_slip);
M1 = matlabFunction(V1, 'vars', {'t1', 'Y'});

while tstart < tend
    % Se empieza en modo Stick
    options = odeset('RelTol', 1e-3, 'AbsTol', 1e-6);
    [t_, s_] = ode45(M, [tstart tend], [x_i xdot_i Theta_i Thetadot_i], options);

    eta_y_ = A * sin(Omega * t_);
    eta_ydd_ = - Omega^2 * eta_y_;
    
    eta_x_ = A * sin(Omega * t_);
    eta_xdd_ = - Omega^2 * eta_x_;

    A3_ = masa * (R^2 * sin(s_(:, 3)).^2);
    B3_ = masa * R * cos(s_(:, 3));
    A4_ = R * cos(s_(:, 3));
    B4_ = - 1;

    F3_ = - masa * R^2 * sin(s_(:, 3)).*cos(s_(:, 3)).*s_(:, 4).^2 + masa * R * sin(s_(:, 3)).*(eta_ydd_) + masa * g * R * sin(s_(:, 3)) - k * (s_(:, 3) - theta_o);
    F4_ = R * s_(:, 4).^2.*sin(s_(:, 3));

    segundaderivadatheta = (B4_.*F3_) ./ (A3_.*B4_ - A4_.*B3_) - (B3_.*F4_) ./ (A3_.*B4_ - A4_.*B3_);
    segundaderivadax = (A3_.*F4_) ./ (A3_.*B4_ - A4_.*B3_) - (A4_.*F3_) ./ (A3_.*B4_ - A4_.*B3_);

    [m, n] = size(s_);

    for paso = 1:m
        aceleracion = abs(segundaderivadax(paso));
        fuerzas_sistema = abs( - R * segundaderivadatheta(paso).*sin(s_(paso, 3)) - R * s_(paso, 4).^2.*cos(s_(paso, 3)) + eta_ydd_(paso) + g) * us;
        if  aceleracion < fuerzas_sistema
            continue
        else
            break
        end
    end

    ultimopaso = paso;

    % Vectores acumulativos
    t_out = [t_out; t_(1:paso - 1)];
    xl_out = [xl_out; s_(1:paso - 1, 1) - R .* sin(s_(1:paso - 1, 3))];
    x_out = [x_out; s_(1:paso - 1, 1)];
    y_out = [y_out; R * cos(s_(1:paso - 1, 3))];
    t_stick_out{end + 1} = t_(1:paso - 1);
    theta_stick_out{end + 1} = s_(1:paso - 1, 3);
    thetadot_stick_out{end + 1} = s_(1:paso - 1, 4);
    x_stick_out{end + 1} = s_(1:paso - 1, 1);
    xl_stick_out{end + 1} = s_(1:paso - 1, 1) - R .* sin(s_(1:paso - 1, 3));
    xdot_stick_out{end + 1} = s_(1:paso - 1, 2);
    xldot_stick_out{end + 1} = s_(1:paso - 1, 2) - R * s_(1:paso - 1, 4);
    y_stick_out{end + 1} = R * cos(s_(1:paso - 1, 3));
    ydot_stick_out{end + 1} = - R * s_(1:paso - 1, 4) .* sin(s_(1:paso - 1, 3));
    vpata_stick_out{end + 1} = s_(1:paso - 1, 2) - R * s_(1:paso - 1, 4) .* cos(s_(1:paso - 1, 3));
    eta_ydd_stick_out{end + 1} = eta_ydd_(1:paso - 1);
    fuerzasy_stick_out{end + 1} = masa * (g + eta_ydd_stick_out{end});
    fuerzayeta_stick_out{end + 1} = masa * eta_ydd_stick_out{end};
    normal_stick_out{end + 1} = masa * g + masa * (-R .* segundaderivadatheta(1:paso - 1) .* sin(s_(1:paso - 1, 3)) - R .* s_(1:paso - 1, 4) .^ 2 .* cos(s_(1:paso - 1, 3))) + masa .* eta_ydd_(1:paso - 1);
    friccion_stick_out{end + 1} = masa .* segundaderivadax(1:paso - 1);
    fuerzasx_stick_out{end + 1} = (masa .* segundaderivadax(1:paso - 1)) - us * (masa * g + masa * (-R .* segundaderivadatheta(1:paso - 1) .* sin(s_(1:paso - 1, 3)) - R .* s_(1:paso - 1, 4) .^ 2 .* cos(s_(1:paso - 1, 3))) + masa .* eta_ydd_(1:paso - 1));
    landa1_stick_out{end + 1} =  masa * (R .* segundaderivadatheta(1:paso - 1) .* cos(s_(1:paso - 1, 3)) - R .* s_(1:paso - 1, 4) .^ 2 .* sin(s_(1:paso - 1, 3))) + masa .* eta_xdd_(1:paso - 1);
    
    % Nuevas condiciones iniciales
    tstart = t_(ultimopaso);
    Theta_i = s_(ultimopaso, 3);
    Thetadot_i = s_(ultimopaso, 4);
    x_i = s_(ultimopaso, 1);
    xdot_i = s_(ultimopaso, 2);

    % Modo Slip
    clear paso eta_y_ eta_ydd_ eta_x_ eta_xdd_ segundaderivadatheta segundaderivadax

    if tstart < tend
        options = odeset('RelTol', 1e-3, 'AbsTol', 1e-6);
        [t1_, s1_] = ode45(M1, [tstart tend], [x_i xdot_i Theta_i Thetadot_i], options);

        Mu = uk * sign(s1_(:, 2) - R * s1_(:, 4).*cos(s1_(:, 3)));

        eta_y_ = A * sin(Omega * t1_);
        eta_ydd_ = - Omega^2 * eta_y_;
        
        eta_x_ = A * sin(Omega * t1_);
        eta_xdd_ = - Omega^2 * eta_x_;

        A1_ = (masa * R^2 * sin(s1_(:, 3)).^2) + (masa * R^2 * Mu.*sin(s1_(:, 3)).*cos(s1_(:, 3)));
        B1_ = 0;
        A2_ = - masa * R * Mu.*sin(s1_(:, 3));
        B2_= masa;
        F1_a_ = (masa * R^2 * Mu.*cos(s1_(:, 3)).^2 + masa * R^2 * sin(s1_(:, 3)).*cos(s1_(:, 3))).*s1_(:, 4).^2;
        F1_b_ = - masa* g * R * Mu.*cos(s1_(:, 3)) - masa * R * Mu.*eta_ydd_.*cos(s1_(:, 3)) - masa * R * (eta_ydd_).*sin(s1_(:, 3)) - masa * g * R * sin(s1_(:, 3)) + k * (s1_(:, 3) - theta_o);
        F1_ = - (F1_a_ + F1_b_);
        F2_ = - masa * Mu.*(eta_ydd_) + masa * R * Mu.*cos(s1_(:, 3)).*s1_(:, 4).^2 - Mu * masa * g;

        segundaderivadatheta = (B2_.*F1_) ./ (A1_.*B2_ - A2_.*B1_) - (B1_.*F2_) ./ (A1_.*B2_ - A2_.*B1_);
        segundaderivadax = (A1_.*F2_) ./ (A1_.*B2_ - A2_.*B1_) - (A2_.*F1_) ./ (A1_.*B2_ - A2_.*B1_);

        vpata = s1_(:, 2) - R * s1_(:, 4).*cos(s1_(:, 3));

        [m, n] = size(s1_);

        for paso = 4:m
            if  sign(vpata(paso)) == sign(vpata(paso - 1))
                continue
            else
                break
            end
        end

        ultimopaso2 = paso;
        
    else
        break
    end

    % Vectores acumulativos
    t_out = [t_out; t1_(1:paso - 1)];
    xl_out = [xl_out; s1_(1:paso - 1, 1) - R .* sin(s1_(1:paso - 1, 3))];
    x_out = [x_out; s1_(1:paso - 1, 1)];
    y_out = [y_out; R * cos(s1_(1:paso - 1, 3))];
    t_slip_out{end + 1} = t1_(1:paso - 1);
    theta_slip_out{end + 1} = s1_(1:paso - 1, 3);
    thetadot_slip_out{end + 1} = s1_(1:paso - 1, 4);
    x_slip_out{end + 1} = s1_(1:paso - 1, 1);
    xl_slip_out{end + 1} = s1_(1:paso - 1, 1) - R .* sin(s1_(1:paso - 1, 3));
    xdot_slip_out{end + 1} = s1_(1:paso - 1, 2);
    xldot_slip_out{end + 1} = s1_(1:paso - 1, 2) - R * s1_(1:paso - 1, 4);
    y_slip_out{end + 1} = R * cos(s1_(1:paso - 1, 3));
    ydot_slip_out{end + 1} = - R * s1_(1:paso - 1, 4) .* sin(s1_(1:paso - 1, 3));
    vpata_slip_out{end + 1} = s1_(1:paso - 1, 2) - R * s1_(1:paso - 1, 4) .* cos(s1_(1:paso - 1, 3));
    eta_ydd_slip_out{end + 1} = eta_ydd_(1:paso - 1);
    fuerzasy_slip_out{end + 1} = masa * (g + eta_ydd_slip_out{end});
    fuerzayeta_slip_out{end + 1} = masa * eta_ydd_slip_out{end};
    normal_slip_out{end + 1} = masa * g + masa * (-R .* segundaderivadatheta(1:paso - 1) .* sin(s1_(1:paso - 1, 3)) - R .* s1_(1:paso - 1, 4) .^ 2 .* cos(s1_(1:paso - 1, 3))) + masa .* eta_ydd_(1:paso - 1);
    friccion_slip_out{end + 1} = - uk * sign(s1_(1:paso - 1, 2) - R * s1_(1:paso - 1, 4) .* cos(s1_(1:paso - 1, 3))) .* (masa * g + masa * (-R .* segundaderivadatheta(1:paso - 1) .* sin(s1_(1:paso - 1, 3)) - R .* s1_(1:paso - 1, 4) .^ 2 .* cos(s1_(1:paso - 1, 3))) + masa .* eta_ydd_(1:paso - 1));
    fuerzasx_slip_out{end + 1} = (masa .* segundaderivadax(1:paso - 1)) - uk * (masa * g + masa * (-R .* segundaderivadatheta(1:paso - 1) .* sin(s1_(1:paso - 1, 3)) - R .* s1_(1:paso - 1, 4) .^ 2 .* cos(s1_(1:paso - 1, 3))) + masa .* eta_ydd_(1:paso - 1));
    landa1_slip_out{end + 1} =  masa * (R .* segundaderivadatheta(1:paso - 1) .* cos(s1_(1:paso - 1, 3)) - R .* s1_(1:paso - 1, 4) .^ 2 .* sin(s1_(1:paso - 1, 3))) + masa .* eta_xdd_(1:paso - 1);
    
    % Nuevas condiciones iniciales
    tstart = t1_(ultimopaso2);
    Theta_i = s1_(ultimopaso2, 3);
    Thetadot_i = s1_(ultimopaso2, 4);
    x_i = s1_(ultimopaso2, 1);
    xdot_i = s1_(ultimopaso2, 2);

    clear paso eta_y_ eta_ydd_ eta_x_ eta_xdd_ t_ s_ t1_ s1_ segundaderivadatheta segundaderivadax
    clear A1_ B1_ A2_ B2_ F1_ F2_ F1_a_ F1_b_ vpata
    clear A3_ B3_ A4_ B4_ F3_ F4_ vpatastick
end
end

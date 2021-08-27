% En este script se plotean las distintas variables de interés del sistema
% que se quieran graficar, empleando las funciones "Plot_StickSlip.m" y
% "Plot_StickSlip_2ejes.m", en función de si se quieren graficar dos
% variables juntas para compararlas, o una sola.

% Parámetros a emplear en la simulación

% Parámetros para estudio genérico
masa = 1; %kg
k = 100; %Nm/rad
R = 1; %m
A = 0.01; %m
theta = pi/6; %rad
frecuencia = 1.59; %Hz
g = 9.8; %m/s^2

% Parámetros para estudio experimental
% masa = 0.15e-3; %kg
% k = 0.25; %Nm/rad
% R = 1e-3; %m
% A = 1e-9; %m
% theta = pi/4; %rad
% frecuencia = 68000; % Hz
%g = 9.8; %m/s^2

[t_out, xl_out, x_out, y_out, x_stick_out, x_slip_out, xdot_stick_out, xdot_slip_out, theta_equilibrio, ...
    theta_stick_out, theta_slip_out, thetadot_stick_out, thetadot_slip_out, ...
    y_stick_out, y_slip_out, ydot_stick_out, ydot_slip_out, xl_stick_out, ...
    xl_slip_out, vpata_stick_out, vpata_slip_out, eta_ydd_stick_out, ...
    eta_ydd_slip_out, friccion_stick_out, friccion_slip_out, normal_stick_out, ...
    normal_slip_out, fuerzasx_stick_out, fuerzasx_slip_out, fuerzasy_stick_out, ...
    fuerzasy_slip_out, fuerzayeta_stick_out, fuerzayeta_slip_out, ...
    landa1_stick_out, landa1_slip_out, t_slip_out, t_stick_out] = Simula_Vertical(frecuencia, masa, k, R, A, theta, 0.15, 0.17);

% 1. Representación de theta y v_pata frente al tiempo en un mismo gráfico
titulo = 'V_{pata} vs \theta con respecto al tiempo';
eje_x = 'Tiempo (s)';
eje_y1 = 'Velocidad en extremo de la pata ($V_{pata}$ (m/s))';
eje_y2 = '$\theta$ (rad)';
offset_y_1 = 0;
offset_y_2 = theta_equilibrio;
Plot_StickSlip_2ejes(t_stick_out, t_slip_out, vpata_stick_out, vpata_slip_out, theta_stick_out, theta_slip_out, offset_y_1, offset_y_2, titulo, eje_x, eje_y1, eje_y2)

% Representación de theta de equilibrio en el mismo gráfico
yyaxis right
theta_equilibrio_plot = theta_equilibrio * ones(1, length(t_out));
plot(t_out, theta_equilibrio_plot,':k', 'LineWidth', 1.5)

if ~isempty(x_stick_out{1, 2})
    yyaxis right
    offset = 0.035;
    axes = gca;
    axes.YLim = [theta_equilibrio - offset theta_equilibrio + offset];
    
    yyaxis left
    offset = 0.5;
    axes = gca;
    axes.YLim = [0 - offset 0 + offset];
    
    % Leyenda para modo stick - slip
    legend('Vpata modo Stick','','','','','','','','','','','','','','','','','Vpata modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','\theta modo Stick','','','','','','','\theta modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','\theta de equilibrio', 'NumColumns', 3)
else
    yyaxis right
    offset = 0.03;
    axes = gca;
    axes.YLim = [theta_equilibrio - offset theta_equilibrio + offset];
    
    yyaxis left
    offset = 0.4;
    axes = gca;
    axes.YLim = [0 - offset 0 + offset];
    
    % Leyenda para modo slip
    legend('Vpata modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', '','','','','','','','','','','','','','','','','','','','','','','','','','\theta modo slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','\theta de equilibrio','NumColumns', 2)
end


% 2. Representación de la posición x frente al tiempo
figure
titulo = 'Posición X con respecto al tiempo';
eje_x = 'Tiempo (s)';
eje_y = 'Posici\''on en x (m)';
if ~isempty(x_stick_out{1, 2})
    offset_y = x_stick_out{1, 1}(1);
else
    offset_y = x_slip_out{1, 1}(1);
end
Plot_StickSlip(t_stick_out, t_slip_out, x_stick_out, x_slip_out, offset_y, titulo, eje_x, eje_y)

% Representación de x inicial en el mismo gráfico
if ~isempty(x_stick_out{1, 2})
    % Modo stick - slip
    x_i_plot = x_stick_out{1, 1}(1) * ones(1, length(t_out));
    plot(t_out, x_i_plot,':k', 'LineWidth', 1.5)
    
    % Leyenda para modo stick - slip
    legend('Posición en modo Stick','','','','','','','Posición en modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','Posición inicial','NumColumns', 1, 'Location', 'southwest')
else
    % Modo slip
    x_i_plot = x_slip_out{1, 1}(1) * ones(1, length(t_out));
    plot(t_out, x_i_plot,':k', 'LineWidth', 1.5)

    % Leyenda para modo slip
    legend('Posición en modo slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','Posición inicial','NumColumns', 1)
end

% 3. Representación de la posición y frente al tiempo
figure
titulo = 'Posición Y con respecto al tiempo';
eje_x = 'Tiempo (s)';
eje_y = 'Posici\''on en y (m)';
if ~isempty(x_stick_out{1, 2})
    offset_y = y_stick_out{1, 1}(1);
else
    offset_y = y_slip_out{1, 1}(1);
end
Plot_StickSlip(t_stick_out, t_slip_out, y_stick_out, y_slip_out, offset_y, titulo, eje_x, eje_y)

% Representación de y inicial en el mismo gráfico
if ~isempty(y_stick_out{1, 2})
    % Modo stick - slip
    y_i_plot = y_stick_out{1, 1}(1) * ones(1, length(t_out));
    plot(t_out, y_i_plot,':k', 'LineWidth', 1.5)
    
    % Leyenda para modo stick - slip
    legend('Posición en modo Stick','','','','','','','Posición en modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','Posición inicial','NumColumns', 1, 'Location', 'southwest')
else
    % Modo slip
    y_i_plot = y_slip_out{1, 1}(1) * ones(1, length(t_out));
    plot(t_out, y_i_plot,':k', 'LineWidth', 1.5)

    % Leyenda para modo slip
    legend('Posición en modo slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','Posición inicial','NumColumns', 1)
end

% 4. Representación de theta frente al tiempo
figure
titulo = '\theta con respecto al tiempo';
eje_x = 'Tiempo (s)';
eje_y = '$\theta$ (rad)';
offset_y = theta_equilibrio;
Plot_StickSlip(t_stick_out, t_slip_out, theta_stick_out, theta_slip_out, offset_y, titulo, eje_x, eje_y)

% Representación de theta inicial en el mismo gráfico
theta_i_plot = theta_equilibrio * ones(1, length(t_out));
plot(t_out, theta_i_plot,':k', 'LineWidth', 1.5)

if ~isempty(x_stick_out{1, 2})
    % Leyenda para modo stick - slip
    legend('\theta en modo Stick','','','','','','','','','','','','','\theta en modo Slip','','','','\theta de equilibrio','NumColumns', 1, 'Location', 'southwest')
else
    % Modo slip
    % Leyenda para modo slip
    legend('\theta en modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','\theta de equilibrio','NumColumns', 1)
end

% 5. Representación de la velocidad en el extremo de la pata frente al tiempo
figure
titulo = 'V_{pata} con respecto al tiempo';
eje_x = 'Tiempo (s)';
eje_y = 'Velocidad en extremo de la pata ($V_{pata}$ (m/s))';
offset_y = 0;
Plot_StickSlip(t_stick_out, t_slip_out, vpata_stick_out, vpata_slip_out, offset_y, titulo, eje_x, eje_y)

if ~isempty(x_stick_out{1, 2})
    % Leyenda para modo stick - slip
    legend('V_{pata} en modo Stick','','','','','','','','','','','','','','','','V_{pata} en modo Slip','NumColumns', 1)
else
    % Modo slip
    % Leyenda para modo slip
    legend('V_{pata} en modo Slip')
end

% 7. Representación de v_pata y (m*g + m*eta_ydd) frente al tiempo en un mismo gráfico
figure
titulo = 'V_{pata} vs m*(g + eta_{ydd}) con respecto al tiempo';
eje_x = 'Tiempo (s)';
eje_y1 = 'Velocidad en extremo de la pata ($V_{pata}$ (m/s))';
eje_y2 = 'm * g + m * $eta_{ydd}$ (N)';
offset_y_1 = 0;
offset_y_2 = masa * g;
Plot_StickSlip_2ejes(t_stick_out, t_slip_out, vpata_stick_out, vpata_slip_out, fuerzasy_stick_out, fuerzasy_slip_out, offset_y_1, offset_y_2, titulo, eje_x, eje_y1, eje_y2)

% Se marca la gravedad en el gráfico
yyaxis right
g_plot = g * ones(1, length(t_out));
plot(t_out, g_plot,':k', 'LineWidth', 1.5)

if ~isempty(x_stick_out{1, 2})
    yyaxis right
    offset = 1.4;
    axes = gca;
    axes.YLim = [g - offset g + offset];

    yyaxis left
    offset = 0.45;
    axes = gca;
    axes.YLim = [0 - offset 0 + offset];
    
    % Leyenda para modo stick - slip
    legend('Vpata modo Stick','','','','','','','','','','','','','Vpata modo Slip','','','','','','Fuerzas en la vertical modo Stick','','','','','','Fuerzas en la vertical modo Slip','','','','','','','','','gravedad', 'NumColumns', 3)
else
    yyaxis right
    offset = 12;
    axes = gca;
    axes.YLim = [g - offset g + offset];

    yyaxis left
    offset = 0.45;
    axes = gca;
    axes.YLim = [0 - offset 0 + offset];
    
    % Leyenda para modo slip
    legend('Vpata modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','Fuerzas en la vertical modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','gravedad', 'NumColumns', 2)
end

% 10. Representación de v_pata y x_dot frente al tiempo en un mismo gráfico
figure
titulo = 'V_{pata} vs xdot con respecto al tiempo';
eje_x = 'Tiempo (s)';
eje_y1 = 'Velocidad en extremo de la pata ($V_{pata}$ (m/s))';
eje_y2 = 'Velocidad en x ($x_{dot}$ (m/s))';
offset_y_1 = 0;
offset_y_2 = 0;
Plot_StickSlip_2ejes(t_stick_out, t_slip_out, vpata_stick_out, vpata_slip_out, xdot_stick_out, xdot_slip_out, offset_y_1, offset_y_2, titulo, eje_x, eje_y1, eje_y2)

if ~isempty(x_stick_out{1, 2})
    yyaxis right
    lower_offset = 0.3;
    upper_offset = 0.2;
    axes = gca;
    axes.YLim = [0 - lower_offset 0 + upper_offset];
    
    yyaxis left
    lower_offset = 0.48;
    upper_offset = 0.22;
    axes = gca;
    axes.YLim = [0 - lower_offset 0 + upper_offset];
    
    % Leyenda para modo stick - slip
    legend('Vpata modo Stick','','','','','','','','','','','','','','','Vpata modo Slip','','','','','','xdot en modo Stick','','xdot en modo Slip', 'NumColumns', 2)
else
    yyaxis right
    offset = 0.5;
    axes = gca;
    axes.YLim = [0 - offset 0 + offset];
    
    yyaxis left
    offset = 0.5;
    axes = gca;
    axes.YLim = [0 - offset 0 + offset];
    
    % Leyenda para modo slip
    legend('Vpata modo Slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','xdot en modo Slip', 'NumColumns', 2)
end

% 11. Representación de la posición de la pata xl frente al tiempo
figure
titulo = 'Posición en el extremo de la pata con respecto al tiempo';
eje_x = 'Tiempo (s)';
eje_y = 'Posici\''on en extremo de pata ($x_l$ (m))';
offset_y_1 = 0;
offset_y_2 = 0;
Plot_StickSlip(t_stick_out, t_slip_out, xl_stick_out, xl_slip_out, offset_y, titulo, eje_x, eje_y)

% Representación de x inicial en el mismo gráfico
if ~isempty(xl_stick_out{1, 2})
    % Modo stick - slip
    x_i_plot = xl_stick_out{1, 1}(1) * ones(1, length(t_out));
    plot(t_out, x_i_plot,':k', 'LineWidth', 1.5)
    
    lower_offset = 0.15;
    upper_offset = 0.01;
    axes = gca;
    axes.YLim = [0 - lower_offset 0 + upper_offset];
    
    % Leyenda para modo stick - slip
    legend('Posición en modo Stick','','','','Posición en modo Slip','','','','','','','','','Posición inicial', 'NumColumns', 1, 'Location', 'southwest')
else
    % Modo slip
    x_i_plot = xl_slip_out{1, 1}(1) * ones(1, length(t_out));
    plot(t_out, x_i_plot,':k', 'LineWidth', 1.5)
    ytickformat('%.3f')

    % Leyenda para modo slip
    legend('Posición en modo slip','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','Posición inicial','NumColumns', 1)
end

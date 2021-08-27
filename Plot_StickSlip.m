function Plot_StickSlip(variable_x_stick, variable_x_slip, variable_y_stick, variable_y_slip, offset_y, titulo, eje_x, eje_y)
% Esta función plotea una variable frente a otra diferenciando entre
% slip y stick para mostrar cada estado en un color distinto. 
% En caso de que solamente haya slip, grafica una única línea de un mismo
% color.

% Se fija un límite para graficar los resultados
limite_x = 3;

if ~isempty(variable_x_stick{1, 2})
    % Gráfica para el estado de stick-slip
    % Inicialización de vectores acumulativos
    var_x_stick_final = [];
    var_y_stick_final = [];
    var_x_slip_principio = [];
    var_y_slip_principio = [];

    var_x_stick_principio = [];
    var_y_stick_principio = [];
    var_x_slip_final = [];
    var_y_slip_final = [];

    % Plot en modo stick
    hold off
    for i = 1:length(variable_y_stick)
        var_y_tramo = variable_y_stick{i};
        var_x_tramo = variable_x_stick{i};
        plot(var_x_tramo, var_y_tramo, 'r','LineWidth',1.5)

        % Acumulación de puntos finales de tramos stick
        if length(variable_y_stick{i}) > 1
            var_x_stick_final = [var_x_stick_final variable_y_stick{i}(end)];
            var_y_stick_final = [var_y_stick_final variable_x_stick{i}(end)];
        end

        % Acumulación de puntos iniciales de tramos stick
        if (length(variable_y_stick{i}) > 1) && (i ~= 1)
            var_x_stick_principio = [var_x_stick_principio variable_y_stick{i}(1)];
            var_y_stick_principio = [var_y_stick_principio variable_x_stick{i}(1)];
        end

        hold on
    end

    % Plot en modo slip
    for i = 1:length(variable_y_slip)
        % Representación de puntos aislados
        if length(variable_y_slip{i}) == 1
            % Se añade una posición al tramo i + 1 y se inicializa a 0
            variable_y_slip{i + 1}(end + 1) = 0; 
            variable_x_slip{i + 1}(end + 1) = 0;
            % Se recolocan los valores para tener en primer lugar el punto
            % aislado del tramo i
            for j = 1:length(variable_y_slip{i + 1})
                if j ~= length(variable_y_slip{i + 1})
                    variable_y_slip{i + 1}(end - j + 1) = variable_y_slip{i + 1}(end - j);
                    variable_x_slip{i + 1}(end - j + 1) = variable_x_slip{i + 1}(end - j);
                else
                    variable_y_slip{i + 1}(1) = variable_y_slip{i};
                    variable_x_slip{i + 1}(1) = variable_x_slip{i};
                end
            end
        end

        var_y_tramo = variable_y_slip{i};
        var_x_tramo = variable_x_slip{i};
        plot(var_x_tramo, var_y_tramo, 'b','LineWidth',1.5)

        % Acumulación de puntos iniciales de tramos slip
        if length(variable_y_slip{i}) > 1 %&& (i ~= 3)
            var_x_slip_principio = [var_x_slip_principio variable_y_slip{i}(1)];
            var_y_slip_principio = [var_y_slip_principio variable_x_slip{i}(1)];
        end

        % Acumulación de puntos finales de tramos slip
        if length(variable_y_slip{i}) > 1
            var_x_slip_final = [var_x_slip_final variable_y_slip{i}(end)];
            var_y_slip_final = [var_y_slip_final variable_x_slip{i}(end)];
        end

        hold on
    end

    %Unión de tramos stick - slip
    for i = 1:min(length(var_y_stick_final), length(var_y_slip_principio))
        line([var_y_stick_final(i), var_y_slip_principio(i)], [var_x_stick_final(i), var_x_slip_principio(i)], 'Color', 'r','LineWidth',1.5);
    end

    %Unión de tramos slip - stick
    for i = 1:min(length(var_y_stick_principio), length(var_y_slip_final))
        line([var_y_stick_principio(i), var_y_slip_final(i)], [var_x_stick_principio(i), var_x_slip_final(i)], 'Color', 'b','LineWidth',1.5);
    end

    % Definición de títulos de gráfico y ejes
    title(titulo);
    xlim([0 limite_x]);
    xlabel(eje_x, 'Interpreter', 'latex','FontSize',15);
    ylabel(eje_y, 'Interpreter', 'latex','FontSize',15);
else
    % Gráfica en el estado slip
    % Inicialización de vectores acumulativos
    var_x_slip_principio = [];
    var_y_slip_principio = [];

    var_x_slip_final = [];
    var_y_slip_final = [];

    % Plot en modo slip
    hold off
    for i = 1:length(variable_y_slip)
        % Representación de puntos aislados
        if length(variable_y_slip{i}) == 1
            % Se añade una posición al tramo i + 1 y se inicializa a 0
            variable_y_slip{i + 1}(end + 1) = 0; 
            variable_x_slip{i + 1}(end + 1) = 0;
            % Se recolocan los valores para tener en primer lugar el punto
            % aislado del tramo i
            for j = 1:length(variable_y_slip{i + 1})
                if j ~= length(variable_y_slip{i + 1})
                    variable_y_slip{i + 1}(end - j + 1) = variable_y_slip{i + 1}(end - j);
                    variable_x_slip{i + 1}(end - j + 1) = variable_x_slip{i + 1}(end - j);
                else
                    variable_y_slip{i + 1}(1) = variable_y_slip{i};
                    variable_x_slip{i + 1}(1) = variable_x_slip{i};
                end
            end
        end

        var_y_tramo = variable_y_slip{i};
        var_x_tramo = variable_x_slip{i};
        plot(var_x_tramo, var_y_tramo, 'b','LineWidth',1.5)

        % Acumulación de puntos finales de tramos slip
        if length(variable_y_slip{i}) > 1
            var_x_slip_final = [var_x_slip_final variable_y_slip{i}(end)];
            var_y_slip_final = [var_y_slip_final variable_x_slip{i}(end)];
        end
        
        % Acumulación de puntos iniciales de tramos slip
        if length(variable_y_slip{i}) > 1 && i ~= 1
            var_x_slip_principio = [var_x_slip_principio variable_y_slip{i}(1)];
            var_y_slip_principio = [var_y_slip_principio variable_x_slip{i}(1)];
        end

        hold on
    end

    % Unión de tramos slip
    for i = 1:(length(var_y_slip_final) - 1)
        line([var_y_slip_final(i), var_y_slip_principio(i)], [var_x_slip_final(i), var_x_slip_principio(i)], 'Color', 'b','LineWidth',1.5);
    end

    % Unión del tramo inicial con 0
    line([variable_x_slip{1, 1}(1), variable_x_slip{1, 1}(1)], [0 + offset_y, variable_y_slip{1, 1}(1)], 'Color', 'b','LineWidth',1.5);
    
    % Definición de títulos de gráfico y ejes
    title(titulo);
    xlim([0 limite_x]);
    xlabel(eje_x, 'Interpreter', 'latex', 'FontSize', 15);
    ylabel(eje_y, 'Interpreter', 'latex', 'FontSize', 15);
end

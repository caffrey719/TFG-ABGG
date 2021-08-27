function Plot_StickSlip_2ejes(variable_x_stick, variable_x_slip, variable1_y_stick, variable1_y_slip, variable2_y_stick, variable2_y_slip, offset_y_1, offset_y_2, titulo, eje_x, eje_y1, eje_y2)
% Esta función plotea dos variables frente a otra en un mismo gráfico 
% diferenciando entre slip y stick para mostrar cada estado en un color distinto.
% En caso de que solamente haya slip, grafica una única línea de un mismo
% color para cada variable, diferenciando ambas en el color de línea.

% Se fija un límite para graficar los resultados
limite_x = 3;

if ~isempty(variable_x_stick{1, 2})
    % Gráfica en el estado de stick-slip
    % Inicialización de vectores acumulativos
    var1_x_stick_final = [];
    var1_y_stick_final = [];
    var1_x_slip_principio = [];
    var1_y_slip_principio = [];
    var1_x_stick_principio = [];
    var1_y_stick_principio = [];
    var1_x_slip_final = [];
    var1_y_slip_final = [];

    var2_y_stick_final = [];
    var2_x_stick_final = [];
    var2_y_slip_principio = [];
    var2_x_slip_principio = [];
    var2_x_stick_principio = [];
    var2_y_stick_principio =[];
    var2_x_slip_final = [];
    var2_y_slip_final = [];

    % Plot en modo stick de la primera variable y
    hold off
    yyaxis left
    title(titulo)
    xlim([0 limite_x]);
    xlabel(eje_x, 'Interpreter', 'latex', 'FontSize', 15)
    for i = 1:length(variable1_y_stick)
        var_y_tramo = variable1_y_stick{i};
        var_x_tramo = variable_x_stick{i};
        plot(var_x_tramo, var_y_tramo, 'r', 'LineWidth', 1.5)

        % Acumulación de puntos finales de tramos stick
        if length(variable1_y_stick{i}) > 1
            var1_x_stick_final = [var1_x_stick_final variable1_y_stick{i}(end)];
            var1_y_stick_final = [var1_y_stick_final variable_x_stick{i}(end)];
        end

        % Acumulación de puntos iniciales de tramos stick
        if (length(variable1_y_stick{i}) > 1) && (i ~= 1)
            var1_x_stick_principio = [var1_x_stick_principio variable1_y_stick{i}(1)];
            var1_y_stick_principio = [var1_y_stick_principio variable_x_stick{i}(1)];
        end

        hold on
    end

    % Plot en modo slip de la primera variable y
    for i = 1:length(variable1_y_slip)
        % Representación de puntos aislados
        if length(variable1_y_slip{i}) == 1
            % Se añade una posición al tramo i + 1 y se inicializa a 0
            variable1_y_slip{i + 1}(end + 1) = 0; 
            variable_x_slip{i + 1}(end + 1) = 0;
            % Se recolocan los valores para tener en primer lugar el punto
            % aislado del tramo i
            for j = 1:length(variable1_y_slip{i + 1})
                if j ~= length(variable1_y_slip{i + 1})
                    variable1_y_slip{i + 1}(end - j + 1) = variable1_y_slip{i + 1}(end - j);
                    variable_x_slip{i + 1}(end - j + 1) = variable_x_slip{i + 1}(end - j);
                else
                    variable1_y_slip{i + 1}(1) = variable1_y_slip{i};
                    variable_x_slip{i + 1}(1) = variable_x_slip{i};
                end
            end
        end

        var_y_tramo = variable1_y_slip{i};
        var_x_tramo = variable_x_slip{i};
        plot(var_x_tramo, var_y_tramo, 'b','LineWidth',1.5)

        % Acumulación de puntos iniciales de tramos slip
        if length(variable1_y_slip{i}) > 1
            var1_x_slip_principio = [var1_x_slip_principio variable1_y_slip{i}(1)];
            var1_y_slip_principio = [var1_y_slip_principio variable_x_slip{i}(1)];
        end

        % Acumulación de puntos finales de tramos slip
        if length(variable1_y_slip{i}) > 1
            var1_x_slip_final = [var1_x_slip_final variable1_y_slip{i}(end)];
            var1_y_slip_final = [var1_y_slip_final variable_x_slip{i}(end)];
        end

        hold on
    end

    % Unión de tramos stick - slip para la primera variable
    for i = 1:min(length(var1_y_stick_final), length(var1_y_slip_principio))
        line([var1_y_stick_final(i), var1_y_slip_principio(i)], [var1_x_stick_final(i), var1_x_slip_principio(i)], 'Color', 'r','LineWidth',1.5);
    end

    % Unión de tramos slip - stick para la primera variable
    for i = 1:min(length(var1_y_stick_principio), length(var1_y_slip_final))
        line([var1_y_stick_principio(i), var1_y_slip_final(i)], [var1_x_stick_principio(i), var1_x_slip_final(i)], 'Color', 'b','LineWidth',1.5);
    end

    % Ajustes de gráfico de la primera variable
    ylabel(eje_y1, 'Interpreter', 'latex','FontSize',15)
    axes = gca;
    axes.LineStyleOrder = '-';

    % Plot en modo stick de la segunda variable y
    yyaxis right
    for i = 1:length(variable2_y_stick)
        var_y2_tramo = variable2_y_stick{i};
        var_x2_tramo = variable_x_stick{i};
        plot(var_x2_tramo, var_y2_tramo, '-.r', 'LineWidth', 1.5)

        % Acumulación de puntos finales de tramos stick
        if length(variable2_y_stick{i}) > 1
            var2_y_stick_final = [var2_y_stick_final variable2_y_stick{i}(end)];
            var2_x_stick_final = [var2_x_stick_final variable_x_stick{i}(end)];
        end

        % Acumulación de puntos iniciales de tramos stick
        if (length(variable2_y_stick{i}) > 1) && (i ~= 1)
            var2_x_stick_principio = [var2_x_stick_principio variable2_y_stick{i}(1)];
            var2_y_stick_principio = [var2_y_stick_principio variable_x_stick{i}(1)];
        end

        hold on
    end

    % Plot en modo slip de la segunda variable y
    for i = 1:length(variable2_y_slip)
        % Representación de puntos aislados
        if length(variable2_y_slip{i}) == 1
            % Se añade una posición al tramo i + 1 y se inicializa a 0
            variable2_y_slip{i + 1}(end + 1) = 0; 
            % Se recolocan los valores para tener en primer lugar el punto
            % aislado del tramo i
            for j = 1:length(variable2_y_slip{i + 1})
                if j ~= length(variable2_y_slip{i + 1})
                    variable2_y_slip{i + 1}(end - j + 1) = variable2_y_slip{i + 1}(end - j);
                else
                    variable2_y_slip{i + 1}(1) = variable2_y_slip{i};
                end
            end
        end

        var_y2_tramo = variable2_y_slip{i};
        var_x2_tramo = variable_x_slip{i};
        plot(var_x2_tramo, var_y2_tramo, '-.b', 'LineWidth', 1.5)

        % Acumulación de puntos iniciales de tramos slip
        if length(variable2_y_slip{i}) > 1
            var2_y_slip_principio = [var2_y_slip_principio variable2_y_slip{i}(1)];
            var2_x_slip_principio = [var2_x_slip_principio variable_x_slip{i}(1)];
        end

        % Acumulación de puntos finales de tramos slip
        if length(variable2_y_slip{i}) > 1
            var2_x_slip_final = [var2_x_slip_final variable2_y_slip{i}(end)];
            var2_y_slip_final = [var2_y_slip_final variable_x_slip{i}(end)];
        end

        hold on
    end

    % Unión de tramos stick - slip en la segunda variable y
    for i = 1:min(length(var2_x_stick_final), length(var2_x_slip_principio))
        line([var2_x_stick_final(i), var2_x_slip_principio(i)], [var2_y_stick_final(i), var2_y_slip_principio(i)], 'LineStyle', '-.', 'LineWidth', 1.5, 'Color', 'r');
    end

    % Unión de tramos slip - stick en la segunda variable y
    for i = 1:min(length(var2_y_stick_principio), length(var2_y_slip_final))
        line([var2_y_stick_principio(i), var2_y_slip_final(i)], [var2_x_stick_principio(i), var2_x_slip_final(i)], 'LineStyle', '-.', 'LineWidth', 1.5, 'Color', 'b');
    end

    % Ajustes de gráfico para la segunda variable y
    ylabel(eje_y2, 'Interpreter', 'latex','FontSize',15)
    axes = gca;
    axes.LineStyleOrder = '-.';
else
    % Gráfica en el estado de puro slip
    % Inicialización de vectores acumulativos
    var1_x_slip_principio = [];
    var1_y_slip_principio = [];
    var1_x_slip_final = [];
    var1_y_slip_final = [];

    var2_y_slip_principio = [];
    var2_x_slip_principio = [];
    var2_x_slip_final = [];
    var2_y_slip_final = [];

    % Plot en modo slip de la primera variable y
    hold off
    yyaxis left
    title(titulo)
    xlim([0 limite_x]);
    xlabel(eje_x, 'Interpreter', 'latex','FontSize',15)
    for i = 1:length(variable1_y_slip)
        % Representación de puntos aislados
        if length(variable1_y_slip{i}) == 1
            % Se añade una posición al tramo i + 1 y se inicializa a 0
            variable1_y_slip{i + 1}(end + 1) = 0; 
            variable_x_slip{i + 1}(end + 1) = 0;
            % Se recolocan los valores para tener en primer lugar el punto
            % aislado del tramo i
            for j = 1:length(variable1_y_slip{i + 1})
                if j ~= length(variable1_y_slip{i + 1})
                    variable1_y_slip{i + 1}(end - j + 1) = variable1_y_slip{i + 1}(end - j);
                    variable_x_slip{i + 1}(end - j + 1) = variable_x_slip{i + 1}(end - j);
                else
                    variable1_y_slip{i + 1}(1) = variable1_y_slip{i};
                    variable_x_slip{i + 1}(1) = variable_x_slip{i};
                end
            end
        end

        var_y_tramo = variable1_y_slip{i};
        var_x_tramo = variable_x_slip{i};
        plot(var_x_tramo, var_y_tramo, 'b','LineWidth',1.5)

        % Acumulación de puntos iniciales de tramos slip
        if length(variable1_y_slip{i}) > 1 && i > 1
            var1_x_slip_principio = [var1_x_slip_principio variable1_y_slip{i}(1)];
            var1_y_slip_principio = [var1_y_slip_principio variable_x_slip{i}(1)];
        end

        % Acumulación de puntos finales de tramos slip
        if length(variable1_y_slip{i}) > 1
            var1_x_slip_final = [var1_x_slip_final variable1_y_slip{i}(end)];
            var1_y_slip_final = [var1_y_slip_final variable_x_slip{i}(end)];
        end

        hold on
    end

    % Unión de tramos slip en la primera variable y
    for i = 1:(length(var1_y_slip_final) - 1)
        line([var1_y_slip_final(i), var1_y_slip_principio(i)], [var1_x_slip_final(i), var1_x_slip_principio(i)], 'Color', 'b','LineWidth',1.5);
    end
    
    % Unión del tramo inicial con 0
    line([variable_x_slip{1, 1}(1), variable_x_slip{1, 1}(1)], [0 + offset_y_1, variable1_y_slip{1, 1}(1)], 'Color', 'b','LineWidth',1.5);

    % Ajustes de gráfico de la primera variable
    ylabel(eje_y1, 'Interpreter', 'latex','FontSize',15)
    axes = gca;
    axes.LineStyleOrder = '-';
    
    % Plot en modo slip de la segunda variable y
    yyaxis right
    for i = 1:length(variable2_y_slip)
        % Representación de puntos aislados
        if length(variable2_y_slip{i}) == 1
            % Se añade una posición al tramo i + 1 y se inicializa a 0
            variable2_y_slip{i + 1}(end + 1) = 0; 
            % Se recolocan los valores para tener en primer lugar el punto
            % aislado del tramo i
            for j = 1:length(variable2_y_slip{i + 1})
                if j ~= length(variable2_y_slip{i + 1})
                    variable2_y_slip{i + 1}(end - j + 1) = variable2_y_slip{i + 1}(end - j);
                else
                    variable2_y_slip{i + 1}(1) = variable2_y_slip{i};
                end
            end
        end

        var_y2_tramo = variable2_y_slip{i};
        var_x2_tramo = variable_x_slip{i};
        plot(var_x2_tramo, var_y2_tramo, 'r','LineWidth',1.5)

        % Acumulación de puntos iniciales de tramos slip
        if length(variable2_y_slip{i}) > 1 && i ~= 1
            var2_y_slip_principio = [var2_y_slip_principio variable2_y_slip{i}(1)];
            var2_x_slip_principio = [var2_x_slip_principio variable_x_slip{i}(1)];
        end

        % Acumulación de puntos finales de tramos slip
        if length(variable2_y_slip{i}) > 1
            var2_x_slip_final = [var2_x_slip_final variable2_y_slip{i}(end)];
            var2_y_slip_final = [var2_y_slip_final variable_x_slip{i}(end)];
        end

        hold on
    end
    
    % Unión de tramos slip en la segunda variable y
    for i = 1:(length(var2_y_slip_final) - 1)
        line([var2_y_slip_final(i), var2_x_slip_principio(i)], [var2_x_slip_final(i), var2_y_slip_principio(i)], 'Color', 'r','LineWidth',1.5);
    end

    % Unión del tramo inicial con 0
    line([variable_x_slip{1, 1}(1), variable_x_slip{1, 1}(1)], [0 + offset_y_2, variable2_y_slip{1, 1}(1)], 'Color', 'r','LineWidth',1.5);
    
    % Ajustes de gráfico para la segunda variable y
    ylabel(eje_y2, 'Interpreter', 'latex','FontSize',15)
    axes = gca;
    axes.LineStyleOrder = '-';
end

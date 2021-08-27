function crear_frame(pos_x, pos_y, pos_xl, indice)
% Esta función se ocupa de graficar en un plot los puntos que intervienen
% en la representación de la estructura, de tal modo que se conforma un
% frame de la futura animación.

% Se generan los frames de la animación
plot(pos_x(indice), pos_y(indice), 'o')
hold on
plot(pos_xl(indice), 0, 'o')

% Se calculan los puntos del rectángulo que representa la estructura
ancho = 0.3;
alto = 0.1;
x_inicial = pos_x(indice) - ancho / 2;
y_inicial = pos_y(indice) - alto / 2;
rectangle('Position', [x_inicial y_inicial ancho alto])

% Se calculan los puntos de la línea que representa la pata de la
% estructura
line([pos_xl(indice) pos_x(indice)], [0 pos_y(indice)])

% Ajuste del frame
xlim([-0.3 1.3])
ylim([0 1])
end

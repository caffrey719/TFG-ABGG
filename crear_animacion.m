function [frames] = crear_animacion(t_out, x_out, y_out, xl_out)
% Esta función se ocupa de crear la animación, realizando las llamadas a la
% función crear_frame, almacenándo cada uno de ellos y borrándolos para que
% puedan sucederse de tal forma que se cree correctamente la animación.

for i = 1:length(t_out)
    % Se borra el frame anterior
    clf
    % Creamos el frame actual
    crear_frame(x_out, y_out, xl_out, i)
    
    % Se almacena cada estado
    frames(i) = getframe(gcf);
end
end

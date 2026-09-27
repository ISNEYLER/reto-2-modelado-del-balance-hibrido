%Horas de funcionamiento y uso del Sistema
Horas = 1:24;
% Potencia solar generada en funcion de horas del sistema
P_solar = [0 0 0 0 0 0 6.47 12.5 17.67 21.65 24.14 25 24.14 21.65 17.67 12.5 6.47 0 0 0 0 0 0 0];
% Potencia eolica generada en funcion de horas del sistema
P_eolica = [8 11 6 13 9 5 12 7 14 10 6 13 8 12 5 11 14 7 10 6 13 9 12 7];
%Potencia total del sistema (solar + eolica)
P_total = P_solar + P_eolica;

P_demanda = [3 2.5 3.5 2 3 ...      % Horas 1-5
    6 7 8 7.5 9 8.5 ...   % Horas 6-11
    9 8 7.5 9 10 8 ...    % Horas 12-17
    12 14 15 13 ...       % Horas 18-21
    3.5 3 2.5];           % Horas 22-24

figure;
%Crea la ventana para mostrar la grafica de la potencia solar
plot(Horas, P_solar, '-o');
%Dibujar el gráfico de la potencia solar con las horas en el eje x, la
%potencia en el eje "y" con linea continua (-) y circulos como las marcas
%de la gráfica (o)
xlabel('Hora');
%Etiqueta del eje x
ylabel('Potencia solar (kW)');
%Etiqueta del eje y
title('Potencia producida por los paneles solares');
%Titulo del gráfico
xticks(1:24);
%Establece las marcas en el eje x de 1 hasta 24
grid on;
%Activa la rejilla de la gráfica

figure;
%Crea la ventana para mostrar la grafica de la potencia eolica
plot(Horas, P_eolica, '-o');
%Dibujar el gráfico de la potencia eolica con las horas en el eje x, la
%potencia en el eje "y" con linea continua (-) y circulos como las marcas
%de la gráfica (o)
xlabel('Hora');
%Etiqueta del eje x
ylabel('Potencia eólica (kW)');
%Etiqueta del eje y
title('Potencia producida por los aerogeneradores');
%Titulo de la gráfica
xticks(1:24);
%Establece las marcas en el eje x de 1 hasta 24
ylim([0 16]);
%Limita de 0 a 16 los valores del eje y
grid on;
%Activa las rejilla del la gráfica


figure;
%Crea la ventana para mostrar la grafica de la potencia solar + eolica
plot(Horas, P_solar, '-o');
%Traza en el gráfico la potencia solar con sus horas
hold on;
%Le dice a matlab que conserve lo que ya está dibujado y no lo borre
plot(Horas, P_eolica, '-o');
%Traza en el gráfico la potencia eolica con sus horas
plot(Horas, P_total, '-o');
%Traza en el gráfico la potencia solar + eolica
xlabel('Hora');
%Etiqueta del eje x
ylabel('Potencia (kW)');
%Etiqueta del eje y
title('Generación híbrida solar-eólica');
%Titulo de la gráfica
legend('Solar', 'Eólica', 'Generación Total');
% Establece un
% indicador visual para diferenciar cada gráfica en la ventana
xticks(1:24);
%Establece las marcas en el eje x de 1 hasta 24
grid on;
%Activa las rejillas del la gráfica

figure;
%Crea la ventana para mostrar la grafica de la potencia demandada
plot(Horas, P_demanda, '-o');
%Traza el gráfico de la demanda energetica del pueblo en cada hora
xlabel('Hora');
%Etiqueta del eje x
ylabel('Demanda eléctrica (kW)');
%Etiqueta del eje y
title('Demanda eléctrica de la comunidad');
%Titulo de la gráfica
xticks(1:24);
%Establece las marcas en el eje x de 1 hasta 24
ylim([0 16]);
%Limita de 0 a 16 los valores del eje y
grid on;
%Activa las rejillas del la gráfica


figure;
%Crea la ventana para mostrar la grafica de la potencia total y la potencia
%demandada
plot(Horas, P_total, '-o');
%Traza el gráfico de la potencia total de la micro red
hold on;
%Le dice a matlab que conserve lo que ya está dibujado y no lo borre
plot(Horas, P_demanda, '-s');
%Traza el gráfico de la demanda de potencia del pueblo
xlabel('Tiempo en horas');
%Etiqueta del eje x
ylabel('Potencia en Kilovatios');
%Etiqueta del eje y
title('Generación Total vs Demanda de la Comunidad');
%Titulo de la gráfica
legend('Generación Total', 'Demanda del Pueblo');
% Establece un indicador visual para diferenciar cada gráfica en la venta
xticks(1:24);
%Establece las marcas en el eje x de 1 hasta 24
grid on;
%Activa las rejillas del la gráfica

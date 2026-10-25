clc;                    % Limpia la ventana de comandos.
clear;                  % Elimina las variables del espacio de trabajo.

%% CONFIGURACION E INICIALIZACIÓN DEL SISTEMA
Horas = 1:24;            % Define las 24 horas de simulacion.

% Potencia solar generada en cada hora (kW).
P_solar = [0 0 0 0 0 0 6.47 12.5 17.67 21.65 24.14 25 ...
           24.14 21.65 17.67 12.5 6.47 0 0 0 0 0 0 0];

% Potencia eolica generada en cada hora (kW).
P_eolica = [8 11 6 13 9 5 12 7 14 10 6 13 ...
            8 12 5 11 14 7 10 6 13 9 12 7];

% Demanda total de la comunidad en cada hora (kW).
P_demanda = [3 2.5 3.5 2 3 ...       % Horas 1 a 5.
             6 7 8 7.5 9 8.5 ...    % Horas 6 a 11.
             9 8 7.5 9 10 8 ...     % Horas 12 a 17.
             12 14 15 13 ...        % Horas 18 a 21.
             3.5 3 2.5];           % Horas 22 a 24.

% Calcula la generacion hibrida total de cada hora (solar + eolica).
P_total = P_solar + P_eolica;

% Define los parametros de la bateria.
Capacidad_bat = 100;     % Capacidad de la bateria (kWh).
SOC_inicial = 50;        % Carga inicial de la bateria (%).
SOC_min = 0;             % Carga minima de la bateria (%).
SOC_max = 100;           % Carga maxima de la bateria (%).
Umbral_alerta = 40;      % Umbral de la ruta de alerta (%).
Umbral_emergencia = 20;  % Umbral de la ruta de emergencia (%).

% Prepara vectores para guardar los resultados de cada hora.
Balance = zeros(1,24);            % Generacion menos demanda.
SOC_horario = zeros(1,24);        % SOC al final de cada hora (%).
Estado = cell(1,24);              % Clasificacion del estado energetico.
Escuela = cell(1,24);             % Estado de la escuela rural.
Bombeo = cell(1,24);              % Estado del bombeo agricola.
Alumbrado = cell(1,24);           % Estado del alumbrado publico.

% Inicializa el SOC antes de iniciar el ciclo horario.
SOC = SOC_inicial;

%% 2. BUCLE DE SIMULACION DE 24 HORAS
for h = 1:24
    % Obtiene la generacion total y la demanda de la hora actual.
    E_gen = P_total(h);       % Generacion hibrida durante una hora (kWh).
    E_dem = P_demanda(h);     % Demanda durante una hora (kWh).

    % Calcula el balance: si es positivo significa superavit, en caso de ser negativo significa deficit.
    Balance(h) = E_gen - E_dem;

    % Guarda el SOC con el que comienza la hora.
    SOC_actual = SOC;

    %% 3. DETECCIÓN DE SUPERAVIT O DEFICIT
    if E_gen >= E_dem
        % SUPERAVIT: la generacion cubre toda la demanda comunitaria.
        Excedente = E_gen - E_dem;  % Calcula la energia sobrante (kWh).

        % Convierte la energia excedente en carga de la batería.
        SOC_nuevo = SOC_actual + (Excedente / Capacidad_bat) * 100;

        % Impide que la bateria supere su limite maximo del 100 %.
        SOC = min(SOC_nuevo, SOC_max);

        % En superavit, los tres servicios permanecen activos.
        Escuela{h} = 'ACTIVA';
        Bombeo{h} = 'ACTIVO';
        Alumbrado{h} = 'ACTIVO';
        Estado{h} = 'SUPERAVIT';

    else
        % DEFICIT: la demanda supera la generacion disponible.
        Faltante = E_dem - E_gen;  % Calcula la energia faltante (kWh).

        % Calcula el SOC despues de cubrir el deficit con la bateria.
        SOC_nuevo = SOC_actual - (Faltante / Capacidad_bat) * 100;

        % Impide que el SOC al valor minimo %.
        SOC = max(SOC_nuevo, SOC_min);

        % Aplica el protocolo de desconexion segun el SOC.
        if SOC > Umbral_alerta
            % RUTA SEGURA: SOC superior al 40 %.
            Escuela{h} = 'ACTIVA';
            Bombeo{h} = 'ACTIVO';
            Alumbrado{h} = 'ACTIVO';
            Estado{h} = 'DEFICIT - SEGURO';

        elseif SOC > Umbral_emergencia
            % RUTA DE ALERTA: SOC mayor que 20 % y menor o igual a 40 %.
            Escuela{h} = 'ACTIVA';
            Bombeo{h} = 'ACTIVO';
            Alumbrado{h} = 'SUSPENDIDO';
            Estado{h} = 'DEFICIT - ALERTA';

        else
            % RUTA DE EMERGENCIA: SOC igual o inferior al 20 %.
            Escuela{h} = 'ACTIVA';
            Bombeo{h} = 'SUSPENDIDO';
            Alumbrado{h} = 'SUSPENDIDO';
            Estado{h} = 'DEFICIT - EMERGENCIA';
        end
    end

    % Guarda el SOC resultante de la hora actual.
    SOC_horario(h) = SOC;
end

%% 5. TABLA RESUMEN DE LAS 24 HORAS
% Organiza los resultados en una tabla para visualizar facilmente.
Resultados = table(Horas', P_solar', P_eolica', P_total', P_demanda', Balance', SOC_horario', Estado', Escuela', Bombeo', Alumbrado','VariableNames', {'Hora','Solar_kW','Eolica_kW','GeneracionTotal_kW','Demanda_kW','Balance_kWh','SOC','EstadoEnergetico','Escuela','Bombeo Agrícola','Alumbrado'});
% Muestra la tabla en la ventana de comandos.
disp(Resultados);  

%% FIN DEL PROGRAMA
fprintf('\nSimulacion de 24 horas finalizada.\n');

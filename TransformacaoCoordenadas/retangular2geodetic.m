function [lat, long, h] = retangular2geodetic(xe, ye, ze)
% =========================================================================
% 
% (*) Esta função determina a posição em coordenadas retangulares tendo as
%     informações das coordenadas em relação ao sistema ECEF.
%
% (*) As informções aqui programadas encontram-se no livro "Fundalmentais 
%     of Inertial Navigation, Satellite-based Positioning and their 
%     integration, Nouredin, Karamat and Gerogy." Páginas 50 a 52. 
%
% ENTRADAS:
%
%    xe, ye, ze ..................: coordenadas ECEF (em metros);
%
% SAÍDAS:
%
%    lat, long ...................: coordenadas retangulares (em rad);
%    h ...........................: altitude (m).
%
% 
% Eduardo H. Santos
% 22/09/2020
% =========================================================================

% Variáveis a serem empregadas.
a  = 6378137;      
f  = 1/298.257223563;
b  = a * (1 - f);
e  = sqrt( f * (2 - f) );
we = 7.292115 * 10^-5;  
GM = 3.986004418 * 10^14;
tol = 10^-12;

%  Processo iterativo (inicialização)
h(1)    = 0;
pe      = sqrt(xe^2 + ye^2);
lat(1)  = atan(ze / (pe * (1 - e^2)));
long(1) = atan(ye / xe); 

flag = 0;
i    = 1;
while( ~flag )
    i = i + 1;
    Rn(i)  = a / sqrt(1 - (e^2 * sin(lat(i-1))^2));
    h(i)   = (sqrt(xe^2 + ye^2) / cos(lat(i-1)) - Rn(i));
    lat(i) = atan( (ze/pe) * (Rn(i) + h(i))/(Rn(i)*(1 - e^2) + h(i)) );
    
    % Verifica se convergiu.
    if ( (abs(lat(i) - lat(i-1)) < tol) & (abs(h(i) - h(i-1)) < tol) )
       flag = 1; 
    end
end

% Últimas informações após a convergência.
lat  = lat(end);
long = long(end);
h    = h(end);
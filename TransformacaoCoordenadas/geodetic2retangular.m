function [xe, ye, ze] = geodetic2retangular(lat, long, h)
% =========================================================================
% 
% (*) Esta função determina a posição em coordenadas ECEF tendo as 
%     informações das coordenadas retangulares..
%
% (*) As informções aqui programadas encontram-se no livro "Fundalmentais 
%     of Inertial Navigation, Satellite-based Positioning and their 
%     integration, Nouredin, Karamat and Gerogy." Páginas 50 a 52. 
%
% ENTRADAS:
%
%    lat, long ...................: coordenadas retangulares (em rad);
%    h ...........................: altitude (m).
%
% SAÍDAS:
%
%    xe, ye, ze...................: coordenadas geodéticas (em m);
%
% 
% Eduardo H. Santos
% 22/09/2020
% =========================================================================

% Referência pega no Livro de Inerciais (página 47).
a  = 6378137;              % m
f  = 1/298.257223563;    
b  = a * (1 - f);
e  = sqrt( f * (2 - f) );
we = 7.292115 * 10^-5;     % rad/s
GM = 3.986004418 * 10^14;  % m^3/s^2

% Primeira parte do cálculo.
Rn = a / sqrt(1 - (e^2 * sin(lat)^2));
Rm = a * (1 - e^2)/ (sqrt(1 - (e^2 * sin(lat)^2)))^3;

% Segunda parte do cálculo. 
xe = (Rn + h) * cos(lat) * cos(long);
ye = (Rn + h) * cos(lat) * sin(long);
ze = (Rn*(1 - e^2) + h) * sin(lat);







clear all; close all; clc; 

% Entrada carteada.
LAT  = 38.736946 * (pi/180);
LONG = -9.142685 * (pi/180);
H    = 87;

% Vai e volta (para conferência entre as funções).
[xe, ye, ze]   = geodetic2retangular(LAT, LONG, H);
[lat, long, h] = retangular2geodetic(xe, ye, ze);

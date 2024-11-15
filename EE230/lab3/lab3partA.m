% Press "Run" to load the data in to the MATLAB workspace. To get started,
% try typing "plot(freqHz, mag)" in the command window (after running this
% file). 
% Type "help semilogx" and "help plot" or go to the Mathworks documentation 
% page on "plot" to learn more. Pay special attention to "hold."
% Other useful things: help grid, help subplot, help rad2deg.
freq_hz = [...
   100.000, 	   146.800, 	   215.400, ...
   316.200, 	   464.200, 	   681.300, ...
  1000.000, 	  1468.000, 	  2154.000, ...
  3162.000, 	  4642.000, 	  6813.000, ...
 10000.000, 	 14680.000, 	 21540.000, ...
 31620.000, 	 46420.000, 	 68130.000, ...
100000.000];

mag_dB = [...
    12.983, 	    12.956, 	    12.905, ...
    12.804, 	    12.601, 	    12.200, ...
    11.454, 	    10.205, 	     8.359, ...
     5.965, 	     3.215, 	     0.215, ...
    -2.946, 	    -6.162, 	    -9.431, ...
   -12.597, 	   -15.923, 	   -19.283, ...
   -22.451];

mag_v = [...
     4.458, 	     4.444, 	     4.418, ...
     4.367, 	     4.266, 	     4.074, ...
     3.738, 	     3.238, 	     2.618, ...
     1.987, 	     1.448, 	     1.025, ...
     0.712, 	     0.492, 	     0.338, ...
     0.234, 	     0.160, 	     0.109, ...
     0.075];

mag_vout = [...
     2.109, 	     2.112, 	     2.115, ...
     2.109, 	     2.077, 	     1.995, ...
     1.837, 	     1.594, 	     1.290, ...
     0.979, 	     0.714, 	     0.505, ...
     0.351, 	     0.242, 	     0.166, ...
     0.116, 	     0.079, 	     0.054, ...
     0.037];

mag_vin = [...
     0.473, 	     0.475, 	     0.479, ...
     0.483, 	     0.487, 	     0.490, ...
     0.491, 	     0.492, 	     0.493, ...
     0.493, 	     0.493, 	     0.493, ...
     0.493, 	     0.492, 	     0.491, ...
     0.494, 	     0.495, 	     0.496, ...
     0.497];

phase_rad = [...
     3.075, 	     3.045, 	     3.001, ...
     2.937, 	     2.846, 	     2.722, ...
     2.565, 	     2.384, 	     2.200, ...
     2.037, 	     1.905, 	     1.806, ...
     1.733, 	     1.681, 	     1.643, ...
     1.614, 	     1.591, 	     1.573, ...
     1.565];

omega = 2 * pi *freq_hz;



%calc_mag = 20 * log10( 4.55 .* 10000 ./ (sqrt(10000^2 + omega.^2)) );
calc_phase = pi-atan(omega ./ 10000);
semilogx(freq_hz,calc_phase);
hold on
semilogx(freq_hz,phase_rad);

xlabel("Frequency, Hz");
ylabel("Phase, rad");




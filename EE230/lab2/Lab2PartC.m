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
    19.974, 	    19.948, 	    19.896, ...
    19.796, 	    19.596, 	    19.209, ...
    18.489, 	    17.283, 	    15.488, ...
    13.141, 	    10.447, 	     7.394, ...
     4.338, 	     1.170, 	    -2.089, ...
    -5.457, 	    -8.623, 	   -12.019, ...
   -15.282];

mag_v = [...
     9.970, 	     9.940, 	     9.881, ...
     9.768, 	     9.546, 	     9.129, ...
     8.403, 	     7.314, 	     5.948, ...
     4.540, 	     3.329, 	     2.343, ...
     1.648, 	     1.144, 	     0.786, ...
     0.534, 	     0.371, 	     0.251, ...
     0.172];

mag_vout = [...
     1.156, 	     1.158, 	     1.159, ...
     1.156, 	     1.140, 	     1.096, ...
     1.013, 	     0.883, 	     0.719, ...
     0.549, 	     0.403, 	     0.283, ...
     0.199, 	     0.138, 	     0.095, ...
     0.065, 	     0.045, 	     0.030, ...
     0.021];

mag_vin = [...
     0.116, 	     0.116, 	     0.117, ...
     0.118, 	     0.119, 	     0.120, ...
     0.121, 	     0.121, 	     0.121, ...
     0.121, 	     0.121, 	     0.121, ...
     0.121, 	     0.121, 	     0.120, ...
     0.121, 	     0.121, 	     0.122, ...
     0.122];

phase_rad = [...
     3.077, 	     3.048, 	     3.005, ...
     2.943, 	     2.856, 	     2.737, ...
     2.585, 	     2.406, 	     2.223, ...
     2.057, 	     1.921, 	     1.818, ...
     1.743, 	     1.689, 	     1.649, ...
     1.620, 	     1.597, 	     1.580, ...
     1.572];

omega = 2 * pi *freq_hz;

subplot(2,1,1); 
calc_mag = 20 * log10(10000 ./ (sqrt(1000^2 + omega.^2)));
semilogx(freq_hz,calc_mag);
hold on
semilogx(freq_hz,mag_dB);

xlabel("Frequency, Hz");
ylabel("Magnitude, dB");

subplot(2,1,2); 
calc_phase= -atan(omega ./ 1000);
semilogx(freq_hz,calc_phase);
hold on
semilogx(freq_hz,phase_rad);

xlabel("Frequency, Hz");
ylabel("Phase, rad");
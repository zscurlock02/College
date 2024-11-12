% Press "Run" to load the data in to the MATLAB workspace. To get started,
% try typing "plot(freqHz, mag)" in the command window (after running this
% file). 
% Type "help semilogx" and "help plot" or go to the Mathworks documentation 
% page on "plot" to learn more. Pay special attention to "hold."
% Other useful things: help grid, help subplot, help rad2deg.
freq_hz = [...
   100.000, 	   112.200, 	   125.900, ...
   141.300, 	   158.500, 	   177.800, ...
   199.500, 	   223.900, 	   251.200, ...
   281.800, 	   316.200, 	   354.800, ...
   398.100, 	   446.700, 	   501.200, ...
   562.300, 	   631.000, 	   707.900, ...
   794.300, 	   891.300, 	  1000.000, ...
  1122.000, 	  1259.000, 	  1413.000, ...
  1585.000, 	  1778.000, 	  1995.000, ...
  2239.000, 	  2512.000, 	  2818.000, ...
  3162.000, 	  3548.000, 	  3981.000, ...
  4467.000, 	  5012.000, 	  5623.000, ...
  6310.000, 	  7079.000, 	  7943.000, ...
  8913.000, 	 10000.000, 	 11220.000, ...
 12590.000, 	 14130.000, 	 15850.000, ...
 17780.000, 	 19950.000, 	 22390.000, ...
 25120.000, 	 28180.000, 	 31620.000, ...
 35480.000, 	 39810.000, 	 44670.000, ...
 50120.000, 	 56230.000, 	 63100.000, ...
 70790.000, 	 79430.000, 	 89130.000, ...
100000.000];

mag_dB = [...
   -31.053, 	   -30.998, 	   -30.927, ...
   -30.859, 	   -30.748, 	   -30.630, ...
   -30.482, 	   -30.290, 	   -30.070, ...
   -29.800, 	   -29.483, 	   -29.101, ...
   -28.669, 	   -28.183, 	   -27.636, ...
   -27.035, 	   -26.357, 	   -25.631, ...
   -24.821, 	   -23.979, 	   -23.061, ...
   -22.084, 	   -21.047, 	   -19.939, ...
   -18.758, 	   -17.478, 	   -16.069, ...
   -14.497, 	   -12.723, 	   -10.702, ...
    -8.181, 	    -5.538, 	    -4.252, ...
    -5.346, 	    -7.600, 	    -9.953, ...
   -12.039, 	   -13.976, 	   -15.639, ...
   -17.102, 	   -18.569, 	   -19.769, ...
   -21.001, 	   -22.302, 	   -23.450, ...
   -24.569, 	   -25.664, 	   -26.737, ...
   -27.789, 	   -28.842, 	   -29.903, ...
   -30.939, 	   -31.949, 	   -32.992, ...
   -34.028, 	   -35.072, 	   -36.081, ...
   -37.118, 	   -38.133, 	   -39.192, ...
   -40.268];

mag_v = [...
     0.028, 	     0.028, 	     0.028, ...
     0.029, 	     0.029, 	     0.029, ...
     0.030, 	     0.031, 	     0.031, ...
     0.032, 	     0.034, 	     0.035, ...
     0.037, 	     0.039, 	     0.042, ...
     0.044, 	     0.048, 	     0.052, ...
     0.057, 	     0.063, 	     0.070, ...
     0.079, 	     0.089, 	     0.101, ...
     0.115, 	     0.134, 	     0.157, ...
     0.188, 	     0.231, 	     0.292, ...
     0.390, 	     0.529, 	     0.613, ...
     0.540, 	     0.417, 	     0.318, ...
     0.250, 	     0.200, 	     0.165, ...
     0.140, 	     0.118, 	     0.103, ...
     0.089, 	     0.077, 	     0.067, ...
     0.059, 	     0.052, 	     0.046, ...
     0.041, 	     0.036, 	     0.032, ...
     0.028, 	     0.025, 	     0.022, ...
     0.020, 	     0.018, 	     0.016, ...
     0.014, 	     0.012, 	     0.011, ...
     0.010];

mag_vout = [...
     0.013, 	     0.013, 	     0.013, ...
     0.013, 	     0.014, 	     0.014, ...
     0.014, 	     0.015, 	     0.015, ...
     0.015, 	     0.016, 	     0.017, ...
     0.018, 	     0.019, 	     0.020, ...
     0.022, 	     0.023, 	     0.025, ...
     0.028, 	     0.031, 	     0.034, ...
     0.038, 	     0.043, 	     0.049, ...
     0.056, 	     0.065, 	     0.077, ...
     0.092, 	     0.113, 	     0.143, ...
     0.192, 	     0.262, 	     0.306, ...
     0.268, 	     0.205, 	     0.156, ...
     0.122, 	     0.098, 	     0.081, ...
     0.068, 	     0.058, 	     0.050, ...
     0.044, 	     0.037, 	     0.033, ...
     0.029, 	     0.025, 	     0.022, ...
     0.020, 	     0.017, 	     0.016, ...
     0.014, 	     0.012, 	     0.011, ...
     0.010, 	     0.009, 	     0.008, ...
     0.007, 	     0.006, 	     0.005, ...
     0.005];

mag_vin = [...
     0.468, 	     0.469, 	     0.469, ...
     0.470, 	     0.471, 	     0.472, ...
     0.473, 	     0.474, 	     0.475, ...
     0.477, 	     0.478, 	     0.479, ...
     0.481, 	     0.482, 	     0.483, ...
     0.484, 	     0.485, 	     0.485, ...
     0.486, 	     0.486, 	     0.487, ...
     0.487, 	     0.487, 	     0.488, ...
     0.488, 	     0.488, 	     0.489, ...
     0.489, 	     0.490, 	     0.491, ...
     0.493, 	     0.496, 	     0.499, ...
     0.496, 	     0.493, 	     0.491, ...
     0.490, 	     0.490, 	     0.489, ...
     0.489, 	     0.489, 	     0.489, ...
     0.489, 	     0.488, 	     0.488, ...
     0.488, 	     0.487, 	     0.487, ...
     0.483, 	     0.483, 	     0.489, ...
     0.490, 	     0.490, 	     0.490, ...
     0.491, 	     0.491, 	     0.491, ...
     0.491, 	     0.492, 	     0.492, ...
     0.492];

phase_rad = [...
     0.207, 	     0.230, 	     0.258, ...
     0.288, 	     0.321, 	     0.356, ...
     0.394, 	     0.435, 	     0.480, ...
     0.526, 	     0.576, 	     0.627, ...
     0.680, 	     0.731, 	     0.783, ...
     0.832, 	     0.881, 	     0.926, ...
     0.967, 	     1.005, 	     1.037, ...
     1.065, 	     1.086, 	     1.102, ...
     1.110, 	     1.108, 	     1.096, ...
     1.068, 	     1.016, 	     0.923, ...
     0.752, 	     0.423, 	    -0.105, ...
    -0.609, 	    -0.934, 	    -1.125, ...
    -1.240, 	    -1.314, 	    -1.365, ...
    -1.401, 	    -1.428, 	    -1.449, ...
    -1.466, 	    -1.479, 	    -1.490, ...
    -1.498, 	    -1.506, 	    -1.512, ...
    -1.517, 	    -1.522, 	    -1.525, ...
    -1.529, 	    -1.531, 	    -1.533, ...
    -1.536, 	    -1.536, 	    -1.538, ...
    -1.537, 	    -1.538, 	    -1.536, ...
    -1.533];

omega = 2 * pi *freq_hz;

transfer = 6666.67 * ((j .* omega) ./ ((j .* omega).^2 + 6666.67 * j .* omega + 666666666.7));

calc_phase = angle(transfer);
calc_mag = 20 * log10(abs(transfer));
semilogx(freq_hz,phase_rad);
hold on
semilogx(freq_hz,calc_phase);

xlabel("Frequency, Hz");
ylabel("Phase, rad");
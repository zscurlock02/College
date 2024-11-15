% Press "Run" to load the data in to the MATLAB workspace. To get started,
% try typing "plot(freqHz, mag)" in the command window (after running this
% file). 
% Type "help semilogx" and "help plot" or go to the Mathworks documentation 
% page on "plot" to learn more. Pay special attention to "hold."
% Other useful things: help grid, help subplot, help rad2deg.
freq_hz = [...
   100.000, 	   116.600, 	   135.900, ...
   158.500, 	   184.800, 	   215.400, ...
   251.200, 	   292.900, 	   341.500, ...
   398.100, 	   464.200, 	   541.200, ...
   631.000, 	   735.600, 	   857.700, ...
  1000.000, 	  1166.000, 	  1359.000, ...
  1585.000, 	  1848.000, 	  2154.000, ...
  2512.000, 	  2929.000, 	  3415.000, ...
  3981.000, 	  4642.000, 	  5412.000, ...
  6310.000, 	  7356.000, 	  8577.000, ...
 10000.000, 	 11660.000, 	 13590.000, ...
 15850.000, 	 18480.000, 	 21540.000, ...
 25120.000, 	 29290.000, 	 34150.000, ...
 39810.000, 	 46420.000, 	 54120.000, ...
 63100.000, 	 73560.000, 	 85770.000, ...
100000.000];

mag_dB = [...
    -6.487, 	    -5.175, 	    -3.873, ...
    -2.571, 	    -1.293, 	    -0.041, ...
     1.182, 	     2.511, 	     3.712, ...
     4.847, 	     5.992, 	     7.042, ...
     8.141, 	     9.045, 	     9.933, ...
    10.655, 	    11.245, 	    11.774, ...
    12.208, 	    12.610, 	    12.891, ...
    13.109, 	    13.275, 	    13.401, ...
    13.493, 	    13.563, 	    13.614, ...
    13.651, 	    13.678, 	    13.698, ...
    13.711, 	    13.721, 	    13.727, ...
    13.730, 	    13.732, 	    13.731, ...
    13.729, 	    13.720, 	    13.709, ...
    13.695, 	    13.674, 	    13.642, ...
    13.595, 	    13.521, 	    13.392, ...
    13.118];

mag_v = [...
     0.474, 	     0.551, 	     0.640, ...
     0.744, 	     0.862, 	     0.995, ...
     1.146, 	     1.335, 	     1.533, ...
     1.747, 	     1.994, 	     2.250, ...
     2.553, 	     2.833, 	     3.138, ...
     3.410, 	     3.650, 	     3.879, ...
     4.078, 	     4.271, 	     4.411, ...
     4.523, 	     4.610, 	     4.678, ...
     4.728, 	     4.766, 	     4.794, ...
     4.814, 	     4.830, 	     4.841, ...
     4.848, 	     4.853, 	     4.857, ...
     4.859, 	     4.859, 	     4.859, ...
     4.858, 	     4.853, 	     4.847, ...
     4.839, 	     4.827, 	     4.810, ...
     4.784, 	     4.743, 	     4.673, ...
     4.528];

mag_vout = [...
     0.230, 	     0.268, 	     0.312, ...
     0.363, 	     0.421, 	     0.488, ...
     0.564, 	     0.659, 	     0.759, ...
     0.868, 	     0.993, 	     1.123, ...
     1.277, 	     1.419, 	     1.574, ...
     1.712, 	     1.834, 	     1.951, ...
     2.053, 	     2.154, 	     2.228, ...
     2.288, 	     2.336, 	     2.374, ...
     2.403, 	     2.426, 	     2.442, ...
     2.455, 	     2.466, 	     2.473, ...
     2.479, 	     2.480, 	     2.483, ...
     2.483, 	     2.480, 	     2.474, ...
     2.458, 	     2.459, 	     2.484, ...
     2.482, 	     2.478, 	     2.471, ...
     2.460, 	     2.441, 	     2.408, ...
     2.337];

mag_vin = [...
     0.485, 	     0.486, 	     0.487, ...
     0.488, 	     0.489, 	     0.490, ...
     0.492, 	     0.494, 	     0.495, ...
     0.497, 	     0.498, 	     0.499, ...
     0.500, 	     0.501, 	     0.502, ...
     0.502, 	     0.503, 	     0.503, ...
     0.504, 	     0.504, 	     0.505, ...
     0.506, 	     0.507, 	     0.507, ...
     0.508, 	     0.509, 	     0.509, ...
     0.510, 	     0.511, 	     0.511, ...
     0.511, 	     0.511, 	     0.511, ...
     0.511, 	     0.510, 	     0.509, ...
     0.506, 	     0.507, 	     0.513, ...
     0.513, 	     0.513, 	     0.514, ...
     0.514, 	     0.515, 	     0.515, ...
     0.516];

phase_rad = [...
     4.605, 	     4.589, 	     4.571, ...
     4.550, 	     4.526, 	     4.498, ...
     4.465, 	     4.428, 	     4.386, ...
     4.338, 	     4.285, 	     4.225, ...
     4.161, 	     4.091, 	     4.018, ...
     3.943, 	     3.866, 	     3.791, ...
     3.719, 	     3.650, 	     3.586, ...
     3.527, 	     3.474, 	     3.427, ...
     3.384, 	     3.347, 	     3.313, ...
     3.283, 	     3.257, 	     3.232, ...
     3.210, 	     3.190, 	     3.170, ...
     3.151, 	     3.132, 	     3.113, ...
     3.093, 	     3.072, 	     3.049, ...
     3.024, 	     2.995, 	     2.961, ...
     2.921, 	     2.871, 	     2.807, ...
     2.715];


omega = 2 * pi *freq_hz;


subplot(2,1,1);
calc_mag = 20 * log10( 5 .* omega ./ (sqrt(6447.45^2 + omega.^2)) );
semilogx(freq_hz,calc_mag);
hold on
semilogx(freq_hz,mag_dB);

xlabel("Frequency, Hz");
ylabel("Magnitude, dB");

subplot(2,1,2); 
calc_phase= atan(6447.5 ./ omega);
semilogx(freq_hz,calc_phase);
hold on
semilogx(freq_hz,phase_rad);

xlabel("Frequency, Hz");
ylabel("Phase, rad");



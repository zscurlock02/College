# reset our counter
force CLRN 0 0, 1 20

# now observe the count
force CLOCK 0 0, 1 50 -repeat 100
force ENABLE 0 0, 1 100, 0 1900, 1 2100

run 2400 
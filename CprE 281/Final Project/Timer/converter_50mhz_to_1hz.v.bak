module Converter_50mHz_To_1Hz(clock_in, clock_out);
    input clock_in;
    output clock_out;

    wire clock_in;
    reg clock_out = 0;

    localparam div_value = 24999999;

    //<statements>
    // division_value = 50MHz/(2*desired_value) - 1

    integer counter_value = 0;

    // counter 
    always@ (posedge clock_in)
    begin
        if (counter_value == div_value)
            counter_value <= 0;
        else 
            counter_value <= counter_value+1;
        end 

     // clock divider
     always@ (posedge clock_in)
     begin
        if(counter_value == div_value)
           clock_out <= ~clock_out;    // Suppose to occur after 0.5sec
        else
           clock_out <= clock_out;     // If the counter is not at its limit, do nothing 
        end
     endmodule
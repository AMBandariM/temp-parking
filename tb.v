module tb;
reg clk = 0, rst = 0, carin, is_uni_carin, carout, is_uni_carout;
wire [15:0] uni_parked_car, parked_car, uni_vacated_space, vacated_space;
wire uni_is_vacated_space, is_vacated_space;

board brd(clk, rst, carin, is_uni_carin, carout, is_uni_carout, uni_parked_car, parked_car,
uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space);

always begin
    #1 clk = ~clk;
end

initial begin
    rst = 1;
    #2
    rst = 0;
    #7200 // one hour
    #7200
    #7200
    #7200
    
    #7200
    #7200
    #7200
    #7200
    #7200
    
    carin = 1; is_uni_carin = 0;
    #600
    carin = 1; is_uni_carin = 1;
    carout = 1; is_uni_carout = 0;
    #200
    carin = 1; is_uni_carin = 1;
    #800
    carin = 0;
    #7200
    #7200
    #7200
    #7200
    carout = 1; is_uni_carout = 1;
    #100
    #100
    #800
    carout = 0;
    #7200
    #7200
    #7200
    
    #7200
    #7200
    #7200
    #7200
    #7200
    $stop;
end

initial begin
    $monitor("%t, %2t:%2t] parked:%d-%d vacated:%d-%d open:%b-%b", $time, brd.hour, brd.minute, uni_parked_car,
    parked_car, uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space);
end
endmodule

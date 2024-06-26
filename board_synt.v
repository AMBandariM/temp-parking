module board_synt (
    input clk, reset, car_entered, is_uni_car_entered, car_exited, is_uni_car_exited,
    output reg [15:0] uni_parked_car, parked_car,
    output [15:0] uni_vacated_space, vacated_space,
    output uni_is_vacated_space, is_vacated_space
);
wire [5:0] hour, minute;
timer_synt tmr (clk, reset, hour, minute);

reg [15:0] uni_max, pub_max;
assign uni_vacated_space = uni_max <= uni_parked_car ? 0 : (pub_max > parked_car ? uni_max - uni_parked_car : 700 - parked_car - uni_parked_car);
assign vacated_space = pub_max <= parked_car ? 0 : (uni_max > uni_parked_car ? pub_max - parked_car : 700 - parked_car - uni_parked_car);
assign uni_is_vacated_space = uni_vacated_space > 0;
assign is_vacated_space = vacated_space > 0;

always @(hour) begin
    uni_max = 0; pub_max = 0;
    if (hour >= 8 && hour < 13) begin uni_max = 500; pub_max = 200; end
    else if (hour == 13) begin uni_max = 450; pub_max = 250; end
    else if (hour == 14) begin uni_max = 400; pub_max = 300; end
    else if (hour == 15) begin uni_max = 350; pub_max = 350; end
    else if (hour >= 16 && hour < 21) begin uni_max = 200; pub_max = 500; end
end

always @(posedge clk) begin
    if (car_exited) begin
        if (is_uni_car_exited && uni_parked_car != 0) uni_parked_car = uni_parked_car - 1;
        else if (parked_car != 0) parked_car = parked_car - 1;
    end
    if (car_entered) begin
        if (is_uni_car_entered && uni_parked_car < uni_max) uni_parked_car = uni_parked_car + 1;
        else if (parked_car < pub_max) parked_car = parked_car + 1;
    end

    if (reset) begin
        uni_parked_car =16'b0;
        parked_car =16'b0;
    end
end
endmodule


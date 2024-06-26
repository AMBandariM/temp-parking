module timer_synt (
    input clk, reset,
    output reg [5:0] hour, minute
);
reg [25:0] counter;

always @(posedge clk) begin
    counter = counter + 1;
    if (counter >= 6000000) begin counter = 0; minute = minute + 1; end
    if (minute >= 60) begin minute = 0; hour = hour + 1; end
    if (hour >= 24) begin hour = 0; end
    if (reset) begin        
        hour = 6'b0;
        minute = 6'b0;
        counter = 26'b0;
    end
end

endmodule


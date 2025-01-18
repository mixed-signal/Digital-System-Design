module fsmdebounce
(
    input logic clk, reset,
    input logic sw,
    output logic db
);

localparam N = 20;

typedef enum {zero, wait1_1, wait1_2, wait1_3, one, wait0_1, wait0_2, wait0_3} state_type;

state_type state_reg, state_next;
logic [N-1:0] qreg;
logic [N-1:0] qnext;
logic mtick;

always_ff @( posedge clk )
    qreg <= qnext;

assign qnext = qreg + 1;
assign mtick = (qreg == 0) ? 1'b1 : 1'b0;

always_ff @( posedge clk, posedge reset )
begin
    if (reset)
    begin
        state_reg <= 0;
        qreg = {N{1'b0}};
    end
    else
        state_reg <= state_next;
end

always_comb 
begin
    state_next = state_reg;
    db = 1'b0;
    case(state_reg)
    zero :
        if(sw)
        state_next = wait1_1;
    wait1_1 :
        if(~sw)
        state_next = zero;
        else
            if (mtick)
            state_next = wait1_2;
    wait1_2 :
        if(~sw)
        state_next = zero;
        else
            if(mtick)
            state_next = wait1_3;
    wait1_3 :
        if(~sw)
        state_next = zero;
        else
            if(mtick)
            state_next = one;
    one :
    begin
        db = 1'b1;
        if (~sw)
        state_next = wait0_1;
    end
    wait0_1 :
    begin
        db = 1'b1;
        if (sw)
        state_next = one;
        else
            if(mtick)
            state_next = wait0_2;
    end
    wait0_2 :
    begin
        db = 1'b1; 
        if (sw)
        state_next = one;
        else 
            if(mtick)
            state_next = wait0_3;
    end
    wait0_3 :
    begin
        db = 1'b1;
        if (sw)
        state_next = one;
        else
            if(mtick)
            state_next = zero;
    end
    default :
        state_next = zero;


    endcase
    
end


initial begin
    $dumpfile("debounce.vcd");
    $dumpvars;
end

endmodule
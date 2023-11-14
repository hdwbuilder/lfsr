module get_next_state(
 input  wire rstn, get_random, load_seed,
 input  wire [3:0] state,
 output reg [3:0] next_state
);


always@(rstn, get_random, load_seed, state) begin
 if(rstn == 0)
  next_state <= 4'd0;
 else begin    
  case(state)
    4'd0: begin 
           if(( get_random == 1) && (load_seed == 0)) next_state <= 4'd1;
           else if(( get_random == 0) && (load_seed == 1)) next_state <= 4'd5;
           else next_state <= 4'd0; 
          end
    4'd1: next_state <= 4'd2; 
    4'd2: next_state <= 4'd3;     
    4'd3: next_state <= 4'd4;     
    4'd4: begin  
           if(( get_random == 1) && (load_seed == 0)) next_state <= 4'd1;
           else next_state <= 4'd0;
          end
    4'd5: next_state <= 4'd6; 
    4'd6: next_state <= 4'd7; 
    4'd7: next_state <= 4'd8; 
    4'd8: next_state <= 4'd0;     
  endcase
  end
 end
endmodule 
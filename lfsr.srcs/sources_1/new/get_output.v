
module get_output(
input wire clk, rstn,
input wire [7:0] data_in,
input wire [3:0] next_state,
output reg [3:0] state = 0,
output reg [0:31] input_change, 
output reg [7:0] data_out  
    );
  
always@(posedge clk)
state<= next_state;
   
always@(posedge clk)
 begin
 data_out <= 0;
  case(state)
    4'd0: begin
          if(rstn == 1)
           input_change <= {input_change[31]^input_change[29]^input_change[19]^input_change[16]^
                            input_change[15]^input_change[13]^input_change[2],input_change[0:30]};
          else begin 
                input_change <= 32'h02468ACD;                   
               end 
          end
    4'd1: data_out <= input_change[24:31];
    4'd2: data_out <= input_change[16:23];
    4'd3: data_out <= input_change[8:15];
    4'd4: data_out <= input_change[0:7];
    4'd5: input_change[24:31]<= data_in;
    4'd6: input_change[16:23]<= data_in;
    4'd7: input_change[8:15]<= data_in;
    4'd8: input_change[0:7]<= data_in;      
  endcase      
 end        
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2021 06:37:35 PM
// Design Name: 
// Module Name: lfsr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lfsr(
 input wire clk, rstn, get_random, load_seed,
 input wire [7:0] data_in, 
 output wire [7:0] data_out    
);

 wire [0:31] input_change;  
 wire [3:0] state, next_state;


 get_next_state lfsr_next_state(
  .rstn(rstn),
  .get_random(get_random),
  .load_seed(load_seed),
  .state(state),
  .next_state(next_state)
);

 get_output lfsr_opt(
  .clk(clk), 
  .rstn(rstn),
  .data_in(data_in), 
  .next_state(next_state),
  .state(state),
  .input_change(input_change),
  .data_out(data_out)  
 );
  
endmodule 







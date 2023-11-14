`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 09:41:44 AM
// Design Name: 
// Module Name: lfsr_tb
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

module lfsr_tb(
);

reg clk_tb, rstn_tb;
reg getrandom_tb;
reg loadseed_tb;
reg [7:0] datain_tb;
wire [7:0] dataout_tb;
      
lfsr DUT(
 .clk(clk_tb), 
 .rstn(rstn_tb), 
 .get_random(getrandom_tb), 
 .load_seed(loadseed_tb), 
 .data_in(datain_tb), 
 .data_out(dataout_tb)   
 );

// clock        
always 
begin
    clk_tb = 0;
    #5
    clk_tb = 1;
    #5;
end

// test cases 
initial 
begin
/* 1. check loading and while loading dataout_tb should be 0 
   2. check while shift dataout_tb should be 0   
   3. check output after shift when get_random is set for less then 4 cycles */  

    rstn_tb = 0;
    loadseed_tb = 0;
    getrandom_tb = 0;            
    
    #10
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during reset");
    datain_tb = 8'hCD;
    rstn_tb = 1;
    loadseed_tb = 1;
   
    #10  
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during shift"); 
    
    #10 
    datain_tb = 8'h8A;
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during loading");
   
    #10  
    loadseed_tb = 1;
    datain_tb = 8'h46;
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during loading");
   

    #10
    datain_tb = 8'h02;
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during loading");
    
    
    #10    
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during shift");
    loadseed_tb = 0;
    getrandom_tb = 1;     
    
    #10   
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during shift");
    
// check the value loaded by reading them after one shift     
    #10
    getrandom_tb = 0;        
    if(dataout_tb != 8'h66) $fatal("Incorrect output after shift"); 
   
    #10
    if(dataout_tb != 8'h45) $fatal("Incorrect output after shift"); 
   
    #10    
    if(dataout_tb != 8'h23) $fatal("Incorrect output after shift");
    
    #10    
    if(dataout_tb != 8'h01) $fatal("Incorrect output after shift");
    
    $display("Loading was accurate:Compared values obtained after 1 shift in dataout_tb");
    $display("After loading a word, successful shit was performed");
    $display("Correct bytes were obtained when get_random was set for less than 4 cycles");
    
    #10                         
    getrandom_tb = 1;   
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during shift");      
    
    #10 
    if(dataout_tb != 8'h00)  $fatal("Output not cleared during shift");
    
    #50                                                
    if(dataout_tb != 8'h59) $fatal("Incorrect output after shift"); 

// 4. check output after 2 shift when get random is set for more than 4 cycles.     
    #10                             
    if(dataout_tb != 8'hD1) $fatal("Incorrect output after shift"); 
    
    #10                             
    if(dataout_tb != 8'h48) $fatal("Incorrect output after shift"); 
    loadseed_tb = 1;
    
    #10  
     if(dataout_tb != 8'h80) $fatal("Incorrect output after shift!");  
     $display("Test Case:Get_random active more than 4 cycles and no shifts occurred:Successful");
   
// 5. check output when load_see and get_random are high together    
    #10 
    if(dataout_tb != 8'h00) $fatal("Incorrect output when load_seed, rstn and get_random are high");
    
    $display("All test are successful!!");
    $finish;   
     
end   
endmodule
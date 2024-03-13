`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2024 10:33:29 AM
// Design Name: 
// Module Name: clkdivider
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


module clkdivider(
input     clk,  // master clock 
input clr,
//input     [1:0] sw, // input for switch
//output    refreshClk,  //refresh the display
output    clk_25, //counter clock
output one_second_enable
);

reg [26:0] 	count = 0;  // counter register variable


reg      	tmp_clk = 0; // temporary clock register variable

assign clk_25 = tmp_clk;// 0.5Hz clock


BUFG clock_buf_0(  //buffered clock to reduce the clock skew
  .I(clk),
  .O(clk_100mhz)
);

// use two always block to generate the clock. 
// when postive edge of master clock, both always block will be evaluated immediately
// Use non-block assignment in the block

always @(posedge clk_100mhz) begin // use for loop to generate the tmp_clk. tmp_clk*count = master 
//      if (count < 50000000) begin //10,000,000 is within the refresh vector range 2^27 
//        count <= count + 1; // count up
//      end
//      else begin
//        tmp_clk <= ~tmp_clk; // flip the signal when count reaches 250,000. 
//        count <= 0; // reset the counter
//      end
       if (clr == 1)
            count <= 0;
       else begin
            if (count >= 99999999)
                count <= 0;
            else
                count <= count + 1;
       end
end
       
assign one_second_enable = (count == 99999999) ? 1 : 0;
    
endmodule

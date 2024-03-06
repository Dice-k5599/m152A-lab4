`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:22:49 PM
// Design Name: 
// Module Name: wam_obd
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


module wam_obd(             // 1-bit digital tube output
    input wire [3:0] num,
    output reg [6:0] a2g
    );

    always @(*) begin
        case(num)
            'h0: a2g=7'b0000001;
            'h1: a2g=7'b1001111;
            'h2: a2g=7'b0010010;
            'h3: a2g=7'b0000110;
            'h4: a2g=7'b1001100;
            'h5: a2g=7'b0100100;
            'h6: a2g=7'b0100000;
            'h7: a2g=7'b0001111;
            'h8: a2g=7'b0000000;
            'h9: a2g=7'b0000100;
            'hA: a2g=7'b1001000;        // use A for H
            'hB: a2g=7'b0011100;        // use B for higher o
            'hC: a2g=7'b0110001;
            'hD: a2g=7'b1000010;
            'hE: a2g=7'b0110000;
            'hF: a2g=7'b1111111;        // use F for blank
            default: a2g=7'b1111111;    // default is blank
        endcase
    end
endmodule // wam_obd

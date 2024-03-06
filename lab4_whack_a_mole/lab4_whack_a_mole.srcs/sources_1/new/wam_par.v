`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 04:30:26 PM
// Design Name: 
// Module Name: wam_par
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


module wam_par (            // decide hardness parameters
    input wire [3:0] hrdn,
    output reg [3:0] age,
    output reg [7:0] rto
    );

    always @ ( * ) begin
        case (hrdn)
            'h0: begin
                age <= 4'd14;
                rto <= 42;
            end
            'h1: begin
                age <= 4'd11;
                rto <= 62;
            end
            'h2: begin
                age <= 4'd09;
                rto <= 76;
            end
            'h3: begin
                age <= 4'd07;
                rto <= 87;
            end
            'h4: begin
                age <= 4'd06;
                rto <= 93;
            end
            'h5: begin
                age <= 4'd05;
                rto <= 96;
            end
            'h6: begin
                age <= 4'd04;
                rto <= 93;
            end
            'h7: begin
                age <= 4'd04;
                rto <= 87;
            end
            'h8: begin
                age <= 4'd03;
                rto <= 76;
            end
            'h9: begin
                age <= 4'd03;
                rto <= 61;
            end
            'hA: begin
                age <= 4'd02;
                rto <= 93;
            end
            default: begin
                age <= 4'b0111;
                rto <= 70;
            end
        endcase
    end
endmodule // wam_par

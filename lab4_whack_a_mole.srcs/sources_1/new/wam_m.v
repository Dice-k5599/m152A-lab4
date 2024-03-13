`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 11:29:27 AM
// Design Name: 
// Module Name: wam_m
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

module WhackAMole(input clk, input start, input whack, output reg game_over);

  reg [3:0] lives_reg;
  reg [3:0] whacks_reg;
  reg [3:0] moles_reg;
  wire [3:0] moles_next;

  always @(posedge clk) begin
    if (start) begin
      lives_reg <= 4'b0100;  
      whacks_reg <= 4'b0000; 
      moles_reg <= 4'b0101;  
    end else begin
      lives_reg <= lives_reg;  
      whacks_reg <= whack ? whacks_reg + 1 : whacks_reg; 
      moles_reg <= moles_next; 
    end
  end

  assign moles_next = {moles_reg[2:0], moles_reg[3]}; 

  always @(posedge clk) begin
    if (whack && moles_reg[3]) begin
      lives_reg <= lives_reg - 1; 
    end
  end

  always @(posedge clk) begin
    if (lives_reg == 4'b0000) begin
      game_over <= 1; 
      
    end else begin
      game_over <= 0; 
    end
  end

endmodule

module wam_fsm (
    input wire clk_19,
    input wire clr,
    input wire [7:0] sw,
    input wire [7:0] tap,
    input wire [7:0] holes,
    output reg [7:0] hit,
    output reg [7:0] holes_out,
    output reg [3:0] hrdn_out
);

    reg [1:0] state;
    reg [7:0] tap_reg;
    reg [7:0] holes_reg;
    reg [7:0] hit_reg;
    reg [3:0] hrdn_reg;

    // FSM states
    parameter IDLE = 2'b00;
    parameter HIT_DETECTED = 2'b01;
    parameter HIT_CONFIRMED = 2'b10;

    always @(posedge clk_19) begin
        if (clr) begin
            state <= IDLE;
            tap_reg <= 8'b0;
            holes_reg <= 8'b0;
            hit_reg <= 8'b0;
            hrdn_reg <= 4'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    tap_reg <= tap;
                    holes_reg <= holes;
                    hrdn_reg <= hrdn_out;

                    if (tap_reg != 8'b0) begin
                        state <= HIT_DETECTED;
                    end
                end

                HIT_DETECTED: begin
                    if (tap_reg == 8'b0) begin
                        state <= IDLE;
                    end
                    else if (tap_reg & holes_reg != 8'b0) begin
                        state <= HIT_CONFIRMED;
                        hit_reg <= tap_reg & holes_reg;
                    end
                end

                HIT_CONFIRMED: begin
                    if (tap_reg == 8'b0) begin
                        state <= IDLE;
                    end
                    else if (hit_reg != 8'b0) begin
                        state <= HIT_CONFIRMED;
                    end
                    else begin
                        state <= HIT_DETECTED;
                    end
                end
            endcase
        end
    end

    always @(posedge clk_19) begin
        case (state)
            IDLE: begin
                holes_out <= holes_reg;
                hit <= 8'b0;
            end

            HIT_DETECTED: begin
                holes_out <= holes_reg;
                hit <= 8'b0;
            end

            HIT_CONFIRMED: begin
                holes_out <= holes_reg & ~hit_reg;
                hit <= hit_reg;
            end
        endcase
    end

endmodule 


// main top level module
module wam_m(
    input  wire clk,        // clock (50MHz)
    input  wire clr,        // button - clear
    input  wire lft,        // button - left
    input  wire rgt,        // button - right
    input  wire pse,        // button - pause
    input  wire [7:0] sw,   // switch
    output wire [3:0] an,   // digital tube - analog
    output wire [6:0] a2g,  // digital tube - stroke
    output wire [7:0] ld    // LED
    );

    reg  [31:0] clk_cnt;    // clock count
    reg  [27:0] clk_cnt2;   // for 1hz clock
    wire clk_16;            // clock at 2^16 (800Hz)
    reg  clk_19;            // clock at 2^19 (100Hz)
    wire  clk_25;            // clock at 2^25 (1Hz)
    reg  clk_out;
    reg  pse_flg = 1;           // pause flag
    reg temp_pse;

    wire cout0;             // carry signal
    wire lstn;              // digital tube last signal

    wire [3:0]  hrdn;       // hardness of 0~9
    wire [7:0]  holes;      // 8 holes idicating have moles or not
    wire [7:0]  tap;        // 8 switch hit input
    wire [7:0]  hit;        // 8 successful hit
    wire [11:0] score;      // score
    
    //timer count register that holds remaining time
    wire [3:0] left_digit;
    wire [3:0] right_digit;
    wire one_second_enable;
    wire [7:0] displayed_number;
//    reg [3:0] first_digit;
//    reg [3:0] second_digit;    

    // handle clock
    always @(posedge clk) begin
        // if(clr)          // DO NOT clear main clock as it is seed of randomizer
        //     clk_cnt = 0;
        // else begin
        clk_cnt = clk_cnt + 1;
        if(clk_cnt[31:28]>15)
            clk_cnt = 0;
    end

    assign clk_16 = clk_cnt[16];

    // handle pause for clk_19
    always @ (posedge pse) begin
        pse_flg = ~pse_flg;
    end

    always @ (posedge clk) begin
        if (!pse_flg && displayed_number != 0) begin
            clk_19 = clk_cnt[19];
        end
    end
    
    // generate 1hz clock
    clkdivider clkdivider(
        .clk(clk),
        .clr(clr),
        .clk_25(clk_25),
        .one_second_enable(one_second_enable)
    );

    // generate moles
    wam_gen sub_gen( 
        .clk_19(clk_19), 
        .clr(clr), 
        .clk_cnt(clk_cnt), 
        .hit(hit), 
        .hrdn(hrdn), 
        .holes(holes) 
    );
    
    wam_timerCount sub_timerCount (
        .clk(clk),
        .clk_25(clk_25),
        .clr(clr),
        .pse(pse),
        .pse_flg(pse_flg),
        .one_second_enable(one_second_enable),
        .displayed_number(displayed_number),
        .left_digit(left_digit),
        .right_digit(right_digit)
    );
    
    wam_hrd sub_hrd( 
        .clk_19(clk_19), 
        .clr(clr), 
        .lft(lft), 
        .rgt(rgt), 
        .cout0(cout0), 
        .hrdn(hrdn) 
    );

    // handle input tap
    wam_tap sub_tap( .clk_19(clk_19), .sw(sw), .tap(tap) );
    wam_hit sub_hit( .clk_19(clk_19), .tap(tap), .holes(holes), .hit(hit) );

    // handle score count
    wam_scr sub_scr( .clk(clk), .clr(clr), .hit(hit), .num(score), .cout0(cout0) );

    // handle display on digital tube
    wam_led sub_led( .holes(holes), .ld(ld) );
    wam_lst sub_lst( .clk_19(clk_19), .tap(tap), .lft(lft), .rgt(rgt), .cout0(cout0), .lstn(lstn) );
    wam_dis sub_dis( 
        .clk_16(clk_16),
        .clk_25(clk_25),    //1hz clock
        .hrdn(hrdn), 
        .score(score),
        .lstn(lstn), 
        .an(an), 
        .a2g(a2g),
        
        .left_digit(left_digit),
        .right_digit(right_digit),
        .displayed_number(displayed_number)
    );
endmodule

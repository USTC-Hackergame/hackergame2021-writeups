`timescale 1ns / 1ps

module top
(
	input clk,
	input btn1,
	input btn2,
	input btn3,
	input btn4,
	output led,
	output tx
);
	reg [3:0]cnt1 = 0;
	always @ (posedge clk) begin
		if (btn1) cnt1 <= cnt1 + 1;
	end
	wire ok1 = cnt1 == 4'b1101;

	reg btn2old = 0;
	always @ (posedge clk) begin
		btn2old <= btn2;
	end
	wire ok2 = btn2old != btn2;

	wire ok3 = btn3 == 1;
	
	wire ok4 = btn4 == 0;

	wire ok = ok1 & ok2 & ok3 & ok4;

	assign led = ok;

	reg btn2old2 = 1;
	always @ (posedge clk) begin
		btn2old2 <= btn2;
	end
	reg [3:0]cnt2 = 0;
	always @ (posedge clk) begin
		if (btn1) cnt2 <= cnt2 + 1;
	end

	reg [15:0]cnt = 1;
	reg [7:0]charcnt = 0;
	localparam CHARCNT_MAX = 38;
	always @ (posedge clk) begin
		//if (ok) begin
		if ((btn2old2 != btn2) & (cnt2 == 4'b1101) & (btn3 == 1) & (btn4 == 0)) begin
			if (cnt == 6000) begin
				cnt <= 0;
				if (charcnt <= CHARCNT_MAX) // charcnt stays at CHARCNT_MAX+1 when send finished
					charcnt <= charcnt + 1;
			end
			else cnt <= cnt + 1;
		end else begin
			cnt <= 1;
			charcnt <= 0;
		end
	end
	assign usend = cnt == 0 & charcnt <= CHARCNT_MAX;
	// flag{FpG4_has_F0Ss_t001cha1n_n0Wwwwww}
	always @ (*) begin
		ucode = 0;
		case (charcnt)
			1: ucode = 8'h66;
			2: ucode = 8'h6c;
			3: ucode = 8'h61;
			4: ucode = 8'h67;
			5: ucode = 8'h7b;
			6: ucode = 8'h46;
			7: ucode = 8'h70;
			8: ucode = 8'h47;
			9: ucode = 8'h34;
			10: ucode = 8'h5f;
			11: ucode = 8'h68;
			12: ucode = 8'h61;
			13: ucode = 8'h73;
			14: ucode = 8'h5f;
			15: ucode = 8'h46;
			16: ucode = 8'h30;
			17: ucode = 8'h53;
			18: ucode = 8'h73;
			19: ucode = 8'h5f;
			20: ucode = 8'h74;
			21: ucode = 8'h30;
			22: ucode = 8'h30;
			23: ucode = 8'h31;
			24: ucode = 8'h63;
			25: ucode = 8'h68;
			26: ucode = 8'h61;
			27: ucode = 8'h31;
			28: ucode = 8'h6e;
			29: ucode = 8'h5f;
			30: ucode = 8'h6e;
			31: ucode = 8'h30;
			32: ucode = 8'h57;
			33: ucode = 8'h77;
			34: ucode = 8'h77;
			35: ucode = 8'h77;
			36: ucode = 8'h77;
			37: ucode = 8'h77;
			38: ucode = 8'h7d;
			default: ucode = 0;
		endcase
	end

	wire usend;
	reg [7:0]ucode;
	wire txclk_en;
	baud_rate_gen #(
		.CLOCK_FREQ(30000000),
		.BAUD_RATE(115200)
	) baud_rate_gen_inst(
		.clk(clk),
		.txclk_en(txclk_en)
	);
	uarttx uarttx_inst(
		.clk(clk),
		.clken(txclk_en),
		.enable(ok),
		.send(usend),
		.ucode(ucode),
		.tx(tx)
	);
endmodule

module uarttx
(
	input clk,
	input clken,
	input enable,
	input send,
	input [7:0]ucode,
	output reg tx = 1
);
    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;
    reg [1:0]state_tx = IDLE;
    reg [7:0]data_tx = 8'h00;
    reg [2:0]bitpos_tx = 3'b0;

	always @ (posedge clk) begin
		case (state_tx)
			IDLE: if (send & enable) begin
				data_tx <= ucode;
				state_tx <= START;
				bitpos_tx <= 3'b0;
			end
			START: if (clken) begin
				tx <= 1'b0;
				state_tx <= DATA;
			end
			DATA: if (clken) begin
				if (bitpos_tx == 3'h7) state_tx <= STOP;
				else bitpos_tx <= bitpos_tx + 1;
				tx <= data_tx[bitpos_tx];
			end
			STOP: if (clken) begin
				tx <= 1'b1;
				state_tx <= IDLE;
			end
		endcase
	end
endmodule

module baud_rate_gen
	#(
		parameter CLOCK_FREQ = 30000000,
		parameter BAUD_RATE = 115200
	)
    (
        input wire clk,
        output wire txclk_en
    );

	parameter TX_ACC_MAX = CLOCK_FREQ / BAUD_RATE;
    parameter TX_ACC_WIDTH = 20;
    reg [TX_ACC_WIDTH - 1:0] tx_acc = 0;

    assign txclk_en = (tx_acc == 0);

    always @(posedge clk) begin
        if (tx_acc == TX_ACC_MAX[TX_ACC_WIDTH - 1:0])
            tx_acc <= 0;
        else
            tx_acc <= tx_acc + 1;
    end

endmodule

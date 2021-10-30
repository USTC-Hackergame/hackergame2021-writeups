`timescale 1ns / 1ps
module uart_simu();
reg clk = 0;
initial begin
	forever #5 clk = ~clk;
end

reg btn1 = 0;
reg btn2 = 0;
wire btn3;
wire btn4;
wire led;
wire tx;

initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0, top_inst);
	btn1 = 1;
	#130
	btn1 = 0;
	#3000000
	$finish;
end
always @ (posedge clk) begin
	btn2 <= ~btn2;
end
assign btn3 = 1;
assign btn4 = 0;

//top top_inst(
chip top_inst(
	.clk(clk),
	.btn1(btn1),
	.btn2(btn2),
	.btn3(btn3),
	.btn4(btn4),
	.led(led),
	.tx(tx)
);

wire rxclk_en;
uart_rx uart_rx_inst(
	.clk(clk),
	.rxclk_en(rxclk_en),
	.rx(tx)
);

baud_rate_gen baud_rate_gen_inst(
	.clk(clk),
	.rxclk_en(rxclk_en)
);
endmodule

module uart_rx
(
	input clk,
	input rxclk_en,
	input rx,
	output newrecv,
	output [7:0]charrecv
);
    localparam RX_STATE_START = 2'b01;
    localparam RX_STATE_DATA = 2'b10;
    localparam RX_STATE_STOP = 2'b11;
    reg [1:0]state_rx = RX_STATE_START;
    reg [3:0]sample = 0;
    reg [3:0]bitpos_rx = 0;
    reg [7:0]scratch = 8'b0;

    reg [7:0]data_rx = 0;
	assign charrecv = data_rx;

	reg data_rx_ready = 0;
	reg data_rx_ready_old = 0;
	always @ (posedge clk) begin
		data_rx_ready_old <= data_rx_ready;
	end
	assign newrecv = !data_rx_ready_old & data_rx_ready;

	always @ (posedge clk) begin if (rxclk_en) begin
		case(state_rx)
			RX_STATE_START: begin
				data_rx_ready <= 0;
				if (!rx || sample != 0) sample <= sample + 1;
				if (sample == 15) begin
					state_rx <= RX_STATE_DATA;
					bitpos_rx <= 0;
					sample <= 0;
					scratch <= 0;
				end
			end
			RX_STATE_DATA: begin
				sample <= sample + 1;
				if (sample == 8) begin //
					scratch[bitpos_rx[2:0]] <= rx;
					bitpos_rx <= bitpos_rx + 1;
				end
				if (bitpos_rx == 8 && sample == 15) state_rx <= RX_STATE_STOP;
			end
			RX_STATE_STOP: begin
				if (sample == 15 || (sample >= 8 && !rx)) begin //
					$display("%c", scratch);
					state_rx <= RX_STATE_START;
					data_rx <= scratch;
					data_rx_ready <= 1;
					sample <= 0;
				end else begin
					sample <= sample + 1;
				end
			end
			default: state_rx <= RX_STATE_START;
		endcase
	end end

endmodule

module baud_rate_gen
	#(
		parameter CLOCK_FREQ = 30000000,
		parameter BAUD_RATE = 115200,
		parameter SAMPLE_MULTIPLIER = 16
	)
    (
        input wire clk,
        output wire rxclk_en,
        output wire txclk_en
    );

    parameter RX_ACC_MAX = CLOCK_FREQ / (BAUD_RATE * SAMPLE_MULTIPLIER);
    parameter TX_ACC_MAX = CLOCK_FREQ / BAUD_RATE;
    parameter RX_ACC_WIDTH = 16;
    parameter TX_ACC_WIDTH = 16;
    //parameter RX_ACC_WIDTH = $clog2(RX_ACC_MAX);
    //parameter TX_ACC_WIDTH = $clog2(TX_ACC_MAX);
    reg [RX_ACC_WIDTH - 1:0] rx_acc = 0;
    reg [TX_ACC_WIDTH - 1:0] tx_acc = 0;

    assign rxclk_en = (rx_acc == 0);
    assign txclk_en = (tx_acc == 0);

    always @(posedge clk) begin
        if (rx_acc == RX_ACC_MAX[RX_ACC_WIDTH - 1:0])
            rx_acc <= 0;
        else
            rx_acc <= rx_acc + 1;
    end

    always @(posedge clk) begin
        if (tx_acc == TX_ACC_MAX[TX_ACC_WIDTH - 1:0])
            tx_acc <= 0;
        else
            tx_acc <= tx_acc + 1;
    end
endmodule




module ahb_slave(

input HCLK,
input HRESET,
input [2:0] HSIZE,
input [2:0] HBURST,
input HWRITE,
input [31:0] HADDR,
input [31:0] HWDATA,
input [1:0] HTRANS,

output reg HREADY,
output reg HRESP,
output reg [31:0] HRDATA

);

parameter idle = 2'b00;
parameter sample_state = 2'b01;
parameter write_state = 2'b10;

reg [1:0] present_state,next_state;

// PRESENT STATE LOGIC 
always @(posedge HCLK)
begin
if(HRESET)
present_state <= idle;
else
present_state <= next_state;
end

// NEXT STATE LOGIC 

always @(*)
begin

next_state = present_state;

case(present_state)

idle:
begin
HREADY = 1;
next_state = sample_state;
end

sample_state:
begin

if(HTRANS[1])
begin
if(HWRITE)
next_state = write_state;
end

end

write_state:
begin
HRDATA = HWDATA;

if(HTRANS==2'b00)
next_state = idle;

end

endcase

end

endmodule


module master_ahb(

input CLK_MASTER,
input RESET_MASTER,
input HREADY,HRESP,
input [31:0] HRDATA,

input write_top,
input [31:0] data_top,
input [3:0] beat_length,
input enable,
input [31:0] addr_top,
input wrap_enable,

output [31:0] HADDR,
output reg HWRITE,
output reg [2:0] HSIZE,
output reg [2:0] HBURST,
output reg [1:0] HTRANS,
output reg [31:0] HWDATA,

output fifo_full,fifo_empty
);

reg [2:0] present_state,next_state;
reg [31:0] addr_internal;

reg [2:0] count;
integer i;

reg [3:0] wptr,rptr;

reg [31:0] mem [15:0];

parameter idle = 3'b000;
parameter write_state_addr = 3'b001;
parameter write_state_data = 3'b011;

assign fifo_full = (wptr+1)==rptr;
assign fifo_empty = wptr==rptr;

assign HADDR = addr_internal;

// FIFO WRITE

always @(posedge CLK_MASTER)
begin
if(RESET_MASTER)
begin
for(i=0;i<16;i=i+1)
mem[i] <= 0;

wptr <= 0;
rptr <= 0;
end

else if(write_top && !fifo_full)
begin
mem[wptr] <= data_top;
wptr <= wptr +1;
end

end


// STATE transition logic 

always @(posedge CLK_MASTER or posedge RESET_MASTER)
begin
if(RESET_MASTER)
begin
present_state <= idle;
count <= 0;
addr_internal <= 0;
end

else
begin
present_state <= next_state;

if((present_state==write_state_data) && HREADY)
begin
count <= count +1;
rptr <= rptr +1;
addr_internal <= addr_internal +4;
end

end
end


// NEXT STATE LOGIC


always @(*)
begin

next_state = present_state;

case(present_state)

idle:
begin

HTRANS = 2'b00;
HSIZE = 3'bx;
HBURST = 3'bx;
HWDATA = 32'bx;
count = 0;

addr_internal = addr_top;

if(write_top && enable && HREADY && beat_length==4)
begin
next_state = write_state_addr;
HBURST = 3'b011;
HWRITE = 1;  // that means it is an write operation 
end

end

write_state_addr:
begin

HSIZE = 3'b010;
HTRANS = 2'b10;
HWRITE = 1;

next_state = write_state_data;

end

write_state_data:
begin

HWRITE = 1;

if(HREADY)
begin
HWDATA = mem[rptr];  // transfering data from fifo memory to HWDATA Bus 
HTRANS = 2'b11;

if(count == beat_length-1)
next_state = idle;
else
next_state = write_state_data;  // repeat write_state_data state till condition count == (beat_length - 1) is not becomes true 

end

end

default:
next_state = idle;

endcase

end

endmodule

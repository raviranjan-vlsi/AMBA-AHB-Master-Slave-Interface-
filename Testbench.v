
`timescale 1ns / 1ps

module testbench_incr_4;
  reg clk, rst;
  reg [31:0] data_top;
  reg write_top;
  reg wrap_enable;
  
  reg enable;
  reg [31:0] addr_top;
  
  
  wire hready, hresp;
  wire [31:0] hrdata;
  
  wire [31:0] HADDR;
  wire HWRITE;
  wire [2:0] HSIZE;
  wire [2:0] HBURST;
  wire [1:0] HTRANS;
  wire [31:0] HWDATA;
  
  reg [3:0] beat_length;
  
  wire fifo_empty, fifo_full;
  
  
  //instantiation of  the ahb master
   master_ahb master_dut(clk, rst, hready,hresp,hrdata, write_top,data_top,  beat_length, enable,addr_top, wrap_enable, HADDR, HWRITE, HSIZE, HBURST, HTRANS, HWDATA, fifo_full,fifo_empty );
   ahb_slave slave_dut(clk, rst,HSIZE, HBURST, HWRITE, HADDR,HWDATA, HTRANS, hready, hresp, hrdata );
   
   initial 
     {clk, rst, beat_length} = 0;
     
     always #5 clk = ~clk;
     
     initial 
       begin
           rst = 1;
           #10
           rst = 0;
           
           if(!fifo_full)
              begin
              
               write_top = 1;  // write operation 
               addr_top = 32'b0000_0000;  // base addr
               data_top = 32'h0000_0001;
               #10
               data_top = 32'h1234_1234;
               #10
               data_top = 32'h0000_0002;
               #10
               data_top = 32'h0000_0003;
               
               
               
               beat_length = 4;
               enable = 1;
               wrap_enable = 0;
               
               #20
               enable  = 0;
             
               
           
               end
               
              
       
       
       end
endmodule

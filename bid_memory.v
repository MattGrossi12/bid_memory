`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:35 12/29/2025 
// Design Name: 
// Module Name:    
// Project Name: bid_memory
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
// Code your design here

module bid_memory
  #(
    //Widths:
    parameter A_WID = 5,
    parameter D_WID = 8,
    //Truelly-Width
    parameter AT_WID = (A_WID-1),
    parameter DT_WID = (D_WID-1)
   )(
    //Input-list:
    //Signals:
    input [AT_WID:0] addr,
    input clk, wr, rd,
    
    //Mem data:
    inout [DT_WID:0] data
    );
  
  //Intern Bank of flops:
  reg [DT_WID:0] data_bank;
  
  //Address parameters:
  localparam integer addr_a = 5'b00001;
  localparam integer addr_b = 5'b00010;
  localparam integer addr_c = 5'b00100;
  localparam integer addr_d = 5'b01000;
  localparam integer addr_e = 5'b10000;
  
  //Memory-banks:
  reg [DT_WID:0] bank_a;
  reg [DT_WID:0] bank_b;
  reg [DT_WID:0] bank_c;
  reg [DT_WID:0] bank_d; 
  reg [DT_WID:0] bank_e; 
  
  always@(posedge clk)
    begin
    //Write-mode:
    if(wr) 
      begin
      case (addr)
        addr_a: bank_a <= data;
        addr_b: bank_b <= data;
        addr_c: bank_c <= data;
        addr_d: bank_d <= data;
        addr_e: bank_e <= data;
        default: 
          begin
          bank_a <= bank_a;
          bank_b <= bank_b;
          bank_c <= bank_c;
          bank_d <= bank_d;
          bank_e <= bank_e; 
          end
      endcase
      end else begin
        //Read-mode:
        case (addr)
          addr_a: data_bank <= bank_a;
          addr_b: data_bank <= bank_b;
          addr_c: data_bank <= bank_c;
          addr_d: data_bank <= bank_d;
          addr_e: data_bank <= bank_e;
          default: 
            data_bank <= data_bank;
        endcase
      end
    end 
  
  assign data = (rd & !wr) ? data_bank : {D_WID{1'bz}};
  
endmodule

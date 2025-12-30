`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:14:24 12/30/2025
// Design Name:   bid_memory
// Module Name:   /home/matheus/ISE_projects/bid_memory/bid_memory_tb.v
// Project Name:  bid_memory
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bid_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bid_memory_tb;

    localparam A_WID = 5;
    localparam D_WID = 8;
    //Truelly-Width
    localparam AT_WID = (A_WID-1);
    localparam DT_WID = (D_WID-1);
  
	// Inputs
	reg [AT_WID:0] addr;
	reg clk;
	reg wr;
	reg rd;

	// Bidirs
  	wire [DT_WID:0] data;

    // Bidirs Flags:
    reg [DT_WID:0] data_next;
	reg tb_state;

    //Address parameters:
    localparam integer addr_a = 5'b00001;
    localparam integer addr_b = 5'b00010;
    localparam integer addr_c = 5'b00100;
    localparam integer addr_d = 5'b01000;
    localparam integer addr_e = 5'b10000;
    
	// Instantiate the Unit Under Test (UUT)
	bid_memory uut (
		.addr(addr), 
		.clk(clk), 
		.wr(wr), 
		.rd(rd), 
		.data(data)
	);

    task div_line;
      begin
        $display("|--------------------------------------------------------------------------------------------------|");
      end
    endtask

    initial 
        begin : Monitor
            div_line();
          $display("|                        DATA_BANKS                    |       OPERATION-INFO      |   MODE  | clk |");
            div_line();
          $display("|  bank_a  |  bank_b  |  bank_c  |  bank_d  |  bank_e  | DATA-IN-USE | ADDR-IN-USE | WR | RD | *** |");
            div_line();
          $monitor("| %08b | %08b | %08b | %08b | %08b |   %08b  |    %05b    | %02b | %02b |  %01b  |",
                        uut.bank_a, uut.bank_b, uut.bank_c, uut.bank_d, uut.bank_e, data, addr, wr, rd, clk);
        end

//Mode:
    task data_is_input;
        begin
            #5;
            tb_state = 1'b1;
            #5;
        end
    endtask

    task data_is_output;
        begin
            #5;
            tb_state = 1'b0;
            #5;
        end
    endtask

    task write;
        begin
            data_is_input ();
            wr = 1; rd = 0;
            #10;
            wr = 0; rd = 0; 
            data_is_output ();
        end
    endtask

    task read;
        begin
            data_is_output ();
            wr = 0; rd = 1;
            #10;
            wr = 0; rd = 0;
            #10;
        end
    endtask

//Choose bank to write:
    task bank_a_wr;            //Write-mode test at bank a:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                   Testcase: Write bank A                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_a; 
            write();
        end
    endtask
  
    task bank_b_wr;            //Write-mode test at bank b:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                   Testcase: Write bank B                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_b; 
            write();
        end
    endtask

    task bank_c_wr;            //Write-mode test at bank c:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                   Testcase: Write bank C                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_c; 
            write();
        end
    endtask
  
    task bank_d_wr;            //Write-mode test at bank d:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                   Testcase: Write bank D                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_d; 
            write();
        end
    endtask

    task bank_e_wr;            //Write-mode test at bank e:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                   Testcase: Write bank E                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_e; 
            write();
        end
    endtask
 
//Choose bank to read:
    task bank_a_rd;            //Read-mode test at bank a:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                    Testcase: Read bank A                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_a; 
            read();
        end
    endtask
  
    task bank_b_rd;            //Read-mode test at bank b:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                    Testcase: Read bank B                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_b; 
            read();
        end
    endtask

    task bank_c_rd;            //Read-mode test at bank c:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                    Testcase: Read bank C                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_c; 
            read();
        end
    endtask

    task bank_d_rd;            //Read-mode test at bank d:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                    Testcase: Read bank D                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_d;
            read();
        end
    endtask

    task bank_e_rd;            //Read-mode test at bank e:
        begin
            //------------------------------------------------------------
            div_line();
            $display("|                                    Testcase: Read bank E                                         |");
            div_line();
            //------------------------------------------------------------
            addr = addr_e; 
            read();
        end
    endtask  
//------------------------------------------------------------

    initial 
        begin: Clock_generator
          clk = 0;
          forever #5 clk = ~clk;
        end
  
    assign data = tb_state ? data_next : {D_WID{1'bz}};

  	task write_test;
      begin
        div_line();
        $display("|                                         Write mode test                                          |");
        div_line();
        //Write-tests
        //---------------------------------------------------
        //Bank-a write:
        data_next = 8'hA1;
        bank_a_wr();
        //---------------------------------------------------
        //Bank-b write:
        data_next = 8'hB1;
        bank_b_wr();
        //---------------------------------------------------
        //Bank-C write:
        data_next = 8'hC1;
        bank_c_wr();
        //---------------------------------------------------
        //Bank-d write:
        data_next = 8'hD1;
        bank_d_wr();  
        //---------------------------------------------------
        //Bank-e write:
        data_next = 8'hE1;
        bank_e_wr();  
      end
    endtask
  
  	task overwrite_test;
      begin
        div_line();
        $display("|                                      Overwrite mode test                                         |");
        div_line();
        //Overwrite test:
        //---------------------------------------------------
        //Bank-a overwrite:
        data_next = 8'hA2;
        bank_a_wr();  
          
        //---------------------------------------------------
        //Bank-b overwrite:
        data_next = 8'hB2;
        bank_b_wr();  
          
        //---------------------------------------------------
        //Bank-c overwrite:
        data_next = 8'hC2;
        bank_c_wr();  
          
        //---------------------------------------------------
        //Bank-d overwrite:
        data_next = 8'hD2;
        bank_d_wr();  
          
        //---------------------------------------------------
        //Bank-e overwrite:
        data_next = 8'hE2;
        bank_e_wr();  
      end
    endtask
  
  	task read_test;
      begin
        div_line();
        $display("|                                        Read mode test                                            |");
        div_line();
        
        //Readmode test:
        //---------------------------------------------------
        //Bank-a read:
        bank_a_rd();  
        //---------------------------------------------------
        //Bank-b read:
        bank_b_rd();  
        //---------------------------------------------------
        //Bank-c read:
        bank_c_rd();  
        //---------------------------------------------------
        //Bank-d read:
        bank_d_rd();  
        //---------------------------------------------------
        //Bank-e read:
        bank_e_rd();  
      end
    endtask


	initial 
      	begin
            write_test();
            div_line();
            #100;
            overwrite_test();
            div_line();
		    #100;
            read_test();
            //---------------------------------------------------
		    #1;
        $finish;
		end
  
    initial begin: Wavedump
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
  
endmodule
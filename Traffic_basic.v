//Design
module traff(North_lig,South_lig,East_lig,West_lig,clk,rst);
  input clk,rst;
  output reg [2:0]North_lig,South_lig,East_lig,West_lig;
  
  reg [2:0]state;
  
  parameter [2:0] North_G=3'b000;
  parameter [2:0] North_Y=3'b001;
  parameter [2:0] South_G=3'b010;
  parameter [2:0] South_Y=3'b011;
  parameter [2:0] East_G=3'b100;
  parameter [2:0] East_Y=3'b101;
  parameter [2:0] West_G=3'b110;
  parameter [2:0] West_Y=3'b111;
  
  reg [2:0]count;
  
  always @(posedge clk, posedge rst)begin
    if(rst)
      begin
        state=North_G;
        count=0;
      end
    else
      begin
        case(state)
          North_G:
            begin
              if(count==3'b111)begin
                count=3'b000;
                state=North_Y;
              end
              else begin
                count=count+1;
                state=North_G;
              end
            end
          North_Y:
            begin
              if(count==3'b011)begin
                count=0;
                state=South_G;
              end
              else begin
                count=count+1;
                state=North_Y;
              end
            end
          South_G:
            begin
              if(count==3'b111)begin
                count=0;
                state=South_Y; 
              end
              else begin
                count=count+1;
                state=South_G;
              end
            end
          South_Y:
            begin
              if(count==3'b011)begin
                count=0;
                state=East_G;
              end
              else begin
                count=count+1;
                state=South_Y;
              end
            end
          East_G:
            begin
              if(count==3'b111)begin
                count=0;
                state=East_Y;
              end
              else begin
                count=count+1;
                state=East_G;
              end
            end
           East_Y:
            begin
              if(count==3'b011)begin
                count=0;
                state=West_G;
              end
              else begin
                count=count+1;
                state=East_Y;
              end
            end
          West_G:
            begin
              if(count==3'b111)begin
                count=0;
                state=West_Y;
              end
              else begin
                count=count+1;
                state=West_G;
              end
            end
           West_Y:
            begin
              if(count==3'b011)begin
                count=0;
                state=North_G;
              end
              else begin
                count=count+1;
                state=West_Y;
              end
            end
        endcase
      end
  end
  
  always@(state)
    begin
      case(state)
        North_G:
          begin
            North_lig=3'b001;
            South_lig=3'b100;
            East_lig=3'b100;
            West_lig=3'b100;
          end
        North_Y:
           begin
            North_lig=3'b010;
            South_lig=3'b100;
            East_lig=3'b100;
            West_lig=3'b100;
          end
        South_G:
           begin
            North_lig=3'b100;
            South_lig=3'b001;
            East_lig=3'b100;
            West_lig=3'b100;
          end
        South_Y:
           begin
            North_lig=3'b100;
            South_lig=3'b010;
            East_lig=3'b100;
            West_lig=3'b100;
          end
        East_G:
           begin
            North_lig=3'b100;
            South_lig=3'b100;
            East_lig=3'b001;
            West_lig=3'b100;
          end
        East_Y:
          begin
            North_lig=3'b100;
            South_lig=3'b100;
            East_lig=3'b010;
            West_lig=3'b100;
          end
        West_G:
          begin
            North_lig=3'b100;
            South_lig=3'b100;
            East_lig=3'b100;
            West_lig=3'b001;
          end
        West_Y:
          begin
            North_lig=3'b100;
            South_lig=3'b100;
            East_lig=3'b100;
            West_lig=3'b010;
          end
      endcase
    end
endmodule


//Testbench

module tb;
  reg clk,rst;
  wire  [2:0]North_lig,South_lig,East_lig,West_lig;
  
  traff nitpt(North_lig,South_lig,East_lig,West_lig,clk,rst);
  
  initial begin
    clk=1;
    forever #5 clk=~clk;

  end
  initial begin
    $display("--------------------------------------------");
    $display("	North	South	East	West ");
    $display("--------------------------------------------");
    $display("	GREEN	RED  	RED 	RED	 ");
    $display("	RED  	GREEN	RED 	RED	 ");
    $display("	RED  	RED  	GREEN   RED	 ");
    $display("	RED  	RED  	RED 	GREEN");
    
    $monitor("Time=%0t  NORTH=%b SOUTH=%b EAST=%b WEST=%b",$time,North_lig,South_lig,East_lig,West_lig);

    rst=1;
    #15;
    rst=0;
    #1000;
    $stop;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
  



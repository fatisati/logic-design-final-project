
module counter (ALOAD,C, D, Q); 
input C, ALOAD; 
input  [7:0] D; 
output [7:0] Q; 
reg    [7:0] tmp; 
 
  always @(posedge C or posedge ALOAD) 
    begin 
      if (ALOAD) 
        tmp = D; 
      else 
        tmp = tmp + 1'b1; 
    end 
  assign Q = tmp; 
endmodule
module main(rst, a, b, clk, r, a_tr, b_tr, a_ti_l, a_ti_h, b_ti_l, b_ti_h, a_l, b_l, c);
  
  input rst, clk, a, b, a_tr, b_tr, r;
  output [3:0] a_ti_l;
  output [3:0] a_ti_h, b_ti_l, b_ti_h;
  output a_l, b_l, c;
  
  reg auto, police, toggle;
  reg [1 :0] state;
  parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
  
  wire [7:0] c1_out;
  reg c1_load;
  counter c1(c1_load, clk,0, c1_out);
  
  wire [7:0] c2_out;
  counter c2(a_tr | b_tr, clk,0, c2_out);
  
  wire [7:0] c3_out;
  reg c3_load;
  counter c3(~a_tr | ~b_tr | c3_load, clk, 0, c3_out);
  
  reg [3:0] a_ti_out_l, a_ti_out_h, b_ti_out_l, b_ti_out_h;
  
  always @ (posedge clk or posedge a or posedge b or posedge r or posedge rst)
  
    if(rst)begin
    state = S2;
    auto = 1;
    police = 0;
    toggle = 0;
    c3_load = 1;
    c1_load = 1;
    #1 c1_load = 0; c3_load = 0;
    end
    
    else if(auto == 1)begin
      a_ti_out_l = c1_out[3:0];
      a_ti_out_h = c1_out [7:4];
      b_ti_out_l = c1_out[3:0];
      b_ti_out_h = c1_out[7:4];
      if(a && ~r)begin
        
        auto = 0;
        police = 1;
        state = S2;
         
      end
      
      else if(b && ~r)begin
        auto = 0;
        police = 1;
        state = S1;
      end
      
      else if(c2_out > 5)begin
        auto = 0;
        toggle = 1;
        c1_load = 1;
        c3_load = 1;
        #1 c1_load = 0; c3_load =0;
        state = S0;
      end
    
      else if(state == S2)begin
        
        if(c1_out == 3)state= S0;
     
      end
      else if(state == S0)begin
        
        if(c1_out == 5)begin
          
          state = S1;
          c1_load = 1;
          #1 c1_load = 0;
        end
        
        else if(c1_out == 7)begin
          state = S2;
          c1_load = 1;
          #1 c1_load = 0;
        end
      end
      
      else if(state == S1)begin
        
        if(c1_out== 5)state = S0;
      end
          
    end
    
    else if(police)begin
      a_ti_out_l = 1;
      a_ti_out_h = 1;
      b_ti_out_l = 1;
      b_ti_out_h = 1;
      if(r)begin
        state = S2;
        auto = 1;
        police = 0;
        c1_load = 1;
        #1 c1_load = 0;
      end
      
      else if(b)state = S1;
      else if(a)state = S2;
    end
    
    else if(toggle)begin
      a_ti_out_l = 1;
      a_ti_out_h = 1;
      b_ti_out_l = 1;
      b_ti_out_h = 1;
      if(a && ~r)begin
        
        toggle = 0;
        police = 1;
        state = S2;
         
      end
      
      else if(b && ~r)begin
        toggle = 0;
        police = 1;
        state = S1;
      end
      
      else if(c3_out>5)begin
       state = S2;
       auto = 1;
       toggle = 0;
       c1_load = 1;
       c3_load = 1;
       #1 c1_load = 0; c3_load = 0;
     end
        
     else if(state == S0)begin
       if(c1_out == 1)begin
         
         state = S3;
         c1_load = 1;
         #1 c1_load =0;
       end
     end
     
     else if(state == S3)begin
       if(c1_out == 1)begin
         
         state = S0;
         c1_load = 1;
         #1 c1_load =0;
       end
     end
     
    end
    
    assign a_ti_l = a_ti_out_l;
    assign a_ti_h = a_ti_out_h;
    assign b_ti_l = b_ti_out_l;
    assign b_ti_h = b_ti_out_h;
    assign a_l = state[1];
    assign b_l = state[0];
    
    
    
endmodule
module testTcircuit;
  reg rst,clk, a, b, a_tr, b_tr, r;  //inputs fr circuit
  wire [7:0] a_ti_l, a_ti_h, b_ti_h, b_ti_l;     //output from circuit
  wire c;
  wire a_l, b_l;
 main main(rst,a, b, clk, r, a_tr, b_tr, a_ti_l, a_ti_h, b_ti_l, b_ti_h, a_l, b_l, c);  // instantiate circuit
  initial
 begin
   clk =0;
         repeat (3000)
       #2 clk = ~clk;
          
     end
     
     initial
     begin
       rst = 1;
       a_tr = 1;
       #1 rst = 0;
     end
 
       initial
       begin

a_tr = 1;
          b_tr = 0;
          #1 a_tr = 0;   
          #50 a_tr =1;b_tr =1;     
        
       end
       
       initial
       begin
         r = 0;
         #50 r=1;
         #50 r=0;
         #300 r=1;
         #20 r=0;
         #300 r=1;
         #10 r=0;
       end
       initial
       begin
         b= 0;a=0;
         #300 a=1; b=0;
         #100 a=0; b=1;
         #20 a=0; b=0;
         #150 b=1;
         #140
 
   
b=0;
        end
 
 
 
initial
 $monitor (" b_l= %b a_l = %b ",a_l, b_l);     
endmodule


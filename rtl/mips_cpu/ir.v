import codes::*;

module ir (
      input clk,
      input state_t state_o,
      input logic wen_i,
      input logic reset_i,
      input size_t instr_i,
      output opcode_t opcode_o,
      output funct_t funct_o,
      output logic[4:0] shift_o;
      output regaddr_t rs_o,
      output regaddr_t rt_o,
      output regaddr_t rd_o,
      output logic[15:0] immediate_o,
      output logic[25:0] target_o
);

    // The register that holds the instruction in EXEC2 and the next FETCH
    size_t ihold;
    size_t data;

    always_ff @(posedge clk) begin
        if (state_o == EXEC1) begin
            ihold <= instr_i;
        end
    end 

    always_comb begin
        if (state_o == EXEC1) begin
            data = instr_i;
        end else begin
            data = ihold;
        end
    end

    always_comb begin
      if (wen_i && reset_i == 0) begin
            opcode_o = data[31:26];
            if (opcode_o == OP_SPECIAL) begin   
                //r-type 
                rs_o = data[25:21];
                rt_o = data[20:16];
                rd_o = data[15:11];
                shift_o = data[10:6];
                funct_o = data[5:0]
            end else if (opcode_o == OP_J || opcode_o == OP_JAL) begin
                //j-type
                target_o = data[25:0];
            end else begin
                //i-type
                rs_o = data[25:21];
                rt_o = data[20:16];
                immediate_o = data[15:0];
            end
        end else if (reset_i) begin
            opcode_o = 0;
            funct_o = 0;
            shift_o = 0;
            rs_o = 0;
            rt_o = 0;
            rd_o = 0;
            immediate_o = 0;
            target_o = 0;
        end
    end


endmodule

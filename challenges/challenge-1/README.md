# Challenge 1: Foundation Digital Design

**Release Date**: November 1, 2025  
**Submission Deadline**: February 15, 2026  
**Milestone Review**: December 15, 2025

## 🎯 Challenge Overview

Welcome to your first AI-HDL challenge! This foundational challenge introduces you to AI-assisted hardware design by having you create a **Multi-Function Digital Calculator** using Large Language Models (LLMs) to generate Verilog code.

### Learning Objectives
- Master the basics of AI-assisted Verilog generation
- Understand digital arithmetic operations in hardware
- Learn FPGA implementation and testing workflows
- Develop effective AI prompting strategies for hardware design

## 📋 Challenge Description

Design and implement a **16-bit Multi-Function Digital Calculator** that can perform various arithmetic and logical operations. Your calculator should be capable of processing two 16-bit inputs and producing appropriate outputs based on the selected operation.

### Core Functionality Requirements

#### Input/Output Specification
- **Input A**: 16-bit operand (`input [15:0] a`)
- **Input B**: 16-bit operand (`input [15:0] b`)  
- **Operation Select**: 4-bit operation code (`input [3:0] op_select`)
- **Clock**: System clock (`input clk`)
- **Reset**: Active-high reset (`input rst`)
- **Result**: 16-bit result (`output reg [15:0] result`)
- **Overflow**: Overflow flag (`output reg overflow`)
- **Zero Flag**: Zero result indicator (`output reg zero_flag`)

#### Required Operations

| op_select | Operation | Description |
|-----------|-----------|-------------|
| 4'b0000 | ADD | A + B |
| 4'b0001 | SUB | A - B |
| 4'b0010 | MUL | A * B (lower 16 bits) |
| 4'b0011 | AND | A & B |
| 4'b0100 | OR | A \| B |
| 4'b0101 | XOR | A ^ B |
| 4'b0110 | NOT | ~A |
| 4'b0111 | SHL | A << B[3:0] (shift left) |
| 4'b1000 | SHR | A >> B[3:0] (shift right) |
| 4'b1001 | CMP | Compare (result = A > B ? 1 : 0) |
| 4'b1010-1111 | Reserved | Output 16'h0000 |

### Design Requirements

1. **Synchronous Design**: All operations must be clocked and reset-able
2. **Combinational Logic**: Operations complete in one clock cycle
3. **Flag Generation**: Proper overflow and zero flag handling
4. **Error Handling**: Graceful handling of undefined operations

### AI Usage Requirements

1. **Primary Design Generation**: Use LLMs to generate the main calculator module
2. **Test Bench Creation**: Use AI to help create comprehensive test benches
3. **Optimization**: Use AI to suggest and implement optimizations
4. **Documentation**: AI-assisted code commenting and documentation

## 🛠️ Technical Specifications

### Module Interface
```verilog
module digital_calculator (
    input wire clk,
    input wire rst,
    input wire [15:0] a,
    input wire [15:0] b,
    input wire [3:0] op_select,
    output reg [15:0] result,
    output reg overflow,
    output reg zero_flag
);
    // Your AI-generated implementation here
endmodule
```

### Timing Requirements
- **Setup Time**: 2ns before clock edge
- **Hold Time**: 1ns after clock edge  
- **Clock-to-Output**: Maximum 10ns
- **Maximum Frequency**: 100MHz

### Resource Constraints (FPGA Implementation)
- **LUTs**: Maximum 500
- **Flip-Flops**: Maximum 200
- **DSP Blocks**: Maximum 2 (for multiplication)
- **Block RAM**: 0 (not allowed for this challenge)

## 📁 Deliverables

### 1. Design Files
```
src/
├── digital_calculator.v          # Main calculator module
├── calculator_tb.v              # Comprehensive test bench
└── calculator_top.v             # Top-level wrapper for FPGA
```

### 2. AI Interaction Logs
```
logs/
├── design_generation_log.md     # LLM conversations for main design
├── testbench_generation_log.md  # AI assistance for verification
├── optimization_log.md          # AI-suggested improvements
└── debugging_log.md             # AI help with issues
```

### 3. Verification Results
```
results/
├── simulation_results.txt       # ModelSim/Icarus simulation output
├── synthesis_report.txt         # Synthesis tool reports
├── fpga_implementation.txt      # FPGA implementation results
└── timing_analysis.txt          # Timing analysis reports
```

### 4. Documentation
```
docs/
├── design_methodology.md       # Your design approach
├── ai_prompting_strategy.md    # How you used AI tools
├── test_plan.md               # Verification strategy
└── lessons_learned.md         # Challenges and insights
```

## 🧪 Test Bench Requirements

Your test bench must verify:

1. **Basic Operations**: All 10 required operations
2. **Edge Cases**: Maximum/minimum values, zero inputs
3. **Overflow Conditions**: Addition and subtraction overflow
4. **Flag Verification**: Correct overflow and zero flag generation
5. **Reset Functionality**: Proper reset behavior
6. **Timing**: Setup/hold time compliance

### Sample Test Cases
```verilog
// Example test cases (expand these significantly)
initial begin
    // Test addition
    a = 16'h1234; b = 16'h5678; op_select = 4'b0000;
    #10; // Check result = 16'h68AC
    
    // Test overflow
    a = 16'hFFFF; b = 16'h0001; op_select = 4'b0000;
    #10; // Check overflow = 1
    
    // Test zero flag  
    a = 16'h0000; b = 16'h0000; op_select = 4'b0000;
    #10; // Check zero_flag = 1
    
    // Add many more test cases...
end
```

## 🎯 Evaluation Rubric

### Functionality (40 points)
- **Basic Operations (20 pts)**: All operations work correctly
- **Flag Generation (10 pts)**: Overflow and zero flags work properly  
- **Edge Cases (10 pts)**: Proper handling of boundary conditions

### AI Integration (25 points)
- **Design Generation (15 pts)**: Effective use of LLMs for main design
- **Prompting Quality (10 pts)**: Well-crafted prompts with good results

### Innovation (20 points)
- **Creative Solutions (10 pts)**: Novel approaches to implementation
- **AI Applications (10 pts)**: Innovative use of AI beyond basic generation

### Documentation (15 points)
- **AI Logs (8 pts)**: Complete, detailed interaction logs
- **Technical Docs (7 pts)**: Clear design and methodology documentation

## 🏆 Bonus Opportunities

### Extra Credit (up to 10 additional points)
- **Advanced Operations**: Implement division or modulo operations
- **Pipeline Design**: Multi-stage pipelined calculator
- **Error Correction**: Implement error detection/correction
- **Power Optimization**: Demonstrate significant power savings
- **Creative AI Usage**: Unique applications of AI tools

## 🚀 Getting Started Guide

### Step 1: Environment Setup
1. Pull the AI-HDL Docker container
2. Verify tool installations (ModelSim, Yosys, etc.)
3. Test FPGA toolchain connectivity

### Step 2: AI Tool Preparation  
1. Set up access to ChatGPT, Claude, or other LLMs
2. Review the [AI Prompting Guide](../../docs/ai-guides/prompting-guide.md)
3. Prepare your logging system for AI interactions

### Step 3: Initial Design
1. Start with high-level prompts for overall architecture
2. Generate the basic module structure
3. Implement operations incrementally

### Step 4: Verification
1. Create comprehensive test benches with AI assistance
2. Run simulations and verify functionality
3. Debug any issues using AI guidance

### Step 5: FPGA Implementation
1. Synthesize your design
2. Implement on target FPGA
3. Verify hardware functionality

## 📚 Recommended Resources

### AI Prompting for Hardware
- [Effective Prompting Strategies](../../docs/ai-guides/prompting-guide.md)
- [Common Verilog Patterns](../../docs/ai-guides/verilog-patterns.md)
- [Debugging with AI](../../docs/ai-guides/ai-debugging.md)

### Verilog and Digital Design
- [Verilog Quick Reference](../../docs/getting-started/verilog-reference.md)
- [Digital Design Principles](../../docs/getting-started/digital-design.md)
- [FPGA Implementation Guide](../../docs/getting-started/fpga-guide.md)

### Tools and Simulation
- [ModelSim Tutorial](../../docs/tools/modelsim-guide.md)
- [Yosys Synthesis Guide](../../docs/tools/yosys-guide.md)
- [Vivado Quick Start](../../docs/tools/vivado-guide.md)

## ❓ Frequently Asked Questions

**Q: Can I use AI to generate the entire design at once?**
A: While possible, we recommend an iterative approach. Generate modules incrementally and refine based on testing.

**Q: What level of AI interaction detail is required in logs?**
A: Include all prompts, responses, and your reasoning for prompt modifications. More detail is better.

**Q: Can I modify AI-generated code manually?**
A: Yes, minor modifications are allowed and expected. Document all changes and reasoning.

**Q: What if my design doesn't fit resource constraints?**
A: Use AI to help optimize your design. This is part of the learning process.

## 📞 Support Contacts

- **Challenge Questions**: Discord #challenge-1 channel
- **Technical Issues**: aihdl-tech@arizona.edu  
- **AI Tool Problems**: aihdl-ai-support@arizona.edu
- **FPGA Issues**: aihdl-fpga@arizona.edu

## 🗓️ Important Dates

- **November 1, 2025**: Challenge released
- **November 15, 2025**: Q&A session (virtual)
- **December 15, 2025**: Milestone review (optional)
- **February 1, 2026**: Submission reminder
- **February 15, 2026**: Final submissions due
- **February 22, 2026**: Results announced

Good luck with your first AI-HDL challenge! Remember, the goal is learning and innovation. Don't hesitate to ask for help when needed.

---

*Challenge 1 v1.0 | Last updated: [Date]*

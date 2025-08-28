# AI-HDL 2025-2026 Competition Environment
# Base image with Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Metadata
LABEL maintainer="AI-HDL Team <aihdl-support@arizona.edu>"
LABEL version="2025.1"
LABEL description="Complete development environment for AI Hardware Design League"

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Create non-root user
RUN groupadd -r student -g 1000 && \
    useradd -u 1000 -r -g student -m -d /home/student -s /bin/bash student

# Install system dependencies
RUN apt-get update && apt-get install -y \
    # Basic utilities
    wget curl git vim nano tree htop \
    build-essential cmake make \
    # Development tools
    gcc g++ gdb \
    python3 python3-pip python3-dev \
    # X11 and GUI support
    x11-apps xauth \
    # Networking and security
    openssh-client \
    # Text processing
    less grep sed awk \
    # Archive tools
    unzip tar gzip \
    # Version control
    git-lfs \
    # System libraries
    libssl-dev libffi-dev \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

# Install Python packages for AI integration
RUN pip3 install --no-cache-dir \
    # AI/ML libraries
    openai anthropic \
    # Data science
    jupyter notebook pandas numpy matplotlib \
    # Hardware design utilities
    cocotb pytest \
    # Documentation
    sphinx markdown \
    # Utilities
    requests beautifulsoup4 \
    # Development
    black flake8 mypy

# Install Icarus Verilog
RUN apt-get update && apt-get install -y \
    iverilog gtkwave \
    && rm -rf /var/lib/apt/lists/*

# Install Yosys (open-source synthesis)
RUN apt-get update && apt-get install -y \
    yosys \
    && rm -rf /var/lib/apt/lists/*

# Install Verilator
RUN apt-get update && apt-get install -y \
    verilator \
    && rm -rf /var/lib/apt/lists/*

# Install additional EDA tools
WORKDIR /tmp

# Install OSS CAD Suite (includes many open-source EDA tools)
RUN wget -O oss-cad-suite-linux-x64.tgz \
    "https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2024-01-01/oss-cad-suite-linux-x64-20240101.tgz" \
    && tar -xzf oss-cad-suite-linux-x64.tgz -C /opt/ \
    && rm oss-cad-suite-linux-x64.tgz

# Install Node.js for web-based tools
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install additional Python packages for HDL
RUN pip3 install --no-cache-dir \
    # HDL libraries
    pyverilog myhdl \
    # Waveform analysis
    vcdvcd \
    # Testing frameworks
    cocotb-test \
    # Utilities
    click rich typer

# Set up user environment
USER student
WORKDIR /home/student

# Create directory structure
RUN mkdir -p \
    /home/student/workspace \
    /home/student/tools \
    /home/student/examples \
    /home/student/challenges \
    /home/student/ai-logs \
    /home/student/.config

# Set up shell environment
RUN echo 'export PATH="/opt/oss-cad-suite/bin:$PATH"' >> ~/.bashrc && \
    echo 'export PYTHONPATH="/home/student/tools/python:$PYTHONPATH"' >> ~/.bashrc && \
    echo 'alias ll="ls -la"' >> ~/.bashrc && \
    echo 'alias la="ls -A"' >> ~/.bashrc && \
    echo 'alias l="ls -CF"' >> ~/.bashrc && \
    echo 'alias ..="cd .."' >> ~/.bashrc && \
    echo 'alias ...="cd ../.."' >> ~/.bashrc && \
    echo 'alias grep="grep --color=auto"' >> ~/.bashrc && \
    echo 'alias fgrep="fgrep --color=auto"' >> ~/.bashrc && \
    echo 'alias egrep="egrep --color=auto"' >> ~/.bashrc

# Install ZSH and Oh My Zsh for better shell experience
USER root
RUN apt-get update && apt-get install -y zsh && rm -rf /var/lib/apt/lists/*

USER student
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN echo 'export PATH="/opt/oss-cad-suite/bin:$PATH"' >> ~/.zshrc && \
    echo 'export PYTHONPATH="/home/student/tools/python:$PYTHONPATH"' >> ~/.zshrc

# Copy utility scripts and examples
COPY --chown=student:student scripts/ /home/student/tools/scripts/
COPY --chown=student:student examples/ /home/student/examples/

# Create AI interaction logging tools
RUN mkdir -p /home/student/tools/python/aihdl

# Create a simple AI logging utility
RUN cat > /home/student/tools/python/aihdl/logger.py << 'EOF'
#!/usr/bin/env python3
"""
AI-HDL Conversation Logger
Simple utility to log AI interactions for competition submissions
"""

import json
import datetime
import os
from pathlib import Path

class AILogger:
    def __init__(self, log_dir="ai-logs"):
        self.log_dir = Path(log_dir)
        self.log_dir.mkdir(exist_ok=True)
        self.session_id = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        
    def log_conversation(self, prompt, response, model="unknown", metadata=None):
        """Log a single AI conversation"""
        log_entry = {
            "timestamp": datetime.datetime.now().isoformat(),
            "session_id": self.session_id,
            "model": model,
            "prompt": prompt,
            "response": response,
            "metadata": metadata or {}
        }
        
        log_file = self.log_dir / f"conversation_{self.session_id}.jsonl"
        with open(log_file, "a") as f:
            f.write(json.dumps(log_entry) + "\n")
            
    def export_markdown(self, output_file=None):
        """Export conversations to markdown format"""
        if output_file is None:
            output_file = self.log_dir / f"conversation_{self.session_id}.md"
            
        log_file = self.log_dir / f"conversation_{self.session_id}.jsonl"
        if not log_file.exists():
            return
            
        with open(log_file, "r") as f:
            conversations = [json.loads(line) for line in f]
            
        with open(output_file, "w") as f:
            f.write(f"# AI Conversation Log - {self.session_id}\n\n")
            for i, conv in enumerate(conversations, 1):
                f.write(f"## Conversation {i}\n")
                f.write(f"**Timestamp**: {conv['timestamp']}\n")
                f.write(f"**Model**: {conv['model']}\n\n")
                f.write(f"**Prompt**:\n```\n{conv['prompt']}\n```\n\n")
                f.write(f"**Response**:\n```\n{conv['response']}\n```\n\n")
                if conv['metadata']:
                    f.write(f"**Metadata**: {conv['metadata']}\n\n")
                f.write("---\n\n")

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "demo":
        logger = AILogger()
        logger.log_conversation(
            "Write a simple Verilog module for a 2-input AND gate",
            "module and_gate(input a, input b, output y); assign y = a & b; endmodule",
            "gpt-4",
            {"challenge": "demo", "purpose": "testing"}
        )
        logger.export_markdown()
        print(f"Demo log created in ai-logs/")
    else:
        print("AI-HDL Logger utility")
        print("Usage: python3 logger.py demo")
EOF

# Make scripts executable
RUN chmod +x /home/student/tools/scripts/* || true
RUN chmod +x /home/student/tools/python/aihdl/logger.py

# Create example Verilog files
RUN mkdir -p /home/student/examples/basic_modules

RUN cat > /home/student/examples/basic_modules/and_gate.v << 'EOF'
// Simple 2-input AND gate example
module and_gate (
    input wire a,
    input wire b,
    output wire y
);
    assign y = a & b;
endmodule
EOF

RUN cat > /home/student/examples/basic_modules/and_gate_tb.v << 'EOF'
// Testbench for AND gate
module and_gate_tb;
    reg a, b;
    wire y;
    
    and_gate uut (.a(a), .b(b), .y(y));
    
    initial begin
        $dumpfile("and_gate.vcd");
        $dumpvars(0, and_gate_tb);
        
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $finish;
    end
    
    initial begin
        $monitor("Time: %0t, a=%b, b=%b, y=%b", $time, a, b, y);
    end
endmodule
EOF

# Create a welcome script
RUN cat > /home/student/welcome.sh << 'EOF'
#!/bin/bash
echo "======================================"
echo "Welcome to AI-HDL 2025-2026!"
echo "======================================"
echo ""
echo "Available tools:"
echo "  - Icarus Verilog (iverilog, vvp)"
echo "  - GTKWave (gtkwave)"
echo "  - Yosys (yosys)"
echo "  - Verilator (verilator)"
echo "  - Python 3 with AI libraries"
echo "  - Jupyter Notebook"
echo ""
echo "Directories:"
echo "  ~/workspace    - Your project files"
echo "  ~/examples     - Example designs"
echo "  ~/tools        - Utility scripts"
echo "  ~/ai-logs      - AI conversation logs"
echo ""
echo "Quick start:"
echo "  cd examples/basic_modules"
echo "  iverilog -o and_gate and_gate.v and_gate_tb.v"
echo "  ./and_gate"
echo "  gtkwave and_gate.vcd"
echo ""
echo "AI logging demo:"
echo "  python3 ~/tools/python/aihdl/logger.py demo"
echo ""
echo "Happy designing! 🚀"
echo "======================================"
EOF

RUN chmod +x /home/student/welcome.sh

# Set up Jupyter configuration
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.token = ''" >> ~/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = ''" >> ~/.jupyter/jupyter_notebook_config.py

# Set default shell and working directory
ENV SHELL=/bin/zsh
WORKDIR /home/student/workspace

# Expose Jupyter port
EXPOSE 8888

# Default command
CMD ["/bin/zsh", "-c", "~/welcome.sh && exec /bin/zsh"]

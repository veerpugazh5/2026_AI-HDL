# AI-HDL Docker Environment

This directory contains Docker configuration files for the AI-HDL 2025-2026 competition environment. The Docker container provides a standardized development environment with all necessary tools pre-installed.

## 🐳 Quick Start

### Pull and Run (Recommended)
```bash
# Pull the latest image
docker pull aihdl/competition-env:2025

# Run with interactive shell
docker run --rm -it aihdl/competition-env:2025

# Run with your local workspace mounted
docker run --rm -it \
  -v "$(pwd)":/home/student/workspace \
  aihdl/competition-env:2025
```

### Alternative: Build Locally
```bash
# Clone this repository
git clone https://github.com/your-org/AIHDL-2025-2026.git
cd AIHDL-2025-2026/docker

# Build the image
docker build -t aihdl-local:2025 .

# Run the locally built image
docker run --rm -it aihdl-local:2025
```

## 🛠️ Included Tools

### Hardware Design & Simulation
- **Icarus Verilog** (iverilog): Open-source Verilog simulator
- **GTKWave**: Waveform viewer for simulation results
- **Yosys**: Open-source synthesis tool
- **Verilator**: Fast Verilog simulator and linter
- **OpenROAD**: Open-source physical design tools

### FPGA Tools
- **Xilinx Vivado** (WebPack Edition): For Xilinx FPGA development
- **Intel Quartus Prime** (Lite Edition): For Intel/Altera FPGA development
- **OpenFPGA**: Open-source FPGA development framework

### Development Environment
- **Visual Studio Code**: With Verilog/SystemVerilog extensions
- **Vim/Neovim**: With syntax highlighting for HDL
- **Git**: Version control system
- **Python 3.9+**: With useful packages for verification
- **Make**: Build automation tool

### AI Integration Tools
- **Python AI Libraries**: OpenAI API, Anthropic API clients
- **Jupyter Notebooks**: For AI interaction logging and analysis
- **Conversation Logging Tools**: Custom scripts for LLM interaction tracking

## 📁 Container Structure

```
/home/student/                    # User home directory
├── workspace/                    # Mounted workspace (your local files)
├── tools/                       # Pre-installed EDA tools
│   ├── iverilog/                # Icarus Verilog installation
│   ├── yosys/                   # Yosys synthesis tool
│   ├── gtkwave/                 # GTKWave viewer
│   └── scripts/                 # Utility scripts
├── examples/                    # Example designs and templates
│   ├── basic_modules/           # Simple Verilog examples
│   ├── testbenches/            # Sample testbench templates
│   └── ai_prompts/             # Example AI prompts
└── challenges/                  # Challenge materials (read-only)
```

## 💡 Usage Examples

### Basic Simulation Workflow
```bash
# Enter the container
docker run --rm -it -v "$(pwd)":/home/student/workspace aihdl/competition-env:2025

# Navigate to your design
cd workspace/my-design

# Compile Verilog
iverilog -o calculator calculator.v calculator_tb.v

# Run simulation
./calculator

# View waveforms (if X11 forwarding is set up)
gtkwave calculator.vcd
```

### Synthesis Example
```bash
# Synthesize with Yosys
yosys -s synthesis_script.ys

# View synthesis results
cat synthesis_report.txt
```

### AI Integration Example
```bash
# Run Jupyter notebook for AI interactions
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser

# Use provided logging tools
python /home/student/tools/scripts/log_ai_conversation.py
```

## 🔧 Customization

### Mounting Additional Directories
```bash
# Mount multiple directories
docker run --rm -it \
  -v "$(pwd)/designs":/home/student/workspace \
  -v "$(pwd)/logs":/home/student/ai-logs \
  -v "$(pwd)/tools":/home/student/custom-tools \
  aihdl/competition-env:2025
```

### X11 Forwarding (Linux/macOS)
```bash
# Enable GUI applications (like GTKWave)
docker run --rm -it \
  -v "$(pwd)":/home/student/workspace \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  aihdl/competition-env:2025
```

### Windows with WSL2
```bash
# Use WSL2 for better Docker integration
wsl
cd /mnt/c/path/to/your/project
docker run --rm -it \
  -v "$(pwd)":/home/student/workspace \
  aihdl/competition-env:2025
```

## 🚀 Advanced Features

### Jupyter Integration
The container includes Jupyter notebooks for:
- AI conversation logging and analysis
- Design documentation and reporting
- Interactive tutorials and examples

```bash
# Start Jupyter server
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root

# Access via browser at localhost:8888
```

### VS Code Integration
```bash
# Install VS Code Docker extension
# Open workspace in container using "Remote-Containers: Open Folder in Container"
# Or use the command palette: "Remote-Containers: Reopen in Container"
```

### Background Services
```bash
# Run container as daemon for long-running tasks
docker run -d --name aihdl-workspace \
  -v "$(pwd)":/home/student/workspace \
  -p 8888:8888 \
  aihdl/competition-env:2025 \
  jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root

# Execute commands in running container
docker exec -it aihdl-workspace bash
```

## 🔍 Troubleshooting

### Common Issues

**Permission Problems**
```bash
# Fix file permissions
docker run --rm -it \
  -v "$(pwd)":/home/student/workspace \
  --user $(id -u):$(id -g) \
  aihdl/competition-env:2025
```

**Out of Disk Space**
```bash
# Clean up Docker images
docker system prune -a

# Remove old containers
docker container prune
```

**Tool Not Found**
```bash
# Check if tool is in PATH
which iverilog

# Source environment setup
source /home/student/.bashrc

# Manually add to PATH if needed
export PATH=$PATH:/home/student/tools/bin
```

### Performance Optimization

**Increase Memory Allocation**
```bash
# Allocate more memory to Docker
docker run --rm -it \
  -v "$(pwd)":/home/student/workspace \
  --memory=4g \
  --cpus=2 \
  aihdl/competition-env:2025
```

**Use tmpfs for Temporary Files**
```bash
# Use RAM for temporary compilation files
docker run --rm -it \
  -v "$(pwd)":/home/student/workspace \
  --tmpfs /tmp:rw,size=1g \
  aihdl/competition-env:2025
```

## 📋 Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `AIHDL_WORKSPACE` | `/home/student/workspace` | Default workspace directory |
| `AIHDL_TOOLS` | `/home/student/tools` | Tools installation directory |
| `AIHDL_EXAMPLES` | `/home/student/examples` | Examples directory |
| `PYTHONPATH` | Includes AI tools | Python module search path |
| `PATH` | Includes all tools | System PATH with EDA tools |

## 🔐 Security Notes

- Container runs as non-root user `student` (UID 1000)
- No sensitive data should be stored in the container
- Mount only necessary directories
- Use read-only mounts for shared resources when possible

```bash
# Read-only mount for challenges
docker run --rm -it \
  -v "$(pwd)/workspace":/home/student/workspace \
  -v "$(pwd)/challenges":/home/student/challenges:ro \
  aihdl/competition-env:2025
```

## 📞 Support

### Getting Help
- **Docker Issues**: Discord #docker-support channel
- **Tool Problems**: aihdl-tools@arizona.edu
- **Environment Setup**: Check the troubleshooting section above

### Reporting Issues
Please report Docker-related issues with:
1. Your operating system and Docker version
2. Complete command you're trying to run
3. Full error message
4. Steps to reproduce the issue

### Updates and Maintenance
- Container images are updated monthly
- Check for updates: `docker pull aihdl/competition-env:2025`
- Changelog available at: [CHANGELOG.md](./CHANGELOG.md)

## 🏗️ Building from Source

If you need to customize the container:

```bash
# Clone repository
git clone https://github.com/your-org/AIHDL-2025-2026.git
cd AIHDL-2025-2026/docker

# Customize Dockerfile as needed
vim Dockerfile

# Build custom image
docker build -t my-aihdl:2025 .

# Test your custom image
docker run --rm -it my-aihdl:2025
```

## 📄 License

This Docker configuration is part of the AI-HDL project and is licensed under the same Creative Commons Attribution-NonCommercial 4.0 International License.

---

*Docker Environment v2025.1 | Last updated: [Date]*

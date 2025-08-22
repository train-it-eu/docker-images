# C++ Development Docker Images

These Docker images provide a complete C++ development environment optimized for GitHub Codespaces and VS Code.

## Image Hierarchy

```text
trainiteu/ubuntu:latest
└── trainiteu/cpp:latest
    └── trainiteu/cpp-conan:latest
```

## What's Included

### trainiteu/ubuntu

- Ubuntu Plucky base
- Essential development tools
- Git, bash completion, development utilities
- Configured for `/workspaces` persistence

### trainiteu/cpp

- GCC 15 and Clang 20
- CMake 4.1.0 (built from source)
- Debugging tools (gdb, valgrind)
- Code analysis (cppcheck)
- pipx for Python tool management

### trainiteu/cpp-conan

- Conan package manager
- Pre-configured with custom remotes
- Ready for C++ package management

## Usage

### In GitHub Codespaces

1. Use `trainiteu/cpp-conan:latest` as your dev container image
2. Python packages installed with `pipx install <package>` will persist
3. Conan packages and profiles are stored in `/workspaces/.conan2`

### Custom Python Tools

```bash
# Install tools that persist across rebuilds
pipx install <tool-name>

# Tools are installed to /workspaces/.local/bin (already in PATH)
```

### Compiler Selection

```bash
# Default compilers
gcc --version    # GCC 15
g++ --version    # G++ 15
clang --version  # Clang 20

# Or use versioned names directly
gcc-15 --version
clang-20 --version
```

### CMake Usage

```bash
# Ninja Multi-Config is the default generator
cmake -B build
cmake --build build --config Release
```

## Environment Variables

- `CC=/usr/bin/gcc-15`
- `CXX=/usr/bin/g++-15`
- `CMAKE_GENERATOR=Ninja Multi-Config`
- `CONAN_HOME=/workspaces/.conan2`
- `PIPX_HOME=/workspaces/.pipx`

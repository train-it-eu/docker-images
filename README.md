# C++ Development Docker Images

These Docker images provide a complete C++ development environment optimized for GitHub Codespaces and VS Code.

## Image Hierarchy

```text
trainiteu/ubuntu:latest
└── trainiteu/cpp:latest
    └── trainiteu/cpp-conan:latest
        ├── trainiteu/mp-units:latest
        └── trainiteu/irrlicht:latest
```

Build an image and everything it depends on with `make <image>`, for example `make mp-units`.

## What's Included

### trainiteu/ubuntu

- Ubuntu 26.04 LTS (Resolute) base
- Essential development tools
- Git, bash completion, development utilities
- Passwordless `sudo` for the `ubuntu` user

### trainiteu/cpp

- GCC 16 and Clang 23
- CMake 4.4.4 (Kitware's prebuilt release)
- Debugging tools (gdb, valgrind)
- Code analysis (cppcheck)
- pipx for Python tool management

### trainiteu/cpp-conan

- Conan package manager
- Pre-configured with custom remotes
- Ready for C++ package management

### trainiteu/mp-units

- The mp-units compiler matrix: GCC 12-16 and Clang 16-18 and 20-24, each Clang with its own
  libc++, set up by mp-units' `.devcontainer/setup_compilers.sh`
- A Conan profile for each of those compilers
- ProperDocs with Material for MkDocs and `mike` for the documentation
- pre-commit

### trainiteu/irrlicht

- OpenGL and X11 development libraries for the Irrlicht workshop
- Conan profiles switched to the GNU dialect of their standard (`cppstd=gnu23`)

## Usage

### In GitHub Codespaces

1. Use `trainiteu/cpp-conan:latest`, or one of the images built on it, as your dev container image
2. Conan packages and profiles are stored in `~/.conan2`

### Custom Python Tools

```bash
pipx install <tool-name>

# Tools are installed to ~/.local/bin (already in PATH)
```

### Compiler Selection

```bash
# Default compilers
gcc --version    # GCC 16
g++ --version    # G++ 16
clang --version  # Clang 23

# Or use versioned names directly
gcc-16 --version
clang-23 --version
```

### CMake Usage

```bash
# Ninja Multi-Config is the default generator
cmake -B build
cmake --build build --config Release
```

## Environment Variables

- `CC=/usr/bin/gcc-16`
- `CXX=/usr/bin/g++-16`
- `CMAKE_GENERATOR=Ninja Multi-Config`
- `CONAN_HOME=~/.conan2`
- `PIPX_HOME=~/.pipx`
- `PIPX_BIN_DIR=~/.local/bin`

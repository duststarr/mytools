#!/bin/bash

# 安装开发工具脚本
# 包含：git、make、cmake、docker、nvm、uv、golang、oh-my-bash、neovim、lazyvim、rustc

echo "开始安装开发工具..."

# 检查并安装基础工具
echo "\n=== 检查基础工具 ==="
if ! command -v git &> /dev/null; then
    echo "安装 git..."
    apt install -y git
else
    echo "git 已安装"
fi

if ! command -v make &> /dev/null; then
    echo "安装 make..."
    apt install -y make
else
    echo "make 已安装"
fi

# 通过 snap 安装 cmake 和 docker
echo "\n=== 安装 cmake 和 docker ==="
if ! command -v cmake &> /dev/null; then
    echo "安装 cmake..."
    snap install cmake --classic
else
    echo "cmake 已安装"
fi

if ! command -v docker &> /dev/null; then
    echo "安装 docker..."
    snap install docker
else
    echo "docker 已安装"
fi

# 安装 nvm (Node Version Manager)
echo "\n=== 安装 nvm ==="
if [ ! -d "$HOME/.nvm" ]; then
    echo "安装 nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    echo "nvm 已安装"
fi

# 安装 uv (Python 包管理工具)
echo "\n=== 安装 uv ==="
if ! command -v uv &> /dev/null; then
    echo "安装 uv..."
    curl -Ls https://github.com/astral-sh/uv/releases/latest/download/uv-installer.sh | bash
else
    echo "uv 已安装"
fi

# 安装 golang
echo "\n=== 安装 golang ==="
if ! command -v go &> /dev/null; then
    echo "安装 golang..."
    mkdir -p ~/go
    wget -q -O - https://go.dev/dl/go1.22.0.linux-amd64.tar.gz | tar -C ~/go --strip-components=1 -xzf -
else
    echo "golang 已安装"
fi

# 安装 oh-my-bash
echo "\n=== 安装 oh-my-bash ==="
if [ ! -d "$HOME/.oh-my-bash" ]; then
    echo "安装 oh-my-bash..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
else
    echo "oh-my-bash 已安装"
fi

# 安装 neovim
echo "\n=== 安装 neovim ==="
if ! command -v nvim &> /dev/null; then
    echo "安装 neovim..."
    snap install nvim --classic
else
    echo "neovim 已安装"
fi

# 安装 lazyvim
echo "\n=== 安装 lazyvim ==="
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "安装 lazyvim..."
    # 备份现有配置
    if [ -d "$HOME/.config/nvim" ]; then
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
    fi
    if [ -d "$HOME/.local/share/nvim" ]; then
        mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.bak"
    fi
    # 克隆 lazyvim 配置
    git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
    rm -rf "$HOME/.config/nvim/.git"
else
    echo "lazyvim 已安装"
fi

# 安装 rustc
echo "\n=== 安装 rustc ==="
if ! command -v rustc &> /dev/null; then
    echo "安装 rustc..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
    echo "rustc 已安装"
fi

# 更新 .bashrc 文件
echo "\n=== 更新环境变量 ==="
if ! grep -q "export PATH=\"$HOME/.local/bin:$PATH\"" "$HOME/.bashrc"; then
    echo "添加 uv 到 PATH..."
    echo "\n# Add uv to PATH" >> "$HOME/.bashrc"
    echo "export PATH=\"$HOME/.local/bin:$PATH\"" >> "$HOME/.bashrc"
fi

if ! grep -q "export GOROOT=\"$HOME/go\"" "$HOME/.bashrc"; then
    echo "添加 Go 到 PATH..."
    echo "\n# Add Go to PATH" >> "$HOME/.bashrc"
    echo "export GOROOT=\"$HOME/go\"" >> "$HOME/.bashrc"
    echo "export PATH=\"$GOROOT/bin:$PATH\"" >> "$HOME/.bashrc"
fi

if ! grep -q "source \$HOME/.cargo/env" "$HOME/.bashrc"; then
    echo "添加 Rust 到 PATH..."
    echo "\n# Add Rust to PATH" >> "$HOME/.bashrc"
    echo "source \$HOME/.cargo/env" >> "$HOME/.bashrc"
fi

echo "\n=== 安装完成 ==="
echo "请重启终端或运行 'source ~/.bashrc' 来应用环境变量"
echo "所有开发工具已安装完成！"

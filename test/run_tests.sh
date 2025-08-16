#!/usr/bin/env bash

# Neovim Configuration Test Suite
# This script tests the Neovim configuration for common issues and errors

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((TESTS_PASSED++))
}

print_error() {
    echo -e "${RED}✗${NC} $1"
    ((TESTS_FAILED++))
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "ℹ $1"
}

print_header() {
    echo ""
    echo "================================"
    echo "$1"
    echo "================================"
}

# Check if Neovim is installed
check_neovim() {
    print_header "Checking Neovim Installation"

    if command -v nvim &> /dev/null; then
        NVIM_VERSION=$(nvim --version | head -n1)
        print_success "Neovim is installed: $NVIM_VERSION"

        # Check version is 0.8+
        VERSION=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)
        MAJOR=$(echo $VERSION | cut -d. -f1)
        MINOR=$(echo $VERSION | cut -d. -f2)

        if [ "$MAJOR" -eq 0 ] && [ "$MINOR" -lt 8 ]; then
            print_error "Neovim version is too old. Required: 0.8+, Found: $VERSION"
        else
            print_success "Neovim version meets requirements: $VERSION"
        fi
    else
        print_error "Neovim is not installed"
        exit 1
    fi
}

# Check required dependencies
check_dependencies() {
    print_header "Checking Dependencies"

    # Check for git
    if command -v git &> /dev/null; then
        print_success "Git is installed"
    else
        print_error "Git is not installed"
    fi

    # Check for ripgrep (optional but recommended)
    if command -v rg &> /dev/null; then
        print_success "Ripgrep is installed (optional)"
    else
        print_warning "Ripgrep is not installed (optional, needed for telescope live grep)"
    fi

    # Check for fd (optional but recommended)
    if command -v fd &> /dev/null; then
        print_success "fd is installed (optional)"
    else
        print_warning "fd is not installed (optional, improves telescope performance)"
    fi

    # Check for Node.js
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node --version)
        print_success "Node.js is installed: $NODE_VERSION"
    else
        print_warning "Node.js is not installed (needed for many LSP servers)"
    fi

    # Check for Python
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version)
        print_success "Python is installed: $PYTHON_VERSION"
    else
        print_warning "Python3 is not installed (needed for some tools)"
    fi

    # Check for tree-sitter CLI
    if command -v tree-sitter &> /dev/null; then
        print_success "tree-sitter CLI is installed"
    else
        print_warning "tree-sitter CLI is not installed (needed for auto-installing parsers)"
    fi
}

# Check configuration file structure
check_file_structure() {
    print_header "Checking File Structure"

    REQUIRED_FILES=(
        "init.lua"
        "lua/core/init.lua"
        "lua/core/plugins.lua"
        "lua/core/configs.lua"
        "lua/core/mappings.lua"
        "lua/core/colors.lua"
    )

    for file in "${REQUIRED_FILES[@]}"; do
        if [ -f "$file" ]; then
            print_success "Required file exists: $file"
        else
            print_error "Required file missing: $file"
        fi
    done

    PLUGIN_FILES=(
        "lua/plugins/treesitter.lua"
        "lua/plugins/lsp.lua"
        "lua/plugins/cmp.lua"
        "lua/plugins/mason.lua"
        "lua/plugins/telescope.lua"
        "lua/plugins/nullls.lua"
        "lua/plugins/gitsigns.lua"
        "lua/plugins/lualine.lua"
        "lua/plugins/toggleterm.lua"
        "lua/plugins/buffline.lua"
        "lua/plugins/neotree.lua"
        "lua/plugins/hop.lua"
    )

    for file in "${PLUGIN_FILES[@]}"; do
        if [ -f "$file" ]; then
            print_success "Plugin config exists: $file"
        else
            print_warning "Plugin config missing: $file"
        fi
    done
}

# Test configuration loading
test_config_loading() {
    print_header "Testing Configuration Loading"

    # Test basic loading
    if nvim --headless -c "echo 'Testing'" -c "qa" 2>&1 | grep -q "Error"; then
        print_error "Configuration has errors on loading"
        nvim --headless -c "echo 'Testing'" -c "qa" 2>&1 | grep "Error"
    else
        print_success "Configuration loads without errors"
    fi

    # Test that Welcome message appears
    if nvim --headless -c "qa" 2>&1 | grep -q "Welcome"; then
        print_success "Welcome message appears"
    else
        print_warning "Welcome message not found"
    fi
}

# Test plugin installation
test_plugins() {
    print_header "Testing Plugin Manager"

    # Check if Lazy.nvim is installed
    if [ -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
        print_success "Lazy.nvim is installed"
    else
        print_warning "Lazy.nvim not found, attempting to install..."
        nvim --headless -c "qa" 2>&1
        if [ -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
            print_success "Lazy.nvim installed successfully"
        else
            print_error "Failed to install Lazy.nvim"
        fi
    fi

    # Try to sync plugins
    print_info "Attempting to sync plugins..."
    if nvim --headless -c "Lazy! sync" -c "qa" 2>&1; then
        print_success "Plugin sync completed"
    else
        print_warning "Plugin sync had issues"
    fi
}

# Test LSP functionality
test_lsp() {
    print_header "Testing LSP Configuration"

    # Create a test Lua file
    TEST_FILE="/tmp/nvim_test_$$.lua"
    echo "local test = 'hello'" > "$TEST_FILE"

    # Try to open file and check LSP
    if nvim --headless "$TEST_FILE" -c "LspInfo" -c "qa" 2>&1 | grep -q "Error"; then
        print_warning "LSP might have issues"
    else
        print_success "LSP configuration seems OK"
    fi

    # Clean up
    rm -f "$TEST_FILE"
}

# Check for syntax errors in Lua files
check_lua_syntax() {
    print_header "Checking Lua Syntax"

    LUA_FILES=$(find . -name "*.lua" -not -path "./.git/*" -not -path "./test/*")

    for file in $LUA_FILES; do
        if luac -p "$file" 2>/dev/null; then
            print_success "Valid syntax: $file"
        else
            # Try with Neovim's Lua if system Lua not available
            if nvim --headless -c "luafile $file" -c "qa" 2>&1 | grep -q "Error"; then
                print_error "Syntax error in: $file"
            else
                print_success "Valid syntax: $file"
            fi
        fi
    done
}

# Check for common issues
check_common_issues() {
    print_header "Checking Common Issues"

    # Check for tabs in Lua files
    if grep -r $'\t' --include="*.lua" . 2>/dev/null | grep -v "^Binary"; then
        print_warning "Found tabs in Lua files (consider using spaces)"
    else
        print_success "No tabs found in Lua files"
    fi

    # Check for trailing whitespace
    TRAILING_WS=$(grep -r '[[:space:]]$' --include="*.lua" . 2>/dev/null | wc -l)
    if [ "$TRAILING_WS" -gt 0 ]; then
        print_warning "Found $TRAILING_WS lines with trailing whitespace"
    else
        print_success "No trailing whitespace found"
    fi

    # Check lazy-lock.json validity
    if [ -f "lazy-lock.json" ]; then
        if python3 -m json.tool lazy-lock.json > /dev/null 2>&1; then
            print_success "lazy-lock.json is valid JSON"
        else
            print_error "lazy-lock.json is not valid JSON"
        fi
    else
        print_warning "lazy-lock.json not found"
    fi
}

# Run health check
run_health_check() {
    print_header "Running Neovim Health Check"

    print_info "Running :checkhealth (output saved to health_check.log)"
    nvim --headless -c "checkhealth" -c "qa" 2>&1 > health_check.log

    if grep -q "ERROR" health_check.log; then
        print_warning "Health check found some errors (see health_check.log)"
        grep "ERROR" health_check.log | head -5
    else
        print_success "Health check passed without errors"
    fi

    if grep -q "WARNING" health_check.log; then
        print_warning "Health check found some warnings (see health_check.log)"
    fi
}

# Performance test
test_performance() {
    print_header "Testing Startup Performance"

    # Measure startup time
    START_TIME=$(nvim --headless -c "echo reltimefloat(reltime())" -c "qa" 2>&1 | tail -1)

    if (( $(echo "$START_TIME < 1.0" | bc -l 2>/dev/null || echo 1) )); then
        print_success "Fast startup time: ${START_TIME}s"
    else
        print_warning "Slow startup time: ${START_TIME}s (consider optimizing)"
    fi
}

# Main execution
main() {
    echo "======================================"
    echo "  Neovim Configuration Test Suite"
    echo "======================================"
    echo ""

    # Change to script directory
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    cd "$SCRIPT_DIR/.."

    # Run all tests
    check_neovim
    check_dependencies
    check_file_structure
    test_config_loading
    test_plugins
    test_lsp
    check_lua_syntax
    check_common_issues
    run_health_check
    test_performance

    # Print summary
    print_header "Test Summary"
    echo "Tests Passed: $TESTS_PASSED"
    echo "Tests Failed: $TESTS_FAILED"
    echo "Test Warnings: Check output above"

    if [ "$TESTS_FAILED" -gt 0 ]; then
        echo ""
        echo -e "${RED}Some tests failed. Please review the errors above.${NC}"
        exit 1
    else
        echo ""
        echo -e "${GREEN}All tests passed successfully!${NC}"
        exit 0
    fi
}

# Run main function
main "$@"

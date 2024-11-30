#!/bin/bash

# Function to detect project type
detect_project_type() {
    if [ -f "$PROJECT_DIR/package.json" ]; then
        echo "Node.js"
    elif [ -f "$PROJECT_DIR/requirements.txt" ] || [ -f "$PROJECT_DIR/setup.py" ]; then
        echo "Python"
    elif [ -f "$PROJECT_DIR/pom.xml" ] || [ -f "$PROJECT_DIR/build.gradle" ]; then
        echo "Java"
    elif [ -f "$PROJECT_DIR/Cargo.toml" ]; then
        echo "Rust"
    elif [ -f "$PROJECT_DIR/go.mod" ]; then
        echo "Go"
    elif [ -f "$PROJECT_DIR/Gemfile" ]; then
        echo "Ruby"
    elif [ -f "$PROJECT_DIR/composer.json" ]; then
        echo "PHP"
    elif [ -f "$PROJECT_DIR/CMakeLists.txt" ]; then
        echo "C/C++"
    elif [ -d "$PROJECT_DIR/.git" ]; then
        echo "Git (Unable to determine specific language)"
    else
        echo "Unknown"
    fi
}

# Function to get project settings
get_project_settings() {
    local project_type="$1"
    case $project_type in
    "Node.js")
        AUTO_GEN_DIRS="node_modules"
        FILE_TYPES="js jsx ts tsx json"
        ;;
    "Python")
        AUTO_GEN_DIRS="venv env .venv __pycache__ .pytest_cache .coverage"
        FILE_TYPES="py pyw pyx pxd pxi"
        ;;
    "Java")
        AUTO_GEN_DIRS="target build .gradle"
        FILE_TYPES="java class jar gradle"
        ;;
    "Rust")
        AUTO_GEN_DIRS="target"
        FILE_TYPES="rs toml"
        ;;
    "Go")
        AUTO_GEN_DIRS="vendor"
        FILE_TYPES="go mod sum"
        ;;
    "Ruby")
        AUTO_GEN_DIRS="vendor"
        FILE_TYPES="rb rake gemspec"
        ;;
    "PHP")
        AUTO_GEN_DIRS="vendor"
        FILE_TYPES="php phtml php3 php4 php5 php7 phps"
        ;;
    "C/C++")
        AUTO_GEN_DIRS="build CMakeFiles"
        FILE_TYPES="c cpp cxx cc h hpp hxx hh"
        ;;
    *)
        AUTO_GEN_DIRS=""
        FILE_TYPES="py js jsx ts tsx html css java cpp c h rb php go rs md yml yaml json xml"
        ;;
    esac
}

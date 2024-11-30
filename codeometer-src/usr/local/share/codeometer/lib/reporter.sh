#!/bin/bash

# Function to print formatted output
print_stat() {
    local category="$1"
    local lines="$2"
    local files="$3"

    if $USE_FORMATTING; then
        apply_color "MAGENTA"
        printf "%-20s" "$category"
        reset_color
        apply_color "YELLOW"
        printf "%8d" "$lines"
        reset_color
        apply_color "GREEN"
        printf "%8d\n" "$files"
        reset_color
    else
        echo "$category: $lines lines, $files files"
    fi
}

# Function to print detailed report
print_report() {
    if $USE_FORMATTING; then
        print_line
        apply_color "BLUE"
        print_centered "Project Analysis Report"
        reset_color
        print_line
    fi

    apply_color "CYAN"
    echo "Project Type: $PROJECT_TYPE"
    reset_color
    echo ""

    apply_color "BLUE"
    echo "Code Statistics:"
    reset_color

    if $USE_FORMATTING; then
        print_line
        apply_color "MAGENTA"
        printf "%-20s" "Category"
        apply_color "YELLOW"
        printf "%8s" "Lines"
        apply_color "GREEN"
        printf "%8s\n" "Files"
        reset_color
        print_line
    fi

    print_stat "Total:" "$TOTAL_LINES" "$TOTAL_FILES"
    print_stat "Hand-written:" "$HAND_WRITTEN_LINES" "$HAND_WRITTEN_FILES"
    print_stat "Auto-generated:" "$AUTO_GENERATED_LINES" "$AUTO_GENERATED_FILES"
    if [ "$COMMENT_LINES" != "" ]; then
        print_stat "Comments:" "$COMMENT_LINES" "-"
    fi

    if $USE_FORMATTING; then
        print_line
    fi

    # Print percentages
    if [ $TOTAL_LINES -ne 0 ]; then
        HAND_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($HAND_WRITTEN_LINES / $TOTAL_LINES) * 100}")
        AUTO_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($AUTO_GENERATED_LINES / $TOTAL_LINES) * 100}")
        if [ "$COMMENT_LINES" != "" ]; then
            COMMENT_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($COMMENT_LINES / $TOTAL_LINES) * 100}")
        fi
    else
        HAND_PERCENT="0.00"
        AUTO_PERCENT="0.00"
        COMMENT_PERCENT="0.00"
    fi

    echo ""
    apply_color "BLUE"
    echo "Percentages:"
    reset_color
    apply_color "CYAN"
    echo "  Hand-written:"
    reset_color
    apply_color "YELLOW"
    echo "    $HAND_PERCENT%"
    reset_color
    apply_color "CYAN"
    echo "  Auto-generated:"
    reset_color
    apply_color "YELLOW"
    echo "    $AUTO_PERCENT%"
    reset_color
    if [ "$COMMENT_LINES" != "" ]; then
        apply_color "CYAN"
        echo "  Comments:"
        reset_color
        apply_color "YELLOW"
        echo "    $COMMENT_PERCENT%"
        reset_color
    fi

    # Print lines by file extension
    echo ""
    apply_color "BLUE"
    echo "Lines of code by file extension:"
    reset_color
    for ext in $FILE_TYPES; do
        read -r lines files <<<$(count_lines_and_files "$PROJECT_DIR" "$ext")
        if [ "$lines" != "0" ]; then
            apply_color "CYAN"
            printf "  %-5s:" ".$ext"
            reset_color
            apply_color "YELLOW"
            printf "%8d" "$lines"
            reset_color
            echo " lines in $files files"
        fi
    done

    if $USE_FORMATTING; then
        print_line
    fi
}

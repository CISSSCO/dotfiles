#!/usr/bin/env bash
# ==============================================================================
# Cosmic Event Horizon Powermenu
# Interactive TUI Power Menu for BSPWM Rice
# Themed after Cosmic Black Hole / Accretion Disk Wallpaper
# ==============================================================================

# Script directory & config
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DIALOGRC="${DIALOGRC:-$SCRIPT_DIR/dialogrc}"

# Window dimensions for floating terminal
FLOAT_WIDTH=640
FLOAT_HEIGHT=460

# Menu configuration
CONFIRM_DANGEROUS=true   # Set to false to disable confirmation prompts

# ------------------------------------------------------------------------------
# 1. Window Manager & Terminal Auto-Detection
# If launched directly from window manager (sxhkd, dmenu, polybar) without a TTY,
# spawn a centered floating terminal window.
# ------------------------------------------------------------------------------
if [ "$1" != "--tui" ] && [ ! -t 0 ]; then
    # Add BSPWM one-shot rule for floating centered window
    if command -v bspc >/dev/null 2>&1; then
        bspc rule -a "*:*:powermenu-float" -o state=floating center=on rectangle="${FLOAT_WIDTH}x${FLOAT_HEIGHT}+0+0"
    fi

    # Launch inside preferred terminal emulator
    if command -v terminator >/dev/null 2>&1; then
        exec terminator -u -p powermenu -r powermenu-float -T "powermenu-float" --geometry="${FLOAT_WIDTH}x${FLOAT_HEIGHT}" -e "$0 --tui"
    elif command -v kitty >/dev/null 2>&1; then
        exec kitty --class "powermenu-float" --title "powermenu-float" "$0" --tui
    elif command -v alacritty >/dev/null 2>&1; then
        exec alacritty --class "powermenu-float,powermenu-float" --title "powermenu-float" -e "$0" --tui
    elif command -v xfce4-terminal >/dev/null 2>&1; then
        exec xfce4-terminal --title="powermenu-float" --geometry=65x20 -e "$0 --tui"
    else
        exec xterm -title "powermenu-float" -geometry 65x20 -e "$0 --tui"
    fi
    exit 0
fi

# ------------------------------------------------------------------------------
# 2. Dependency Check
# ------------------------------------------------------------------------------
if ! command -v dialog >/dev/null 2>&1; then
    echo "Error: 'dialog' is not installed."
    echo "Install it with: sudo pacman -S dialog"
    read -rp "Press Enter to exit..."
    exit 1
fi

# Clean up cursor and terminal state on exit or interrupt
cleanup() {
    tput cnorm 2>/dev/null || true
    clear 2>/dev/null || true
}
trap cleanup EXIT INT TERM

# Hide cursor during menu navigation
tput civis 2>/dev/null || true

# ------------------------------------------------------------------------------
# 3. System Status & Helpers
# ------------------------------------------------------------------------------
get_uptime() {
    if command -v uptime >/dev/null 2>&1; then
        uptime -p 2>/dev/null | sed -e 's/up //' -e 's/,//g' || echo "N/A"
    else
        echo "N/A"
    fi
}

# Confirmation dialog prompt
confirm_action() {
    local action_title="$1"
    local action_icon="$2"
    local action_desc="$3"

    dialog --colors \
        --no-shadow \
        --title " \Zb\Z1󰚌 CONFIRMATION REQUIRED\Zn " \
        --yes-label "  󰄬 Yes, Proceed  " \
        --no-label "  󰅚 Cancel  " \
        --defaultno \
        --yesno "\n   \ZbAre you sure you want to \Z3${action_icon} ${action_desc}\Zn?\n\n   \Z4System: \Z7$(hostname)\Zn  │  \Z4Session: \Z7${USER}\Zn" 10 54
}

# ------------------------------------------------------------------------------
# 4. Interactive Menu Loop
# ------------------------------------------------------------------------------
while true; do
    UPTIME=$(get_uptime)
    HOST="${HOSTNAME:-$(hostname)}"
    CURRENT_TIME=$(date +"%H:%M")

    # Header bar
    BACKTITLE="\Zb\Z5 \Z7${USER}\Z5@\Z6${HOST}   \Z7│   \Zb\Z3󱑂 Uptime: \Z7${UPTIME}   \Z7│   \Zb\Z6󰥔 \Z7${CURRENT_TIME}\Zn"
    TITLE="\Zb\Z3󰐥 EVENT HORIZON \Z5:: \Z6POWER MENU\Zn"
    PROMPT="Select an action using \Zb\Z3[1-6]\Zn, \Zb\Z6Arrow Keys\Zn, or \Zb\Z6[Enter]\Zn:"

    # Display dialog menu
    choice=$(dialog --colors \
        --no-shadow \
        --keep-tite \
        --ok-label " Select " \
        --cancel-label " Exit " \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --menu "$PROMPT" \
        17 56 6 \
        "1" "\Zb\Z6󰌾\Zn  Lock Screen          \Z4[slock]\Zn" \
        "2" "\Zb\Z5󰤄\Zn  Suspend (Sleep)      \Z4[RAM sleep]\Zn" \
        "3" "\Zb\Z2󰗽\Zn  Log Out              \Z4[Exit bspwm]\Zn" \
        "4" "\Zb\Z3󰜉\Zn  Reboot System        \Z4[Restart]\Zn" \
        "5" "\Zb\Z1󰐥\Zn  Power Off            \Z4[Shut down]\Zn" \
        "6" "\Zb\Z4󰅚\Zn  Cancel               \Z4[Close menu]\Zn" \
        --stdout)

    exit_code=$?

    # Handle Cancel button or Escape key (dialog exit_code != 0)
    if [ $exit_code -ne 0 ] || [ -z "$choice" ] || [ "$choice" = "6" ]; then
        exit 0
    fi

    case "$choice" in
        1)
            # Lock Screen
            clear
            if command -v slock >/dev/null 2>&1; then
                slock
            elif command -v i3lock >/dev/null 2>&1; then
                i3lock -c 08031d
            else
                xdg-screensaver lock 2>/dev/null || true
            fi
            exit 0
            ;;

        2)
            # Suspend
            if [ "$CONFIRM_DANGEROUS" = true ]; then
                confirm_action "SUSPEND" "󰤄" "Suspend to RAM" || continue
            fi
            clear
            # Pause audio if mpc or playerctl is available
            command -v mpc >/dev/null 2>&1 && mpc -q pause 2>/dev/null || true
            command -v playerctl >/dev/null 2>&1 && playerctl -a pause 2>/dev/null || true
            systemctl suspend
            exit 0
            ;;

        3)
            # Log Out
            if [ "$CONFIRM_DANGEROUS" = true ]; then
                confirm_action "LOG OUT" "󰗽" "Log out of BSPWM session" || continue
            fi
            clear
            if command -v bspc >/dev/null 2>&1; then
                bspc quit
            else
                pkill -KILL -u "$USER"
            fi
            exit 0
            ;;

        4)
            # Reboot
            if [ "$CONFIRM_DANGEROUS" = true ]; then
                confirm_action "REBOOT" "󰜉" "Restart the entire system" || continue
            fi
            clear
            systemctl reboot
            exit 0
            ;;

        5)
            # Power Off
            if [ "$CONFIRM_DANGEROUS" = true ]; then
                confirm_action "POWER OFF" "󰐥" "Power off and shut down" || continue
            fi
            clear
            systemctl poweroff
            exit 0
            ;;

        *)
            exit 0
            ;;
    esac
done

#!/bin/bash

# ========================
# machine.sh - Full remote machine control
# Supports: ssh, power, sol, reboot
# ========================

# --- Configuration ---
BMC_IP="192.168.1.100"
SSH_HOST="192.168.1.101"
SSH_USER="ubuntu"
SSH_PORT=22

BMC_PASS="your_bmc_password"

# --- Dependency Check ---
command -v ipmitool >/dev/null 2>&1 || { echo "❌ Error: ipmitool not found. Install it."; exit 1; }
command -v ssh >/dev/null 2>&1 || { echo "❌ Error: ssh not found."; exit 1; }

# --- Base IPMI Command ---
IPMI_CMD="ipmitool -I lanplus -H $BMC_IP -U admin -P $BMC_PASS"

# --- Help Function ---
show_help() {
    echo "Usage: $0 <command> [args]"
    echo ""
    echo "Commands:"
    echo "  ssh              → SSH into machine"
    echo "  power on         → Power on"
    echo "  power off        → Graceful shutdown"
    echo "  power status     → Check power state"
    echo "  reboot           → Graceful reboot (power cycle)"
    echo "  reboot hard      → Force hard reset"
    echo "  reboot os        → Reboot via SSH (inside OS)"
    echo "  sol              → Activate Serial-over-LAN console"
    echo "  sol deactivate   → Deactivate SOL session"
    echo ""
    echo "Config: Store BMC password in ~/.bmc_pass"
    echo "Edit script to customize BMC_IP, SSH_HOST, SSH_USER"
}

# --- Main Logic ---
case "$1" in
    ssh)
        echo "🚀 SSH into $SSH_USER@$SSH_HOST:$SSH_PORT ..."
        ssh -p "$SSH_PORT" "$SSH_USER@$SSH_HOST"
        ;;

    power)
        case "$2" in
            on)
                echo "🔌 Powering ON via BMC ($BMC_IP) ..."
                $IPMI_CMD power on
                ;;
            off)
                echo "🔌 Powering OFF via BMC ($BMC_IP) ..."
                $IPMI_CMD power off
                ;;
            status)
                echo "🔋 Power status:"
                $IPMI_CMD power status
                ;;
            *)
                echo "❌ Unknown power command: $2"
                show_help
                exit 1
                ;;
        esac
        ;;

    reboot)
        case "$2" in
            ""|"graceful")
                echo "🔄 Graceful reboot via IPMI power cycle..."
                $IPMI_CMD power cycle
                ;;
            hard)
                echo "⚠️  FORCING HARD RESET (immediate)..."
                $IPMI_CMD power reset
                ;;
            os)
                echo "🔄 Rebooting via SSH (graceful, inside OS)..."
                ssh -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" "sudo reboot" && \
                echo "✅ Reboot command sent. Connection will drop."
                ;;
            *)
                echo "❌ Unknown reboot type: $2"
                show_help
                exit 1
                ;;
        esac
        ;;

    sol)
        case "$2" in
            deactivate|"")
                if [ "$2" = "deactivate" ]; then
                    echo "⏹️  Deactivating SOL session..."
                    $IPMI_CMD sol deactivate
                else
                    echo "🔌 Activating SOL console (press ~. to exit)..."
                    echo "   Connecting to BMC: $BMC_IP"
                    $IPMI_CMD sol activate
                fi
                ;;
            *)
                echo "❌ Unknown sol command: $2"
                show_help
                exit 1
                ;;
        esac
        ;;

    ""|help|-h|--help)
        show_help
        ;;

    *)
        echo "❌ Unknown command: $1"
        show_help
        exit 1
        ;;
esac

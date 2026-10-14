#!/system/bin/sh
# post-fs-data.sh - Leica Camera Auto-Mount Entrypoint
MODDIR="${0%/*}"

# Avoid conflicting mounts
touch "$MODDIR/skip_mount" 2>/dev/null
touch "$MODDIR/skip_mountify" 2>/dev/null

# Execute universal standalone mounting
if [ -f "$MODDIR/global_mount.sh" ]; then
    sh "$MODDIR/global_mount.sh"
fi

#!/system/bin/sh
# global_mount.sh - Universal Standalone OverlayFS Mounting Script
# Automatically selects tmpfs (if CONFIG_TMPFS_XATTR=y) or ext4_sparse (for stock GKI kernels).
# No metamodules or external dependencies required!
PATH=/data/adb/ap/bin:/data/adb/ksu/bin:/data/adb/magisk:$PATH
MODDIR="${0%/*}"

# Prevent root managers or metamodules from double-mounting
touch "$MODDIR/skip_mount" 2>/dev/null
touch "$MODDIR/skip_mountify" 2>/dev/null

FAKE_MOUNT_NAME="leica_cam_mnt"
MOUNT_DEVICE_NAME="overlay"

SUSFS_BIN=/data/adb/ksu/bin/ksu_susfs
KSUD_BIN=/data/adb/ksud

echo "leicacam/standalone: starting universal mount..." >> /dev/kmsg

# Fast lookup for a writable mount staging dir (/mnt is primary and always tmpfs)
MNT_FOLDER=""
if [ -w /mnt ]; then
    MNT_FOLDER=/mnt
elif [ -w /data/local/tmp ]; then
    MNT_FOLDER=/data/local/tmp
elif [ -w /mnt/vendor ]; then
    MNT_FOLDER=/mnt/vendor
elif [ -w /dev ]; then
    MNT_FOLDER=/dev
else
    echo "leicacam/standalone: no writable mount directory found!" >> /dev/kmsg
    exit 1
fi

STAGING_DIR="$MNT_FOLDER/$FAKE_MOUNT_NAME"
SPARSE_IMG="$MNT_FOLDER/${FAKE_MOUNT_NAME}.img"
BASE_DIR="$MODDIR/system"

# Ensure cleanup of any stale staging mount
busybox umount -l "$STAGING_DIR" 2>/dev/null
rm -rf "$STAGING_DIR" "$SPARSE_IMG" 2>/dev/null
mkdir -p "$STAGING_DIR"

# Check tmpfs xattr capability
check_tmpfs_xattr() {
    local test_dir="$1/.xattr_test_$$"
    mkdir -p "$test_dir"
    if busybox mount -t tmpfs tmpfs "$test_dir" 2>/dev/null; then
        local testfile="$test_dir/.xattr_test"
        touch "$testfile"
        if busybox setfattr -n trusted.overlay.whiteout -v y "$testfile" 2>/dev/null; then
            busybox umount -l "$test_dir"
            rm -rf "$test_dir"
            return 0
        fi
        busybox umount -l "$test_dir"
    fi
    rm -rf "$test_dir"
    return 1
}

USED_EXT4=0
if check_tmpfs_xattr "$MNT_FOLDER"; then
    echo "leicacam/standalone: using tmpfs mode (kernel supports tmpfs xattrs)" >> /dev/kmsg
    busybox mount -t tmpfs tmpfs "$STAGING_DIR"
else
    echo "leicacam/standalone: using ext4_sparse mode (stock GKI fallback)" >> /dev/kmsg
    USED_EXT4=1
    # Create 512MB sparse image (only consumes actual file size ~195MB)
    busybox dd if=/dev/zero of="$SPARSE_IMG" bs=1M count=0 seek=512 2>/dev/null
    /system/bin/mkfs.ext4 -O ^has_journal -m 0 "$SPARSE_IMG" >/dev/null 2>&1
    [ "$KSU" = "true" ] && busybox chcon "u:object_r:ksu_file:s0" "$SPARSE_IMG" 2>/dev/null
    busybox mount -o loop,rw,noatime,nodiratime "$SPARSE_IMG" "$STAGING_DIR"
fi

if [ ! -d "$STAGING_DIR" ]; then
    echo "leicacam/standalone: failed to mount staging area!" >> /dev/kmsg
    exit 1
fi

# Copy module system files into staging area
echo "leicacam/standalone: copying module files from $BASE_DIR..." >> /dev/kmsg
cp -Lrf "$BASE_DIR"/* "$STAGING_DIR/"

# Mirror / set SELinux contexts
busybox chcon -R "u:object_r:system_file:s0" "$STAGING_DIR" 2>/dev/null

# For each directory in staging (priv-app, lib64, etc), mount an overlay
for DIR_PATH in "$STAGING_DIR"/*; do
    [ -d "$DIR_PATH" ] || continue
    DIR_NAME="$(basename "$DIR_PATH")"
    [ "$DIR_NAME" = "lost+found" ] && continue
    TARGET="/system/$DIR_NAME"
    
    if [ -d "$TARGET" ]; then
        echo "leicacam/standalone: overlaying $DIR_PATH -> $TARGET" >> /dev/kmsg
        busybox mount -t overlay -o "lowerdir=$DIR_PATH:$TARGET" "$MOUNT_DEVICE_NAME" "$TARGET"
        
        # Kernel umount integration (susfs / ksud)
        [ -f "$SUSFS_BIN" ] && "$SUSFS_BIN" add_try_umount "$TARGET" 1 >/dev/null 2>&1
        [ -f "$KSUD_BIN" ] && "$KSUD_BIN" kernel umount add "$TARGET" --flags 2 >/dev/null 2>&1
    fi
done

# Lazy unmount the staging directory from userspace
echo "leicacam/standalone: unmounting staging directory $STAGING_DIR" >> /dev/kmsg
busybox umount -l "$STAGING_DIR"

# If ext4 sparse image was used, delete the file to free space
if [ "$USED_EXT4" -eq 1 ]; then
    rm -f "$SPARSE_IMG" 2>/dev/null
fi

echo "leicacam/standalone: universal mount completed successfully!" >> /dev/kmsg
exit 0

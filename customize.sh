#!/system/bin/sh
ui_print "****************************************"
ui_print "*   MIUI / Leica Camera for Xiaomi 12  *"
ui_print "*        Ported by Joshabys (cupid)    *"
ui_print "****************************************"

DEVICE=$(getprop ro.product.device)
MODEL=$(getprop ro.product.model)
ui_print "- Device detected: $MODEL ($DEVICE)"

if [ "$DEVICE" != "cupid" ] && [ "$(getprop ro.build.product)" != "cupid" ]; then
    ui_print "! Warning: Device is not identified as 'cupid' (Xiaomi 12)."
    ui_print "! Camera HALs and postproc libs may fail on other hardware."
fi

ui_print "- Setting file permissions..."
set_perm_recursive "$MODPATH/system/priv-app/MiuiCamera" 0 0 0755 0644
set_perm_recursive "$MODPATH/system/lib64" 0 0 0755 0644
set_perm_recursive "$MODPATH/system/etc" 0 0 0755 0644

ui_print "- Ensuring public.libraries.txt is untouched to protect 32-bit zygote..."
rm -f "$MODPATH/system/etc/public.libraries.txt" 2>/dev/null

ui_print "- Clearing old camera cache..."
rm -rf /data/data/com.android.camera/cache 2>/dev/null
rm -rf /data/data/com.android.camera/code_cache 2>/dev/null

ui_print "========================================"
ui_print " Installation completed successfully!"
ui_print " Please reboot your device to apply!"
ui_print "========================================"

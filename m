From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Sun, 16 Apr 2017 21:51:07 -0300
Subject: [PATCH v4 2/6] usb: fix some references for /proc/bus/usb
In-Reply-To: <cover.1492389736.git.mchehab@s-opensource.com>
References: <cover.1492389736.git.mchehab@s-opensource.com>
Message-ID: <ba6adfe228123da84ffa3028b71efadd78d483b7.1492389736.git.mchehab@s-opensource.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Since when we got rid of usbfs, the /proc/bus/usb is now
elsewhere. Fix references for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/usb/pwc/philips.txt  | 2 +-
 drivers/usb/class/Kconfig          | 2 +-
 drivers/usb/class/usblp.c          | 2 +-
 drivers/usb/core/devices.c         | 4 ++--
 drivers/usb/storage/unusual_devs.h | 2 +-
 include/linux/usb.h                | 2 +-
 include/uapi/linux/capability.h    | 2 +-
 include/uapi/linux/usb/ch9.h       | 3 ++-
 tools/usb/usbip/README             | 2 +-
 9 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/pwc/philips.txt b/drivers/media/usb/pwc/philips.txt
index d38dd791511e..be8c80eff374 100644
--- a/drivers/media/usb/pwc/philips.txt
+++ b/drivers/media/usb/pwc/philips.txt
@@ -140,7 +140,7 @@ dev_hint
 
    A camera is specified by its type (the number from the camera model,
    like PCA645, PCVC750VC, etc) and optionally the serial number (visible
-   in /proc/bus/usb/devices). A hint consists of a string with the following
+   in /sys/kernel/debug/usb/devices). A hint consists of a string with the following
    format:
 
       [type[.serialnumber]:]node
diff --git a/drivers/usb/class/Kconfig b/drivers/usb/class/Kconfig
index bb8b73682a70..971385fe9abc 100644
--- a/drivers/usb/class/Kconfig
+++ b/drivers/usb/class/Kconfig
@@ -12,7 +12,7 @@ config USB_ACM
 	  Please read <file:Documentation/usb/acm.txt> for details.
 
 	  If your modem only reports "Cls=ff(vend.)" in the descriptors in
-	  /proc/bus/usb/devices, then your modem will not work with this
+	  /sys/kernel/debug/usb/devices, then your modem will not work with this
 	  driver.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index cc61055fb9be..16e889a545e1 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -294,7 +294,7 @@ static int usblp_ctrl_msg(struct usblp *usblp, int request, int type, int dir, i
 
 /*
  * See the description for usblp_select_alts() below for the usage
- * explanation.  Look into your /proc/bus/usb/devices and dmesg in
+ * explanation.  Look into your /sys/kernel/debug/usb/devices and dmesg in
  * case of any trouble.
  */
 static int proto_bias = -1;
diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index f2987ddb1cde..55dea2e7828f 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -24,7 +24,7 @@
  * <mountpoint>/devices contains USB topology, device, config, class,
  * interface, & endpoint data.
  *
- * I considered using /proc/bus/usb/devices/device# for each device
+ * I considered using /dev/bus/usb/device# for each device
  * as it is attached or detached, but I didn't like this for some
  * reason -- maybe it's just too deep of a directory structure.
  * I also don't like looking in multiple places to gather and view
@@ -40,7 +40,7 @@
  *   Converted the whole proc stuff to real
  *   read methods. Now not the whole device list needs to fit
  *   into one page, only the device list for one bus.
- *   Added a poll method to /proc/bus/usb/devices, to wake
+ *   Added a poll method to /sys/kernel/debug/usb/devices, to wake
  *   up an eventual usbd
  * 2000-01-04: Thomas Sailer <sailer@ife.ee.ethz.ch>
  *   Turned into its own filesystem
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 16cc18369111..a5f3e7d687f7 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -42,7 +42,7 @@
  *	- a patch that adds the entry for your device, including your
  *	  email address right above the entry (plus maybe a brief
  *	  explanation of the reason for the entry),
- *	- a copy of /proc/bus/usb/devices with your device plugged in
+ *	- a copy of /sys/kernel/debug/usb/devices with your device plugged in
  *	  running with this patch.
  * Send your submission to either Phil Dibowitz <phil@ipom.com> or
  * Alan Stern <stern@rowland.harvard.edu>, and don't forget to CC: the
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7e68259360de..84bc5741d626 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -248,7 +248,7 @@ void usb_put_intf(struct usb_interface *intf);
  * struct usb_interface (which persists only as long as its configuration
  * is installed).  The altsetting arrays can be accessed through these
  * structures at any time, permitting comparison of configurations and
- * providing support for the /proc/bus/usb/devices pseudo-file.
+ * providing support for the /sys/kernel/debug/usb/devices pseudo-file.
  */
 struct usb_interface_cache {
 	unsigned num_altsetting;	/* number of alternate settings */
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 49bc06295398..6fe14d001f68 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -205,7 +205,7 @@ struct vfs_cap_data {
 #define CAP_SYS_MODULE       16
 
 /* Allow ioperm/iopl access */
-/* Allow sending USB messages to any device via /proc/bus/usb */
+/* Allow sending USB messages to any device via /dev/bus/usb */
 
 #define CAP_SYS_RAWIO        17
 
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 2c5d7c4a69e3..ce1169af39d7 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -224,7 +224,8 @@ struct usb_ctrlrequest {
  * through the Linux-USB APIs, they are not converted to cpu byte
  * order; it is the responsibility of the client code to do this.
  * The single exception is when device and configuration descriptors (but
- * not other descriptors) are read from usbfs (i.e. /proc/bus/usb/BBB/DDD);
+ * not other descriptors) are read from character devices
+ * (i.e. /dev/bus/usb/BBB/DDD);
  * in this case the fields are converted to host endianness by the kernel.
  */
 
diff --git a/tools/usb/usbip/README b/tools/usb/usbip/README
index 5eb2b6c7722b..7844490fc603 100644
--- a/tools/usb/usbip/README
+++ b/tools/usb/usbip/README
@@ -244,7 +244,7 @@ Detach the imported device:
     - See 'Debug Tips' on the project wiki.
 	- http://usbip.wiki.sourceforge.net/how-to-debug-usbip
     - usbip-host.ko must be bound to the target device.
-	- See /proc/bus/usb/devices and find "Driver=..." lines of the device.
+	- See /sys/kernel/debug/usb/devices and find "Driver=..." lines of the device.
     - Target USB gadget must be bound to vudc
       (using USB gadget susbsys, not usbip bind command)
     - Shutdown firewall.
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

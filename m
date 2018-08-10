From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:28 +0200
Subject: [PATCH 2/9] capability: update to new uapi header
In-Reply-To: <20180810161335.27036-1-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
Message-ID: <20180810161335.27036-3-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I'm not completely sure why libcap effectively vendors a copy of the
capability uapi header but I assume there's a good reason for it. But
let's update it to the newest version.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 libcap/include/uapi/linux/capability.h | 39 +++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/libcap/include/uapi/linux/capability.h b/libcap/include/uapi/linux/capability.h
index 432e023..4a2d916 100644
--- a/libcap/include/uapi/linux/capability.h
+++ b/libcap/include/uapi/linux/capability.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * This is <linux/capability.h>
  *
@@ -7,16 +8,14 @@
  *
  * See here for the libcap library ("POSIX draft" compliance):
  *
- * http://www.kernel.org/pub/linux/libs/security/linux-privs/
+ * ftp://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/
  */
 
-#ifndef _UAPI_LINUX_CAPABILITY_H
-#define _UAPI_LINUX_CAPABILITY_H
+#ifndef _LINUX_CAPABILITY_H
+#define _LINUX_CAPABILITY_H
 
 #include <linux/types.h>
 
-struct task_struct;
-
 /* User-level do most of the mapping between kernel and user
    capabilities based on the version tag given by the kernel. The
    kernel might be somewhat backwards compatible, but don't bet on
@@ -62,9 +61,13 @@ typedef struct __user_cap_data_struct {
 #define VFS_CAP_U32_2           2
 #define XATTR_CAPS_SZ_2         (sizeof(__le32)*(1 + 2*VFS_CAP_U32_2))
 
-#define XATTR_CAPS_SZ           XATTR_CAPS_SZ_2
-#define VFS_CAP_U32             VFS_CAP_U32_2
-#define VFS_CAP_REVISION	VFS_CAP_REVISION_2
+#define VFS_CAP_REVISION_3	0x03000000
+#define VFS_CAP_U32_3           2
+#define XATTR_CAPS_SZ_3         (sizeof(__le32)*(2 + 2*VFS_CAP_U32_3))
+
+#define XATTR_CAPS_SZ           XATTR_CAPS_SZ_3
+#define VFS_CAP_U32             VFS_CAP_U32_3
+#define VFS_CAP_REVISION	VFS_CAP_REVISION_3
 
 struct vfs_cap_data {
 	__le32 magic_etc;            /* Little endian */
@@ -74,7 +77,18 @@ struct vfs_cap_data {
 	} data[VFS_CAP_U32];
 };
 
-#ifndef __KERNEL__
+/*
+ * same as vfs_cap_data but with a rootid at the end
+ */
+struct vfs_ns_cap_data {
+	__le32 magic_etc;
+	struct {
+		__le32 permitted;    /* Little endian */
+		__le32 inheritable;  /* Little endian */
+	} data[VFS_CAP_U32];
+	__le32 rootid;
+};
+
 
 /*
  * Backwardly compatible definition for source code - trapped in a
@@ -84,7 +98,6 @@ struct vfs_cap_data {
 #define _LINUX_CAPABILITY_VERSION  _LINUX_CAPABILITY_VERSION_1
 #define _LINUX_CAPABILITY_U32S     _LINUX_CAPABILITY_U32S_1
 
-#endif
 
 
 /**
@@ -207,7 +220,7 @@ struct vfs_cap_data {
 #define CAP_SYS_MODULE       16
 
 /* Allow ioperm/iopl access */
-/* Allow sending USB messages to any device via /proc/bus/usb */
+/* Allow sending USB messages to any device via /dev/bus/usb */
 
 #define CAP_SYS_RAWIO        17
 
@@ -349,7 +362,7 @@ struct vfs_cap_data {
 
 /* Allow reading the audit log via multicast netlink socket */
 
-#define CAP_AUDIT_READ       37
+#define CAP_AUDIT_READ		37
 
 
 #define CAP_LAST_CAP         CAP_AUDIT_READ
@@ -364,4 +377,4 @@ struct vfs_cap_data {
 #define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u32 */
 
 
-#endif /* _UAPI_LINUX_CAPABILITY_H */
+#endif /* _LINUX_CAPABILITY_H */
-- 
2.17.1

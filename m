From: nicolas@belouin.fr (Nicolas Belouin)
Date: Sat, 21 Oct 2017 15:43:02 +0200
Subject: [RFC PATCH 1/2] security, capabilities: Add CAP_SYS_MOUNT
Message-ID: <20171021134303.20685-1-nicolas@belouin.fr>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

With CAP_SYS_ADMIN being bloated and inapropriate for actions such
as mounting/unmounting filesystems, the creation of a new capability
is needed.
CAP_SYS_MOUNT is meant to give a process the ability to call for mount,
umount and umount2 syscalls.

Signed-off-by: Nicolas Belouin <nicolas@belouin.fr>
---
 include/uapi/linux/capability.h     | 5 ++++-
 security/selinux/include/classmap.h | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 230e05d35191..ce230aa6d928 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -365,8 +365,11 @@ struct vfs_ns_cap_data {
 
 #define CAP_AUDIT_READ		37
 
+/* Allow mounting, unmounting filesystems */
 
-#define CAP_LAST_CAP         CAP_AUDIT_READ
+#define CAP_SYS_MOUNT		38
+
+#define CAP_LAST_CAP         CAP_SYS_MOUNT
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 35ffb29a69cb..a873dce97fd5 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -24,9 +24,9 @@
 	    "audit_control", "setfcap"
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read"
+		"wake_alarm", "block_suspend", "audit_read", "sys_mount"
 
-#if CAP_LAST_CAP > CAP_AUDIT_READ
+#if CAP_LAST_CAP > CAP_SYS_MOUNT
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

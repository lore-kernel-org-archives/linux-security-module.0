From: nicolas@belouin.fr (Nicolas Belouin)
Date: Sat, 21 Oct 2017 15:45:57 +0200
Subject: [RFC PATCH 1/2] security, capabilities: create CAP_TRUSTED
Message-ID: <20171021134558.21195-1-nicolas@belouin.fr>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

with CAP_SYS_ADMIN being bloated, the usefulness of using it to
flag a process to be entrusted for e.g reading and writing trusted
xattr is near zero.
CAP_TRUSTED aims to provide userland with a way to mark a process as
entrusted to do specific (not specially admin-centered) actions. It
would for example allow a process to red/write the trusted xattrs.

Signed-off-by: Nicolas Belouin <nicolas@belouin.fr>
---
 include/uapi/linux/capability.h     | 6 +++++-
 security/selinux/include/classmap.h | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index ce230aa6d928..27e457b93c84 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -369,7 +369,11 @@ struct vfs_ns_cap_data {
 
 #define CAP_SYS_MOUNT		38
 
-#define CAP_LAST_CAP         CAP_SYS_MOUNT
+/* Allow read/write trusted xattr */
+
+#define CAP_TRUSTED		39
+
+#define CAP_LAST_CAP         CAP_TRUSTED
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index a873dce97fd5..f5dc8e109f5a 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -24,9 +24,10 @@
 	    "audit_control", "setfcap"
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read", "sys_mount"
+		"wake_alarm", "block_suspend", "audit_read", "sys_mount", \
+		"trusted"
 
-#if CAP_LAST_CAP > CAP_SYS_MOUNT
+#if CAP_LAST_CAP > CAP_TRUSTED
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

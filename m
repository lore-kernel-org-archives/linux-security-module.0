From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:35 +0200
Subject: [PATCH 9/9] capability: add cap_set_nsowner()
In-Reply-To: <20180810161335.27036-1-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
Message-ID: <20180810161335.27036-10-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

cap_set_nsowner() allows to set the rootid of file capability sets. It can
be used to set the rootid of a target user namespace as seen in the
current user namespace. This allows a user namespace to set file
capabilities in lieu of another user namespace.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 libcap/cap_file.c               | 16 ++++++++++++++++
 libcap/include/sys/capability.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/libcap/cap_file.c b/libcap/cap_file.c
index a1f3891..9a1643c 100644
--- a/libcap/cap_file.c
+++ b/libcap/cap_file.c
@@ -384,6 +384,16 @@ int cap_set_file(const char *filename, cap_t cap_d)
     return setxattr(filename, XATTR_NAME_CAPS, &rawvfscap, sizeofcaps, 0);
 }
 
+/*
+ * Set rootid for the file capability sets.
+ */
+
+int cap_set_nsowner(cap_t cap_d, uid_t rootid)
+{
+	cap_d->rootid = rootid;
+	return 0;
+}
+
 #else /* ie. ndef VFS_CAP_U32 */
 
 cap_t cap_get_fd(int fildes)
@@ -416,4 +426,10 @@ int cap_set_file(const char *filename, cap_t cap_d)
     return -1;
 }
 
+void cap_set_nsowner(cap_t cap_d, uid_t rootid)
+{
+	errno = EINVAL;
+	return -1;
+}
+
 #endif /* def VFS_CAP_U32 */
diff --git a/libcap/include/sys/capability.h b/libcap/include/sys/capability.h
index 42d8154..a9515b6 100644
--- a/libcap/include/sys/capability.h
+++ b/libcap/include/sys/capability.h
@@ -85,6 +85,7 @@ extern cap_t   cap_get_file(const char *);
 extern uid_t   cap_get_nsowner(cap_t);
 extern int     cap_set_fd(int, cap_t);
 extern int     cap_set_file(const char *, cap_t);
+extern int     cap_set_nsowner(cap_t, uid_t);
 
 /* libcap/cap_proc.c */
 extern cap_t   cap_get_proc(void);
-- 
2.17.1

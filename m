From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:32 +0200
Subject: [PATCH 6/9] capability: add cap_get_nsowner()
In-Reply-To: <20180810161335.27036-1-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
Message-ID: <20180810161335.27036-7-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

cap_get_nsowner() allows to retrieve the rootid of the file capability sets
in the current user namespace.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 libcap/cap_file.c               | 16 ++++++++++++++++
 libcap/include/sys/capability.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/libcap/cap_file.c b/libcap/cap_file.c
index eb98bf7..7acd60c 100644
--- a/libcap/cap_file.c
+++ b/libcap/cap_file.c
@@ -277,6 +277,16 @@ cap_t cap_get_file(const char *filename)
     return result;
 }
 
+/*
+ * Get rootid as seen in the current user namespace for the file capability
+ * sets.
+ */
+
+uid_t cap_get_nsowner(cap_t cap_d)
+{
+	return cap_d->rootid;
+}
+
 /*
  * Set the capabilities of an open file, as specified by its file
  * descriptor.
@@ -363,6 +373,12 @@ cap_t cap_get_file(const char *filename)
     return NULL;
 }
 
+uid_t cap_get_nsowner(cap_t cap_d)
+{
+    errno = EINVAL;
+    return -1;
+}
+
 int cap_set_fd(int fildes, cap_t cap_d)
 {
     errno = EINVAL;
diff --git a/libcap/include/sys/capability.h b/libcap/include/sys/capability.h
index 0976fa7..42d8154 100644
--- a/libcap/include/sys/capability.h
+++ b/libcap/include/sys/capability.h
@@ -82,6 +82,7 @@ extern int     cap_clear_flag(cap_t, cap_flag_t);
 /* libcap/cap_file.c */
 extern cap_t   cap_get_fd(int);
 extern cap_t   cap_get_file(const char *);
+extern uid_t   cap_get_nsowner(cap_t);
 extern int     cap_set_fd(int, cap_t);
 extern int     cap_set_file(const char *, cap_t);
 
-- 
2.17.1

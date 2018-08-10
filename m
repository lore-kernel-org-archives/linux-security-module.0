From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:29 +0200
Subject: [PATCH 3/9] cap_file: use struct vfs_ns_cap_data if possible
In-Reply-To: <20180810161335.27036-1-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
Message-ID: <20180810161335.27036-4-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On kernels with VFS_CAP_REVISION_3 we should use struct_vfs_ns_cap_data.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 libcap/cap_file.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/libcap/cap_file.c b/libcap/cap_file.c
index 228d806..9b8f11e 100644
--- a/libcap/cap_file.c
+++ b/libcap/cap_file.c
@@ -37,8 +37,12 @@ extern int fremovexattr(int, const char *);
 #define FIXUP_32BITS(x) (x)
 #endif
 
-static cap_t _fcaps_load(struct vfs_cap_data *rawvfscap, cap_t result,
+#ifdef VFS_CAP_REVISION_3
+static cap_t _fcaps_load(struct vfs_ns_cap_data *rawvfscap, cap_t result,
 			 int bytes)
+#else
+static cap_t _fcaps_load(struct vfs_cap_data *rawvfscap, cap_t result, int bytes)
+#endif
 {
     __u32 magic_etc;
     unsigned tocopy, i;
@@ -102,8 +106,12 @@ static cap_t _fcaps_load(struct vfs_cap_data *rawvfscap, cap_t result,
     return result;
 }
 
-static int _fcaps_save(struct vfs_cap_data *rawvfscap, cap_t cap_d,
+#ifdef VFS_CAP_REVISION_3
+static int _fcaps_save(struct vfs_ns_cap_data *rawvfscap, cap_t cap_d,
 		       int *bytes_p)
+#else
+static int _fcaps_save(struct vfs_cap_data *rawvfscap, cap_t cap_d, int *bytes_p)
+#endif
 {
     __u32 eff_not_zero, magic;
     unsigned tocopy, i;
@@ -203,7 +211,11 @@ cap_t cap_get_fd(int fildes)
     /* allocate a new capability set */
     result = cap_init();
     if (result) {
+#ifdef VFS_CAP_REVISION_3
+	struct vfs_ns_cap_data rawvfscap;
+#else
 	struct vfs_cap_data rawvfscap;
+#endif
 	int sizeofcaps;
 
 	_cap_debug("getting fildes capabilities");
@@ -233,7 +245,11 @@ cap_t cap_get_file(const char *filename)
     /* allocate a new capability set */
     result = cap_init();
     if (result) {
+#ifdef VFS_CAP_REVISION_3
+	struct vfs_ns_cap_data rawvfscap;
+#else
 	struct vfs_cap_data rawvfscap;
+#endif
 	int sizeofcaps;
 
 	_cap_debug("getting filename capabilities");
@@ -259,7 +275,11 @@ cap_t cap_get_file(const char *filename)
 
 int cap_set_fd(int fildes, cap_t cap_d)
 {
+#ifdef VFS_CAP_REVISION_3
+    struct vfs_ns_cap_data rawvfscap;
+#else
     struct vfs_cap_data rawvfscap;
+#endif
     int sizeofcaps;
     struct stat buf;
 
@@ -291,7 +311,11 @@ int cap_set_fd(int fildes, cap_t cap_d)
 
 int cap_set_file(const char *filename, cap_t cap_d)
 {
+#ifdef VFS_CAP_REVISION_3
+    struct vfs_ns_cap_data rawvfscap;
+#else
     struct vfs_cap_data rawvfscap;
+#endif
     int sizeofcaps;
     struct stat buf;
 
-- 
2.17.1

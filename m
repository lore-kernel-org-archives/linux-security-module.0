From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:31 +0200
Subject: [PATCH 5/9] cap_file: initialize rootid in _fcaps_load()
In-Reply-To: <20180810161335.27036-1-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
Message-ID: <20180810161335.27036-6-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When the kernel supports namespaced file capabilites (VFS_REVISION_3) it
will return a struct vfs_ns_cap_data that will contain an additional
rootid field recording the rootid of the file capability sets in the
current user namespace.

When libcap has been compiled on a kernel that supports
VFS_CAP_REVISION_3 but is used on a kernel that does not support
VFS_CAP_REVISION_3 we need to initialize the root id of struct
vfs_ns_cap_data to zero so that no invalid data is passed along when a
VFS_REVISION_2 fcap was set on the file.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 libcap/cap_file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libcap/cap_file.c b/libcap/cap_file.c
index 9b8f11e..eb98bf7 100644
--- a/libcap/cap_file.c
+++ b/libcap/cap_file.c
@@ -103,6 +103,13 @@ static cap_t _fcaps_load(struct vfs_cap_data *rawvfscap, cap_t result, int bytes
 	i++;
     }
 
+#ifdef VFS_CAP_REVISION_3
+    /* The kernel returns the rootid as a _le32. In case we're on a big endian
+     * machine we need to fix this up.
+     */
+    result->rootid = FIXUP_32BITS(rawvfscap->rootid);
+#endif
+
     return result;
 }
 
@@ -221,6 +228,7 @@ cap_t cap_get_fd(int fildes)
 	_cap_debug("getting fildes capabilities");
 
 	/* fill the capability sets via a system call */
+	rawvfscap.rootid = 0;
 	sizeofcaps = fgetxattr(fildes, XATTR_NAME_CAPS,
 			       &rawvfscap, sizeof(rawvfscap));
 	if (sizeofcaps < ssizeof(rawvfscap.magic_etc)) {
@@ -255,6 +263,7 @@ cap_t cap_get_file(const char *filename)
 	_cap_debug("getting filename capabilities");
 
 	/* fill the capability sets via a system call */
+	rawvfscap.rootid = 0;
 	sizeofcaps = getxattr(filename, XATTR_NAME_CAPS,
 			      &rawvfscap, sizeof(rawvfscap));
 	if (sizeofcaps < ssizeof(rawvfscap.magic_etc)) {
-- 
2.17.1

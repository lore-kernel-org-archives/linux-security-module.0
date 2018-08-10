From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:33 +0200
Subject: [PATCH 7/9] cap_file: save rootid in _fcaps_save()
In-Reply-To: <20180810161335.27036-1-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
Message-ID: <20180810161335.27036-8-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When the kernel supports namespaced file capabilites (VFS_REVISION_3) it
will take a struct vfs_ns_cap_data that will contain an additional
rootid field recording a rootid.
It can be used to set the rootid of a target user namespace as seen in
the current user namespace. This allows a user namespace to set file
capabilities in lieu of another user namespace.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 libcap/cap_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libcap/cap_file.c b/libcap/cap_file.c
index 7acd60c..57c6e3f 100644
--- a/libcap/cap_file.c
+++ b/libcap/cap_file.c
@@ -197,6 +197,13 @@ static int _fcaps_save(struct vfs_cap_data *rawvfscap, cap_t cap_d, int *bytes_p
 	}
     }
 
+#ifdef VFS_CAP_REVISION_3
+    /* The kernel expects the rootid to be a _le32. In case we're on a big
+     * endian machine we need to fix this up.
+     */
+    rawvfscap->rootid = FIXUP_32BITS(cap_d->rootid);
+#endif
+
     if (eff_not_zero == 0) {
 	rawvfscap->magic_etc = FIXUP_32BITS(magic);
     } else {
-- 
2.17.1

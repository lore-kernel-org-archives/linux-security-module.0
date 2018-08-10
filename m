From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:34 +0200
Subject: [PATCH 8/9] cap_file: handle run- vs buildtime vfs cap support
In-Reply-To: <20180810161335.27036-1-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
Message-ID: <20180810161335.27036-9-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

If libcap was compiled on a kernel supporting VFS_CAP_REVISION_3 but
running on a kernel that does not support VFS_CAP_REVISION_3 we should
always pass down a legacy struct vfs_cap_data if the rootid is 0. On
kernels supporting VFS_CAP_REVISION_3 the kernel will take care of
translating it from VFS_CAP_REVISION_2 to a VFS_CAP_REVISION_3 version.
We can elegantly handle both cases by setting magic to
VFS_CAP_REVISION_2 and only passing down XATTR_CAPS_SZ_2 bytes which
will leave out the rootid field.
If the rootid field is not 0 then we will pass down the
VFS_CAP_REVISION_3 and XATTR_CAPS_SZ_3. On kernels supporting
VFS_CAP_REVISION_3 this will succeed on kernels not supporting
VFS_CAP_REVISION_3 this will fail. The failure on kernels not supporting
VFS_CAP_REVISION_3 is wanted since the user explicitly requested an
unprivileged file capability but the kernel does not actually support
it. So fail hard.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 libcap/cap_file.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/libcap/cap_file.c b/libcap/cap_file.c
index 57c6e3f..a1f3891 100644
--- a/libcap/cap_file.c
+++ b/libcap/cap_file.c
@@ -202,6 +202,24 @@ static int _fcaps_save(struct vfs_cap_data *rawvfscap, cap_t cap_d, int *bytes_p
      * endian machine we need to fix this up.
      */
     rawvfscap->rootid = FIXUP_32BITS(cap_d->rootid);
+    if (rawvfscap->rootid == 0) {
+	/* If libcap was compiled on a kernel supporting VFS_CAP_REVISION_3 but
+	 * running on a kernel that does not support VFS_CAP_REVISION_3 we
+	 * should always pass down a legacy struct vfs_cap_data if the rootid is
+	 * 0. On kernels supporting VFS_CAP_REVISION_3 the kernel will take care
+	 * of translating it from VFS_CAP_REVISION_2 to a VFS_CAP_REVISION_3
+	 * version.  We can elegantly handle both cases by setting magic to
+	 * VFS_CAP_REVISION_2 and only passing down XATTR_CAPS_SZ_2 bytes which
+	 * will leave out the rootid field.  If the rootid field is not 0 then
+	 * we will pass down the VFS_CAP_REVISION_3 and XATTR_CAPS_SZ_3. On
+	 * kernels supporting VFS_CAP_REVISION_3 this will succeed on kernels
+	 * not supporting VFS_CAP_REVISION_3 this will fail. The failure on kernels
+	 * not supporting VFS_CAP_REVISION_3 is wanted since the user explicitly
+	 * requested an unprivileged file capability but the kernel does not
+	 * actually support it. So fail hard. */
+	magic = VFS_CAP_REVISION_2;
+	*bytes_p = XATTR_CAPS_SZ_2;
+    }
 #endif
 
     if (eff_not_zero == 0) {
-- 
2.17.1

From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:30 +0200
Subject: [PATCH 4/9] cap_file: add new rootid argument
In-Reply-To: <20180810161335.27036-1-christian@brauner.io>
References: <20180810161335.27036-1-christian@brauner.io>
Message-ID: <20180810161335.27036-5-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Newer kernels support setting file capabilities in user namespaces. In
addition to directly setting file capabilites in a user namespaces they
can also be set in lieu of another user namespace by passing a uid down
to the kernel which will convert it to an appropriate kuid_t
representation.
This commit adds a new rootid argument to the internal struct
_cap_struct so that we can store the rootid when the kernel supports
VFS_CAP_REVISION_3 and returns a struct vfs_ns_cap_data.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 libcap/libcap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libcap/libcap.h b/libcap/libcap.h
index 2596c11..9abe4a2 100644
--- a/libcap/libcap.h
+++ b/libcap/libcap.h
@@ -118,6 +118,7 @@ struct _cap_struct {
 	struct __user_cap_data_struct set;
 	__u32 flat[NUMBER_OF_CAP_SETS];
     } u[_LIBCAP_CAPABILITY_U32S];
+    uid_t rootid;
 };
 
 /* the maximum bits supportable */
-- 
2.17.1

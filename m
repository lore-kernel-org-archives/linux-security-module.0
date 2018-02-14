From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 14 Feb 2018 08:35:15 -0500
Subject: [RFC PATCH 4/4] fuse: define the filesystem as untrusted
In-Reply-To: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1518615315-7162-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Files on FUSE can change at any point in time without notifying the
kernel.  This patch sets the new fs_type flag FS_UNTRUSTED to indicate
that the filesystem is untrusted.

(This patch is based on Alban Crequy's use of fs_flags.)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18bbfd2b..dad65a3c7388 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1205,7 +1205,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_UNTRUSTED,
 	.mount		= fuse_mount,
 	.kill_sb	= fuse_kill_sb_anon,
 };
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

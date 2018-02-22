From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 22 Feb 2018 16:33:04 -0500
Subject: [PATCH v2 4/4] fuse: define the filesystem as untrusted
In-Reply-To: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1519335184-17808-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Files on FUSE can change at any point in time without IMA being able
to detect it.  The file data read for the file signature verification
could be totally different from what is subsequently read, making the
signature verification useless.

FUSE can be mounted by unprivileged users either today with fusermount
installed with setuid, or soon with the upcoming patches to allow FUSE
mounts in a non-init user namespace.

This patch sets the SB_I_IMA_UNVERIFIABLE_SIGNATURE flag and when
appropriate sets the SB_I_UNTRUSTED_MOUNTER flag.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 fs/fuse/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18bbfd2b..ef309958e060 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1080,6 +1080,9 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_time_gran = 1;
 	sb->s_export_op = &fuse_export_operations;
+	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	if (sb->s_user_ns != &init_user_ns)
+		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 
 	file = fget(d.fd);
 	err = -EINVAL;
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

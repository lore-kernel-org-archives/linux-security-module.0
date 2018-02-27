From: mic@digikod.net (=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=)
Date: Tue, 27 Feb 2018 01:41:12 +0100
Subject: [PATCH bpf-next v8 02/11] fs,
	security: Add a new file access type: MAY_CHROOT
In-Reply-To: <20180227004121.3633-1-mic@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net>
Message-ID: <20180227004121.3633-3-mic@digikod.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

For compatibility reason, MAY_CHROOT is always set with MAY_CHDIR.
However, this new flag enable to differentiate a chdir form a chroot.

This is needed for the Landlock LSM to be able to evaluate a new root
directory.

Signed-off-by: Micka?l Sala?n <mic@digikod.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-fsdevel at vger.kernel.org
---
 fs/open.c          | 3 ++-
 include/linux/fs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 7ea118471dce..084d147c0e96 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -489,7 +489,8 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR |
+			MAY_CHROOT);
 	if (error)
 		goto dput_and_out;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..67c62374446c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -90,6 +90,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define MAY_CHDIR		0x00000040
 /* called from RCU mode, don't block */
 #define MAY_NOT_BLOCK		0x00000080
+#define MAY_CHROOT		0x00000100
 
 /*
  * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
-- 
2.16.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: deepa.kernel@gmail.com (Deepa Dinamani)
Date: Fri,  7 Apr 2017 17:57:10 -0700
Subject: [PATCH 12/12] time: Delete current_fs_time() function
In-Reply-To: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
References: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
Message-ID: <1491613030-11599-13-git-send-email-deepa.kernel@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

All uses of the current_fs_time() function have been
replaced by other time interfaces.

And, its use cases can be fulfilled by current_time()
or ktime_get_* variants.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/fs.h |  1 -
 kernel/time/time.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f1d7347..cce6c57 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1430,7 +1430,6 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
-extern struct timespec current_fs_time(struct super_block *sb);
 extern struct timespec current_time(struct inode *inode);
 
 /*
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 25bdd25..cf69cca 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -230,20 +230,6 @@ SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
 	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
 }
 
-/**
- * current_fs_time - Return FS time
- * @sb: Superblock.
- *
- * Return the current time truncated to the time granularity supported by
- * the fs.
- */
-struct timespec current_fs_time(struct super_block *sb)
-{
-	struct timespec now = current_kernel_time();
-	return timespec_trunc(now, sb->s_time_gran);
-}
-EXPORT_SYMBOL(current_fs_time);
-
 /*
  * Convert jiffies to milliseconds and back.
  *
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

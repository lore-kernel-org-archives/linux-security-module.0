From: keescook@chromium.org (Kees Cook)
Date: Fri, 9 Mar 2018 11:07:36 -0800
Subject: [PATCH] exec: Set file unwritable before LSM check
Message-ID: <20180309190736.GA4657@beast>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The LSM check should happen after the file has been confirmed to be
unchanging. Without this, we could have a ToCToU issue between the
LSM verification and the actual contents of the file later.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Only loadpin and SELinux implement this hook. From what I can see, this
won't change anything for either of them. IMA calls kernel_read_file(),
but looking there it seems those callers won't be negatively impacted
either. Can folks double-check this and send an Ack please?
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7eb8d21bcab9..a919a827d181 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -895,13 +895,13 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
 		return -EINVAL;
 
-	ret = security_kernel_read_file(file, id);
+	ret = deny_write_access(file);
 	if (ret)
 		return ret;
 
-	ret = deny_write_access(file);
+	ret = security_kernel_read_file(file, id);
 	if (ret)
-		return ret;
+		goto out;
 
 	i_size = i_size_read(file_inode(file));
 	if (max_size > 0 && i_size > max_size) {
-- 
2.7.4


-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

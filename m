From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:02 +0100
Subject: [RFC][PATCH v2 1/9] ima: pass filename to ima_rdwr_violation_check()
In-Reply-To: <20171130105610.15761-1-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
Message-ID: <20171130105610.15761-2-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

ima_rdwr_violation_check() retrieves the full path of a measured file by
calling ima_d_path(). If process_measurement() calls this function, it
reuses the pointer and passes it to the functions to measure/appraise/audit
an accessed file.

After commit bc15ed663e7e ("ima: fix ima_d_path() possible race with
rename"), ima_d_path() first tries to retrieve the full path by calling
d_absolute_path() and, if there is an error, copies the dentry name to the
buffer passed as argument.

However, ima_rdwr_violation_check() passes to ima_d_path() the pointer of a
local variable. process_measurement() might be reusing the pointer to an
area in the stack which may have been already overwritten after
ima_rdwr_violation_check() returned.

Correct this issue by passing to ima_rdwr_violation_check() the pointer of
a buffer declared in process_measurement().

Fixes: bc15ed663e7e ("ima: fix ima_d_path() possible race with rename")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 294b2fe69334..5a7321bc325c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -84,10 +84,10 @@ static void ima_rdwr_violation_check(struct file *file,
 				     struct integrity_iint_cache *iint,
 				     int must_measure,
 				     char **pathbuf,
-				     const char **pathname)
+				     const char **pathname,
+				     char *filename)
 {
 	struct inode *inode = file_inode(file);
-	char filename[NAME_MAX];
 	fmode_t mode = file->f_mode;
 	bool send_tomtou = false, send_writers = false;
 
@@ -205,7 +205,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	if (violation_check) {
 		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
-					 &pathbuf, &pathname);
+					 &pathbuf, &pathname, filename);
 		if (!action) {
 			rc = 0;
 			goto out_free;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

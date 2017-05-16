From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 16 May 2017 14:53:44 +0200
Subject: [PATCH 4/7] ima: declare get_binary_runtime_size() as non-static
In-Reply-To: <20170516125347.10574-1-roberto.sassu@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
Message-ID: <20170516125347.10574-5-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The function get_binary_runtime_size(), renamed to
ima_get_template_entry_size(), is now declared as non-static, so that
it can be used by callers outside ima_queue.c to calculate the size
of a given measurement entry.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h       | 1 +
 security/integrity/ima/ima_queue.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b563fbd..10ef9c8 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -131,6 +131,7 @@ extern bool ima_canonical_fmt;
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
+int ima_get_template_entry_size(struct ima_template_entry *entry);
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index f628968..24984a2 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -74,7 +74,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
  * binary_runtime_measurement list entry, which contains a
  * couple of variable length fields (e.g template name and data).
  */
-static int get_binary_runtime_size(struct ima_template_entry *entry)
+int ima_get_template_entry_size(struct ima_template_entry *entry)
 {
 	int size = 0;
 
@@ -118,7 +118,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	if (binary_runtime_size != ULONG_MAX) {
 		int size;
 
-		size = get_binary_runtime_size(entry);
+		size = ima_get_template_entry_size(entry);
 		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
 		     binary_runtime_size + size : ULONG_MAX;
 	}
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

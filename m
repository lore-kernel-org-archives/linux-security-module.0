From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 13 Aug 2017 19:36:02 +0200
Subject: [PATCH] ima: Delete an error message for a failed memory allocation
	in ima_add_digest_entry()
Message-ID: <dcbe18c8-a7e3-b26e-a95b-2d3cc2531081@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 13 Aug 2017 19:29:11 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/integrity/ima/ima_queue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a02a86d51102..3b60e72aecb2 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -100,10 +100,9 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	unsigned int key;
 
 	qe = kmalloc(sizeof(*qe), GFP_KERNEL);
-	if (qe == NULL) {
-		pr_err("OUT OF MEMORY ERROR creating queue entry\n");
+	if (!qe)
 		return -ENOMEM;
-	}
+
 	qe->entry = entry;
 
 	INIT_LIST_HEAD(&qe->later);
-- 
2.14.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: gomonovych@gmail.com (Vasyl Gomonovych)
Date: Thu, 21 Dec 2017 16:55:53 +0100
Subject: [PATCH] ima: Fix warn potential negative subtraction from max
Message-ID: <1513871754-13943-1-git-send-email-gomonovych@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Found by smatch:
security/integrity/ima/ima_queue.c:122 ima_add_digest_entry() warn:
potential negative subtraction from max '(~0)- size'

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 security/integrity/ima/ima_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a02a86d51102..446018478b81 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -116,7 +116,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	}
 
 	if (binary_runtime_size != ULONG_MAX) {
-		int size;
+		unsigned int size;
 
 		size = get_binary_runtime_size(entry);
 		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

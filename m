From: gomonovych@gmail.com (Vasyl Gomonovych)
Date: Thu, 21 Dec 2017 22:54:18 +0100
Subject: [PATCH v2] ima: Fix warn potential negative subtraction from max
In-Reply-To: <20171221180001.GC16008@mail.hallyn.com>
References: <20171221180001.GC16008@mail.hallyn.com>
Message-ID: <1513893258-28773-1-git-send-email-gomonovych@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Found by smatch:
security/integrity/ima/ima_queue.c:122 ima_add_digest_entry() warn:
potential negative subtraction from max '(~0)- size'

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
This minor change remove smatch warning but 
I don't think that before change it was vulnerable, 
motivation for this patch was smatch report.

Changelog:
 - v2: change get_binary_runtime_size return type

 security/integrity/ima/ima_queue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a02a86d51102..3d5f981b8453 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -74,9 +74,9 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
  * binary_runtime_measurement list entry, which contains a
  * couple of variable length fields (e.g template name and data).
  */
-static int get_binary_runtime_size(struct ima_template_entry *entry)
+static unsigned int get_binary_runtime_size(struct ima_template_entry *entry)
 {
-	int size = 0;
+	unsigned int size = 0;
 
 	size += sizeof(u32);	/* pcr */
 	size += sizeof(entry->digest);
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

From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 16 May 2017 14:53:47 +0200
Subject: [PATCH 7/7] ima: fix get_binary_runtime_size()
In-Reply-To: <20170516125347.10574-1-roberto.sassu@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
Message-ID: <20170516125347.10574-8-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Remove '+ 1' from 'size += strlen(entry->template_desc->name) + 1;',
as the template name is sent to userspace without the '\0' character.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 24984a2..2f7e03c 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -81,7 +81,7 @@ int ima_get_template_entry_size(struct ima_template_entry *entry)
 	size += sizeof(u32);	/* pcr */
 	size += sizeof(entry->digest);
 	size += sizeof(int);	/* template name size field */
-	size += strlen(entry->template_desc->name) + 1;
+	size += strlen(entry->template_desc->name);
 	size += sizeof(entry->template_data_len);
 	size += entry->template_data_len;
 	return size;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

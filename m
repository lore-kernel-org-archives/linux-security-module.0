From: jiazhouyang09@gmail.com (Zhouyang Jia)
Date: Tue, 12 Jun 2018 12:27:03 +0800
Subject: [PATCH] integrity: add error handling for kmem_cache_create
Message-ID: <1528777625-40502-1-git-send-email-jiazhouyang09@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When kmem_cache_create fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kmem_cache_create.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 security/integrity/iint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 149faa8..c074fd8 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -172,6 +172,9 @@ static int __init integrity_iintcache_init(void)
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, init_once);
+	if (!iint_cache)
+		return -ENOMEM;
+
 	return 0;
 }
 security_initcall(integrity_iintcache_init);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: colin.king@canonical.com (Colin King)
Date: Mon,  4 Dec 2017 18:14:24 +0000
Subject: [PATCH] security: keys: remove redundant assignment to key_ref
Message-ID: <20171204181424.15808-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable key_ref is being assigned a value that is never read;
key_ref is being re-assigned a few statements later.  Hence this
assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/keys/key.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 66049183ad89..d97c9394b5dd 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -833,7 +833,6 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 
 	key_check(keyring);
 
-	key_ref = ERR_PTR(-EPERM);
 	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
 		restrict_link = keyring->restrict_link;
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

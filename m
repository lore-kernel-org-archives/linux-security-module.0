From: ebiggers@google.com (Eric Biggers)
Date: Tue, 17 Jul 2018 10:36:04 -0700
Subject: [PATCH] security: check for kstrdup() failure in lsm_append()
Message-ID: <20180717173604.107840-1-ebiggers@google.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

lsm_append() should return -ENOMEM if memory allocation failed.

Fixes: d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/security.c b/security/security.c
index 03e98be76d58..259ff593d543 100644
--- a/security/security.c
+++ b/security/security.c
@@ -121,6 +121,8 @@ static int lsm_append(char *new, char **result)
 
 	if (*result == NULL) {
 		*result = kstrdup(new, GFP_KERNEL);
+		if (*result == NULL)
+			return -ENOMEM;
 	} else {
 		/* Check if it is the last registered name */
 		if (match_last_lsm(*result, new))
-- 
2.18.0.203.gfac676dfb9-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

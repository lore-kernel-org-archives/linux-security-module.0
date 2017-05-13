From: geliangtang@gmail.com (Geliang Tang)
Date: Sat, 13 May 2017 11:15:57 +0800
Subject: [PATCH] KEYS: use memdup_user
Message-ID: <908fa521decaf3703e172c3734c0d498741f3ddb.1494580404.git.geliangtang@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Use memdup_user() helper instead of open-coding to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 security/keys/keyctl.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index dd0da25..ce1574a 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -326,14 +326,11 @@ long keyctl_update_key(key_serial_t id,
 	/* pull the payload in if one was supplied */
 	payload = NULL;
 	if (_payload) {
-		ret = -ENOMEM;
-		payload = kmalloc(plen, GFP_KERNEL);
-		if (!payload)
+		payload = memdup_user(_payload, plen);
+		if (IS_ERR(payload)) {
+			ret = PTR_ERR(payload);
 			goto error;
-
-		ret = -EFAULT;
-		if (copy_from_user(payload, _payload, plen) != 0)
-			goto error2;
+		}
 	}
 
 	/* find the target key (which must be writable) */
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

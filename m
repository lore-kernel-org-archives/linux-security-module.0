From: ebiggers3@gmail.com (Eric Biggers)
Date: Mon, 18 Sep 2017 11:39:02 -0700
Subject: [PATCH] KEYS: use kmemdup() in request_key_auth_new()
Message-ID: <20170918183902.114459-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

kmemdup() is preferred to kmalloc() followed by memcpy().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/request_key_auth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index f2f29f13ecff..08bf6f99c043 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -161,12 +161,13 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 		kleave(" = -ENOMEM");
 		return ERR_PTR(-ENOMEM);
 	}
-	rka->callout_info = kmalloc(callout_len, GFP_KERNEL);
+	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL);
 	if (!rka->callout_info) {
 		kleave(" = -ENOMEM");
 		kfree(rka);
 		return ERR_PTR(-ENOMEM);
 	}
+	rka->callout_len = callout_len;
 
 	/* see if the calling process is already servicing the key request of
 	 * another process */
@@ -193,8 +194,6 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 
 	rka->target_key = key_get(target);
 	rka->dest_keyring = key_get(dest_keyring);
-	memcpy(rka->callout_info, callout_info, callout_len);
-	rka->callout_len = callout_len;
 
 	/* allocate the auth key */
 	sprintf(desc, "%x", target->serial);
-- 
2.14.1.690.gbb1197296e-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

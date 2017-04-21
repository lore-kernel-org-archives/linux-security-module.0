From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 21 Apr 2017 01:30:34 -0700
Subject: [PATCH 2/5] KEYS: user_defined: sanitize key payloads
In-Reply-To: <20170421083037.12746-1-ebiggers3@gmail.com>
References: <20170421083037.12746-1-ebiggers3@gmail.com>
Message-ID: <20170421083037.12746-3-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Zero the payloads of user and logon keys before freeing them.  This
prevents sensitive key material from being kept around in the slab
caches after a key is released.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/user_defined.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 26605134f17a..3d8c68eba516 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -86,10 +86,18 @@ EXPORT_SYMBOL_GPL(user_preparse);
  */
 void user_free_preparse(struct key_preparsed_payload *prep)
 {
-	kfree(prep->payload.data[0]);
+	kzfree(prep->payload.data[0]);
 }
 EXPORT_SYMBOL_GPL(user_free_preparse);
 
+static void user_free_payload_rcu(struct rcu_head *head)
+{
+	struct user_key_payload *payload;
+
+	payload = container_of(head, struct user_key_payload, rcu);
+	kzfree(payload);
+}
+
 /*
  * update a user defined key
  * - the key's semaphore is write-locked
@@ -112,7 +120,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
 	prep->payload.data[0] = NULL;
 
 	if (zap)
-		kfree_rcu(zap, rcu);
+		call_rcu(&zap->rcu, user_free_payload_rcu);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(user_update);
@@ -130,7 +138,7 @@ void user_revoke(struct key *key)
 
 	if (upayload) {
 		rcu_assign_keypointer(key, NULL);
-		kfree_rcu(upayload, rcu);
+		call_rcu(&upayload->rcu, user_free_payload_rcu);
 	}
 }
 
@@ -143,7 +151,7 @@ void user_destroy(struct key *key)
 {
 	struct user_key_payload *upayload = key->payload.data[0];
 
-	kfree(upayload);
+	kzfree(upayload);
 }
 
 EXPORT_SYMBOL_GPL(user_destroy);
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

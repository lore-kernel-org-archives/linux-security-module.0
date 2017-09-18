From: ebiggers3@gmail.com (Eric Biggers)
Date: Mon, 18 Sep 2017 11:33:31 -0700
Subject: [PATCH] KEYS: fix cred refcount leak in request_key_auth_new()
Message-ID: <20170918183331.113261-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In request_key_auth_new(), if alloc_key() or key_instantiate_and_link()
were to fail, we would leak a reference to the 'struct cred'.  Currently
this can only happen if alloc_key() fails to to allocate memory.  But it
still should be fixed, as it is a more severe bug waiting to happen.

Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/request_key_auth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index afe9d22ab361..f2f29f13ecff 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -227,6 +227,7 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 	key_revoke(authkey);
 	key_put(authkey);
 error_alloc:
+	put_cred(rka->cred);
 	key_put(rka->target_key);
 	key_put(rka->dest_keyring);
 	kfree(rka->callout_info);
-- 
2.14.1.690.gbb1197296e-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

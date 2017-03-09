From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu,  9 Mar 2017 12:23:11 -0800
Subject: [PATCH v12 06/10] KEYS: Consistent ordering for __key_link_begin and
	restrict check
In-Reply-To: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
References: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170309202315.15361-7-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The keyring restrict callback was sometimes called before
__key_link_begin and sometimes after, which meant that the keyring
semaphores were not always held during the restrict callback.

If the semaphores are consistently acquired before checking link
restrictions, keyring contents cannot be changed after the restrict
check is complete but before the evaluated key is linked to the keyring.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 security/keys/key.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 488adf2b6ad4..989ec35c1c48 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -500,21 +500,23 @@ int key_instantiate_and_link(struct key *key,
 	}
 
 	if (keyring) {
+		ret = __key_link_begin(keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto error;
+
 		if (keyring->restrict_link && keyring->restrict_link->check) {
 			struct key_restriction *keyres = keyring->restrict_link;
 
 			ret = keyres->check(keyring, key->type, &prep.payload,
 					    keyres->data);
 			if (ret < 0)
-				goto error;
+				goto error_link_end;
 		}
-		ret = __key_link_begin(keyring, &key->index_key, &edit);
-		if (ret < 0)
-			goto error;
 	}
 
 	ret = __key_instantiate_and_link(key, &prep, keyring, authkey, &edit);
 
+error_link_end:
 	if (keyring)
 		__key_link_end(keyring, &key->index_key, edit);
 
@@ -855,21 +857,21 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	}
 	index_key.desc_len = strlen(index_key.description);
 
+	ret = __key_link_begin(keyring, &index_key, &edit);
+	if (ret < 0) {
+		key_ref = ERR_PTR(ret);
+		goto error_free_prep;
+	}
+
 	if (restrict_link && restrict_link->check) {
 		ret = restrict_link->check(keyring, index_key.type,
 					   &prep.payload, restrict_link->data);
 		if (ret < 0) {
 			key_ref = ERR_PTR(ret);
-			goto error_free_prep;
+			goto error_link_end;
 		}
 	}
 
-	ret = __key_link_begin(keyring, &index_key, &edit);
-	if (ret < 0) {
-		key_ref = ERR_PTR(ret);
-		goto error_free_prep;
-	}
-
 	/* if we're going to allocate a new key, we're going to have
 	 * to modify the keyring */
 	ret = key_permission(keyring_ref, KEY_NEED_WRITE);
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

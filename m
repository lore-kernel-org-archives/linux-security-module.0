From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu,  9 Mar 2017 12:23:07 -0800
Subject: [PATCH v12 02/10] KEYS: Split role of the keyring pointer for keyring
	restrict functions
In-Reply-To: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
References: <20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170309202315.15361-3-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The first argument to the restrict_link_func_t functions was a keyring
pointer. These functions are called by the key subsystem with this
argument set to the destination keyring, but restrict_link_by_signature
expects a pointer to the relevant trusted keyring.

Restrict functions may need something other than a single struct key
pointer to allow or reject key linkage, so the data used to make that
decision (such as the trust keyring) is moved to a new, fourth
argument. The first argument is now always the destination keyring.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/security/keys.txt   |  8 ++++----
 certs/system_keyring.c            | 18 +++++++++++-------
 crypto/asymmetric_keys/restrict.c |  9 ++++++---
 include/crypto/public_key.h       |  3 ++-
 include/keys/system_keyring.h     |  6 ++++--
 include/linux/key.h               |  8 +++++---
 security/keys/key.c               |  5 +++--
 security/keys/keyring.c           |  6 ++++--
 8 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/Documentation/security/keys.txt b/Documentation/security/keys.txt
index df695bddc140..5e7f63bade96 100644
--- a/Documentation/security/keys.txt
+++ b/Documentation/security/keys.txt
@@ -1054,10 +1054,10 @@ payload contents" for more information.
     can be verified by a key the kernel already has.
 
     When called, the restriction function will be passed the keyring being
-    added to, the key flags value and the type and payload of the key being
-    added.  Note that when a new key is being created, this is called between
-    payload preparsing and actual key creation.  The function should return 0
-    to allow the link or an error to reject it.
+    added to, the key type, the payload of the key being added, and data to be
+    used in the restriction check.  Note that when a new key is being created,
+    this is called between payload preparsing and actual key creation.  The
+    function should return 0 to allow the link or an error to reject it.
 
     A convenience function, restrict_link_reject, exists to always return
     -EPERM to in this case.
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 50979d6dcecd..e904653b7cff 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -32,11 +32,13 @@ extern __initconst const unsigned long system_certificate_list_size;
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in the built in system keyring.
  */
-int restrict_link_by_builtin_trusted(struct key *keyring,
+int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 				     const struct key_type *type,
-				     const union key_payload *payload)
+				     const union key_payload *payload,
+				     void *data)
 {
-	return restrict_link_by_signature(builtin_trusted_keys, type, payload);
+	return restrict_link_by_signature(dest_keyring, type, payload,
+					  builtin_trusted_keys);
 }
 
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
@@ -49,20 +51,22 @@ int restrict_link_by_builtin_trusted(struct key *keyring,
  * keyrings.
  */
 int restrict_link_by_builtin_and_secondary_trusted(
-	struct key *keyring,
+	struct key *dest_keyring,
 	const struct key_type *type,
-	const union key_payload *payload)
+	const union key_payload *payload,
+	void *data)
 {
 	/* If we have a secondary trusted keyring, then that contains a link
 	 * through to the builtin keyring and the search will follow that link.
 	 */
 	if (type == &key_type_keyring &&
-	    keyring == secondary_trusted_keys &&
+	    dest_keyring == secondary_trusted_keys &&
 	    payload == &builtin_trusted_keys->payload)
 		/* Allow the builtin keyring to be added to the secondary */
 		return 0;
 
-	return restrict_link_by_signature(secondary_trusted_keys, type, payload);
+	return restrict_link_by_signature(dest_keyring, type, payload,
+					  secondary_trusted_keys);
 }
 #endif
 
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 19d1afb9890f..d223929e01ac 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -56,9 +56,10 @@ __setup("ca_keys=", ca_keys_setup);
 
 /**
  * restrict_link_by_signature - Restrict additions to a ring of public keys
- * @trust_keyring: A ring of keys that can be used to vouch for the new cert.
+ * @dest_keyring: Keyring being linked to.
  * @type: The type of key being added.
  * @payload: The payload of the new key.
+ * @data: A ring of keys that can be used to vouch for the new cert.
  *
  * Check the new certificate against the ones in the trust keyring.  If one of
  * those is the signing key and validates the new certificate, then mark the
@@ -69,13 +70,15 @@ __setup("ca_keys=", ca_keys_setup);
  * signature check fails or the key is blacklisted and some other error if
  * there is a matching certificate but the signature check cannot be performed.
  */
-int restrict_link_by_signature(struct key *trust_keyring,
+int restrict_link_by_signature(struct key *dest_keyring,
 			       const struct key_type *type,
-			       const union key_payload *payload)
+			       const union key_payload *payload,
+			       void *data)
 {
 	const struct public_key_signature *sig;
 	struct key *key;
 	int ret;
+	struct key *trust_keyring = (struct key *) data;
 
 	pr_devel("==>%s()\n", __func__);
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 882ca0e1e7a5..e28b182833cc 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -52,7 +52,8 @@ union key_payload;
 
 extern int restrict_link_by_signature(struct key *trust_keyring,
 				      const struct key_type *type,
-				      const union key_payload *payload);
+				      const union key_payload *payload,
+				      void *data);
 
 extern int verify_signature(const struct key *key,
 			    const struct public_key_signature *sig);
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 0d8762622ab9..d82e657b75a1 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -18,7 +18,8 @@
 
 extern int restrict_link_by_builtin_trusted(struct key *keyring,
 					    const struct key_type *type,
-					    const union key_payload *payload);
+					    const union key_payload *payload,
+					    void *data);
 
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
@@ -28,7 +29,8 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
 extern int restrict_link_by_builtin_and_secondary_trusted(
 	struct key *keyring,
 	const struct key_type *type,
-	const union key_payload *payload);
+	const union key_payload *payload,
+	void *data);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
diff --git a/include/linux/key.h b/include/linux/key.h
index 455171320ffc..c4016bc314f7 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -126,9 +126,10 @@ static inline bool is_key_possessed(const key_ref_t key_ref)
 	return (unsigned long) key_ref & 1UL;
 }
 
-typedef int (*key_restrict_link_func_t)(struct key *keyring,
+typedef int (*key_restrict_link_func_t)(struct key *dest_keyring,
 					const struct key_type *type,
-					const union key_payload *payload);
+					const union key_payload *payload,
+					void *data);
 
 /*****************************************************************************/
 /*
@@ -308,7 +309,8 @@ extern struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid
 
 extern int restrict_link_reject(struct key *keyring,
 				const struct key_type *type,
-				const union key_payload *payload);
+				const union key_payload *payload,
+				void *data);
 
 extern int keyring_clear(struct key *keyring);
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 4e9138cc89e0..128ea40b01bd 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -499,7 +499,7 @@ int key_instantiate_and_link(struct key *key,
 	if (keyring) {
 		if (keyring->restrict_link) {
 			ret = keyring->restrict_link(keyring, key->type,
-						     &prep.payload);
+						     &prep.payload, NULL);
 			if (ret < 0)
 				goto error;
 		}
@@ -851,7 +851,8 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 	index_key.desc_len = strlen(index_key.description);
 
 	if (restrict_link) {
-		ret = restrict_link(keyring, index_key.type, &prep.payload);
+		ret = restrict_link(keyring, index_key.type, &prep.payload,
+				    NULL);
 		if (ret < 0) {
 			key_ref = ERR_PTR(ret);
 			goto error_free_prep;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index a7f26fd08f6c..ccffb536d17e 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -517,6 +517,7 @@ EXPORT_SYMBOL(keyring_alloc);
  * @keyring: The keyring being added to.
  * @type: The type of key being added.
  * @payload: The payload of the key intended to be added.
+ * @data: Additional data for evaluating restriction.
  *
  * Reject the addition of any links to a keyring.  It can be overridden by
  * passing KEY_ALLOC_BYPASS_RESTRICTION to key_instantiate_and_link() when
@@ -527,7 +528,8 @@ EXPORT_SYMBOL(keyring_alloc);
  */
 int restrict_link_reject(struct key *keyring,
 			 const struct key_type *type,
-			 const union key_payload *payload)
+			 const union key_payload *payload,
+			 void *data)
 {
 	return -EPERM;
 }
@@ -1220,7 +1222,7 @@ static int __key_link_check_restriction(struct key *keyring, struct key *key)
 {
 	if (!keyring->restrict_link)
 		return 0;
-	return keyring->restrict_link(keyring, key->type, &key->payload);
+	return keyring->restrict_link(keyring, key->type, &key->payload, NULL);
 }
 
 /**
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
